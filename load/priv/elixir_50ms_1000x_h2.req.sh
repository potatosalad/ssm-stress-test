#!/usr/bin/env bash

rrdtool graph elixir_50ms_1000x_h2.req.svg \
--width 600 \
--height 200 \
--start 00:00 \
--end start+39seconds \
--title 'elixir_50ms_1000x_h2' \
--vertical-label 'requests per second' \
--imgformat SVG \
--border 0 \
--font DEFAULT:0:Consolas \
--upper-limit 1000 \
--lower-limit 0 \
--rigid \
'DEF:error=elixir_50ms_1000x_h2.rrd:error:MAX:start=1544710074:end=1544710113:step=1' \
'DEF:requests=elixir_50ms_1000x_h2.rrd:requests:MAX:start=1544710074:end=1544710113:step=1' \
'SHIFT:error:-29274' \
'SHIFT:requests:-29274' \
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
