INSERT INTO ORGANIZATIONS (org_code, en_org_name, ar_org_name, prnt_org_code) VALUES
-- 1 root
-- (1,  'ELECON ELECTROMECHANICAL CONTRACTPRS', 'شركة اليكون للمقاولات الكهروميكانيكية', NULL),

-- top-level under root (left->right as in diagram)
(2,  'Human Resources Department',                'إدارة شئون العاملين',                1),
(3,  'Warehouse Department',                       'إدارة المخازن',                      1),
(4,  'Accounting Department',                      'إدارة الحسابات',                     1),
(5,  'Business Development Department',            'إدارة تطوير الأعمال',               1),
(6,  'Procurement Department',                     'إدارة المشتريات',                    1),
(7,  'Tendering Department',                       'إدارة المناقصات',                    1),
(8,  'Technical Office Department',                'إدارة المكتب الفني',                 1),
(9,  'Project Management Department',              'إدارة المشروعات',                    1),

-- Human Resources children (under org_code=2)
(10, 'Legal Department',                           'إدارة الشؤون القانونية',             2),
(11, 'Recruitment Department',                     'إدارة التوظيف',                      2),

-- Warehouse (org_code=3) has no children in the image

-- Accounting children (under org_code=4)
(12, 'Pantry Department',                          'إدارة البوفيه',                      4),
(13, 'Public Relations Department',                'إدارة العلاقات العامة',              4),
(14, 'Secretariat Department',                     'إدارة السكرتارية',                   4),
(15, 'Audit Department',                           'إدارة المراجعة',                     4),

-- Business Development (org_code=5) has no smaller boxes visible

-- Procurement children (under org_code=6)
(16, 'Local Materials',                            'الخامات المحلية',                    6),
(17, 'Engineering Equipment',                      'المعدات الهندسية',                   6),

-- Tendering children (under org_code=7)
(18, 'Electrical (Tendering)',                     'كهرباء (مناقصات)',                   7),
(19, 'Mechanical (Tendering)',                     'ميكانيكا (مناقصات)',                 7),
-- (20, 'Civil/Structural (Tendering)',               'إنشائية (مناقصات)',                  7),

-- Technical Office children (under org_code=8)
-- diagram shows small boxes under Technical Office; include the clear ones:
(21, 'Electrical (Technical Office)',              'كهرباء',                             8),
(22, 'Mechanical (Technical Office)',              'ميكانيكا',                           8),
-- (23, 'Civil/Structural (Technical Office)',        'إنشائية',                            8),

-- Project Management children (under org_code=9)
(24, 'Technical Department',                       'الإدارة الفنية',                     9),
(25, 'Driver Fleet Department',                    'إدارة أسطول السائقين',               9),
(26, 'Occupational Health & Safety Department',    'إدارة السلامة والصحة المهنية',      9),
(27, 'Document Control Department',                'إدارة مراقبة الوثائق',               9),
(28, 'Planning Department',                        'إدارة التخطيط',                      9),

-- Technical Department children (under org_code=24)
(29, 'Machining Department',                       'إدارة البرادة',                      24),
(30, 'Welding Department',                         'إدارة اللحام',                       24),
(31, 'Installation Department',                    'إدارة التركيبات',                    24),
(23, 'Sheet Metal Department',        'إدارة الصاج',                            24),

-- Installation sub-sections (under org_code=31)
(32, 'Installation - Electrical',                  'تركيب - كهرباء',                     31),
(33, 'Installation - Mechanical',                  'تركيب - ميكانيكا',                   31);
