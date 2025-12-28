ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = MetalCoreEngine
MetalCoreEngine_FILES = Tweak.mm
MetalCoreEngine_INSTALL_PATH = /Library/Frameworks
MetalCoreEngine_CFLAGS = -fobjc-arc -O3

include $(THEOS_MAKE_PATH)/framework.mk

# أمر نسخ ذكي يتجاوز مشكلة المسافات في الأسماء
after-package::
	cp ./*.dylib $(THEOS_STAGING_DIR)/Library/Frameworks/MetalCoreEngine.framework/
