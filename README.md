# Contoso University - ASP.NET Core MVC & Entity Framework Core
## تطبيق عملي وفق دليل Microsoft Learn (الدرس الأول - Tutorial 01)

**إعداد وإشراف المهندس / المطور:**  
`Eng.Alhassan Ali Bahbah`

---

### 1. نظرة عامة على المشروع (Project Overview)
تم بناء هذا المشروع بدقة وتطابق كامل مع خطوات الدليل الرسمي لشركة مايكروسوفت:
**"Tutorial: Get started with EF Core in an ASP.NET MVC web app | Microsoft Learn"**

يقدم المشروع نظام إدارة لجامعة افتراضية (**Contoso University**) باستخدام إطار العمل **ASP.NET Core MVC** ونظام إدارة الكائنات العلائقية **Entity Framework Core (EF Core)** بنمط **Code-First**.

---

### 2. البنية الهيكلية للملفات والمجلدات (Project Structure)
تم تنظيم المشروع بالكامل داخل المجلد:
`d:\هندسة الحاسوب\واجب الويب\ContosoUniversity`

```text
ContosoUniversity/
│
├── ContosoUniversity.sln           # ملف الحل لفتحه مباشرة في Visual Studio
├── ContosoUniversity.csproj        # ملف إعدادات المشروع وحزم NuGet
├── Program.cs                      # نقطة انطلاق التطبيق وإعداد الخدمات وحقن التبعيات
├── appsettings.json                # ملف التكوينات وسلسلة الاتصال بقاعدة البيانات
├── appsettings.Development.json    # إعدادات بيئة التطوير وتسجيل أوامر SQL (Logging)
├── ContosoUniversity_Database.sql  # سكربت SQL كامل للجداول والبيانات الأولية (جاهز لـ MySQL / SQL Server)
│
├── Models/                         # نماذج البيانات (Data Entities)
│   ├── Student.cs                  # كيان الطالب (يتضمن علاقة Enrollments)
│   ├── Course.cs                   # كيان المقرر الدراسي مع [DatabaseGenerated(None)]
│   ├── Enrollment.cs               # كيان التسجيل مع التقدير كـ Enum ورابط بين الطالب والمقرر
│   └── ErrorViewModel.cs           # نموذج معالجة الأخطاء
│
├── Data/                           # سياق قاعدة البيانات والتهيئة الأولية
│   ├── SchoolContext.cs            # سياق EF Core مع DbSet وتعريف أسماء الجداول مفردة
│   └── DbInitializer.cs            # فئة تهيئة وتغذية البيانات الأولية (تتضمن اسم Eng.Alhassan Ali Bahbah)
│
├── Controllers/                    # المتحكمات
│   ├── HomeController.cs           # متحكم الصفحة الرئيسية، نبذة عن المشروع (About)، وسياسة الخصوصية
│   └── StudentsController.cs       # متحكم إدارة الطلاب مع كامل عمليات CRUD غير المتزامنة (Async/Await)
│
└── Views/                          # الواجهات
    ├── _ViewImports.cshtml         # التضمينات المشتركة والمساعدات TagHelpers
    ├── _ViewStart.cshtml           # تعيين القالب الافتراضي _Layout
    ├── Home/
    │   ├── Index.cshtml            # الصفحة الرئيسية بتصميم عصري وبصمة المطور
    │   └── About.cshtml            # صفحة تعريفية بالمشروع وواجب الويب
    ├── Students/
    │   ├── Index.cshtml            # عرض قائمة الطلاب ومفتاح التنقل لعمليات التعديل والحذف
    │   ├── Details.cshtml          # تفاصيل الطالب مع سجل المقررات والتقديرات المسجلة
    │   ├── Create.cshtml           # نموذج إضافة طالب جديد
    │   ├── Edit.cshtml             # نموذج تعديل بيانات طالب
    │   └── Delete.cshtml           # تأكيد حذف طالب
    └── Shared/
        ├── _Layout.cshtml          # القالب العام وشريط التنقل الرئيسي وبصمة المطور
        ├── _ValidationScriptsPartial.cshtml
        └── Error.cshtml
```

---

### 3. ما تم تنفيذه خطوة بخطوة من ملف الشرح (Implemented Steps)

1. **إنشاء مشروع الويب (Create Web App):**
   - مشروع ASP.NET Core MVC كامل مهيأ للعمل مع أحدث بيئات التشغيل ومدعوم بالتوافق العالي.
2. **تنسيق الموقع وتخصيص القالب (Set up site style):**
   - تعديل `Views/Shared/_Layout.cshtml` وتحديث شريط التنقل ليشمل: (Home, About, Students, Courses, Instructors, Departments).
   - إدراج توقيع وبصمة المهندس **Eng.Alhassan Ali Bahbah** في ترويسة وتذييل الموقع.
   - إنشاء صفحة `Views/Home/Index.cshtml` وتزويدها بتعريف بالمشروع ورابط لصفحة الطلاب.
