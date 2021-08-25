---
title: "DNS and my refreshed CV site"
layout: blog
date: 2012-12-31T12:07:00+00:00
aliased:
- /blog/2012/12/31/dns-and-my-refreshed-cv-site/
tags:
- dns
- wordpress
---
It has been in process for a little while, starting when I moved the bulk of my DNS hosting from <https://www.bytemark.co.uk/> (with whom I've had a small virtual machine since April 2004). One of the things I really like about Bytemark was the free DNS hosting they provided, particularly since they used [TinyDNS](https://tinydns.org/) - which is worthy of its own post. To add a new domain name, create a small file with the relevant lines, with one per DNS record - really easy if you have any kind of database or automation.
<!--more-->

{{< gist alister 4419185 >}}
<!--{% gist 4419185  %} tinydns record -->

Back in April (2012), I came across [a post on HackerNews](https://news.ycombinator.com/item?id=3794654) to <https://www.luadns.com/>. This is a system that again, uses TinyDNS as a backend, but instead of some hacked-together PHP scripts I wrote to produce the data files, they are run through a Lua script. That gives the benefit of very easy to read configurations, and then the files themselves are stored in a Git repository, which can arrange to notify the main luadns website whenever it is changed, so the records are updated whenever the repository is.

{{< gist alister 4419224 >}}
<!--{% gist 4419224  %} luadns record -->

So, with the use of the service from luadns, I had a good reason to a) move my DNS off bytemark (with the intention to also eventually shut down my old server there), and b) tidy it up as I went. So I did. I had already moved my tech-blog to <https://phpscaling.com/> last year, and over this last few weeks, I added <https://abulman.co.uk/> to the same Wordpress installation.

Supporting different domain names for (at least) two different blogs isn't too easy in a stack Wordpress 3 installation. It isn't made any easier becuase I also have a couple of domain name aliases that point to the <https://abulman.co.uk/> site (there is also <https://alisterb.co.uk/>, and of course there is also the www.* versions) and so I was having a lot of trouble till I found the [wordpress-mu-domain-mapping](https://wordpress.org/plugins/wordpress-mu-domain-mapping/) plugin. While it's not quite a drop-in plugin (you have to copy some files around manually) and of course setup the IP address and domain names, it solved my problem.
