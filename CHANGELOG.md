## 0.1.1 - June 11, 2015 - Added license

Added MIT license.

## 0.1.0 - June 11, 2015 - Ruby Support

Great work @orenf
Removes support for ruby 1.9.2 and 1.8.7
Upgrades httparty
Runs on ruby 2.2.1
Fixes failing specs
APIError message now returns valid Invoice object


## 0.0.3 - October 4, 2013 - Updated multi_json gem

The multi_json gem was way out of date, but https://github.com/imajes
updated it. We also moved over to using Travis for builds.

## 0.0.2 - May 7, 2012 - Updated tests for test endpoint.

Looks like the tests were initally run against the production database
(whops). I re-ran them against test and they're still working.
No code changes for this, other than documenting the test endpoint.

## 0.0.1 - February 3, 2012 - Initial Release with get_tax call

Not much in the way of features so far, but the rough draft of the get_tax call is in,
as well as error and warning message handling. Still need to update the docs with it
once an API to the gem is finalized.
