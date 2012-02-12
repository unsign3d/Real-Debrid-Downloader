Author:  Luca Bruzzone http://www.unsigned.it
Licence: http://creativecommons.org/licenses/by-nc-sa/3.0/

This is a simple command-line downloader for Real-Debrid.fr
The aim was actually create a script for download all night long
some of the link.

HOW TO USE
-- Step 1
in main.rb change
Downloader::new('user', 'password', 'list.txt');
with your user and password

--Step 2
put all your link (one per line) in list.txt

--Step 3
put in your console
$ ruby main.rb 

KNOWN BUGS
- Strange messages when link is broken (Sorry but I don't have much time in this period...)
- I think the syntax is quite horrible
- Drunk too few coffee to write it

CHANGELOG

# Patch 1
- Added percentage for download