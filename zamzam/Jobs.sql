INSERT INTO JOBS (job_id, job_name_en, job_name_ar, org_code, parent_job_id) VALUES
-- Level 1
(1, 'Chairman of the Board of Directors', 'رئيس مجلس الإدارة', 1, NULL),

-- Level 2
(2, 'Vice Chairman', 'نائب رئيس مجلس الإدارة', 1, 1),

-- Level 3 (reporting to Vice Chairman)
(3, 'Plant Manager', 'مدير المصنع', 14, 2),
(4, 'Financial Manager', 'المدير المالي', 2, 2),
(5, 'Systems and Information Manager', 'مدير نظم المعلومات', 4, 2),
(6, 'Quality Management Manager', 'مدير إدارة الجودة', 6, 2),
(7, 'Purchasing Manager', 'مدير المشتريات', 7, 2),
(8, 'Legal and Administrative Affairs Manager', 'مدير الشؤون القانونية والإدارية', 10, 2),
(9, 'Technical Office Manager', 'مدير المكتب الفني', 11, 2),
(10, 'Maintenance Manager', 'مدير الصيانة', 13, 2),
(11, 'Business Manager', 'مدير الأعمال', 12, 2),
(12, 'Store Manager', 'مدير المخازن', 8, 2),
(13, 'Sales Manager', 'مدير المبيعات', 12, 2),
(14, 'Human Resources Manager', 'مدير الموارد البشرية', 9, 2),
(15, 'Internal Auditor', 'المراجع الداخلي', 3, 2),
(16, 'Head of Occupational Safety and Health', 'رئيس قسم السلامة والصحة المهنية', 5, 2),

-- Level 4 (reporting to department heads)
-- Technical Office
(17, 'Technical Office Engineer', 'مهندس المكتب الفني', 11, 9),
(18, 'Technical Draftsman', 'الرسام الفني', 11, 9),

-- Maintenance
(19, 'Maintenance Engineer', 'مهندس الصيانة', 13, 10),
(20, 'Maintenance Supervisor', 'مشرف الصيانة', 13, 10),
(21, 'Maintenance Technician', 'فني الصيانة', 13, 10),

-- Stores
(22, 'Head of Raw Materials Store', 'رئيس مخزن المواد الخام', 8, 12),
(23, 'Head of Finished Goods Store', 'رئيس مخزن المنتجات النهائية', 8, 12),
(24, 'Head of Semi-factory Store', 'رئيس مخزن نصف المصنع', 8, 12),
(25, 'Storekeeper', 'أمين مخزن', 8, 12),
(26, 'Assistant Storekeeper', 'مساعد أمين مخزن', 8, 12),
(27, 'Store Worker', 'عامل مخزن', 8, 12),

-- Raw Materials / Workshop
(28, 'Workshop Engineer', 'مهندس الورشة', 14, 3),
(29, 'Raw Materials Manager', 'مدير المواد الخام', 8, 12),
(30, 'Raw Materials Supervisor', 'مشرف المواد الخام', 8, 12),
(31, 'Workshop Supervisor', 'مشرف الورشة', 14, 3),
(32, 'Metal Lathe Technician', 'فني خراطة معدنية', 14, 3),

-- Sales
(33, 'Sales Specialist', 'أخصائي مبيعات', 12, 13),
(34, 'Customer Service Accountant', 'محاسب خدمة عملاء', 12, 13),

-- Human Resources
(35, 'Head of Training Department', 'رئيس قسم التدريب', 9, 14),
(36, 'Human Resource Specialist', 'أخصائي موارد بشرية', 9, 14),
(37, 'Lawyer', 'محامي', 10, 8),

-- Services and Security
(38, 'Security Supervisor', 'مشرف الأمن', 10, 8),
(39, 'Security Officer', 'ضابط الأمن', 10, 8),
(40, 'Services Workers Supervisor', 'مشرف عمال الخدمات', 10, 8),
(41, 'Services Worker', 'عامل خدمات', 10, 8),

-- Quality
(42, 'Head of Document Control Department', 'رئيس قسم ضبط الوثائق', 6, 6),
(43, 'Head of Quality Assurance Department', 'رئيس قسم ضمان الجودة', 6, 6),
(44, 'Quality Inspector', 'مفتش جودة', 6, 6),

-- Occupational Safety
(45, 'Occupational Safety Officer', 'ضابط سلامة مهنية', 5, 16),

-- Production
(46, 'Production Engineer', 'مهندس إنتاج', 14, 3),
(47, 'Production Supervisor', 'مشرف إنتاج', 14, 3),
(48, 'Production Technician', 'فني إنتاج', 14, 3),
(49, 'Electric Welding Technician', 'فني لحام كهرباء', 14, 3),

-- Purchasing
(50, 'Assistant Purchasing Manager', 'مساعد مدير المشتريات', 7, 7),
(51, 'Purchasing Specialist', 'أخصائي مشتريات', 7, 7),

-- Finance
(52, 'Financial Review Manager', 'مدير المراجعة المالية', 2, 4),
(53, 'Accountant', 'محاسب', 2, 4);

