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
make
```
which also records results as `.throughput` files.

To measure a particular implementation:
```bash
make IMPL=parse-json-xs.pl clean test
```

## Parameters

You can tell which JSON/JSON-lines data to feed as input.
```bash
make DATA=citylogs.json
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
