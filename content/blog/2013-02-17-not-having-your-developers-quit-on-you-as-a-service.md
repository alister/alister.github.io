---
title: "Not having your developers quit on you - as a service"
date: "2013-02-17T17:30:00+00:00"
layout: blog
tags:
- employment
- contract
- anti-pattern
published: true
---

{{< tweet user="alister_b" id="302046661528649728" >}}

<!-- <blockquote class="twitter-tweet" align="right"><p>Developers! Trying to work for a company with crappy s/w practices sucks. Don't succumb to Stockholm Syndrome. Do better</p>&mdash; Alister Bulman (@alister_b) <a href="https://twitter.com/alister_b/status/302046661528649728">February 14, 2013</a></blockquote><script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script> -->
Discuss at [Hacker News](https://news.ycombinator.com/item?id=5238705)

It's never good when someone feels they need to quit a job (or contract) rather than be able to continue, but sometimes, if the environment that they are working is so just so toxic and/or painful to work within, then it can be the best thing for all parties.

That doesn't mean that I particularly keen to admit that I've done it twice in the last five months. It's useful to tell you the why, of what happened though. <!--more-->

The name of the company itself isn't important, though they do deal in the enterprise and government space. The sites that are being written aren't themselves particularly big or complicated, nor are they high traffic - though I very much doubt they are cheap - selling to large organisations has its own specialised costs in itself. Some small parts of them are more complicated than others though - like the internal intranet that deals with holidays being reseerved and taken by the staff (which number several hundreds) - this is part that I spent a little time in myself, but I'll get back to that.

Rewind to mid-January. I interview for a full-time tech lead role at the company. It's clear at the interview that they need a good lead developer to help the team modernise their practices. At the end of the interview I'm asked if I would be willing to work as a home-base contractor. OK - it's more money and less hassle than a 40 minute commute on the tube in the morning.

Four days later, and thats including the weekend, I get a phone call from the recruiter that put me up for it. They'd like to have me as a home-based contractor. A speedy response is a good sign - and certainly better than the week or I'd been waiting after 2nd or 3rd interviews with other positions. Just becuase a company if fast for the first part, it doesn't mean they are any good in anything else. After the paperwork had been completed, it was a full week before I was invited in for a first day at the office to meet the rest of the development lead team.

It wasn't going well. After a week's wait, I'd expected a laptop to be waiting for me, setup with the VPN access, and maybe even a development environment. This was an 'enterprise' outfit, complete with infrastructure department and full-time sysadmins. Even the live server configuration was at best, basic. There was no automation for the servers configurations, and it appeared that the dozens, even hundreds of sites had all been recently migrated manually from some old servers. A nearly perfect opportunity had been completely ignored to improve the deployment of the live websites, and to automate the servers as well. Instead, the machine configuration was written out, step by step, on the internal wiki.

That lack of system, and site, configuration was one of the things that surprised me the most. Deploying a website - to staging, or production - is the sort of thing that will happen regularly, maybe a couple of times a day, even if changes to any one site is infrequent. None of that happened though.

I left the office before lunch, since the laptop I would need wasn't ready.  it would be another 7 full days before I could pick it up.

Lets see the take-aways so far.

#### 1. If you don't automate the server configurations, you will still have things to do next year. They are your pets, love them all individually
#### 2. Sysadmins are paid to deploy code. Let them do it, according to the listed steps
#### 3. Developers don't cost much money. They can wait a week before they get a machine to use. (Contractors don't get paid till you are ready to start)

I spent the first two days with the laptop trying to get a reasonable development environment going. In the last two years (or more!) the classic setup has been a virtual machine running locally, often with a configuration management tool like Puppet to easily bring up the relevant software (LAMP) stack. Without automation in place, that setup simply doesn't exist. The version of software you develop on might, or might not be in any useful way be compatible with the versions on the live site. By the time I had brought up a 32bit Ubuntu 12.10 VM (I'd first tried with a 64bit VM, but the laptop was locked down to not enable the virtualisation support in the CPU/BIOS) and tried to fetch the source code from the source-code (subversion) repository.

