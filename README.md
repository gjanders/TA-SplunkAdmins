## SplunkBase
Available on SplunkBase as [TA-Alerts for SplunkAdmins](https://splunkbase.splunk.com/app/6518/) or [TA-SplunkAdmins on github](https://github.com/gjanders/TA-SplunkAdmins)
This TA app is the companion app for [Alerts for Splunk Admins](https://splunkbase.splunk.com/app/3796/) or [SplunkAdmins github](https://github.com/gjanders/SplunkAdmins/)
You may also be interested in [VersionControl For Splunk](https://splunkbase.splunk.com/app/4355/) or perhaps [Decrypt2](https://splunkbase.splunk.com/app/5565/)

## Introduction
This application accompanies the Alerts for SplunkAdmins application on SplunkBase. 
This TA provides the lookup watcher modular input along with the streamfilter and streamfilterwildcard custom commands. These custom commands are used by a few searches within the Alerts for SplunkAdmins application
Additionally other custom commands are included related to changing TTL values in Splunk searches

## Installation
This application only needs to be installed on the search heads or search head cluster 
 
## Custom search commands
Due to the current SPL not handling a particular task well, and the lookup commands not supporting regular expressions, I found that the only workable solution was to create a custom lookup command.

The following commands exist:
- streamfilter - based on a single (or multivalue) field name, and a single (or multivalue) field with patterns, apply the regular expression in the pattern field against the nominated field(s)
- streamfilterwildcard - identical to streamfilter except that this takes a field name with wildcards, and assumes an index-style expression, so `*` becomes `(?i)^[^_].*$`, and `example*` becomes `(?i)^example.*$`
- listdispatchttl - Provided with an app name, owner, sharing level and saved search name this lists the dispatch.ttl value of a saved search
- listdispatchttlall - Provided with an app name, owner, sharing level and saved search name this lists the dispatch.ttl and any action.`*.ttl` values of a saved search
- changedispatchttl - Provided with an app name, owner, sharing level, saved search name and TTL value this changes the dispatch.ttl value of a saved search
- changedispatchttlall - Provided with an app name, owner, sharing level, saved search name and TTL value this changes the dispatch.ttl and any action.`*.ttl` values of a saved search

Search help is available and these are used within the reports in this application. The Splunk python SDK version 1.6.5 is also included as this is required as part of the app, an example from the reports is:
`| streamfilterwildcard pattern=indexes fieldname=indexes srchIndexesAllowed`

Where indexes is a field name containing a list of wildcards `(_int*, _aud*)` or similar, indexes is the output field name, srchIndexesAllowed is the field name which the indexes field will be compared to.
Each entry in the pattern field will be compared to each entry in the srchIndexesAllowed field in this example

To make these custom commands work the Splunk python SDK is bundled into the add-on as per Splunk development practices

The list/changedispatchttl commands have two dashboards, one called `dispatch_ttl_changer` which is for admins to change the TTL on any savedsearch
Another called `dispatch_ttl_changer_global` this uses the current user context & app context and is useful when shared globally 

## Lookup Watcher
The Lookup Watcher is a modular input designed to work in either search head clusters or standalone Splunk instances to determine the modification time and size of all lookup files on the filesystem of the Splunk servers.
In a search head cluster the input will run on the captain only by running a rest call on each run, on a non-search head cluster it will always run.
To use this, on a non-search head cluster simply go to Settings -> Inputs and create the Lookup Watcher modular input, the name of the input does not matter, you just need to create 1 input. 
Note that the debugMode is optional and defaults to false, enabling this generates more logs for troubleshooting.

Under the more settings button choose an index to send the data to and an interval to run the script

On a search head cluster you will need to push an inputs.conf via the deployer server (if you are unsure of the syntax create one on a standalone server first)

Once done the additional logs can be used to determine how often lookups are updated and how big they are

Tested on Windows & Linux on Splunk 7.x. Tested on Splunk on Linux version 8.0.x, 8.2.x

Lookup Watcher generates a log file is created in `$SPLUNK_HOME/var/log/splunk/` and will also be in the internal index with the name `lookup_watcher.log`

## Feedback?
Feel free to open an issue on github or use the contact author on the SplunkBase link and I will try to get back to you when possible, thanks!

## Release Notes
### 1.0.1
Added custom commands:
- listdispatchttl
- listdispatchttlall
- changedispatchttl
- changedispatchttlall

Along with two dashboards to change TTL values via the UI

Changed visible to true (as this add on now includes a dashboard, which you can move to another app if preferred and hide this one)

### 1.0.0
Initial version

## Other
Icons made by [Freepik](http://www.freepik.com) from www.flaticon.com is licensed by [Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0)
