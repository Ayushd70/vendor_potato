include vendor/potato/config/ProductConfigQcom.mk

PRODUCT_SOONG_NAMESPACES += $(PATHMAP_SOONG_NAMESPACES)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

LAWNCHAIR_OPTOUT := true

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/potato/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/potato/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/potato/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/potato/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip \

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1 \
    ro.boot.vendor.overlay.theme=com.potato.overlay.accent.purple;com.potato.overlay.base.stockfixed;com.potato.overlay.lawnconf;com.potato.overlay.shape.circle \
    ro.opa.eligible_device=true

# LatinIME gesture typing
ifneq ($(filter tenderloin,$(TARGET_PRODUCT)),)
ifneq ($(filter shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/potato/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/potato/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
endif
endif

# Lawnchair
ifeq ($(LAWNCHAIR_OPTOUT),)
PRODUCT_PACKAGE_OVERLAYS += vendor/potato/overlay/lawnchair
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-lawnchair.xml:system/etc/permissions/privapp-permissions-lawnchair.xml \
    vendor/potato/prebuilt/common/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml:system/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml
endif

# POSP Common
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-potato.xml:system/etc/permissions/privapp-permissions-potato.xml

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Weather client
#PRODUCT_COPY_FILES += \
#    vendor/potato/etc/permissions/org.pixelexperience.weather.client.xml:system/etc/permissions/org.pixelexperience.weather.client.xml \
#    vendor/potato/etc/default-permissions/org.pixelexperience.weather.client.xml:system/etc/default-permissions/org.pixelexperience.weather.client.xml

# Set custom volume steps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# Turbo
#PRODUCT_COPY_FILES += \
#    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-turbo.xml:system/etc/permissions/privapp-permissions-turbo.xml \
#    vendor/potato/prebuilt/common/etc/sysconfig/turbo.xml:system/etc/sysconfig/turbo.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/potato/config/permissions/custom-power-whitelist.xml:system/etc/sysconfig/custom-power-whitelist.xml

# Disable Rescue Party
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true

# exFAT
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Markup libs
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/lib/libsketchology_native.so:system/lib/libsketchology_native.so \
    vendor/potato/prebuilt/common/lib64/libsketchology_native.so:system/lib64/libsketchology_native.so

# GSans font
include vendor/potato/config/fonts.mk

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),user)
    SELINUX_IGNORE_NEVERALLOWS := true
endif

# Fonts
PRODUCT_COPY_FILES += \
   vendor/potato/prebuilt/common/fonts/GoogleSans-Regular.ttf:system/fonts/GoogleSans-Regular.ttf \
   vendor/potato/prebuilt/common/fonts/GoogleSans-Medium.ttf:system/fonts/GoogleSans-Medium.ttf \
   vendor/potato/prebuilt/common/fonts/GoogleSans-MediumItalic.ttf:system/fonts/GoogleSans-MediumItalic.ttf \
   vendor/potato/prebuilt/common/fonts/GoogleSans-Italic.ttf:system/fonts/GoogleSans-Italic.ttf \
   vendor/potato/prebuilt/common/fonts/GoogleSans-Bold.ttf:system/fonts/GoogleSans-Bold.ttf \
   vendor/potato/prebuilt/common/fonts/GoogleSans-BoldItalic.ttf:system/fonts/GoogleSans-BoldItalic.ttf

ADDITIONAL_FONTS_FILE := vendor/potato/prebuilt/common/fonts/google-sans.xml

# Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/potato/overlay/common

# Packages
include vendor/potato/config/packages.mk

# Branding
include vendor/potato/config/branding.mk
