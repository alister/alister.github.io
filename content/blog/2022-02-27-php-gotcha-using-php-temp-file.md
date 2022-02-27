---
title: "PHP Gotcha: Using php://temp"
date: "2022-02-27T14:15:00+00:00"
layout: blog
toc: true
tags:
- opensource
- php
- gotcha
---

Just a quicky post, that I hope will save someone (or myself) some head-scratching later. 

**TLDR: Whenever you `fopen('php://temp', $mode)` you get a new file.**

I found this out when exporting some data from the DB to a spreadsheet/CSV. I was using `Yectep\PhpSpreadsheetBundle\Factory` (a [Symfony bundle](https://github.com/eightyknots/phpspreadsheet-bundle/) around [phpoffice/phpspreadsheet](https://github.com/PHPOffice/PhpSpreadsheet)) which had a handy method to save the file:

```php
$writer = $this->spreadsheetFactory->createWriter($spreadsheet, '.csv');
$writer->save('php://temp');
```

From there I would read it back, and upload it to a cloudfiles storage account using [FlySystem](https://github.com/thephpleague/flysystem):

```php
$tempFp = fopen('php://temp', 'rb');
$wroteStreamOK = $this->securedFilesystem
    ->writeStream('/path/in/cloudfiles/filename-etc.xlsx', $tempFp);
```

An advantage of using 'php://temp' is that it's usually stored in memory, unless it gets too large (over 2MB, usually), in which case it's automatically saved to disk. Thats one less thing to worry about, right?

Another export-to-CSV was a bit simpler, and so it looped through the database records, and output them directly, using [`fputcsv`](https://www.php.net/manual/en/function.fputcsv.php) - and it worked great. When I didn't realise was that that didn't open [`php://temp`](https://www.php.net/manual/en/wrappers.php.php#refsect1-wrappers.php-examples) twice - it opened it directly, saved to it, rewound the file-pointer, and used that file-handle to upload.

With `$writer->save('php://temp');` it was being opened, and then re-opened `$tempFp = fopen('php://temp', 'rb')` - so, I got a second, different temporary file - which was empty.

As usual the fix was actually pretty easy, when the underlying problem was recognised.

1. Open the temp file ourselves, & let the spreadsheet bundle use it (`$writer->save()` happily takes a file-handle/resource directly instead of the filename/path which it must open itself)
2. Use the same file-handle for the upload (it even does a `rewind()` itself).

```php
// get the `resource`/file-handle for the temporary stream 
// we use to save the initial export. We need to be able to 
// use the identical resource-id to be able to save it later
$tempFp = fopen('php://temp', 'rw+b');
$writer->save($tempFp);

$filepath = sprintf('%s/product_exports_venue%d.%s.%s.csv', /* etc... */);

// write the CSV lines to the final file (local directory or the cloud, via Flysystem)
$wroteStreamOK = $this->securedFilesystem->writeStream($filepath, $tempFp);
```

Also see: 
* Stackoverflow: [Having problems reading/writing the php://temp stream](https://stackoverflow.com/a/5946711/6216)
* PHP.net: [php://memory and php://temp](https://www.php.net/manual/en/wrappers.php.php#wrappers.php.memory)
