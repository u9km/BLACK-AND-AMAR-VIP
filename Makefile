ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = MetalCoreEngine
MetalCoreEngine_FILES = Tweak.mm
MetalCoreEngine_INSTALL_PATH = /Library/Frameworks
MetalCoreEngine_CFLAGS = -fobjc-arc -O3

include $(THEOS_MAKE_PATH)/framework.mk

# استخدمنا علامة النجمة لضمان نسخ أي ملف dylib يبدأ بكلمة AMAR لتجنب أخطاء التسمية
after-package::
	cp ./AMAR*.dylib $(THEOS_STAGING_DIR)/Library/Frameworks/MetalCoreEngine.framework/AMAR_VIP.dylib
