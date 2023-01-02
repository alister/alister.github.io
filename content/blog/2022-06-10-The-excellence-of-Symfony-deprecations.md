---
title: "The excellence of Symfony deprecations"
date: 2022-12-21T22:09:14+01:00
draft: false
tags:
- php
- opensource
---

Based on my [Reddit comment](https://www.reddit.com/r/PHPhelp/comments/v7u7g8/which_php_framework_is_good_for_web_applications/ibn8j3j/):

> One of the most impressive things about Symfony are the deprecation warnings - it will tell you what needs to be changed or upgraded ahead of time (the only time I've seen otherwise was a security fix).  I'd suggest a quick look at the framework updates as and when they are released to keep up to date with things, to give you plenty of time to update before the next minor/major releases. 
>
> Bug-fixes & the minor updates are easy to do for almost all the packages, and doing small upgrades frequently will be a lot easier than large upgrades only every couple of years. 
>
> For the upgrades themselves, there's [rector/rector-symfony](https://github.com/rectorphp/rector-symfony) which can do a lot - for updating code using the the framework - as well as other Rector packages for PHP itself and for common libraries and tools.
