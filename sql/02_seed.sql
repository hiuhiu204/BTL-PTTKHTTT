-- ============================================================
-- RestMan - Du lieu mau
-- Chay: mysql -u root -p < sql/02_seed.sql
-- Mat khau moi tai khoan mau: 123456
-- (SHA-256 hex cua "123456")
-- ============================================================
USE restman;
SET NAMES utf8mb4;
SET @pw = '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92';

INSERT INTO tblMember (id,username,password,fullName,dateOfBirth,address,phoneNumber,email,role) VALUES
 (1,'customer1', @pw,'Nguyễn Văn X','1998-03-15','12 Láng Hạ, Hà Nội','0901000001','customer1@restman.vn','CUSTOMER'),
 (2,'manager1',  @pw,'Trần Quốc Quản','1985-07-20','45 Cầu Giấy, Hà Nội','0901000002','manager1@restman.vn','MANAGER'),
 (3,'warehouse1',@pw,'Lê Thị Kho','1990-11-02','8 Nguyễn Trãi, Hà Nội','0901000003','warehouse1@restman.vn','WAREHOUSE'),
 (4,'sales1',    @pw,'Phạm Văn Bán','1995-01-25','30 Tây Sơn, Hà Nội','0901000004','sales1@restman.vn','SALES');

INSERT INTO tblMembershipCard (id,cardID,tier,points) VALUES (1,'MC001','Bạc',120);
INSERT INTO tblCustomer (id,tblMemberid,tblMembershipCardid) VALUES (1,1,1);
INSERT INTO tblManager (id,employeeID,position,tblMemberid) VALUES (1,'NV001','Quản lý',2);
INSERT INTO tblWarehouseEmployee (id,employeeID,position,tblMemberid) VALUES (1,'NV002','Nhân viên kho',3);
INSERT INTO tblSalesEmployee (id,employeeID,position,tblMemberid) VALUES (1,'NV003','Nhân viên bán hàng',4);

INSERT INTO tblDish (id,dishID,dishName,category,price,image,description,tblManagerid) VALUES
 (1,'D001','Cá hồi nướng măng tây','Món chính',250000,'dishes/dish-salmon.svg','Cá hồi tươi Na Uy áp chảo, ăn kèm măng tây nướng.',1),
 (2,'D002','Cá chép om dưa','Món chính',200000,'dishes/dish-carp.svg','Cá chép tươi om dưa chua theo kiểu truyền thống.',1),
 (3,'D003','Cà ri gà','Món chính',150000,'dishes/dish-curry.svg','Gà ta nấu cà ri nước cốt dừa, ăn kèm bánh mì.',1),
 (4,'D004','Gà nướng mật ong','Món chính',180000,'dishes/dish-honey-chicken.svg','Đùi gà ướp mật ong, nướng vàng giòn da.',1),
 (5,'D005','Salad rau củ','Khai vị',70000,'dishes/dish-salad.svg','Rau củ tươi trộn sốt chanh dây.',1),
 (6,'D006','Bò lúc lắc','Món chính',220000,'dishes/dish-beef-luc-lac.svg','Thăn bò xào lửa lớn với tiêu đen và hành tây.',1),
 (7,'D007','Tôm sú hấp sả','Món chính',260000,'dishes/dish-prawn.svg','Tôm sú hấp cùng sả tươi, giữ vị ngọt tự nhiên.',1),
 (8,'D008','Mực chiên giòn','Món chính',190000,'dishes/dish-squid.svg','Mực tươi tẩm bột chiên giòn, dùng kèm sốt chanh.',1),
 (9,'D009','Phở bò tái','Món chính',85000,'dishes/dish-pho.svg','Phở bò với nước dùng ninh xương và rau thơm.',1),
 (10,'D010','Bánh xèo miền Tây','Món chính',120000,'dishes/dish-banh-xeo.svg','Bánh xèo vàng giòn nhân tôm, ăn cùng rau sống.',1),
 (11,'D011','Chè đậu xanh','Tráng miệng',45000,'dishes/dish-che-dau-xanh.svg','Chè đậu xanh nước cốt dừa, dùng lạnh.',1),
 (12,'D012','Rau muống xào tỏi','Món phụ',55000,'dishes/dish-rau-muong.svg','Rau muống xào tỏi thơm, giòn xanh.',1),
 (13,'D013','Súp bí đỏ nấu tôm','Món canh',65000,'dishes/dish-canh-bi-dao.svg','Bí đỏ nấu tôm tươi, vị ngọt thanh.',1),
 (14,'D014','Bún chả giò','Món chính',95000,'dishes/dish-bun-cha-gio.svg','Bún ăn kèm chả giò chiên và rau sống.',1);

