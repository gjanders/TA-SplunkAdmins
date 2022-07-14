## SplunkBase
This TA will soon be available on splunkbase...

This TA app is the companion app for [Alerts for Splunk Admins](https://splunkbase.splunk.com/app/3796/) or [Alerts for Splunk Admins github](https://github.com/gjanders/SplunkAdmins/)

You may also be interested in [VersionControl For Splunk](https://splunkbase.splunk.com/app/4355/) or perhaps [Decrypt2](https://splunkbase.splunk.com/app/5565/)

## Introduction
This application accompanies the Splunk conf 2017 presentation "How did you get so big? Tips and tricks for growing your Splunk installation from 50GB/day to 1TB/day"

The overall idea behind this application is to provide a variety of alerts that detect issues or potential issues within the splunk log files and then advise via an alert that this has occurred
This application was built as there were a variety of messages in the Splunk console and logs in Splunk that if acted upon could have prevented an issue within the environment.

## Installation
This application can be installed on the search heads, there are some alerts from the Alerts for SplunkAdmins app that will use the custom commands streamfilter or streamfilterwildcard.

The lookup watcher modular input is also included in this application
 
## Custom search commands
Due to the current SPL not handling a particular task well, and the lookup commands not supporting regular expressions, I found that the only workable solution was to create a custom lookup command.

Two exist:
- streamfilter - based on a single (or multivalue) field name, and a single (or multivalue) field with patterns, apply the regular expression in the pattern field against the nominated field(s)
- streamfilterwildcard - identical to streamfilter except that this takes a field name with wildcards, and assumes an index-style expression, so `*` becomes `(?i)^[^_].*$`, and `example*` becomes `(?i)^example.*$`

Search help is available and these are used within the reports in this application. The Splunk python SDK version 1.6.5 is also included as this is required as part of the app, an example from the reports is:
`| streamfilterwildcard pattern=indexes fieldname=indexes srchIndexesAllowed`

Where indexes is a field name containing a list of wildcards `(_int*, _aud*)` or similar, indexes is the output field name, srchIndexesAllowed is the field name which the indexes field will be compared to.
Each entry in the pattern field will be compared to each entry in the srchIndexesAllowed field in this example

To make this command work the Splunk python SDK is bundled into the app, if the bin directory is wiped due to issues with other applications this only disables the two commands which are used in `Search Queries summary non-exact match` so far 

## Lookup Watcher
The Lookup Watcher is a modular input designed to work in either search head clusters or standalone Splunk instances to determine the modification time and size of all lookup files on the filesystem of the Splunk servers.
In a search head cluster the input will run on the captain only by running a rest call on each run, on a non-search head cluster it will always run.
To use this, on a non-search head cluster simply go to Settings -> Inputs and create the Lookup Watcher modular input, the name of the input does not matter, you just need to create 1 input. 
Note that the debugMode is optional and defaults to false, enabling this generates more logs for troubleshooting.

Under the more settings button choose an index to send the data to and an interval to run the script

On a search head cluster you will need to push an inputs.conf via the deployer server (if you are unsure of the syntax create one on a standalone server first)

Once done the additional logs can be used to determine how often lookups are updated and how big they are

Tested on Windows & Linux on Splunk 7.x.

Lookup Watcher generates a log file is created in `$SPLUNK_HOME/var/log/splunk/` and will also be in the internal index with the name `lookup_watcher.log`

## Feedback?
Feel free to open an issue on github or use the contact author on the SplunkBase link and I will try to get back to you when possible, thanks!

## Release Notes

### 1.0 
Initial version

## Other
Icons made by [Freepik](http://www.freepik.com) from www.flaticon.com is licensed by [Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0)
