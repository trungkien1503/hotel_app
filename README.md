# Hotels data merge

## Introduction

To write the application you can use any language. It should work as a web server. You can post it as a gist, upload to github or send us via email, anything works as long as the code is correct and you send us instructions how to use it.

## Background

In any hotels site like Kaligo.com operated by Ascenda, there's a lot of effort being made to present content in a clean & organised manner. Underneath the hood however, the data procurement process is complex and data is often mismatched & dirty.

This exercise gives you a sneak peak in some of the actions we take to clean up data before it makes it to the site

- we are querying multiple suppliers to assimilate data for these different sources
- we are building the most complete data set possible
- we are sanitizing them to remove any dirty data
- etc.

The task is to write a simplified version of our data procurement & merging proceess.

It needs to work in the following way:

## Requirements

1. Merge hotel data of different suppliers
  1. Parse and clean dirty data
  2. Select what you think is the best data to deliver using some simple rules
2. Deliver it via an API endpoint by you which allows us to query the hotels data with some simple filtering
