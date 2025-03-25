# Copyright (C) 2022 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Handle various build version information.
#
# Guarantees that the following are defined:
#     RVOS_MAJOR_VERSION
#     RVOS_MINOR_VERSION
#

# RvOS Maintainer
RVOS_MAINTAINER ?= Unknown
RVOS_MAINTAINER_LINK ?= https://t.me/rvegroup
OFFICIAL_MAINTAINER = $(shell cat vendor/aospa/target/product/maintainer.mk | awk '{ print $$1 }')

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.rvos.maintainer=$(RVOS_MAINTAINER) \
    ro.rvos.maintainer.link=$(RVOS_MAINTAINER_LINK) \

# RvOS Flags
RVOS_FRONT_CAM ?= unknown
RVOS_REAR_CAM ?= unknown
RVOS_PROCESSOR ?= unknown

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.device_camera_info_rear=$(RVOS_REAR_CAM) \
    persist.sys.device_camera_info_front=$(RVOS_FRONT_CAM) \
    ro.rvos.processor=$(RVOS_PROCESSOR)

# Check Official Maintainer
RVOS_BUILD_TYPE ?= Unofficial

ifdef RVOS_MAINTAINER
    ifeq ($(filter $(RVOS_MAINTAINER), $(OFFICIAL_MAINTAINER)), $(RVOS_MAINTAINER))
        $(warning "$(RVOS_MAINTAINER) is verified as official RvOS maintainer, build as official build.")
	RVOS_BUILD_TYPE := Official
    else
        $(warning "Unofficial maintainer detected, building as unofficial build.")
	RVOS_BUILD_TYPE := Unofficial
    endif
else
    $(warning "No maintainer name detected, building as unofficial build.")
    RVOS_BUILD_TYPE := Unofficial
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
     ro.rvos.build.type=$(RVOS_BUILD_TYPE)

# This is the global RvOS version flavor that determines the focal point
# behind our releases. This is bundled alongside $(RVOS_MINOR_VERSION)
# and only changes per major Android releases.
RVOS_MAJOR_VERSION := Tiramisu

# The version code is the upgradable portion during the cycle of
# every major Android release. Each version code upgrade indicates
# our own major release during each lifecycle.
ifdef RVOS_BUILDVERSION
    RVOS_MINOR_VERSION := $(RVOS_BUILDVERSION)
else
    RVOS_MINOR_VERSION := 1
endif

# Build Date
BUILD_DATE := $(shell date -u +%Y%m%d)

# RvOS Version
RVOS_VERSION := $(RVOS_MAJOR_VERSION)-$(RVOS_BUILD_TYPE)-$(DEVICE)-$(BUILD_DATE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.rvos.version=$(RVOS_VERSION) \
    ro.rvos.version.major=$(shell V1=$(RVOS_MAJOR_VERSION); echo $${V1^}) \
    ro.rvos.version.minor=$(RVOS_MINOR_VERSION)

# CodeLinaro Revision
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.codelinaro.revision=LA.QSSI.13.0.r1-15500-qssi.0
