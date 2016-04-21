# Makefile for running JSON parsing performance tests
# Author: Jaeho Shin <netj@cs.stanford.edu>
# Created: 2016-04-21

.DEFAULT_GOAL := test

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

.PHONY: test retest
test: $(DATA) $(MEASUREMENTS)
retest:
	touch $(DATA)
	$(MAKE) test

SHELL = bash
%$(MEASUREMENT_EXTENSION): % $(DATA)
	@echo "# $(DATA) with $<"
	@if ./$< </dev/null; then \
	    while dd if=$(DATA); do :; done 2>$@ | \
	    pv | timeout $(TIMEOUT) ./$<; \
	    [[ $$? = @(0|124) ]]; \
	    cat $@; \
	else \
	    echo "# SKIPPING $<"; \
	fi

.PHONY: clean
clean:
	rm -f $(MEASUREMENTS)

signalmedia-1m.jsonl:
	# To download $@, sign up from: http://research.signalmedia.co/newsir16/signal-dataset.html
	@false
citylots.json:
	curl -RLO https://github.com/zemirco/sf-city-lots-json/raw/master/citylots.json
