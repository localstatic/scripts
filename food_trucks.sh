#!/usr/bin/env bash

curl 'https://backend.thefoodtruckleague.com/events/?days=5&name=The%20Gateway' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en-US,en;q=0.5' --compressed \
  -H 'Referer: https://thefoodtruckleague.com/food-truck-finder/' \
  -H 'Origin: https://thefoodtruckleague.com'  \
  -H 'DNT: 1' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -s \
  | jq '.[] | {id: .id, name: .name, date: .occurrences[0], trucks: [.attending_trucks[].name]}'
