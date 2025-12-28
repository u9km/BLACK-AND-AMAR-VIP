#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#import <dlfcn.h>
#import <objc/runtime.h>

// كود تشفير المسارات والحماية اللي صممناه
#define SECRET_KEY 0xAD
NSString* decrypt_final(int* data, int len) {
    char* out = (char*)malloc(len + 1);
    for(int i=0; i<len; i++) out[i] = data[i] ^ SECRET_KEY;
    out[len] = '\0';
    NSString* res = [NSString stringWithUTF8String:out];
    free(out);
    return res;
}

void SecurityShield() {
    // تزييف هوية الجهاز IDFV لمنع تتبع الحسابات
    Method m = class_getInstanceMethod([UIDevice class], @selector(identifierForVendor));
    method_setImplementation(m, imp_implementationWithBlock(^(id self) {
        return [[NSUUID alloc] initWithUUIDString:[[NSUUID UUID] UUIDString]];
    }));
}

__attribute__((constructor)) static void init_secure_v8() {
    SecurityShield();

    [cite_start]// تشغيل ملف AMAR VIP بشكل مخفي بعد 15 ثانية [cite: 1-19]
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // مسار ملف الدايلب داخل مجلد الـ Framework الجديد
        NSString *frameworkPath = @"/Library/Frameworks/MetalCoreEngine.framework/AMAR_VIP.dylib";
        void *handle = dlopen([frameworkPath UTF8String], RTLD_NOW);
        
        if (handle) {
            NSLog(@"[SUCCESS] AMAR VIP LOADED UNDER PROTECTION.");
        }
    });
}
