#!/bin/env make -f

APP_NAME = grub-theme-minimal
VERSION = $(shell cat VERSION)

DESCRIPTION = Minimal GRUB theme

MAINTAINER = $(shell git config user.name) <$(shell git config user.email)>

# Set priority of the package for deb package manager
# optional, low, standard, important, required
PRIORITY = optional

# dpkg Section option
SECTION = boot

# Architecture (amd64, i386, armhf, arm64, ... all)
AARCH = all

export APP_NAME VERSION DESCRIPTION APP_DEP AARCH PRIORITY SECTION MAINTAINER

ROOT_DIR = $(shell pwd)

export ROOT_DIR

# Source path
SOURCE_PATH = src

# Build path
BUILD_PATH = build/$(APP_NAME)-$(VERSION)

BUILD_GRUB = $(BUILD_PATH)/usr/share/grub/themes/$(APP_NAME)

export BUILD_PATH

# Install path
INSTALL_PATH = /usr


# Phony targets
.PHONY: install clean build

# Default target
all: build install

debian:
	make build

	@echo "Building debian package"

	@mkdir -pv $(BUILD_PATH)/DEBIAN

	@cp -vf src/debian/* $(BUILD_PATH)/DEBIAN/

	@cp -av src/theme/* $(BUILD_GRUB)

	@cp -av images/png/* $(BUILD_GRUB)/

	@cp -av images/icons $(BUILD_GRUB)/

	@sed -i "s/Version:/Version: $(VERSION)/" $(BUILD_PATH)/DEBIAN/control

	@sed -i "s/Maintainer:/Maintainer: $(MAINTAINER)/" $(BUILD_PATH)/DEBIAN/control

	@git-changelog $(BUILD_PATH)/DEBIAN/changelog
	@gzip -dv $(BUILD_PATH)/DEBIAN/changelog.gz

	@dpkg-deb --root-owner-group --build $(BUILD_PATH) build/$(APP_NAME)_$(VERSION)_all.deb

# Install the bash script
build:

	@echo "Building $(APP_NAME) $(VERSION)"
	@mkdir -pv $(BUILD_GRUB)

install:

	@cp -rvf $(BUILD_PATH)/* /

uninstall:
	@rm -vf $(INSTALL_PATH)/bin/$(APP_NAME) \
		$(INSTALL_PATH)/share/doc/$(APP_NAME)/* \
		$(INSTALL_PATH)/share/man/man8/$(APP_NAME).8.gz \
		$(INSTALL_PATH)/share/bash-completion/completions/$(APP_NAME)

clean:
	@rm -Rvf ./build

help:
	@echo "Usage: make [target] <variables>"
	@echo ""
	@echo "Targets:"
	@echo "  all       - Build and install the ddns application"
	@echo "  build     - Build the ddns application"
	@echo "  install   - Install the ddns application"
	@echo "  uninstall - Uninstall the ddns application"
	@echo "  clean     - Clean up build files"
	@echo "  help      - Display this help message"
	@echo ""
