create database db_jv240408;
use db_jv240408;
create table category(
	id int auto_increment primary key,
    name varchar(100) not null unique,
    status bit);
    
create table product(
	id int auto_increment primary key,
    name varchar(100),
    producer varchar(100),
    year_making int,
    expire_date date,
    quantity int,
    price double,
    category_id int,
    status bit,
    foreign key(category_id) references category(id));

create table users(
	id int auto_increment primary key,
    name varchar(100),
    gender bit,
    birthday date,
    email varchar(100) not null unique,
    phone varchar(20) not null unique,
    status bit);

create table address(
	id int auto_increment primary key,
    user_id int,
    address_name varchar(200) not null unique,
    receive_name varchar(100),
    status bit,
    foreign key(user_id) references users(id));

create table orders(
	id int auto_increment primary key,
    user_id int not null,
    order_date date not null,
    receive_name varchar(100),
    receive_address varchar(200),
    receive_phone varchar(20),
    status enum('WAITING','CONFIRM','DELIVERY','SUCCESS'),
    foreign key(user_id) references users(id));

create table order_detail(
	order_id int not null,
    product_id int not null,
    quantity int,
    price double,
    foreign key(order_id) references orders(id),
    foreign key(product_id) references product(id));
    
-- create primary key for oder_detail
alter table order_detail add constraint PK_OrderId_ProductId primary key(order_id,product_id);

/* Nhóm lệnh DML (Data Manipulation Language) */
/* insert data category */
select * from category;

insert into category(name,status) values ('Điện tử',1);
insert into category(name,status) values ('Điện lạnh',1),
										 ('Điện dân dụng',1),
										 ('Thời trang nam',1),
                                         ('Thời trang nữ',1),
                                         ('Thời trang công sở',1);

-- insert data to product
select * from product;
insert into product(name,producer,year_making,expire_date,quantity,price,category_id) values
('Tivi','Toshiba',2022,'2022-12-21',100,12000000,1),
('Tủ lạnh','Sanyo',2021,'2022-05-11',50,10000000,2),
('Nồi cơm điện','Cooku',2023,'2023-12-15',120,3000000,3),
('Điều hòa','Panasonic',2023,'2024-05-15',20,15000000,2),
('Bàn là','Shunhouse',2023,'2023-11-05',70,500000,1),
('Áo sơ mi nam','Việt Tiến',2022,'2022-12-21',200,500000,4),
('Áo sơ mi nữ','Việt Tiến',2022,'2022-12-21',200,500000,5),
('Giày Adidas','Adidas',2022,'2022-12-21',50,1200000,6),
('Giày nữ','Adidas',2022,'2022-12-21',70,14000000,6);

-- insert data for user table
select * from users;
insert into users(name,gender,birthday,email,phone) values
('Nguyễn Tuấn Anh',1,'2000-05-11','tuananh@gmail.com','0912322324'),
('Nguyễn Thị Huyền',0,'2001-11-27','huyen@gmail.com','0865123432'),
('Lê Mạnh Cường',1,'2000-10-22','cuong@gmail.com','034123432'),
('Ngô Mạnh Đạt',1,'2001-09-15','dat@gmail.com','0986123535'),
('Trần Thảo My',0,'2000-08-22','thaomy@gmail.com','0234651245');

update users set status = 1;
-- data address
select * from address;
insert into address(user_id,address_name,receive_name,status) values
(1,'Ba Đình - Hà Nôi','Nguyễn Văn Cường',1),
(1,'Gia Lâm - Hà Nôi','Nguyễn Tuấn Anh',1),
(1,'Hà Đông - Hà Nôi','Nguyễn Tuấn Anh',1),
(2,'Sơn Tây - Hà Nôi','Nguyễn Thị Huyền',1),
(2,'Phúc Thọ - Hà Nôi','Nguyễn Thị Huyền',1),
(3,'Việt Trì - Phú Thọ','Lê Mạnh Cường',1),
(3,'Lâm Thao - Phú Thọ','Lê Mạnh Cường',1);

-- data orders
select * from orders;
insert into orders(user_id,order_date,receive_name,receive_address,receive_phone,status) values
(1,'2024-02-12','Nguyễn Tuấn Anh','Ba Đình - Hà Nôi','0912322324','WAITING'),
(3,'2024-03-05','Lê Mạnh Cường','Việt Trì - Phú Thọ','034123432','WAITING'),
(2,'2023-12-27','Nguyễn Thị Huyền','Sơn Tây - Hà Nôi','0865123432','WAITING'),
(2,'2024-02-12','Nguyễn Thị Huyền','Phúc Thọ - Hà Nôi','0865123432','WAITING');