It was half-way through the second day at work (at home) that I was given SVN repo access to be able to download the code to the websites I'd be working on. I actually got the site running (though, as a CMS it was largly useless without the uploaded assets or database). It wasn't helped by the fact that Silverstripe (the CMS they were using) had had [a bug in it for a couple of years](https://github.com/silverstripe/sapphire/commit/9ffa903d50692dad4f3acb9908aa6769d17ebcb8#core/ManifestBuilder.php) which PHP5.4 had immediately complained about. So I gave up trying to do it the right way.

#### 4. Every developer has unique needs. Wait until they ask for something before giving it to them - like access to the source code
#### 5. Every developer understands how to install your site, no matter how complex. No need for documentation
#### 6. Running PHP with <code>error_reporting(0);</code>, means there are no more problems in the code!

The only thing left to me was the dev-host machine. A central server that I could connect to over Samba, that ran a database, with many copies of the data for testing and a space to be able to check out the site you were working on. Just the one site, unless you figured the magic incantations of the various configuration files (a few of which weren't even in version control!) to be able to put the entire site in as a sub-directory of the development environment.

So, to be able to develop more than one, you had to change the way the site worked, in some quite important ways, and then you had to make sure that you worked on it very carefully, because if you got it wrong, there was no way to see there was an error until after the site had gone live - becuase sometimes, the site can't be tested properly, becuase any test would be in the same sub-directory.  No wonder they liked to deploy code (manually) out of business hours. There was no way to tell how badly something could have been broken without anyone being able to know.

Now, having a single main dev-server for an office (even maybe for remote developers), isn't an intrinscally a bad idea, although lss so when it's still running Ubuntu 8.10 and has been online without a reboot since December 2010 (yes, over 800 days uptime!). I've set a few up before myself - at least, before decent laptops that can easily run VirtualBox appeared. I probably setup my first - for other people to use beyond myself - literally ten years ago, when I started as sysadmin at <https://www.datasouth.co.uk/> (and they are still going!).

#### 7. He who dies with the most uptime, wins.

The only difference was, I did it right, even back then at Datasouth. I had set it up with dynamic virtual hosts, you you could create a sub-directory, with say a htdocs/ directory, and that automatically enabled a new site. For example, given a file within a specific directory:

    /home/fred/sites/testing123/htdocs/index.php

it would instantly enable a live webpage at a URL such as:

    http://testing123.fred.example.com/index.php

Create a new directory, alongside 'testing123', and you get a different URL - for a completely different website to test, and checkout of the code repository as a whole. Now, I'm not saying it wasn't without some issues, back then, the Apache (v1.3) module that enabled such a scheme didn't set everything you would have entirely expected, so the site had to work out a couple of things for itself (like the value of $_SERVER['DOCUMENT_ROOT']) - but this was easy common code that got just included in every PHP page automatically.

The _other_ way - that my last contract used - was different configurations, unique to every site (and undocumented, while it was at it) to enable the site-as-subdirectories. This did not enamour itself to me. There are so many potential problems with it.

#### 8. Making it easy to create and test sites just makes programmers lazy. They should do it right first time, no matter how complex.

Did I tell you about the website databases yet?  The live sites mostly ran a CMS, Silverstripe, or maybe some Drupal sites, backed by a MySQL database. So far, so standard. The database tables, were all MyIsam-type tables. Yep, the slow, crashy types that when the machine fell over (as all machines will inevitably do) would lock the tables and require a rebuild of potentially dozens, or hundreds of them before the site would come back up successfully.

I first noticed this brilliant plan on the part of the original sysadmins and developers when I looked at the devhost database, with some 150 databases and countless tables in total. One copy of each database per site, for each developer.  The two sites I was working on had live DB's approaching 1 gigabyte each, which made the (fully manual) syncing of the DB onto the development server 'fun'. That wasn't automated either, which was a shame, considering that Silverstripe tended to use a few of the tables just as audit logs. So, of the 1GB of DB table and indexes, about 750MB was just logs.  Which also helped to explain why the devhost's disk was 98% full.

#### 9. The best place for an automated log is a MyIsam table! Don't forget to keep a dozen copies on dev as well.

Between Monday 11th and Thursday, 14th February, I'd solved a couple of trivial bugs, one a simple CSS placement that had forced a widget to a particular place on sccreen (in IE). it now flowed with the rest of the text, appearing after the article. To solve the other bug, I had listed four date periods (to make it a fraction moreinteresting, not all four were simple 12 month durations, and the window would keep moving as time progressed). Both had been ticketed as solved and were all awaiting signoff.

The date fix though, solved three slightly different issues/bugs at the same time. Before that could go live on the intranet it would require signoff from FIVE different people, and then be scheduled to be updated - out of business hours. That intranet was used by 200-300 people. Compare that with one of my favourite (and interesting) roles of the last 5 years - <https://www.binweevils.com/>, where we reached as many as 10,000 concurrent players (not possible users, but people all playing the game at the same time). Clearly, updating the website when the player count was so high would have been reserved for critical situations, but with a couple of thousand players online when I would deploy some new, or updated code? That was almost a non-event, and likely a weekly one as well.

So, Valentines Day, and seven days since I had started my latest contract, I woke up as usual, and sat down in front of my PC & laptop to stare at it. For an hour and a half, I just could not bring myself to work in such a crap-pile.  And so, I quit.  I handed back my laptop the same day, and I feel so much better for it already.

#### 10. Jobs are scarce in the current economy. developers will put up with all sorts of shit and just smile

* <https://hackerjobs.co.uk/jobs>
* <https://www.techcityjobs.co.uk/>
* <https://www.jobserve.com/gb/en/JobListing.aspx?shid=ECAB04F6C24FB8A469>
* <https://twitter.com/search?q=%23php%20job>
* <https://www.ukstartupjobs.com/>
* <https://workinstartups.com/job-board/jobs/programmers/>
* <https://jobstractor.com/developers/PHP/#!/London>

## Employers

If your development environment isn't working, and doesn't allow your developers to easily write, test and deploy code, you have an immediate and critical problem. Don't sit on your hands for months hoping it will somehow improve, while you are not doing anything to help it.

## Employees and Contractors

Your skills are valuable. Don't allow them, or your time, to be wasted in situations that don't make it enjoyable and easy to concentrate on interesting problems, or at least valuable solutions. If you have to fight in order to write good code, know this: there are places where your skills are valued, and will be nurtured. Don't be a victim; You can do better - by not allowing yourself to be dragged down into the mud of bad development.

----
Discuss at [Hacker News](https://news.ycombinator.com/item?id=5238705)
