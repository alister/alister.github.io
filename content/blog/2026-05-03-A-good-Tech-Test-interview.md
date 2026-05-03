---
title: "A Good Tech-Test Interview"
url: "blog/2026/good-tech-test-interview"
date: 2026-05-03T15:56:49+01:00
layout: blog
tags:
  - interview
  - employment
draft: false
---

A couple of days ago, I had a second interview for a job - after an initial conversation with a tech-lead of the company. I wanted to write a post about it, and praise it as a really good example.

What makes it good is that it wasn't just a pop-quiz about things, and certainly not a leetcode style coding test, but with some real code that the company uses, and that the job deals with on a pretty much daily basis at the core of the company.

The interviewer had taken their own codebase and removed most of it to end up with a simplified version, and with far less functionality, but what was still there was still useful as its core. Then they added several 'bugs' mostly based on the real issues they had previously seen.

What was left also removed 99% of the calls to external functionality, such as where the real one would fetch data from APIs and create things in another system - and so this mostly came down to a fairly fancy CRUD application with a hierarchy of organisations having places and each of those places doing things - in reality, there are more levels and more complexity well beyond that.

What made the test so good was it was a (stripped down) version of the actual codebase, and even more usefully, I got it 24 hours before the actual meeting was due, so I could get it setup on my own machine with docker to run the site, and database - and my own favourite IDE to explore it to see what it did, and how it worked.  It also allowed me to see an extensive example of the quality of code they had already produced - along with some of the tooling (such as PHPStan at level 8, with some baseline errors ignored - still quite impressive to be generally working at that level however).

The main discussion on the day (after the inevitable introductions and chatting about previous roles and experience) was to look for several of the pre-planted bugs and see how I would solve them.  This is an adventure that I would be playing with my own favourite tools. I won't say what sort of things I was being asked to find (though some were a little more involved to reproduce), but it was very much the sort of things that a developer would be asked to do in a regular day-to-day role - and that was the point.

It did help that I had already spotted (and could make an easy fix) for the second bug they asked me to look for. So we were all smiling when I said as much, and walked quickly through what I had done (including a short blind-alley diversion that I had taken myself with my investigations earlier while debugging). The others were more involved, and I'd not seen the problems on the site & code in my previous browsing, but the underlying bugs were findable with some minor pointers - as would hopefully be available to any developer new to a project.

We rounded out the discussion with ideas for how I would suggest handling some new functionality, followed with some ideas from them about what they want to add over time to the code they are producing for the company.  The entire interview/discussion ended up taking about 2hrs 25mins (from a planned 2 hours) -  along with some questions from me about the company and technical environment (for example - I think it's great to know what spec a developer machine is....).

Another point to leave me with a positive thought of the day came half-way through the 2+hour conversation was a 5 minute comfort break. It can be these little things that make the difference to someone being interviewed, making the difference between an extensive chore, to a fun experience. Interesting, and interested people to talk to, also help a lot!

All in all, a very positive experience, and I'd very much suggest such a structure for others to use when hiring - at least with developers with a measure of existing knowledge of at least the language and framework and to see what they would be working with. Getting a better indication of someone's mindset and skills in a more real-world scenario - and showing them something of what you are like (code-wise) - is incredibly valuable.
