# ChefDK Code Generator
This is a code-generator to be used with the `chef generate` command.
ChefDK allows you to supply your own generator cookbook. I found that the stock
generator was missing alot of things I added to each of my cookbooks, so I
decided to roll my own.

Credit for initial figuring out how to do this goes to
[http://blog.dnsimple.com/2014/07/chef-at-dnsimple/](http://blog.dnsimple.com/2014/07/chef-at-dnsimple/)

## Usage
Check this repo out to your cookbooks directory
**NOTE** you MUST check out the repo to a directory called `code_generator`.
Any other name won't work.

Change directories into your cookbook directory and run something like this:

```
chef generate cookbook --generator-cookbook ./
```
