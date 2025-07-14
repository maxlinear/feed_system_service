#
# Copyright (C) 2020-2024 MaxLinear, Inc.
# Copyright (C) 2017-2018 Intel Corporation
#
# Makefile for fwupgrade daemon
#

#### Includes ###################################
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

#### Package Info ###############################
PKG_NAME:=fwupgrade
PKG_SOURCE_VERSION:=5.9.3.12
PKG_VERSION:=$(PKG_SOURCE_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_NAME:=system_service
CONFIG_UGW_PKG_SOURCE_URL:=ssh://git@github.com
PKG_PROJECT:=maxlinear
PKG_SOURCE_INNERDIR:=daemon_fwupgrade_src
PKG_SOURCE_URL:=$(CONFIG_UGW_PKG_SOURCE_URL)/$(PKG_PROJECT)/$(PKG_SOURCE_NAME).git
PKG_MIRROR_HASH:=24538a38a2eb0c32d7c35539706f6023547867ea861e57a12e3b1690792c5d71

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_SOURCE_VERSION)
PKG_MAINTAINER:=MaxLinear
PKG_LICENSE:=MaxLinear
PKG_MXL_LICENSE:=MaxLinear/LICENSE

include $(INCLUDE_DIR)/package.mk
-include $(INCLUDE_DIR)/package-version-override.mk
-include $(STAGING_DIR)/mk/ugw-loglevel.mk

define Package/$(PKG_NAME)
  SECTION:=libs
  CATEGORY:=MaxLinear
  SUBMENU:=UGW Functional APIs
  TITLE:=fwupgrade daemon package.
  URL:=http://www.maxlinear.com
  MAINTAINER:=MaxLinear Inc
  DEPENDS:=+libubox +libubus +libugwhelper +libblobmsg-json +libmsgapi +libhelper +libsafec3-7 +libscapi \
	+TARGET_intel_x86_lgm:sse_fapi_lgm \
	+TARGET_intel_mips_prx300:sse_fapi
endef

define Package/$(PKG_NAME)/description
	daemon fwupgrade.
endef

TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include/safeclib
ifeq ($(CONFIG_TARGET_intel_x86),y)
	TARGET_CFLAGS += -DPLATFORM_LGM
endif

ifeq ($(CONFIG_TARGET_intel_mips_prx300),y)
TARGET_CFLAGS += -DCONFIG_UBOOT_CONFIG_ENV_SIZE=0x4000 -DCONFIG_SYS_REDUNDAND_ENVIRONMENT=1
endif

define Build/InstallDev
	$(INSTALL_DIR) $(1)/$(VENDOR_PATH)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/fwupgrade $(1)/$(VENDOR_PATH)/usr/sbin/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/fwupgrade $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/$(VENDOR_PATH)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/fwupgrade $(1)/$(VENDOR_PATH)/usr/sbin/fwupgrade
endef

define Build/Clean
	if [ -d $(PKG_BUILD_DIR) ]; then $(MAKE) -C $(PKG_BUILD_DIR) clean; \
	$(RM) -r $(PKG_BUILD_DIR)/ipkg-$(BOARD); fi
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
