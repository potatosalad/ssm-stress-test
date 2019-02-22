#!/usr/bin/env bash

rrdtool graph elixir-10x-100x-1000x.svg \
--width 600 \
--height 200 \
--start 00:00 \
--end start+38seconds \
--title 'elixir s=10x vs s=100x vs s=1000x (c=100, w=50ms)' \
--vertical-label 'requests per second' \
--imgformat SVG \
--border 0 \
--font DEFAULT:0:Consolas \
--upper-limit 750 \
--lower-limit 0 \
--rigid \
'DEF:eh1requests=elixir_50ms_10x_h2.rrd:requests:MAX:start=1544708930:end=1544708968:step=1' \
'DEF:gh1requests=elixir_50ms_100x_h2.rrd:requests:MAX:start=1544709976:end=1544710014:step=1' \
'DEF:eh2requests=elixir_50ms_1000x_h2.rrd:requests:MAX:start=1544710074:end=1544710113:step=1' \
'SHIFT:eh1requests:-28130' \
'SHIFT:gh1requests:-29176' \
'SHIFT:eh2requests:-29274' \
'CDEF:eh1ln=eh1requests,eh1requests,UNKN,IF' \
'CDEF:gh1ln=gh1requests,gh1requests,UNKN,IF' \
'CDEF:eh2ln=eh2requests,eh2requests,UNKN,IF' \
'VDEF:eh1requestsmax=eh1requests,MAXIMUM' \
'VDEF:eh1requestsmin=eh1requests,MINIMUM' \
'VDEF:eh1requestsavg=eh1requests,AVERAGE' \
'VDEF:eh1requestsstd=eh1requests,STDEV' \
'VDEF:gh1requestsmax=gh1requests,MAXIMUM' \
'VDEF:gh1requestsmin=gh1requests,MINIMUM' \
'VDEF:gh1requestsavg=gh1requests,AVERAGE' \
'VDEF:gh1requestsstd=gh1requests,STDEV' \
'VDEF:eh2requestsmax=eh2requests,MAXIMUM' \
'VDEF:eh2requestsmin=eh2requests,MINIMUM' \
'VDEF:eh2requestsavg=eh2requests,AVERAGE' \
'VDEF:eh2requestsstd=eh2requests,STDEV' \
'AREA:eh1requests#7648ec: elixir (c=100, s=10x, w=50ms)\l' \
'COMMENT:\u' \
'GPRINT:eh1requestsavg:AVG %6.0lf' \
'GPRINT:eh1requestsmin:MIN %6.0lf' \
'GPRINT:eh1requestsmax:MAX %6.0lf' \
'GPRINT:eh1requestsstd:STDEV %6.0lf\r' \
'AREA:gh1requests#de48ec: elixir (c=100, s=100x, w=50ms)\l' \
'COMMENT:\u' \
'GPRINT:gh1requestsavg:AVG %6.0lf' \
'GPRINT:gh1requestsmin:MIN %6.0lf' \
'GPRINT:gh1requestsmax:MAX %6.0lf' \
'GPRINT:gh1requestsstd:STDEV %6.0lf\r' \
'AREA:eh2requests#48c4ec: elixir (c=100, s=1000x, w=50ms)\l' \
'COMMENT:\u' \
'GPRINT:eh2requestsavg:AVG %6.0lf' \
'GPRINT:eh2requestsmin:MIN %6.0lf' \
'GPRINT:eh2requestsmax:MAX %6.0lf' \
'GPRINT:eh2requestsstd:STDEV %6.0lf\r' \
'LINE1:gh1ln#b415c7' \
'LINE1:eh1ln#4d18e4' \
'LINE1:eh2ln#1598c3'