-- truncate orders;
-- SET FOREIGN_KEY_CHECKS = 0; 
-- TRUNCATE table orders; 
-- SET FOREIGN_KEY_CHECKS = 1;
-- data for order detail
select * from order_detail;
insert into order_detail(order_id,product_id,quantity,price) values
(1,1,1,11000000),
(1,2,1,10000000),
(2,1,1,12000000),
(3,3,2,3000000),
(3,5,1,500000),
(4,4,1,15000000);

-- SELECT ĐƠN GIẢN
select * from product; 

update product set status = 1;

select * from category;

-- select với case .. when
/*
	case expression
    when value1 then return_value1
    when value2 then return_value2
    ...
    end as 'column_name'
*/
select id,name,case status when 1 then 'active' when 0 then 'unactive' end as status from category;

-- select thông qua liên kết
-- Đưa ra kết quả: Mã danh mục, tên danh mục, tên sản phẩm, số lượng, đơn giá
select c.id as 'MaDM',c.name as 'TenDM',p.name as 'TenSP',p.quantity as 'Soluong',p.price as 'Gia' from category c inner join product p on c.id=p.category_id;

-- Đưa ra kết quả: Mã đơn hàng, ngày đặt hàng, họ tên, địa chỉ, tên sản phẩm, số lượng, giá mua
select o.id as 'MaDH',o.order_date as 'NgayDH',o.receive_name as 'HoTen', o.receive_address as 'DiaChi',p.name,od.quantity,od.price 
from orders o inner join users u on o.user_id=u.id
inner join order_detail od on o.id = od.order_id inner join product p on od.product_id=p.id;


select * from orders;

-- left join
-- Hiển thị ra những người chưa mua hàng bao giờ?
select * from users where id not in (select distinct user_id from orders);

select u.*,o.* from users u left join orders o on u.id=o.user_id;

-- RIGHT JOIN
select u.*,o.* from orders o right join users u on u.id=o.user_id;

-- WHERE: Điều kiện
-- Lấy thông tin những người mua hàng ở Hà Nội
select * from users u inner join address a on u.id = a.user_id where a.address_name like '%Phú Thọ';

-- Đưa ra những sản phẩm có giá từ 10tr -> 15tr
select * from product where price between 10000000 and 15000000;

-- Đưa ra những sản phẩm có giá là 10tr, 12tr, 13tr
select * from product where price in (10000000,12000000,13000000);

-- Đưa ra những sản phẩm có giá bán cao nhất?
select * from product where price = (select max(price) from product);

-- Đưa ra 2 sản phẩm có giá bán cao nhất?
select * from product order by price desc limit 2;

-- GROUP BY
-- Đưa ra thông tin giá trị đơn hàng của các đơn hàng đã mua (mã đơn hàng, ngày đặt hàng, người mua hàng, tổng giá trị)
/*
	phân tích:
		Mã đơn hàng, ngày đặt hàng, người mua hàng trong bảng orders
        Tổng giá trị: Phải sử dụng hàm sum() ở bảng order_detail
*/
select o.id as 'ma_dh', o.order_date as 'ngay_dh', o.receive_name as 'nguoi_mua_hang', sum(od.price) as 'tong_gia_tri' 
from orders o inner join order_detail od on o.id = od.order_id
group by o.id;


-- HAVING
-- : Đưa ra nhữn đơn hàng có giá trị từ 15tr trở lên
select o.id as 'ma_dh', o.order_date as 'ngay_dh', o.receive_name as 'nguoi_mua_hang', sum(od.price) as 'tong_gia_tri' 
from orders o inner join order_detail od on o.id = od.order_id
group by o.id
having tong_gia_tri>=15000000;


-- SESSION 04:
-- SUM:
select * from orders;

-- Yêu cầu: Tính doanh thu tháng, kết quả gồm: Tháng, Năm, Doanh thu
/*
	Phân tích: 
		1. Dữ liệu  lấy từ bảng orders và order_detail (đủ yêu cầu)
        2. Nhóm tháng và năm lại với nhau
        3. Dùng sum(soluong*dongia)
*/
select left(order_date,7) as nam from orders;
select year(now()) as nam_hien_tai;

select concat(month(o.order_date),"-",year(o.order_date)) as thang_nam, sum(d.quantity*d.price) as doanh_thu_thang from orders o join order_detail d on o.id=d.order_id
group by thang_nam
order by thang_nam asc;

