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
 (1,'D001','Cá hồi nướng măng tây','Món chính',250000,NULL,'Cá hồi tươi Na Uy áp chảo, ăn kèm măng tây nướng.',1),
 (2,'D002','Cá chép om dưa','Món chính',200000,NULL,'Cá chép tươi om dưa chua theo kiểu truyền thống.',1),
 (3,'D003','Cà ri gà','Món chính',150000,NULL,'Gà ta nấu cà ri nước cốt dừa, ăn kèm bánh mì.',1),
 (4,'D004','Gà nướng mật ong','Món chính',180000,NULL,'Đùi gà ướp mật ong, nướng vàng giòn da.',1),
 (5,'D005','Salad rau củ','Khai vị',70000,NULL,'Rau củ tươi trộn sốt chanh dây.',1),
 (6,'D006','Bò lúc lắc','Món chính',220000,NULL,'Thăn bò xào lửa lớn với tiêu đen và hành tây.',1);

INSERT INTO tblIngredient (id,ingredientID,ingredientName,stockQuantity,unit,expiryDate) VALUES
 (1,'ING01','Nghêu',185,'Kg','2026-06-10'),
 (2,'ING02','Ghẹ xanh',100,'Kg','2026-06-08'),
 (3,'ING03','Cá hồi Na Uy',40,'Kg','2026-06-05'),
 (4,'ING04','Sò điệp',30,'Kg','2026-06-07'),
 (5,'ING05','Mực ống tươi',70,'Kg','2026-06-06'),
 (6,'ING06','Cải bó xôi',900,'Kg','2026-05-25'),
 (7,'ING07','Cà chua bi',450,'Kg','2026-05-30'),
 (8,'ING08','Tôm hùm Alaska',15,'Kg','2026-06-04');

INSERT INTO tblSupplier (id,supplierID,supplierName,address,phoneNumber,note) VALUES
 (1,'SUP01','Đại lý Hải sản Vân Đồn','Vân Đồn, Quảng Ninh','0203111222','Hải sản tươi sống'),
 (2,'SUP02','Vựa rau sạch Đà Lạt','Đà Lạt, Lâm Đồng','0263333444','Rau củ sạch VietGAP'),
 (3,'SUP03','Công ty Thực phẩm Sạch Hà Nội','Long Biên, Hà Nội','0243555666','Chưa có đơn nhập');

INSERT INTO tblSupplierIngredient (tblSupplierid,tblIngredientid) VALUES
 (1,1),(1,2),(1,3),(1,4),(1,5),(1,8),(2,6),(2,7),(3,3);

INSERT INTO tblImportInvoice (id,invoiceID,createdDate,tblSupplierid,tblWarehouseEmployeeid) VALUES
 (1,'HDN101','2026-04-20',1,1),
 (2,'HDN105','2026-05-05',1,1),
 (3,'HDN106','2026-05-06',1,1),
 (4,'HDN107','2026-05-10',2,1),
 (5,'HDN108','2026-06-02',2,1);

INSERT INTO tblImportDetail (id,quantity,unitPrice,tblImportInvoiceid,tblIngredientid) VALUES
 (1, 50,340000,1,5),                        -- HDN101: 17.000.000
 (2, 20,350000,2,5),(3, 15,1200000,2,8),    -- HDN105: 7.000.000 + 18.000.000 = 25.000.000
 (4,185, 40000,3,1),(5,100, 126000,3,2),    -- HDN106: 7.400.000 + 12.600.000 = 20.000.000
 (6,800, 30000,4,6),(7,450,  25000,4,7),    -- HDN107: 24.000.000 + 11.250.000 = 35.250.000
 (8,100, 32000,5,6);                        -- HDN108: 3.200.000
