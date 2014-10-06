# This file is part of ucol_nif released under the Apache 2 license.
# See the NOTICE for more information.

ERL ?= erl
ERLC ?= erlc
REBAR ?= rebar

.PHONY: test

all: compile

static:
	@USE_STATIC_ICU="1" COUCHDB_STATIC="1" $(REBAR) compile

compile:
	@$(REBAR) compile

clean:
	@$(REBAR) clean
	@rm -f t/*.beam

test:
	@$(REBAR) eunit
