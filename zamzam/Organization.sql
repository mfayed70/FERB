INSERT INTO ORGANIZATIONS (org_code, en_org_name, ar_org_name, prnt_org_code) VALUES
(1,  'Zamzam for Engineering Industries', 'زمزم للصناعات الهندسية', NULL),

-- First level under root
(2,  'Manufacturing Sector', 'قطاع التصنيع', 1),
(3,  'Commercial Sector', 'القطاع التجاري', 1),
(4,  'Quality Department', 'إدارة الجودة', 1),
(5,  'Finance Department', 'الإدارة المالية', 1),

-- Manufacturing Sector children
(6,  'Maintenance Department', 'إدارة الصيانة', 2),
(7,  'Material Control & Workshop', 'ورشة و رقابة الخامات', 2),
(8,  'Raw Material Store', 'مخزن المواد الخام', 2),
(9,  'Finished Goods Store', 'مخزن المنتج التام', 2),
(10, 'Production Department', 'إدارة الإنتاج', 2),
(11, 'Technical Office', 'المكتب الفني', 2),

-- Maintenance Department children
(12, 'Electrical Section', 'قسم الكهرباء', 6),
(13, 'Mechanical Section', 'قسم الميكانيكا', 6),

-- Material Control & Workshop children
(14, 'Workshop', 'الورشة', 7),
(15, 'Material Control', 'رقابة الخامات', 7),

-- Finished Goods Store children
(16, 'Air Outlets Section', 'قسم المخارج', 10),
(25, 'Air Ducts', 'قسم الدكت', 10),

(17, 'Paint Section', 'قسم الدهان', 16),
(18, 'Assembly Section', 'قسم التجميع', 16),
(19, 'Preparation Section', 'قسم التجهيز', 16),

-- Production Department children (manufacturing production sub-sections)
(20, 'Ducts & Cable Tray', 'قسم الدكت و الكابل تري', 25),
(26, 'Sheet Metal Products', 'قسم منتجات الصاج', 25),
(27, 'Presses / Machines', 'الماكينات', 25),

(21, 'Rectangular Ducts', 'قسم الدكت المربع', 20),
(22, 'Circular Ducts', 'قسم الدكت الدائري', 20),
(23, 'Welding', 'قسم اللحام', 20),
(24, 'Cable Tray (unit)', 'الكابل تري', 20),

-- Technical Office children

-- Sheet Metal Products subgroups
(28, 'Product Group 1', 'مجموعة منتجات صاج 1', 26),
(29, 'Product Group 2', 'مجموعة منتجات صاج 2', 26),
(30, 'Product Group 3', 'مجموعة منتجات صاج 3', 26),
(31, 'Cutting & Bending', 'القص و الثني', 26),

-- Commercial Sector children
(32, 'Purchasing Department', 'إدارة المشتريات', 3),
(33, 'Sales Department', 'إدارة المبيعات', 3),
(34, 'HR & Administration', 'الشئون الإدارية', 3),

-- HR & Administration children (under Commercial Sector)
(35, 'Personnel Department', 'شئون العاملين', 34),
(36, 'Administration Department', 'الإدارة الإدارية', 34),
(37, 'Legal Section', 'الشئون القانونية', 34),

-- Quality Department children
(38, 'Quality Control', 'رقابة الجودة', 4),
(39, 'Quality Assurance', 'توكيد الجودة', 4),
(40, 'Health & Safety', 'السلامة و الصحة المهنية', 4),

-- Finance Department children
(41, 'Accounting', 'المحاسبة', 5),
(42, 'Internal Audit', 'المراجعة الداخلية', 5),
(43, 'Costing', 'التكاليف', 5),
(44, 'Treasury', 'الخزينة', 5);
