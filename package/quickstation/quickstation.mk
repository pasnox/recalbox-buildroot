################################################################################
#
# QuickStation - https://gitlab.pasnox.com/quickstation/quickstation.git
#
################################################################################

QUICKSTATION_SITE = https://${QS_LOGIN}:${QS_PASSWORD}@gitlab.pasnox.com:${QS_PORT}/quickstation/quickstation.git
QUICKSTATION_VERSION = master
QUICKSTATION_SITE_METHOD = git
QUICKSTATION_LICENSE = Closed Source

define QUICKSTATION_CONFIGURE_CMDS
	( \
		cd $(@D); \
		git clone https://${QS_LOGIN}:${QS_PASSWORD}@gitlab.pasnox.com:${QS_PORT}/quickstation/qtsdljoystick.git qtsdljoystick/; \
		git clone https://github.com/pasnox/fresh.git fresh/; \
		$(TARGET_MAKE_ENV) $(QT_QMAKE) -spec devices/linux-buildroot-g++ DEFINES+=RPI; \
	)
endef

define QUICKSTATION_BUILD_CMDS
	$(MAKE) -C $(@D)
endef

define QUICKSTATION_INSTALL_TARGET_CMDS
	INSTALL_ROOT=$(TARGET_DIR) $(MAKE) -C $(@D) install
endef

define QUICKSTATION_UNINSTALL_TARGET_CMDS
	INSTALL_ROOT=$(TARGET_DIR) $(MAKE) -C $(@D) uninstall
endef

$(eval $(generic-package))
