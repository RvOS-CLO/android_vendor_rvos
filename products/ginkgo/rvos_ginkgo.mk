#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq (rvos_ginkgo,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Inherit from lavender device
$(call inherit-product, device/xiaomi/ginkgo/device.mk)

# RvOS
RVOS_MAINTAINER := Hirokixd
RVOS_MAINTAINER_LINK := https://t.me/Hirokixd28
WITH_GMS := true

PRODUCT_NAME := rvos_ginkgo
PRODUCT_BRAND := Xiaomi
PRODUCT_DEVICE := ginkgo
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := Redmi Note 8/8T

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="xiaomi/ginkgo/ginkgo:11/RKQ1.201004.002/V12.5.2.0.RCOMIXM:user/release-keys"

BUILD_FINGERPRINT := xiaomi/ginkgo/ginkgo:11/RKQ1.201004.002/V12.5.2.0.RCOMIXM:user/release-keys

endif

