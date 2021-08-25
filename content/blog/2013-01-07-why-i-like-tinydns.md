---
title: "Why I like djbdns & tinydns"
date: "2013-01-07T12:21:00+00:00"
aliases:
- /blog/2013/01/07/why-i-like-tinydns/
layout: blog
tags:
- dns
published: true
---
I've been using TinyDNS, and the associated systems, like DNScache and DaemonTools since 2003, when I was first tasked with setting up a local DNS resolver, and a DNS server for a web-development company I was working at <https://www.datasouth.co.uk/>. We had dozens of domain names, and organising the changes - as well as paying per domain name, was getting to be, well, annoying, as well as potentially expensive.

So, I was asked to setup our own name servers....<!--more-->

I looked at BIND, and even bought the O'Reilly 'Cricket' book, but the plan was to use an in-house database management system/CMS to hold the details of the various DNS records and then output the pieces to the DNS server. The thought of producing bind format text files did not appeal - the are pretty complex.

Then, I came across another option - TinyDNS, and a few associated tools, written by djb - Daniel J. Bernstein, who is a mathematician, cryptologist, programmer, and research professor of computer science. It's very _opinionated_ software, and so is the configuration, but easy enough to follow a howto and get working.

One of the design choices that make it so easy to work with is that there is a simple-to-understand format for the configuration file, one line per record, for example each Cname, A or MX record is just one line, with the first character being the type (for example a '@' for an MX record), and the various parts of it is then split up between colons. The latter parts of the record, with information as time-to-live durations, and other defaults, can be safely left to the defaults.

See: <https://cr.yp.to/djbdns/tinydns-data.html> for the exact structure of the data file (or, in fact, of each line that you will generally be using).

Given the various records already in a database, converting them each into such a simple output format is not very difficult at all. In fact, I used an existing perl script as a large basis to do the conversion (porting the perl to PHP was itself trivial), and simply wrapping some database access code around it.

Since the output was just a text file, which was then compiled down into a small database, it was also trivial to have all the name servers (including a tertiary, ns3, name server) call into the server by HTTP (from a cron-job). The web-page produced the data, and output the file as plain text. With the page protected by IP and a HTTP password, it's entirely secure, and very easy to setup.  

In my next djbdns/tinydns post, I'll show you how to setup your own, local top-level domain names - which I find very useful for development, among other things.

Also take a look at the first post in this little series: [DNS and my refreshed CV site]({{< relref "2012-12-31-dns-and-my-refreshed-cv-site.md" >}}), where I also how an example of a TinyDNS zone file, and how simple it can be made with LuaDNS.
