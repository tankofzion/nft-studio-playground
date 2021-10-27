################################################################################
# Centrifuge Chain                                                             #
# Playground                                                                   #
#                                                                              #
# Makefile                                                                     #
#                                                                              #
# Handcrafted since 2021 by Centrifuge Foundation                              #
# All rights reserved                                                          #
#                                                                              #
#                                                                              #
# Description: Script for bootstraping a local Centrifuge ecosystem with a     #
#              Polkadot relay chain which onboards the Centrifuge parachain.   #
################################################################################


# ------------------------------------------------------------------------------
# VARIABLES DEFINITION
# ------------------------------------------------------------------------------

# Colors definition
include ./resources/automake/colors.mk

# Project settings (e.g. Rust toolchain version, ...)
include ./resources/automake/settings.mk

# Set project's root directory
ROOT_DIR:=$(shell pwd)

# ------------------------------------------------------------------------------
# PUBlIC FUNCTIONS DEFINITION
# ------------------------------------------------------------------------------

define display_help_message
	@echo ""
	@echo "$(COLOR_WHITE)Centrifuge$(COLOR_RESET)"
	@echo ""
	@echo "$(COLOR_BLUE)Playground$(COLOR_RESET)"
	@echo ""
	@echo "Handcrafted since 2021 by Centrifuge Foundation"
	@echo "All rights reserved"
	@echo ""
	@echo "$(COLOR_WHITE)Usage:$(COLOR_RESET)"
	@echo "  make $(COLOR_BLUE)COMMAND$(COLOR_RESET)"
	@echo ""
	@echo "$(COLOR_WHITE)Commands:$(COLOR_RESET)"
	@echo "  $(COLOR_BLUE)setup$(COLOR_RESET)                      - Clone source repositories for relay chain and parachain"
	@echo "  $(COLOR_BLUE)build$(COLOR_RESET)                      - Build all binaries from source (i.e. relay chain and parachain)"
	@echo "  $(COLOR_BLUE)start$(COLOR_RESET)                      - Bootstrap playground nodes (see configuration in 'configs/basic-conf.json')"
	@echo "  $(COLOR_BLUE)stop$(COLOR_RESET)                       - Stop currently running playground nodes"
	@echo "  $(COLOR_BLUE)clean$(COLOR_RESET)                      - Clean up project"
	@echo "  $(COLOR_BLUE)build-polkadot-relaychain$(COLOR_RESET)  - Build the Polkadot relay chain binaries from source"
	@echo "  $(COLOR_BLUE)build-centrifuge-parachain$(COLOR_RESET) - Build the Centrifuge parachain binaries from source"
	@echo ""
endef

define setup
	@echo "Setting up environment..."
	@mkdir -p $(ROOT_DIR)/source; \
	cd $(ROOT_DIR)/source; \
	git clone https://github.com/paritytech/polkadot.git; \
	cd ./polkadot; \
	git checkout $(POLKADOT_VERSION); \
	cd $(ROOT_DIR)/source; \
	git clone https://github.com/centrifuge/centrifuge-chain; \
	cd ./centrifuge-chain; \
	git checkout feat/treasury_uniques; \
	cd $(ROOT_DIR)
endef

define build
	$(call build_polkadot_relaychain)
	$(call build_centrifuge_parachain)
endef

define build_polkadot_relaychain
	@echo "Building Polkadot relay chain's binaries ..."
	@mkdir -p $(ROOT_DIR)/binaries; \
	cd $(ROOT_DIR)/source/polkadot; \
	cargo build --release; \
	cp ./target/release/polkadot $(ROOT_DIR)/binaries/$(POLKADOT_RELAY_CHAIN_EXECUTABLE); \
	cd $(ROOT_DIR)
endef

define build_centrifuge_parachain
	@echo "Build Centrifuge parachain's binaries ..."
	@mkdir -p $(ROOT_DIR)/binaries; \
	cd $(ROOT_DIR)/source/centrifuge-chain; \
	cargo build --release; \
	cp ./target/release/centrifuge-chain $(ROOT_DIR)/binaries; \
	cd $(ROOT_DIR)
endef

define start
	@echo "Starting relay chain and parachain nodes ..."
	@polkadot-launch $(ROOT_DIR)/configs/basic-config.json
endef

define stop
	@echo "Stoping relay chain and parachain nodes ..."
	@echo "Not implemented"
endef

define clean
	@echo "Cleaning up project..."
	@rm -rf $(ROOT_DIR)/source
	@rm -rf $(ROOT_DIR)/binaries
	@rm -rf $(ROOT_DIR)/data
	@rm -rf $(ROOT_DIR)/*.log
endef

# ------------------------------------------------------------------------------
# TARGETS DEFINITION
# ------------------------------------------------------------------------------

# NOTE:
# .PHONY directive defines targets that are not associated with files. Generally
# all targets which do not produce an output file with the same name as the target
# name should be .PHONY. This typically includes 'all', 'help', 'build', 'clean',
# and so on.

.PHONY: all help setup build build-polkadot-relaychain build-centrifuge-parachain start stop clean

# Set default target if none is specified
.DEFAULT_GOAL := help

help:
	$(call display_help_message)

setup:
	$(call setup)

build:
	$(call build)

build-centrifuge-parachain:
	$(call build_centrifuge_parachain)

build-polkadot-relaychain:
	$(call build_polkadot_relaychain)

start:
	$(call start)

stop:
	$(call stop)

clean:
	$(call clean)

