--- 
layout: post
title: Preparing your data for a hack day
published: true
draft: false
---

In advance of the more well-planned hack days I've seen recently, one of the new ideas that they have been trying out is organising pre-event workshops and events for the organisations who will be supplying data for the main hack event.

There seem to be a few reasons for doing this:

## Explanation

It's still unclear to many people who work in cultural organisations what a hack day is all about, so it is important that people from a wide variety of organisations are invited along, told about how it works, what it is all about, and what the general principles are. This is important so that problems that might emerge on the day can be fixed in advance, and that everyone is clear what the scope of the hack is. Eg. No, someone won't sort out your website for free, but they might, if you can supply some interesting and unique data, look at doing a prototype of a mobile app that fulfils a certain purpose. 

## Opening data

Katy Beale, one of the Culture Hack team, surprised me by saying that many potential attendees aren't really aware that they have "data". This might be because people think of data as some kind of abstract, complicated thing that's stored in a big database somewhere. 

At a pre-event workshop, they spend a fair amount of time talking about what data is, and working with the cultural organisations to think about the kinds of a information they are already keeping for reporting and transparency reasons - footfall, postcode from where a visitor travelled, box office takings, usage of parts of a building, all sorts of stuff that might otherwise be ignored. Katy described a lightbulb moment that some people experienced when they realised that information they were already recording could be turned into something else at the hack day, without too much work on their part.

## Data cleaning

I've been along to many hack days where the data that is provided for us to play with is only just about good enough, and there is always a frustrated comment or two when it emerges that what at first hand appeared to be a good set of standardised data would have really strange anomalies in it which would mean that some poor soul would spend half their time on the hack day manually going through a speed sheet making it consistent so that their hack would work without bombing.

Part of the advanced work that Culture Hack do is to work with the organisations to look through the array of spreadsheets, text files, folders of images and so on in order to work out how "clean" the data is, and then to recommend anything that might need to be done by the cultural organisations to prepare it for the day.

Here's a few examples of data cleaning issues I've seen that could have prevented a hack day fail:

###Supplying a massive database dump in a proprietary format

For instance, your web development team give you a Microsoft SQL Server file that is several gigabytes in size, and gives you a link for where someone could access it. The problem here is that nobody has really looked at what it contains, and worse, it means that anybody who wants to see what it contains must download the massive file, have double or triple that in available space on their hard drive, also have a licence for that particular software (in the hundreds or low thousands of pounds, dependent on the format), and have the patience to do all of this too! 

Aim to provide data in free formats such as TXT, CSV, JSON, or XML, and provide a small subset of the data in advance do that potential hackers can get a feel for what is in the data.

### Excel documents where business logic is described as formulae

Complex Excel files are almost impossible to work with on a hack day - it just takes too long to work out the relationships between things, plus you're also relying on those present to have a paid-for licence for the software (I don't, for instance). Sometimes it is quite helpful to look through an excel spreadsheet and be a be able to look at the formulae involved. The trouble is, that if this gets complicated it is very hard to extract that logic out of the document and make other things that rely on the same relationships between things.

If possible, find a way to supply any important business logic as a human readable explanatory document.

### Documents where the text colour or background colour of things is important

I've seen lots of spreadsheets where people use red, orange and yellow background fills to denote some kind of status about something. Whilst that is useful for a person to be able to get an overview of the statuses of those things in one glance, it's quite a bit of work for me as someone who wants to do something with that information on to be able to extract it. Assuming I know Excel (which I don't very much), I'd have to write some kind of function that takes the colour of those columns and puts a value in another column somewhere. It might even not be clear what those values might equate to - what might orange mean?

Far better to have these colours in their own column in th first place, and then I can export the data as I want it for my hack.

### Inconsistencies in the data

Addresses are tricky - which column might the postcode appear in? Or perhaps in your export you are using "comma separated values" (CSV) but whatever does the export doesn't know what to do if the there are bits of text containing commas. 

Or a field  that has "Happy" as a value, but sometimes is shortened to "H" or "HAP" or "happy" or "4/5" or "4" or  "\*\*\*\*", or perhaps after a certain date it is left blank and assumed to be "happy". You can imagine the trouble - how can I write a program that uses that value, unless I manually go through every row in the data to "normalise" it to a single, standard way of describing that value. And let's say there a few of these inconsistencies... I'm going to give up and hack on something else, sadly!

So in advance, it's worth cleaning up the data, making sure things are consistent and explained.

## Thinking about rights

At some point the conversation about who owns what, as the result of a hack day, will come up. Some of the work that hack day organisers can do in advance is to discuss the kinds of rights agreements that might be made, from the point of view of the organisations and their ownership of data and derivative works; from the point of view of the hacker and the ownership of and copyright over the code they write and any improvements they might make to the data; from the point of view of the organisers and any general principles they put in place in advance of the event (everything will be open sourced under a creative commons licence, for instance), and also from the position of whoever the hack might be for - the users.

There are a few thorny issues here, so I shall cover this some more in another post.

## Planning for the hack

I find it interesting that hack days have matured to the point where we are now looking at how to ensure that participants on both sides get the most from the day. What's more, I saw definite improvements in the quality of the data that came through at the let Culture Hack, and indeed that seems to be happening at other hack days too.

Planning for the hack, or setting things up so that good things come from a unique combination of talents is a smart idea. I'm looking forward to learning about other things that people are doing to ensure hack days go smoothly.