3. **تثبيت حزم EF Core (NuGet Packages):**
   - `Microsoft.EntityFrameworkCore.SqlServer`
   - `Microsoft.AspNetCore.Diagnostics.EntityFrameworkCore`
4. **بناء نموذج البيانات (Create Data Model):**
   - فئة `Student` مع مفتاح أساسي وخاصية تنقل `Enrollments`.
   - فئة `Enrollment` مع مفتاح أساسي ومفاتيح أجنبية لـ Student و Course والتقدير كـ Enum قابل للقيمة الفارغة (`Grade?`).
   - فئة `Course` مع خاصية `[DatabaseGenerated(DatabaseGeneratedOption.None)]` لإدخال معرف المادة يدويًا.
5. **إنشاء سياق قاعدة البيانات (Database Context):**
   - فئة `SchoolContext` ترث من `DbContext` وتعرف الـ `DbSet` للجداول الثلاثة.
   - تجاوز دالة `OnModelCreating` لمنع جمع أسماء الجداول (`ToTable("Course")`, `ToTable("Enrollment")`, `ToTable("Student")`).
6. **تسجيل السياق وسلسلة الاتصال (Register SchoolContext):**
   - إضافة `AddDbContext<SchoolContext>` في `Program.cs`.
   - إعداد سلسلة الاتصال `DefaultConnection` لـ SQL Server LocalDB في `appsettings.json`.
   - إضافة فلتر استكشاف أخطاء قاعدة البيانات للمطورين `AddDatabaseDeveloperPageExceptionFilter`.
7. **تغذية البيانات الأولية (Seed Database):**
   - إنشاء فئة `DbInitializer` واستدعاء `context.Database.EnsureCreated()`.
   - إضافة الطلاب والمقررات والتسجيلات المذكورة في الدليل، وإدراج الطالب المهندس: **Eng.Alhassan Ali Bahbah** ضمن البيانات الأولية.
   - استدعاء التهيئة عند بدء تشغيل التطبيق في `Program.cs` مع معالجة الأخطاء عبر `try...catch` وتسجيل الأحداث `ILogger`.
8. **إنشاء المتحكم وواجهات العرض (Scaffold Controller & Views):**
   - متحكم `StudentsController` يعتمد أسلوب الحقن بالاعتماديات `SchoolContext`.
   - دوال غير متزامنة بالكامل `async Task<IActionResult>` باستخدام `ToListAsync()`.
   - واجهات Razor المتكاملة لجميع عمليات الاستعراض، التفاصيل، الإضافة، التعديل، والحذف.

---

### 4. التحقق الهيكلي والفحص البرمجي (Verification & Health Check)

- **فحص البناء والتجميع (Compilation Check):**
  تم تنفيذ الأمر:
  ```powershell
  dotnet build "ContosoUniversity.csproj"
  ```
  **النتيجة:**
  ```text
  Build succeeded.
      0 Warning(s)
      0 Error(s)
  ```
- **فحص التشغيل المحلي (Runtime Validation):**
  تم اختبار تشغيل خادم الويب المحلي وتأكيد استجابته للطلبات عبر المنفذ `5052`:
  - صفحة البداية `http://localhost:5052/` تعمل بنجاح وتعرض بصمة المهندس **Eng.Alhassan Ali Bahbah**.
  - صفحة `http://localhost:5052/Home/About` تعمل بنجاح.
  - معالجة غياب خادم LocalDB على الجهاز الحالي تمت بسلاسة عبر كتلة `try...catch` المبرمجة بالدليل دون توقف الخادم.

---

### 5. تعليمات التشغيل على جهاز آخر به Visual Studio (How to Run)

عند نقل مجلد `ContosoUniversity` إلى الجهاز الآخر:
1. **طريقة Visual Studio (الأسهل والأسرع):**
   - انقر مرتين على ملف الحل `ContosoUniversity.sln` لفتحه داخل Visual Studio.
   - اضغط على المفتاح `Ctrl + F5` (Start Without Debugging).
   - سيقوم Visual Studio تلقائيًا باستعادة الحزم، وإنشاء قاعدة البيانات على `(localdb)\mssqllocaldb` وتغذيتها بالبيانات، وفتح المتصفح مباشرة.
   - انقر على تبويب **Students** في شريط التنقل العلوي لرؤية جدول الطلاب المسجلين متضمناً اسمك!

2. **طريقة سطر الأوامر (CLI):**
   ```powershell
   cd "d:\هندسة الحاسوب\واجب الويب\ContosoUniversity"
   dotnet run
   ```
   ثم افتح الرابط الظاهر في المتصفح.

3. **استخدام MySQL (اختياري):**
   إذا أردت فحص الجداول أو إنشائها داخل MySQL على هذا الجهاز أو غيره، يمكنك فتح ملف:
   `ContosoUniversity_Database.sql`
   وتنفيذه مباشرة في **MySQL Workbench** لإنشاء الجداول وإدخال كافة بيانات الطلاب والمقررات والتسجيلات فورًا.

---
**تاريخ الإنجاز:** 2026-11-19  
**المطور:** Eng.Alhassan Ali Bahbah
