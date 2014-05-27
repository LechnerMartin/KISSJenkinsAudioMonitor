KISSJenkinsAudioMonitor
=======================

Simple and Stupid Jenkins Monitor which can play sound files as well as execute command line commands

This is very basic - yet useful - Jenkins Monitor.
It allows to play a sound (or execute any other command) based on the outcome of a Jenkis build.
Six different states are distinguished: OK, FirstFailure, StillFailing, NewFailure, OneFixed, LastFixed

Why was it build and alternatives:

As a Scrum Master I noticed that an extreme feedback monitor is easily overlooked and therefore not enough to notify about build problems.
So I searched for alternatives but found none that fitted my needs (Different sounds per build, works on linux).
Therefore, I programmed a very lightweight solution myself.
I you want to have something more sophisticated checkout: Siren of Shame, cctray, jcctray
Otherwise install and enjoy :)

Features:
- Plays different audio files according to outcome
- Can execute any command you can call form the shell

Attention:
- Stores your username/jenkistoken in plain text

Preconditions: 
- Linux/bash
- ruby 1.9
- Jenkins view accessible with cc.xml suffix 

Verify it works: 

run rake -> runs all tests 

Howto use:
- copy into a directory
- Edit the sh file in the bin directory (change user, pwd, url, directories, filenames, sounds or actions)
- edit crontab file to call the script periodically (crontab -e)


Crontab example:

*/1 08-18 * * 1-5 /path/to/jenkinsMonitor/bin/JenkinsMonitor.sh 2>&1 >> /tmp/monitor.log
00 00 * * * mv /tmp/monitor.log /tmp/monitor.log.old

What it does:
- run every minute between 8-18:00
- clean logfile

