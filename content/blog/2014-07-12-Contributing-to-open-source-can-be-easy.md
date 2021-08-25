---
title: "Contributing to open source can be easy"
date: "2014-07-12T17:30:00+00:00"
layout: blog
toc: true
tags:
- opensource
- github
- packagist
- git
- HWIOAuthBundle
- omniauth
- Capistrano
- forward3d
- docker
- phplondon
- phpdox
- faker-extensions
---
Although I'm busy day to day at my current contract <sup>*</sup>, that isn't to say that my passions outside the office have come to a complete stop. I'm still going to regular meetups (like the [PHP London Meetup](https://www.meetup.com/phplondon/) and [Docker London](https://www.meetup.com/Docker-London/events/192394082/)), and I'm also planning to go to [Symfony Live London 2014](https://london2014.live.symfony.com/). I've also been reading about, and trying some software, and making the odd fix and new code for myself.

I thought that it would be good to show some of the work I've been doing out of hours - some of it trivially easy - that I've done to help improve a few projects, and also some slightly larger things of my own.

(<sup>*</sup> Developing systems for Her Majesty's Passport Office, in the Home Office)

## Capistrano tagger - Quick fix to remove whitespace around sha1 hash

I regularly look around for new tools that can help me, even just a little, to make like just that bit easier. [Capistrano](https://capistranorb.com/) ([Capistrano on github](https://github.com/capistrano/capistrano)) makes deploying code easy, repeatable and fast. Being able to tag the most recently deployed version is useful to be able to refer back. I've got projects that are using both version 2 & 3 of Capistrano (v3 is a complete rewrite of v2, so it's not so easy to upgrade, but v2 still works just fine).

[capistrano-deploy-tagger](https://github.com/forward/capistrano-deploy-tagger) is an internal project, open-sourced by the [Forward 3D](http://forwardtechnology.co.uk/). I've been to their offices several times for Devops and GoLang meet-ups, among others.

It's easy to add this Capistrano plugin to help tag things when I deployed them - to know exactly when things happened. Trouble was, it didn't work for me. I narrowed things down to the response from Git having a newline in front of it, so I [added a 'strip!' to the appropriate variable](https://github.com/forward/capistrano-deploy-tagger/commit/7c30ea8be8004c6bfee0d1c7bb27b1383043f4bd), which removed the errant white-space. There's probably a better way to do it, with some more behind-the-scenes git command, but this works for now, and solved my problem to boot.

I could have just left my fix in my local copy, and it would have worked quite nicely (at least till I went to upgrade the gem), but submitting a merge-request and having [Ryan Conway](https://github.com/Rylon) pull it in, helps everybody - and now I get to automatically tag my deployments.

## PHPDox - Correct source name in errors, PHPUnit, not PHPloc

I created my [personal-ci](https://github.com/alister/personal-ci) meta-project to pull in various PHP-based testing and documentation tools with [Composer](https://getcomposer.org/). One of those was [PHPDox](https://github.com/theseer/phpdox), and it does a good job of processing the projects to make some good looking documentation.

While developing the personal-ci system, I'd been running PHPDox regularly with the rest, and getting some errors from not having all the files in place first (some of the additional logging output of PHPUnit). Trouble was, it was complaining about something that was there - some PHPLoc logs. So, I grepped the source for the message, and found two copies. One was in a class dealing with PHPUnit though - not the PHPLoc that was being reported - so the fix was just changing a couple of [error message strings](https://github.com/theseer/phpdox/pull/141) to show the right program.

A very simple change - a text-only bug, that confused (at least) me, and I could find an improvement.

## FrequenceWebContactBundle - Improved English language translation

I was looking around for a contact-bundle for a project - a simple form to email system. Among my travels around Packagist & Github, I found [FrequenceWebContactBundle](https://github.com/yohang/FrequenceWebContactBundle/).

This is another really trivial change - a couple of lines of [improved translation](https://github.com/yohang/FrequenceWebContactBundle/pull/5). The original author of the project is French, I could fork and edit the file right in the browser (on Github) and make a pull-request in just a moment.


## Rails3 multi-Oauth logins with OmniAuth

I couldn't find a good tutorial on using the Ruby-on-rails gem 'Omniauth', with more than one authentication method, so that you could then login with any connected account into the same user. [So I wrote one :)](https://github.com/alister/rails3-omniauth-multi_tutsplus).

I'm still looking for a good PHP-based equivalent though (using [HWIOAuthBundle](https://github.com/hwi/HWIOAuthBundle)). In fact, until I had to depreciate the part of a new site that was going to use it, [I offered a bounty](https://github.com/hwi/HWIOAuthBundle/issues/424) to be able to get some good example code - with suitable documentation - written. That issue remains unanswered, and HWIOAuthBundle still doesn't have a really good sample..

## faker-extensions

My newest open source code is [faker-extensions](https://github.com/alister/faker-extensions). The actual code that is being run is really trivial - two classes and a total of three functions and then as many lines of actual code (plus some simple tests) - and two of those lines just call someone else's methods, with a little local data. Its the local data that makes it interesting, and useful.

The classes (and tests I wrote for completeness) were actually pulled out of a private project - something I hope to be able to continue to do more of. Even though its so trivial, it is still a useful little library because I've also taken the opportunity to to try out a few new things with some public services.

* [Packagist](https://packagist.org/packages/alister/faker-extensions) [![Latest Stable Version](https://poser.pugx.org/alister/faker-extensions/v/stable.svg)](https://packagist.org/packages/alister/faker-extensions) [![Total Downloads](https://poser.pugx.org/alister/faker-extensions/downloads.svg)](https://packagist.org/packages/alister/faker-extensions) [![Latest Unstable Version](https://poser.pugx.org/alister/faker-extensions/v/unstable.svg)](https://packagist.org/packages/alister/faker-extensions) [![License](https://poser.pugx.org/alister/faker-extensions/license.svg)](https://packagist.org/packages/alister/faker-extensions)

Packagist badges are available from [poser.pugx.org](https://poser.pugx.org/)

