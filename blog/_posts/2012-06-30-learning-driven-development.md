--- 
layout: post
title: Learning Driven Development
published: true
draft: true
---
Test Driven Development (TDD), Behaviour Driven Development (BDD), Business Driven Development... there's plenty of "Driven Developments"

Here's another to add to the list, that I've been thinking about recently: "Learning Driven Development".

TDD is a software development methodology that aims to improve software quality by requiring the developer to write automated tests before they write the code that fulfils the requirements of the tests. The typical flow is "get a requirement", "write a test for the first step to fulfilling the requirement", "run the test", "watch it fail", "write the smallest amount of code required to fulfil the test", "run it again", "watch it pass", "refactor the code as required" (Refactoring being the process of rewriting, reorganising code for a variety of reasons). In this way, you ensure that you're only writing the bare minimum of code required to do the thing that is required, you have code that is documented (the tests become your documentation), and your application should be robust and easy to pass on to another developer should you need to.

BDD takes this a step forward and deals with the behaviours of users. In BDD we talk at a higher level about different types of users, what these users want to achieve and how we might measure the success of these things. Typically, we're able to write very similar tests to what we would in TDD but with an added "human-understandable" layer on top. For an apple website we might see "In order to sell more apples, as a potential customer I can get one apple free with each dozen that I add to my basket", which implies all sorts of features - a "basket", a "deal", a "customer", some way of representing "apples", some way of representing multiples of apples, and so on. But the crucial thing is that the actual feature is tied to the business goal or behaviour we want to support.