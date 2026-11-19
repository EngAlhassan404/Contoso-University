# Contoso University - ASP.NET Core MVC & Entity Framework Core
## تطبيق عملي شامل وفق دليلي Microsoft Learn (الدرس الأول والثاني - Tutorials 01 & 02)

**جامعة حضرموت | كلية الهندسة والبترول**  
**قسم هندسة الحاسوب | المستوى الخامس (سنة التخرج)**  
**تاريخ التوثيق:** 19 نوفمبر 2026م  

---

**إعداد المهندس:**  
الحسن علي باحبه  

**إشراف:**  
م/ عصمت فرج القبس  

---

### 1. نظرة عامة على المشروع (Project Overview)
تم بناء هذا المشروع بدقة وتطابق كامل مع خطوات الأدلة الرسمية لشركة مايكروسوفت:
1. **Tutorial 01: Get started with EF Core in an ASP.NET MVC web app | Microsoft Learn**
2. **Tutorial 02: Implement CRUD Functionality - ASP.NET MVC with EF Core | Microsoft Learn**

يقدم المشروع نظام إدارة لجامعة افتراضية (**Contoso University**) باستخدام إطار العمل **ASP.NET Core MVC** ونظام إدارة الكائنات العلائقية **Entity Framework Core (EF Core)** بنمط **Code-First**.

---

### 2. البنية الهيكلية للملفات والمجلدات (Project Structure)
تم تنظيم المشروع بالكامل داخل المجلد:
`d:\هندسة الحاسوب\واجب الويب\ContosoUniversity`

```text
ContosoUniversity/
│
├── ContosoUniversity.sln           # ملف الحل لفتحه مباشرة في Visual Studio
├── ContosoUniversity.csproj        # ملف إعدادات المشروع وحزم NuGet بخاصية RollForward
├── Program.cs                      # نقطة انطلاق التطبيق وإعداد الخدمات وحقن التبعيات
├── appsettings.json                # ملف التكوينات وسلسلة الاتصال بقاعدة البيانات
├── appsettings.Development.json    # إعدادات بيئة التطوير وتسجيل أوامر SQL (Logging)
├── ContosoUniversity_Database.sql  # سكربت SQL كامل للجداول والبيانات الأولية (جاهز لـ MySQL / SQL Server)
├── README.md                       # دليل التوثيق الكامل للمشروع
│
├── Models/                         # نماذج البيانات (Data Entities)
│   ├── Student.cs                  # كيان الطالب (يتضمن علاقة Enrollments)
│   ├── Course.cs                   # كيان المقرر الدراسي مع [DatabaseGenerated(None)]
│   ├── Enrollment.cs               # كيان التسجيل مع التقدير كـ Enum ورابط بين الطالب والمقرر
│   └── ErrorViewModel.cs           # نموذج معالجة الأخطاء
│
├── Data/                           # سياق قاعدة البيانات والتهيئة الأولية
│   ├── SchoolContext.cs            # سياق EF Core مع DbSet وتعريف أسماء الجداول مفردة
│   └── DbInitializer.cs            # فئة تهيئة وتغذية البيانات الأولية (تتضمن اسم الحسن علي باحبه)
│
├── Controllers/                    # المتحكمات
│   ├── HomeController.cs           # متحكم الصفحة الرئيسية، نبذة عن المشروع (About)، وسياسة الخصوصية
│   └── StudentsController.cs       # متحكم إدارة الطلاب مع كامل عمليات CRUD المخصصة والآمنة
│
└── Views/                          # الواجهات
    ├── _ViewImports.cshtml         # التضمينات المشتركة والمساعدات TagHelpers
    ├── _ViewStart.cshtml           # تعيين القالب الافتراضي _Layout
    ├── Home/
    │   ├── Index.cshtml            # الصفحة الرئيسية بتصميم عصري وبصمة المطور
    │   └── About.cshtml            # صفحة تعريفية بالمشروع وواجب الويب
    ├── Students/
    │   ├── Index.cshtml            # عرض قائمة الطلاب ومفتاح التنقل لعمليات التعديل والحذف
    │   ├── Details.cshtml          # تفاصيل الطالب مع جدول المقررات والتقديرات المسجلة
    │   ├── Create.cshtml           # نموذج إضافة طالب جديد مع حماية Overposting
    │   ├── Edit.cshtml             # نموذج تعديل بيانات طالب بأسلوب Read-and-Update
    │   └── Delete.cshtml           # تأكيد حذف طالب مع آلية التقاط وإظهار الأخطاء للمستخدم
    └── Shared/
        ├── _Layout.cshtml          # القالب العام وشريط التنقل الرئيسي وبصمة المطور
        ├── _ValidationScriptsPartial.cshtml
        └── Error.cshtml
```

---

