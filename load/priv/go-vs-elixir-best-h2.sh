#!/usr/bin/env bash

rrdtool graph go-vs-elixir-best-h2.svg \
--width 600 \
--height 200 \
--start 00:00 \
--end start+38seconds \
--title 'go vs elixir (best h2)' \
--vertical-label 'requests per second' \
--imgformat SVG \
--border 0 \
--font DEFAULT:0:Consolas \
--upper-limit 100000 \
--lower-limit 0 \
--rigid \
'DEF:eh2requests=elixir_best_h2.rrd:requests:MAX:start=1544709533:end=1544709572:step=1' \
'DEF:gh2requests=go_best_h2.rrd:requests:MAX:start=1544709272:end=1544709310:step=1' \
'SHIFT:eh2requests:-28733' \
'SHIFT:gh2requests:-28472' \
'CDEF:eh2ln=eh2requests,eh2requests,UNKN,IF' \
'CDEF:gh2ln=gh2requests,gh2requests,UNKN,IF' \
'VDEF:eh2requestsmax=eh2requests,MAXIMUM' \
'VDEF:eh2requestsmin=eh2requests,MINIMUM' \
'VDEF:eh2requestsavg=eh2requests,AVERAGE' \
'VDEF:eh2requestsstd=eh2requests,STDEV' \
'VDEF:gh2requestsmax=gh2requests,MAXIMUM' \
'VDEF:gh2requestsmin=gh2requests,MINIMUM' \
'VDEF:gh2requestsavg=gh2requests,AVERAGE' \
'VDEF:gh2requestsstd=gh2requests,STDEV' \
'AREA:gh2requests#54ec48: go\l' \
'COMMENT:\u' \
'GPRINT:gh2requestsavg:AVG %6.0lf' \
'GPRINT:gh2requestsmin:MIN %6.0lf' \
'GPRINT:gh2requestsmax:MAX %6.0lf' \
'GPRINT:gh2requestsstd:STDEV %6.0lf\r' \
'AREA:eh2requests#48c4ec: cowboy 2.0.0-rc.1 handler\l' \
'COMMENT:\u' \
'GPRINT:eh2requestsavg:AVG %6.0lf' \
'GPRINT:eh2requestsmin:MIN %6.0lf' \
'GPRINT:eh2requestsmax:MAX %6.0lf' \
'GPRINT:eh2requestsstd:STDEV %6.0lf\r' \
'LINE1:gh2ln#1598c3' \
'LINE1:eh2ln#24bc14'
