# Makefile for running JSON parsing performance tests
# Author: Jaeho Shin <netj@cs.stanford.edu>
# Created: 2016-04-21

.DEFAULT_GOAL := test

TIMEOUT = 5s

DATA ?= citylots.json

DATA ?= companies.json
DATA ?= enron.json
DATA ?= stocks.json
DATA ?= zips.json
DATA ?= world_bank.json

DATA ?= signalmedia-1m.jsonl

# implementations
IMPL += parse-json.jq
IMPL += parse-json-xs.pl
IMPL += parse-json-pp.pl
IMPL += parse-json-json.py2
IMPL += parse-json-json.py3
IMPL += parse-json-json.pypy
IMPL += parse-json-ujson.py2
IMPL += parse-json-ujson.py3
IMPL += parse-json-ujson.pypy
IMPL += parse-json-simplejson.py2
IMPL += parse-json-simplejson.py3
IMPL += parse-json-simplejson.pypy

# measurement outputs
MEASUREMENT_EXTENSION = .throughput
MEASUREMENTS = $(IMPL:%=%-$(DATA)$(MEASUREMENT_EXTENSION))

.PHONY: test retest
test: $(DATA) $(MEASUREMENTS)
retest:
	touch $(DATA)
	$(MAKE) test

SHELL = bash
%-$(DATA)$(MEASUREMENT_EXTENSION): % $(DATA)
	# $(DATA) with $<
	@if ./$< </dev/null; then \
	    while dd if=$(DATA); do :; done 2>$@ | \
	    pv -f -N "# $(DATA) with $<" -t -a | \
	    timeout $(TIMEOUT) ./$<; \
	    [[ $$? = @(0|124) ]]; \
	else \
	    echo "# SKIPPING $<"; \
	fi 2> >(tee $@)

.PHONY: clean
clean:
	rm -f $(MEASUREMENTS)

# Signalmedia 1M articles
signalmedia-1m.jsonl:
	# To download $@, sign up from: http://research.signalmedia.co/newsir16/signal-dataset.html
	@false

# JSON Studio
companies.json enron.json stocks.json zips.json world_bank.json:
	curl -RLOC- http://jsonstudio.com/wp-content/uploads/2014/02/$(@:%.json=%.zip)
	unzip -o $(@:%.json=%.zip)
	touch $@

# other datasets
citylots.json:
	curl -L https://github.com/zemirco/sf-city-lots-json/raw/master/citylots.json | jq -c '.features[]' >$@
