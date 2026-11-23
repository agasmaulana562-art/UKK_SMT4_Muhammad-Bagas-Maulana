INSERT IGNORE INTO `tbl_facility` (`kode_facility`, `nama_facility`, `create_at`, `update_at`) VALUES
  ('FCT001', '30 m2 (30 meter persegi)', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT002', '40 m2 (40 meter persegi)', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT003', 'TV 32 Inchi', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT004', 'One-Bedroom', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT005', 'Two-Bedroom', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT006', 'Living room', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT007', 'Fully equipped kitchen', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT008', 'Refrigerator, stove, microwave', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT009', 'On-site laundry', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT010', 'Private Balcony', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT011', 'Air conditioning (AC)', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT012', 'High-speed internet', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT013', '24-hour security', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT014', 'Parking', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT015', 'Cleanning Room Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT016', 'Breakfast', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('FCT017', 'Loundry Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT IGNORE INTO `tbl_type_unit` (`id_unit_type`, `nama_type_unit`, `branch_id`, `create_at`, `update_at`) VALUES
  (1, 'Studio', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, 'Alcove', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3, 'Konvertibel', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (4, 'Junior One', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (5, 'gfhjk', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (6, 'Alcove', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (7, 'Kamr bulan Madu', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT IGNORE INTO `tbl_type_unit_facility` (`id_unit_type`, `kode_facility`)
SELECT `unit_type`.`id_unit_type`, `facility`.`kode_facility`
FROM `tbl_type_unit` AS `unit_type`
JOIN `tbl_facility` AS `facility`
  ON `facility`.`kode_facility` IN ('FCT001', 'FCT003')
WHERE `unit_type`.`id_unit_type` = 1
  AND `unit_type`.`nama_type_unit` = 'Studio'
  AND `unit_type`.`branch_id` = 1
  AND NOT EXISTS (
    SELECT 1
    FROM `tbl_type_unit_facility` AS `existing`
    WHERE `existing`.`id_unit_type` = `unit_type`.`id_unit_type`
  );
