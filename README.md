## Problem

Write a simple web scraper to help us visit the tide pools. Use any language and/or tools that you want.

Go to https://www.tide-forecast.com/ to get tide forecasts for these locations:

  - Half Moon Bay, California
  - Huntington Beach, California
  - Providence, Rhode Island
  - Wrightsville Beach, North Carolina

Load the tide forecast page for each location and extract information on low tides that occur after sunrise and before sunset. Return the time and height for each daylight low tide.

## How to Run

Ensure your environment can execute Ruby (https://rvm.io/rvm/install)

Install the Bundle dependency manager (`gem install bundler`)

Install dependencies (`bundle install`)

Execute tests (`bundle exec rspec`)

Output results to console (`ruby entry_point.rb`)

## Design Decisions

After considering a simple shell script, I decided to use Ruby for its testing framework. 

This code separtes the problem into three concerns:

`TideStation#days` is responsible for parsing the HTML into a hydrated list of `Day`s which have many `Event`s. 

`Day#daylight_lowtide` is responsible for iterating over its events to detect lowtides occuring between Sunrise and Sunset.

`entry_point` prints the requested return format to stdout. In production this would instead be an async job that caches the data at a set interval.

This separation of concerns allows the classes to be independently tested. Moreover, the project would be easily extended since the full day/event object graph is available. For example, a new requirement to return High Tides occuring before Sunrise could be trivially satisified with another method on `Day`.
