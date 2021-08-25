---
title: "A MySQL optimisation Story"
date: "2013-01-01T17:04:00+00:00"
aliases:
- /blog/2013/01/01/a-mysql-optimisation-story/
layout: blog
toc: false
tags:
- freelance
- mysql
- linux
- scaling
published: true
---
Here is an example of what a little expertise, judiciously applied can do to speed up larger systems. In this case, take a 30 minute run against a MySQL database down to 5 minutes, or less.

<!--more-->

Back in Mid-December (2012), I got an email (via LinkedIn) out of the blue from a web development company in Hampshire. They needed some help with a database they were finishing off for a customer. The site itself barely touched the DB, but instead the heavy lifting was being done once per hour to read the data through a somewhat convoluted database view that did a lot of the work of joining various small tables against the main, multi-million row, table.

The regular job was taking around 30 minutes to complete, and then the website then read the results of that to produce the main site pages as required. They wanted to seee how they could speed it up - a lot.

I've dealt with issues like this before, a couple of times in fact, and it had helped me got at least one full-time job in the past because I'd solved it so easily - stopping the database server crashing a few times a day in the process - so I was happy to take half-hour to talk though the likely scenarios. 

It's a simple enough problem with MySQL servers. They can handle a lot of work, but they don't come with the base configuration to be able to do so. The main issue is having a machine with plenty of memory to handle the amount of data in the database (the sheer megabytes on disk of data), but the __innodb_buffer_pool_size__ hasn't been updated to be able to use the memory, so all the information has to squeeze though a mere 8MB (yes, not much more than eight million bytes) of space. Not helpful when the database could be measured in Gigabytes.

A couple of days later, I drove down the M3 to visit the office and more efficiently deal with their servers (they were firewalled to only talk to the office IP address), and do some other things.  The database & its slave was already running a lot faster with the increased buffer_pool memory, in fact it had reduced the time to run the production from 30 minutes to just 5, so there was already a huge win for them. Even then, it was still using just 33% of the ram for the DB on the master, and less than 8.5% on the slave.

With a few more small tweaks they've now got plenty of room to grow, and room to easily double the amount of data they are storing in the DB - and they've also had some tips how to be able to run the regularly scheduled cache-run almost as often as the database can be changed, without having to worry about how long it might end up running (something that you would have to be concerned about it you ran it as a cron-job).

What was also done:

* Removing redundant indexes - they already had columns as part of the first set of a compound index. More indexes is more space, and more time to produce. If the data already has an index that covers the same data - remove it!
* Enabling the slow-query log showed a couple of places where a full-text search was still being run, although there was a simple column that could provide the same information.
* Reminded them that a string-based UUID as an indexed column was not their friend. The size of the indexes on disk were more than 1.5 times the size of the data!  A simple numeric index would be a fraction of the size, and since that would also mean more data in less space, it would equally mean a faster database.

I put the various database tables into individual files, rather than a single, monolithic file (which was over 20GB on disk). While this doesn't help with backups, and you also have to increase the number of open_files MySQL has, there are some benefits, such as being able to more easily reclaim space from large database tables. It also means that you can see very easily how much disk space each table takes up, so it can be more easily monitored.

A couple of final things I did was a very quick and easy fix to a PHP-server for a different site. Although the database for the other site was quite small, a quick upgrade of the  __innodb_buffer_pool_size__ would help them in the future, but the main improvement I left them with was to install APC with an initial 32MB RAM default. Its a useful and easy speedup for any PHP site. The improvement was pretty obvious to see on-screen, and it would have also used less memory in the process.

So, two websites, with very different needs but both have had substantial improvements in speed. One was entirely back-end and database based, going from a 30 minute turn-around time to regenerate the site from the database to just five minytes, or even less.

The other a more simple PHP site (in fact, written in [Expression Engine](https://expressionengine.com/)). Installing APC produces some very easy improvement in web-page render times.


I hope this has been a useful reminder of how just a little work from a specialist can help your sites can speed up by a great deal.
