#!/usr/bin/env bash

node="h2load${RANDOM}@127.0.0.1"
cookie="mycookie"

if [ $# -lt 4 ]; then
	echo 1>&2 "$0: requires an EXECUTABLE, FILENAME, TYPE=(h1|h2), and PORT argument"
	exit 2
fi

function notify_erl {
	echo "exiting h2load"
	erl -name "notify${RANDOM}@127.0.0.1" -setcookie "${cookie}" -noshell -eval "{worker, '${node}'} ! stop, erlang:halt(0)."
	exit 1
}

trap notify_erl SIGHUP SIGINT SIGTERM

./h2load.escript "${node}" "${cookie}" "$1" "$2" "$3" "$4" &

while true; do sleep 1; done