INSERT INTO tblIngredient (id,ingredientID,ingredientName,stockQuantity,unit,expiryDate) VALUES
 (1,'ING01','Nghêu',185,'Kg','2026-06-10'),
 (2,'ING02','Ghẹ xanh',100,'Kg','2026-06-08'),
 (3,'ING03','Cá hồi Na Uy',40,'Kg','2026-06-05'),
 (4,'ING04','Sò điệp',30,'Kg','2026-06-07'),
 (5,'ING05','Mực ống tươi',70,'Kg','2026-06-06'),
 (6,'ING06','Cải bó xôi',900,'Kg','2026-05-25'),
 (7,'ING07','Cà chua bi',450,'Kg','2026-05-30'),
 (8,'ING08','Tôm hùm Alaska',15,'Kg','2026-06-04'),
 (9,'ING09','Tôm sú tươi',55,'Kg','2026-09-10'),
 (10,'ING10','Mực lá',42,'Kg','2026-09-08'),
 (11,'ING11','Thịt bò thăn',80,'Kg','2026-09-12'),
 (12,'ING12','Bí đỏ',120,'Kg','2026-09-15'),
 (13,'ING13','Đậu xanh',65,'Kg','2026-10-01'),
 (14,'ING14','Rau muống',90,'Kg','2026-09-07'),
 (15,'ING15','Bánh phở tươi',75,'Kg','2026-09-06');

INSERT INTO tblSupplier (id,supplierID,supplierName,address,phoneNumber,note) VALUES
 (1,'SUP01','Đại lý Hải sản Vân Đồn','Vân Đồn, Quảng Ninh','0203111222','Hải sản tươi sống'),
 (2,'SUP02','Vựa rau sạch Đà Lạt','Đà Lạt, Lâm Đồng','0263333444','Rau củ sạch VietGAP'),
 (3,'SUP03','Công ty Thực phẩm Sạch Hà Nội','Long Biên, Hà Nội','0243555666','Chưa có đơn nhập'),
 (4,'SUP04','Hải sản Biển Xanh','Hạ Long, Quảng Ninh','02033881234','Tôm, mực và hải sản đông lạnh'),
 (5,'SUP05','Nông sản hữu cơ An Phú','Mê Linh, Hà Nội','02436662345','Rau củ theo mùa, canh tác hữu cơ'),
 (6,'SUP06','Thực phẩm tươi Minh Châu','Gia Lâm, Hà Nội','02437773456','Thịt và nguyên liệu khô');

INSERT INTO tblSupplierIngredient (tblSupplierid,tblIngredientid) VALUES
 (1,1),(1,2),(1,3),(1,4),(1,5),(1,8),
 (2,6),(2,7),
 (3,3),
 (4,9),(4,10),
 (5,12),(5,13),(5,14),
 (6,11),(6,15);

INSERT INTO tblImportInvoice (id,invoiceID,createdDate,tblSupplierid,tblWarehouseEmployeeid) VALUES
 (1,'HDN101','2026-04-20',1,1),
 (2,'HDN105','2026-05-05',1,1),
 (3,'HDN106','2026-05-06',1,1),
 (4,'HDN107','2026-05-10',2,1),
 (5,'HDN108','2026-06-02',2,1),
 (6,'HDN201','2026-08-03',4,1),
 (7,'HDN202','2026-08-08',5,1),
 (8,'HDN203','2026-08-15',6,1);

INSERT INTO tblImportDetail (id,quantity,unitPrice,tblImportInvoiceid,tblIngredientid) VALUES
 (1, 50,340000,1,5),                        -- HDN101: 17.000.000
 (2, 20,350000,2,5),(3, 15,1200000,2,8),    -- HDN105: 7.000.000 + 18.000.000 = 25.000.000
 (4,185, 40000,3,1),(5,100, 126000,3,2),    -- HDN106: 7.400.000 + 12.600.000 = 20.000.000
 (6,800, 30000,4,6),(7,450,  25000,4,7),    -- HDN107: 24.000.000 + 11.250.000 = 35.250.000
 (8,100, 32000,5,6),                        -- HDN108: 3.200.000
 (9,25,280000,6,9),(10,18,310000,6,10),     -- HDN201: 7.000.000 + 5.580.000 = 12.580.000
 (11,40,68000,7,14),(12,30,92000,7,12),     -- HDN202: 2.720.000 + 2.760.000 = 5.480.000
 (13,35,290000,8,11),(14,25,78000,8,15);    -- HDN203: 10.150.000 + 1.950.000 = 12.100.000
