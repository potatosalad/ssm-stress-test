#!/usr/bin/env bash

rrdtool graph go-vs-elixir-best.svg \
--width 600 \
--height 200 \
--start 00:00 \
--end start+38seconds \
--title 'go vs elixir (best)' \
--vertical-label 'requests per second' \
--imgformat SVG \
--border 0 \
--font DEFAULT:0:Consolas \
--upper-limit 100000 \
--lower-limit 0 \
--rigid \
'DEF:eh1requests=elixir_best_h1.rrd:requests:MAX:start=1544709774:end=1544709812:step=1' \
'DEF:gh1requests=go_best_h1.rrd:requests:MAX:start=1544709339:end=1544709377:step=1' \
'DEF:eh2requests=elixir_best_h2.rrd:requests:MAX:start=1544709533:end=1544709572:step=1' \
'DEF:gh2requests=go_best_h2.rrd:requests:MAX:start=1544709272:end=1544709310:step=1' \
'SHIFT:eh1requests:-28974' \
'SHIFT:gh1requests:-28539' \
'SHIFT:eh2requests:-28733' \
'SHIFT:gh2requests:-28472' \
'CDEF:eh1ln=eh1requests,eh1requests,UNKN,IF' \
'CDEF:gh1ln=gh1requests,gh1requests,UNKN,IF' \
'CDEF:eh2ln=eh2requests,eh2requests,UNKN,IF' \
'CDEF:gh2ln=gh2requests,gh2requests,UNKN,IF' \
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
'VDEF:gh2requestsmax=gh2requests,MAXIMUM' \
'VDEF:gh2requestsmin=gh2requests,MINIMUM' \
'VDEF:gh2requestsavg=gh2requests,AVERAGE' \
'VDEF:gh2requestsstd=gh2requests,STDEV' \
'AREA:gh1requests#7648ec: go HTTP/1.1\l' \
'COMMENT:\u' \
'GPRINT:gh1requestsavg:AVG %6.0lf' \
'GPRINT:gh1requestsmin:MIN %6.0lf' \
'GPRINT:gh1requestsmax:MAX %6.0lf' \
'GPRINT:gh1requestsstd:STDEV %6.0lf\r' \
'AREA:gh2requests#54ec48: go HTTP/2\l' \
'COMMENT:\u' \
'GPRINT:gh2requestsavg:AVG %6.0lf' \
'GPRINT:gh2requestsmin:MIN %6.0lf' \
'GPRINT:gh2requestsmax:MAX %6.0lf' \
'GPRINT:gh2requestsstd:STDEV %6.0lf\r' \
'AREA:eh2requests#de48ec: elixir HTTP/2\l' \
'COMMENT:\u' \
'GPRINT:eh2requestsavg:AVG %6.0lf' \
'GPRINT:eh2requestsmin:MIN %6.0lf' \
'GPRINT:eh2requestsmax:MAX %6.0lf' \
'GPRINT:eh2requestsstd:STDEV %6.0lf\r' \
'AREA:eh1requests#48c4ec: elixir HTTP/1.1\l' \
'COMMENT:\u' \
'GPRINT:eh1requestsavg:AVG %6.0lf' \
'GPRINT:eh1requestsmin:MIN %6.0lf' \
'GPRINT:eh1requestsmax:MAX %6.0lf' \
'GPRINT:eh1requestsstd:STDEV %6.0lf\r' \
'LINE1:gh1ln#4d18e4' \
'LINE1:gh2ln#24bc14' \
'LINE1:eh1ln#1598c3' \
'LINE1:eh2ln#b415c7'
