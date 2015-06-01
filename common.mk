# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

COMMON_FOLDER := device/amazon/omap4-common
OTTER_COMMON_FOLDER := device/amazon/otter-common

$(call inherit-product, $(COMMON_FOLDER)/common.mk)

DEVICE_PACKAGE_OVERLAYS += $(OTTER_COMMON_FOLDER)/overlay/aosp

PRODUCT_AAPT_CONFIG := normal mdpi hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

# Wifi
PRODUCT_PACKAGES += \
    calibrator \
    crda \
    regulatory.bin \
    lib_driver_cmd_wl12xx

# BT vendor lib (fixes crashing)
PRODUCT_PACKAGES += \
    libbt-vendor

#ifdef USES_TI_MAC80211
# Permissions
#PRODUCT_COPY_FILES += \
#    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml
#endif

# Rootfs
PRODUCT_COPY_FILES += \
    $(OTTER_COMMON_FOLDER)/init.otter-common.rc:/root/init.otter-common.rc

# Prebuilts /system/bin
PRODUCT_COPY_FILES += \
    $(OTTER_COMMON_FOLDER)/prebuilt/bin/bbx:/system/bin/bbx

# Prebuilts /system/etc
PRODUCT_COPY_FILES += \
    $(OTTER_COMMON_FOLDER)/prebuilt/etc/audio_policy.conf:/system/etc/audio_policy.conf \
    frameworks/av/media/libstagefright/data/media_codecs_ffmpeg.xml:system/etc/media_codecs_ffmpeg.xml \
    $(OTTER_COMMON_FOLDER)/prebuilt/etc/mixer_paths.xml:/system/etc/mixer_paths.xml \
    $(OTTER_COMMON_FOLDER)/prebuilt/etc/wifi/TQS_S_2.6.ini:/system/etc/wifi/TQS_S_2.6.ini \
    $(OTTER_COMMON_FOLDER)/prebuilt/etc/wifi/p2p_supplicant_overlay.conf:/system/etc/wifi/p2p_supplicant_overlay.conf \
    $(OTTER_COMMON_FOLDER)/prebuilt/etc/wifi/wpa_supplicant.conf:/system/etc/wifi/wpa_supplicant.conf

# Prebuilt /system/usr
PRODUCT_COPY_FILES += \
    $(OTTER_COMMON_FOLDER)/prebuilt/usr/idc/ilitek_i2c.idc:/system/usr/idc/ilitek_i2c.idc \

PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory \
    su

ADDITIONAL_BUILD_PROPERTIES += \
    ro.sf.lcd_density=160 \
    ro.sf.hwrotation=270

# Set dirty regions off
ADDITIONAL_BUILD_PROPERTIES += \
    hwui.render_dirty_regions=false

# wifi-only device
ADDITIONAL_BUILD_PROPERTIES += \
    ro.carrier=wifi-only

$(call inherit-product-if-exists, vendor/amazon/omap4-common/omap4-common-vendor-540_120.mk)
$(call inherit-product, hardware/ti/wlan/mac80211/wl127x-wlan-products.mk)
$(call inherit-product-if-exists, hardware/ti/wpan/ti-wpan-products.mk)
