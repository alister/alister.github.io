---
title: "A year at the Passport Office"
date: 2026-05-18T19:17:00+01:00
url: "blog/2026/a-year-at-the-passport-office"
date: 2026-05-18T19:17:49+01:00
layout: blog
tags:
  - rant
  - contract
  - government
  - passports
  - hmpo
draft: false
---

With the recent news that the NHS wants to  close all its Github repos (see [NHS Goes To War Against Open Source](https://shkspr.mobi/blog/2026/05/nhs-goes-to-war-against-open-source/)  and [An open letter  asking NHS England  to keep its code open](https://keepthingsopen.com/) as well as a couple of other 'war stories' of what people had seen while working on websites in for the UK Government, someone suggested writing up and sharing my own story of my ups and downs of helping to create a government website.

In 2014, I spent most of the year working at the main Home Office / Passport office in Central London. It was a contract via an agency I'd previously done some work with a few years before. This would be to put a fairly simple form online - the two-page  [LS01, Lost or Stolen Passport Notification](https://assets.publishing.service.gov.uk/media/6446453f814c6600128d04ae/LS01_0223.pdf). Along with the form, a number of other benefits were also easily added - such as email and/or SMS updates for the status, ease of contacting people for any further information that would be needed for security, and internal stats as to how often people needed to be contacted before a passport is cancelled. Since a passport is an important (and expensive) document, having an easier way to report it online would be a very good thing.

I started in Mid-February 2014, and immediately got some great news - the project lead was a tech-fan, and so had already built a Linux server that we could develop on! 

I can't recall if there was any suggestion to use Symfony framework from the other tech-teams (there was a few other projects that were using it at that time), or (slightly more likely) it was my own idea, but as the first & lead developer it was my choice, and one I would be very happy with over the course of the project. While I made a start sketching out the shape of the project, other members of the team was assembled, with other (front-end oriented) dev, QA/tester, project manager and a user researcher who would go out to trial some ideas with members of the public to make sure what we were producing was easy to understand and use.

Another very important early event was going to the main passport office, and talking with the team that handles the LS01 forms to get the passports cancelled, at their office in Peterborough. We would also invite a few of them down to London over the coming months to talk over their needs, planning upcoming functionality, and show them what we had done.  I had done much the same for my first GovUK project - the Alpha version of *Lasting Power of Attorney* - and those discussions with support staff were always very valuable.

By April, maybe early May, we had a solid start with most of the core functionality. While there was plenty to do on the back-end, it was mostly reporting & KPIs to show how long things took within the process (for example, the Passport office wanted all reports to be completed & closed , if at possible, within say 16 working hours - though I can't recall the exact numbers).  I could have deployed something useful (at least for people to look at and try) onto Digital Ocean or the like, by certainly early May - but this was to be a major sticking point of trying to get it deployed *anywhere*. While I absolutely appreciate the requirement for security, and careful handling of personal information, the project was being hamstrung with not being able to deploy it at all - to show to Passport office staff, or members of the public as part of user testing.

Now, while I would not call myself a 'devops engineer' (or similar, like 'web-ops' as was the internal name within the home office) I do now how to deploy a couple of servers, secure them, and have them host a website or two - indeed, I've had a server running in DigitalOcean since August 2013 - and other servers going back at least as far as 2004 (for my own websites) - so I was more than capable. But - I was forbidden, even for a site that would be marked as explicitly a test, and not for public use.

I knew some people that worked in GDS web-ops though, from [my time on the LPA project](https://github.com/alphagov/govuk-puppet/blob/882a4608524058631faa92eb3212caaf95b7759a/modules/users/manifests/groups/opg.pp), and also from devops-related meetups. So I dropped one of them a message on Twitter, and arranged a time for a conversation with him along with the newly installed CTO of the passport office & a new WebOps team-member that had been given to us for our assistance. So, the three of us headed over to the GDS offices, just over the road from Holborn tube station, and talked about a system [GDS had built](https://technology.blog.gov.uk/2014/05/21/using-vcloud-tools-to-provision-a-new-platform/), called [Vcloud-tools](https://github.com/gds-operations/vcloud-tools) so that we could spin up the servers and services that we needed. Much information was shared, the Passports CTO learned a lot about what could be done for ourselves, the Ops guy found out about the tools he would be able to use and create what he needed for us. He also gained contacts at GDS for further support as he needed it.  All was great, and the ops-guy and I took a quick break in Holborn to have a coffee, chat, and congratulate ourselves on a very productive meeting before heading back to the office in Marsham Street.

By the time we got back to the Home Office, the CTO had, in the meantime, signed a deal with an outside agency to do all the work of delivering the cloud-infrastructure.  I won't say what was the name of the agency, but they delivered some very caca work, and if they had actually delivered anything worth using, I would not be quite so bitter about that experience. I did hear that (not very long after finding out about them being contracted to do this work) that they had also recently failed to deliver a similar project for (I think it was) DEFRA. So, much of the next several months was spent trying to get anything usable from them, before we eventually just gave up.

Another highlight over the summer was a meeting (in a very small room) to talk about email & SMS sending. While GDS was only beginning to get some thoughts for what would become the 'Notify' project, we had to arrange something for ourselves in the meantime. The obvious answer now would be something like Twilio for SMS & then AWS/SES for the email, but this is a government project - so we looked at a company to supply both, and (as far as I remember) something like a £750/month basic fee plus the per message cost. I'm surprised I didn't spend the entire hour just banging my head against the desk with the stupidity of having a dozen people in a meeting, with a cost for maybe half of us being measured at £100 each per hour (to the agencies that then contracted us to HMPO - we maybe got half of that as contractors), to decide whether or not to pay hundreds more per month for something that even then was literal background noise in terms of the price that would ordinarily be paid out.

For the notification emails being sent to people who had reported their passport as lost or stolen, it might reach the heady heights of maybe as many as 200 emails per day - a number that, per month would fit in almost every 'free' tier of any well known email service provider that I've ever seen.

With so little happening in terms of getting the infrastructure needed to get anything deployed, I was getting bored - and burning out from trying to even look busy! So, I took two full weeks holiday in early November, instead of sitting there and waiting for anything to happen.  When I did got back, they had finally trashed the outside agency & asked the 'Passport Exemplar' team (another team within HMPO that had been created earlier in the year to put new passport requests & renewals online) to write the Puppet manifests to spin up and deploy the virtual servers & databases we needed.

I don't think we actually used the external service to send emails & SMS - as late in the year, the passport exemplar team had built their own email service that we could piggy-back on for emails, and had also arranged a service for sending SMS that we could use.

In December, we also had our mock, and then full, GDS assessments to make sure we were ready for public use. With that, and an earlier security penetration-testing passed without any major issues, we were good for an initial 'beta' release.

About the same time, we heard of other sites that were soon to be released - like the then-new Dartford Crossing payment website - taking credit card payments for the tolls. We commented between ourselves on the team that it was amazing it was allowed to go live, as there were so many apparent problems with it - one I heard of was that it would reject a credit card number if you had spaces or dashes in the field!  Although we weren't dealing with payments, we could at least assure everyone that there would be absolutely no problems with surnames like "Null" or "O'Brien", or anything else we could imagine similarly.  Why was the Dartford crossing site allowed to go live like that though?  Because the fees were going to start being charged on the just a few days later - so it had to go live...

So, just about a week before Christmas, we finally managed to get the website put live - but only with help of the ops-guys from the main passport team, and with a process that took about about an hour to build and then deploy the site through several different layers and various VMs before it was seen.

With that finally done, so was I with the project. I could have continued in the new year - on more of a maintenance basis, but I was burned out - not from overwork and time-crunches, but from trying to get things done.

{{% commentsLink %}}
  You can comment on this article on my Mastodon post for ["A year at the Passport Office"](https://hachyderm.io/@alister/116597572897791885)
  <hr/>
{{% /commentsLink %}}
