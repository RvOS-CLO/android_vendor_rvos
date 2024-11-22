# Copyright (C) 2022 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
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
#     RVOS_BUILD_VARIANT
#

# RvOS Maintainer
RVOS_MAINTAINER ?= Unknown
RVOS_MAINTAINER_LINK ?= https://t.me/rvegroup

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.rvos.maintainer=$(RVOS_MAINTAINER) \
    ro.rvos.maintainer.link=$(RVOS_MAINTAINER_LINK)


# This is the global RvOS version flavor that determines the focal point
# behind our releases. This is bundled alongside $(RVOS_MINOR_VERSION)
# and only changes per major Android releases.
RVOS_MAJOR_VERSION := tiramisu

# The version code is the upgradable portion during the cycle of
# every major Android release. Each version code upgrade indicates
# our own major release during each lifecycle.
ifdef RVOS_BUILDVERSION
    RVOS_MINOR_VERSION := $(RVOS_BUILDVERSION)
else
    RVOS_MINOR_VERSION := 1
endif

# Build Variants
#
# Alpha: Development / Test releases
# Beta: Public releases with CI
# Release: Final Product | No Tagging
ifdef RVOS_BUILDTYPE
  ifeq ($(RVOS_BUILDTYPE), ALPHA)
      RVOS_BUILD_VARIANT := alpha
  else ifeq ($(RVOS_BUILDTYPE), BETA)
      RVOS_BUILD_VARIANT := beta
  else ifeq ($(RVOS_BUILDTYPE), RELEASE)
      RVOS_BUILD_VARIANT := release
  endif
else
  RVOS_BUILD_VARIANT := unofficial
endif

# Build Date
BUILD_DATE := $(shell date -u +%Y%m%d)

# RvOS Version
TMP_RVOS_VERSION := $(RVOS_MAJOR_VERSION)-
ifeq ($(filter release,$(RVOS_BUILD_VARIANT)),)
    TMP_RVOS_VERSION += $(RVOS_BUILD_VARIANT)-
endif
ifeq ($(filter unofficial,$(RVOS_BUILD_VARIANT)),)
    TMP_RVOS_VERSION += $(RVOS_MINOR_VERSION)-
endif
TMP_RVOS_VERSION += $(RVOS_BUILD)-$(BUILD_DATE)
RVOS_VERSION := $(shell echo $(TMP_RVOS_VERSION) | tr -d '[:space:]')

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.rvos.version=$(RVOS_VERSION)

# The properties will be uppercase for parse by Settings, etc.
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.rvos.version.major=$(shell V1=$(RVOS_MAJOR_VERSION); echo $${V1^}) \
    ro.rvos.version.minor=$(RVOS_MINOR_VERSION) \
    ro.rvos.build.variant=$(shell V2=$(RVOS_BUILD_VARIANT); echo $${V2^})

# CodeLinaro Revision
CODELINARO_REVISION := LA.QSSI.13.0.r1-14500-qssi.0
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.codelinaro.revision=$(CODELINARO_REVISION)
