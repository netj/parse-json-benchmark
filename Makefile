# Makefile for running JSON parsing performance tests
# Author: Jaeho Shin <netj@cs.stanford.edu>
# Created: 2016-04-21

TIMEOUT = 10s
DATA ?= citylots.json
DATA ?= signalmedia-1m.jsonl

# implementations
IMPL += parse-json.jq
IMPL += parse-json-xs.pl
IMPL += parse-json-pp.pl
IMPL += parse-json.py2
IMPL += parse-json.py3
IMPL += parse-json.pypy

# measurement outputs
MEASUREMENT_EXTENSION = .throughput
MEASUREMENTS = $(IMPL:%=%$(MEASUREMENT_EXTENSION))

.PHONY: test
test: $(DATA) $(MEASUREMENTS)

SHELL = bash
%$(MEASUREMENT_EXTENSION): % $(DATA)
	# $(DATA) with $<
	@dd if=$(DATA) 2>$@ | pv | timeout $(TIMEOUT) ./$<; [[ $$? = @(0|124) ]]
	@cat $@

.PHONY: clean
clean:
	rm -f $(MEASUREMENTS)

signalmedia-1m.jsonl:
	# To download $@, sign up from: http://research.signalmedia.co/newsir16/signal-dataset.html
	@false
citylots.json:
	curl -RLO https://github.com/zemirco/sf-city-lots-json/raw/master/citylots.json