### 3. ما تم تنفيذه في الدرس الأول (Tutorial 01):
1. **إنشاء مشروع الويب:** مشروع ASP.NET Core MVC كامل مهيأ للعمل بنظام .NET مع التوافقية العالية.
2. **تنسيق الموقع والقالب العام (`_Layout.cshtml`):** تحديث شريط التنقل، إدراج الروابط المطلوبة، وإضافة توقيع وبصمة المهندس **الحسن علي باحبه** في الترويسة والتذييل.
3. **تثبيت حزم EF Core:** تثبيت حزم `Microsoft.EntityFrameworkCore.SqlServer` و `Microsoft.AspNetCore.Diagnostics.EntityFrameworkCore`.
4. **بناء نماذج البيانات (Models):** بناء كيانات `Student`, `Course`, `Enrollment` وتعريف العلاقات.
5. **إنشاء سياق قاعدة البيانات (`SchoolContext`):** وراثة `DbContext` وتخصيص أسماء الجداول لتكون مفردة.
6. **تسجيل السياق والاتصال (`Program.cs`):** إعداد سلسلة الاتصال لـ SQL Server LocalDB وفلتر الأخطاء.
7. **تغذية البيانات الأولية (`DbInitializer`):** إدراج بيانات الطلاب والمقررات والتسجيلات، وإدراج الطالب المهندس **الحسن علي باحبه** بتقديرات ممتازة.

---

### 4. ما تم تنفيذه في الدرس الثاني (Tutorial 02 - تخصيص CRUD والأمان):
1. **تخصيص صفحة التفاصيل (Customize Details):**
   - استخدام `Include(s => s.Enrollments).ThenInclude(e => e.Course)` لتحميل البيانات المرتبطة في المقررات.
   - تطبيق `AsNoTracking()` لتحسين الأداء وسرعة الاستعلام.
   - تحديث واجهة `Views/Students/Details.cshtml` لتعرض جدولاً مفصلاً لجميع المقررات المسجلة للطالب وتقديراته.
2. **تأمين صفحة الإضافة (Update Create Page & Overposting Protection):**
   - إزالة `ID` من وسم `[Bind("EnrollmentDate,FirstMidName,LastName")]` لمنع هجمات التمرير الزائد (Overposting).
   - إضافة كتلة `try-catch (DbUpdateException)` لمعالجة أخطاء تحديث قاعدة البيانات وإظهار رسائل ودية للمستخدم.
3. **تأمين صفحة التعديل (Recommended Read-and-Update Pattern):**
   - استبدال أسلوب الربط الافتراضي بأسلوب **Read and Update** الموصى به برمجياً وأمنياً من مايكروسوفت.
   - استخدام الدالة `TryUpdateModelAsync<Student>` لتحديد الحقول المسموح بتحديثها فقط (`FirstMidName, LastName, EnrollmentDate`).
   - معالجة استثناءات التحديث `DbUpdateException`.
4. **تحديث صفحة الحذف ومعالجة الأخطاء (Update Delete Page):**
   - تعديل دالة `HttpGet Delete` لتقبل معامل اختياري `saveChangesError` لعرض رسالة خطأ عند فشل الحذف.
   - تعديل دالة `HttpPost DeleteConfirmed` لتطبيق أسلوب **Read-First** ومعالجة الأخطاء عبر إعادة التوجيه لصفحة الحذف مع إشعار بالخطأ.
   - تحديث واجهة `Views/Students/Delete.cshtml` لعرض تنبيه الخطأ `@ViewData["ErrorMessage"]` في حال تعذر الحذف.

---

### 5. التحقق الهيكلي والفحص البرمجي (Verification & Health Check)
- **فحص البناء والتجميع (Compilation Check):**
  ```powershell
  dotnet build "ContosoUniversity.sln"
  ```
  **النتيجة:**
  ```text
  Build succeeded.
      0 Warning(s)
      0 Error(s)
  ```
- **فحص التشغيل الفعلي (Runtime Validation):**
  - استجابة خادم الويب واستعراض واجهات الموقع وتأكيد وجود بصمة المهندس **الحسن علي باحبه**.
  - سلامة جميع مسارات التوجيه والتنقل لعمليات CRUD.

---

### 6. تعليمات التشغيل على جهاز آخر به Visual Studio (How to Run)
1. **طريقة Visual Studio (الأسهل والأسرع):**
   - افتح ملف الحل `ContosoUniversity.sln`.
   - اضغط على المفتاح `Ctrl + F5` (Start Without Debugging).
   - سيقوم Visual Studio تلقائياً بإنشاء قاعدة البيانات على `(localdb)\mssqllocaldb` وتغذيتها بالبيانات وعرض الموقع، وتستطيع استعراض وتعديل وإضافة الطلاب مع تجربة ميزات الأمان الجديدة.
2. **طريقة سطر الأوامر (CLI):**
   ```powershell
   cd "d:\هندسة الحاسوب\واجب الويب\ContosoUniversity"
   dotnet run
   ```
3. **استخدام MySQL (اختياري):**
   - تم توفير ملف `ContosoUniversity_Database.sql` الجاهز للاستيراد المباشر في MySQL Workbench.

---
**إعداد المهندس:** الحسن علي باحبه  
**إشراف:** م/ عصمت فرج القبس  
**الكلية والقسم:** جامعة حضرموت - كلية الهندسة والبترول - قسم هندسة الحاسوب (المستوى الخامس - سنة التخرج)  
**تاريخ التوثيق:** 19 نوفمبر 2026م  
**المستودع البعيد:** [https://github.com/EngAlhassan404/Contoso-University](https://github.com/EngAlhassan404/Contoso-University)
