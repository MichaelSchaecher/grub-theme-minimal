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

BUILD_GRUB = $(BUILD_PATH)/usr/share/grub/themes/minimal

export BUILD_PATH

# Install path
INSTALL_PATH = /usr/share/grub/themes


# Phony targets
.PHONY: install clean build

# Default target
all: build install

debian:
	make build

	@echo "Building debian package"

	@mkdir -pv $(BUILD_PATH)/DEBIAN

	@cp -vf src/debian/* $(BUILD_PATH)/DEBIAN/

	@sed -i "s/Version:/Version: $(VERSION)/" $(BUILD_PATH)/DEBIAN/control

	@sed -i "s/Maintainer:/Maintainer: $(MAINTAINER)/" $(BUILD_PATH)/DEBIAN/control

	@git-changelog $(BUILD_PATH)/DEBIAN/changelog
	@gzip -dv $(BUILD_PATH)/DEBIAN/changelog.gz

	@dpkg-deb --root-owner-group --build $(BUILD_PATH) build/$(APP_NAME)_$(VERSION)_all.deb

# Install the bash script
build:

	@echo "Building $(APP_NAME) $(VERSION)"
	@mkdir -pv $(BUILD_GRUB)

	@cp -av src/theme/* $(BUILD_GRUB)

	@cp -av images/png/* $(BUILD_GRUB)/

	@cp -av images/icons $(BUILD_GRUB)/

install:

	@cp -av $(BUILD_GRUB)/* $(INSTALL_PATH)/

uninstall:
	@rm -vf $(INSTALL_PATH)/minimal

clean:
	@rm -Rvf ./build

help:
	@echo "Usage: make [target] <variables>"
	@echo ""
	@echo "Targets:"
	@echo "  all       - Build and install the minimal grub theme"
	@echo "  debian    - Build debian package"
	@echo "  build     - Build the minimal grub theme"
	@echo "  install   - Install the minimal grub theme"
	@echo "  uninstall - Uninstall the minimal grub theme"
	@echo "  clean     - Clean up build files"
	@echo "  help      - Display this help message"
	@echo ""
