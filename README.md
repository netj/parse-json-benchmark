# An experiment to compare JSON parsing performance

Just measuring the throughput of JSON parsing in the following programming languages and libraries:

* jq
* Perl `JSON::XS`
* Perl `JSON::PP`
* CPython 2 `json.loads`
* CPython 3 `json.loads`
* PyPy

## Measuring throughputs

To measure all implementations:
```bash
$ make
# citylots.json with parse-json.jq
# citylots.json with parse-json.jq: 0:00:05 [29.4MiB/s]
# citylots.json with parse-json-xs.pl
# citylots.json with parse-json-xs.pl: 0:00:05 [56.7MiB/s]
# citylots.json with parse-json-pp.pl
# citylots.json with parse-json-pp.pl: 0:00:05 [1.18MiB/s]
# citylots.json with parse-json.py2
# citylots.json with parse-json.py2: 0:00:05 [30.2MiB/s]
# citylots.json with parse-json.py3
# citylots.json with parse-json.py3: 0:00:05 [32.4MiB/s]
# citylots.json with parse-json.pypy
# citylots.json with parse-json.pypy: 0:00:05 [49.4MiB/s]

$ make DATA=companies.json
# companies.json with parse-json.jq
# companies.json with parse-json.jq: 0:00:05 [44.3MiB/s]
# companies.json with parse-json-xs.pl
# companies.json with parse-json-xs.pl: 0:00:05 [67.1MiB/s]
# companies.json with parse-json-pp.pl
# companies.json with parse-json-pp.pl: 0:00:05 [1.38MiB/s]
# companies.json with parse-json.py2
# companies.json with parse-json.py2: 0:00:05 [44.2MiB/s]
# companies.json with parse-json.py3
# companies.json with parse-json.py3: 0:00:05 [62.8MiB/s]
# companies.json with parse-json.pypy
# companies.json with parse-json.pypy: 0:00:05 [ 137MiB/s]

$ make DATA=signalmedia-1m.jsonl
# signalmedia-1m.jsonl with parse-json.jq
# signalmedia-1m.jsonl with parse-json.jq: 0:00:05 [91.3MiB/s]
# signalmedia-1m.jsonl with parse-json-xs.pl
# signalmedia-1m.jsonl with parse-json-xs.pl: 0:00:05 [ 242MiB/s]
# signalmedia-1m.jsonl with parse-json-pp.pl
# signalmedia-1m.jsonl with parse-json-pp.pl: 0:00:05 [1.44MiB/s]
# signalmedia-1m.jsonl with parse-json.py2
# signalmedia-1m.jsonl with parse-json.py2: 0:00:05 [ 112MiB/s]
# signalmedia-1m.jsonl with parse-json.py3
# signalmedia-1m.jsonl with parse-json.py3: 0:00:05 [ 126MiB/s]
# signalmedia-1m.jsonl with parse-json.pypy
# signalmedia-1m.jsonl with parse-json.pypy: 0:00:05 [96.8MiB/s]
```
which also records results as `.throughput` files.
(Measurements above are from a MacBook Pro 15-inch, Mid 2015, 2.5GHz Intel Core i7.)

To measure a particular implementation:
```bash
make IMPL=parse-json-xs.pl clean test
```

## Parameters

You can tell which JSON/JSON-lines data to feed as input.
```bash
make DATA=citylots.json
make DATA=signalmedia-1m.jsonl
```

You can adjust how long to run each implementation with `TIMEOUT` parameter.
```bash
make TIMEOUT=1m
make TIMEOUT=30s
```

## See Also
* <http://sck.pm/p0>
* <http://perlmaven.com/comparing-the-speed-of-json-decoders>
