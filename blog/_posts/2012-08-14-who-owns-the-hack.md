--- 
layout: post
title: Who owns the hack?
published: true
draft: false
---

Attend any hack day or hackathon and at some point someone will ask a question about ownership over a hack - the software and design that has gone into its production, any data/APIs that it uses, and any pre-existing stuff (software libraries, things copied and pasted from previous projects, etc.) used in its creation.

Each event is different and will have its own set of guidelines. Here are a few observations about the different kinds of licensing and ownership issues you might need consider at a hack day. 

Note: I'm not a lawyer, and this isn't legal advice! If you're having an issue with licensing post-hack you should get some proper legal advice from an IP specialist.

## By default

Unless some other agreement is made, copyright on code and designs are retained by whoever makes the hack. You can't copyright an idea, but if you have a team of people making it, it's generally understood that "anything new" is owned collectively by the team until some other agreement is made, and that people own the rights for "anything old" that they have created previously that they use in making the hack.

Any data used in the hack is under whatever licence the data provider grants for the hack, but that doesn't mean they automatically get any rights over the resulting hack. Sometimes at hack days pre-released, time-limited or non-commercial-only data licences apply. That's usually to prevent a situation where a data provider could inadvertently close down a future commercial opportunity by "giving it away for free" and serves to remove a potential risk. If you're a data provider, have a conversation with the organiser about a usage agreement you'd be happy with.

## Full ownership by the organiser or sponsor

Occasionally a hack day will be organised specifically for a company to learn and the attendees will be paid for their time. If that's the case then sometimes the intellectual property to the results of the event will be retained by the organiser or sponsor. Essentially, the idea is that it's a "paid-for hack", equivalent to a day of freelance consultancy, so this is a perfectly legitimate approach. You might find at some of these events that the results aren't made public, and the source code is not released publicly either.

## All hacks under the same licence

I've seen a handful of hackdays advertise in advance (one just hit my inbox) that all of the hacks will be released under a specific licence - usually one of the many Creative Commons licences. I'd be interested in talking to the organisers of these events because I can see a number of problems and benefits with applying a blanket licence.

If you're intending on organising such a day, I'd advise saying well in advance (in the announcement for the event) that a (for example) CC licence would apply, because it could avoid any embarrassing or difficult conversations on the day. 

Using a creative commons licence for a hack day is admirable - what you're saying is that you hope that the results of the day can be used by others to do interesting things in the future, and that the effect of the day is maximised by ensuring wide dissemination of the hacks.

However, given that hack days are very short in duration, attendees will have spend a lot of time getting fast at starting from scratch in order to complete something within a short space of time. So they will tend to be bringing along a lot of code that they have used before. Does this licence include that other work? I can't see how it can't, given that the code will end up on GitHub with a CC0 licence applied to it.

As an example, an upcoming [Wellcome Trust game-hack](http://www.wellcome.ac.uk/Funding/Public-engagement/Funded-projects/Major-initiatives/Broadcast-media-strategy/Gamify-Your-PhD/WTDV033976.htm) requires pre-formed teams of games designers and developers to attend an event where their work will be released under creative commons. In order to produce a good game in a short space of time, a developer will be reaching for code they've written before. I can't personally see the justification for applying that CC licence to the pre-written code used in the making of the hack.

So as an attendee I have two options (assuming I want to attend) - release anything that I've made in the past under this new licence, or don't use my existing stuff and start completely form scratch. It comes down to how fast you want to be able to work, and whether you are ok with releasing your stuff because the organisers say so.

Another issue is that, let's assume you've made a really great hack and there is a large amount of interest in it after the hack day. Would having released the code under a creative commons licence mean that you might not be able to get funding for the idea? Would that count as you being "naive" in the eyes of a potential investor..? I don't, but it sounds like a risk.

Obviously, code written at a hack day is likely to be pretty low quality, pragmatism-over-idealism stuff and it could be argued that it therefore has low value. However if you wanted to get investment and to do so meant deleting your hack and starting again from scratch, that's not an attractive idea for most people.

Personally I find it a bit of a blunt approach. I'd much rather have a "suggested" licence, and if you're unhappy for some reason, apply whatever licence you like. Indeed, I did this with Chircle, because I saw that it might have potential to be an interesting product rather that just a hack.

## Whatever licence you like

In general, most hack days that I've attended use this approach. In fact, the majority of hacks probably don't have any kind of licence applied. My preference is to copy and paste the standard MIT licence and put it in a readme (assuming I want to request the code, which I do most of the time). This licence means that the hacker retains copyright but that anyone is free to use it, even for commercial projects.

## In conclusion

It's worth thinking through the reasoning for whatever licensing approach you might have chosen for your hack day, and including a short paragraph somewhere explaining it, especially for paid-for hacks, or ones where you wish to apply a blanket licence.


























