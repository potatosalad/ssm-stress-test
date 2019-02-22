#!/usr/bin/env bash

rrdtool graph go_best_h1.req.svg \
--width 600 \
--height 200 \
--start 00:00 \
--end start+38seconds \
--title 'go_best_h1' \
--vertical-label 'requests per second' \
--imgformat SVG \
--border 0 \
--font DEFAULT:0:Consolas \
--upper-limit 100000 \
--lower-limit 0 \
--rigid \
'DEF:error=go_best_h1.rrd:error:MAX:start=1544709339:end=1544709377:step=1' \
'DEF:requests=go_best_h1.rrd:requests:MAX:start=1544709339:end=1544709377:step=1' \
'SHIFT:error:-28539' \
'SHIFT:requests:-28539' \
'CDEF:ln1=requests,requests,UNKN,IF' \
 \
'TICK:error#e60073a0:1:  Error' \
'AREA:requests#7648eca0: req/s\l' \
'LINE1:ln1#4d18e4' \
'VDEF:requestsmax=requests,MAXIMUM' \
'VDEF:requestsmin=requests,MINIMUM' \
'VDEF:requestsavg=requests,AVERAGE' \
'COMMENT:\u' \
'GPRINT:requestsavg:AVG %6.0lf' \
'GPRINT:requestsmin:MIN %6.0lf' \
'GPRINT:requestsmax:MAX %6.0lf\r'
