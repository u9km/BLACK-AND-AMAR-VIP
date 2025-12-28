# تحديد المعماريات المستهدفة (الأجهزة الحديثة)
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0

# استيراد إعدادات Theos الأساسية
include $(THEOS)/makefiles/common.mk

# اسم الفريم ورك الذي سيظهر في النظام
FRAMEWORK_NAME = MetalCoreEngine

# الملفات البرمجية التي سيتم بناؤها
MetalCoreEngine_FILES = Tweak.mm

# مسار التثبيت الافتراضي داخل اللعبة
MetalCoreEngine_INSTALL_PATH = /Library/Frameworks

# إعدادات المترجم والتحسين
MetalCoreEngine_CFLAGS = -fobjc-arc -O3

# تضمين ملفات بناء الفريم ورك
include $(THEOS_MAKE_PATH)/framework.mk

# --- الخطوة الأهم: دمج ملف AMAR VIP داخل الفريم ورك ---
# نستخدم العلامة \ قبل المسافة لأن اسم الملف "AMAR VIP.dylib" يحتوي على مسافة
after-package::
	cp ./AMAR\ VIP.dylib $(THEOS_STAGING_DIR)/Library/Frameworks/MetalCoreEngine.framework/
	@echo "تم دمج ملف التفعيلات بنجاح داخل الفريم ورك المشفر."