-- Tổng giá trị tất cả các sản phẩm đã bán:
select sum(quantity*price) as tong_gia_tri from order_detail;

-- Mỗi năm bán được bao nhiêu sẩn phẩm?
select year(o.order_date) as nam, sum(d.quantity) as so_sp_ban_theo_nam
from orders o inner join order_detail d on o.id = d.order_id
group by nam
order by nam asc;

select * from orders;
select * from order_detail;

-- Trung bình mỗi năm bán được bao nhiêu sản phẩm
select sum(d.quantity)/(select count(distinct year(order_date)) from orders) as tb_moi_nam_ban_duoc
from orders o inner join order_detail d on o.id = d.order_id;

-- Trung bình giá của mỗi sản phẩm bán ra
select format(round(sum(quantity*price)/sum(quantity)),1,'vi_VN') as trung_binh_gia from order_detail;

-- giá sản phẩm lớn nhất?	(kq: tên sản phẩm, giá)
select name,price from product where price = (select max(price) from product);

-- Danh sách tên sản phẩm viết hoa
select ucase(name) as ten_sp from product order by ten_sp asc;

-- Danh sách tên sản phẩm viết thường
select lcase(name) as ten_sp from product order by ten_sp asc;

select format(avg(price),1,'vi_VN') as trung_binh_gia_moi_don from order_detail
group by order_id
order by trung_binh_gia_moi_don desc
limit 1;

-- CREATE INDEX:
-- Tạo index cho cột name trong bảng product
create index IDX_Name on product(name);
create unique index UIX_name on category(name); -- Đã tồn tại khi đặt unique

-- Hiển thị các index trong 1 bảng
show index from category;

-- TẠO THỦ TỤC
-- Thủ tục get data from category
delimiter //
create procedure get_categories()
begin
	select * from category;
end;
//

-- gọi thủ tục
call get_categories();

-- Thủ tục có tham số:
delimiter //
create procedure update_category(
	in id_in int,
	in name_in varchar(100),
    in status_in bit 
)
begin
	update category set name = name_in, status = status_in where id = id_in;
end;
//

-- call update 
call update_category (1,'Điện tử update',1);

-- select
select * from category;

-- Tham số ra:
delimiter //
create procedure count_all_category(
	out n int
)
begin
	select count(*) into n from category;   --  count(*): Đếm cột bất kỳ trong bảng, đếm cụ thể: count(id) from category
end;
//

-- Test
call count_all_category(@n);
select @n as so_ban_ghi;

-- full procedure for product table:
-- 1. get data
delimiter //
create procedure get_data_product()
begin
	select * from product;
end;
//

-- 2. insert data
delimiter //
create procedure insert_data_product(
	name_in varchar(100),
    producer_in varchar(100),
    year_making_in int,
    expire_date_in date,
    quantity_in int,
    price_in double,
    category_id_in int,
    status_in bit
)
begin
	insert into product(name,producer,year_making,expire_date,quantity,price,category_id,status) values
    (name_in,producer_in,year_making_in,expire_date_in,quantity_in,price_in,category_id_in,status_in);
end;
//
-- 3. update data
delimiter //
create procedure update_data_product(
	id_in int,
	name_in varchar(100),
    producer_in varchar(100),
    year_making_in int,
    expire_date_in date,
    quantity_in int,
    price_in double,
    category_id_in int,
    status_in bit
)
begin
	update product set name=name_in,producer=producer_in,year_making=year_making_in,expire_date=expire_date_in,quantity=quantity_in,price=price_in,category_id=category_id_in,status=status_in where id=id_in;
end;
//
-- 4. delete data
delimiter //
create procedure delete_data_product_1(
	id_in int
)
begin
	update product set status=false where id=id_in;   -- xóa mềm
end;
//

delimiter //
create procedure delete_data_product_2(
	id_in int
)
begin
	delete from product where id=id_in;   -- xóa cứng
end;
//

-- 5. get data by id
delimiter //
create procedure get_product_by_id(
	id_in int
)
begin
	select * from product where id=id_in;   
end;
//

-- create view
create or replace view get_product_with_category_name
as
select p.*,c.name as category_name from product p inner join category c on p.category_id=c.id
WITH CHECK OPTION;

-- get data from view
select * from get_product_with_category_name;

-- xem lại lệnh tạo view
show create view get_product_with_category_name;

-- xóa view:
drop view get_product_with_category_name;

-- xóa thủ tục
-- drop procedure update_data_product;