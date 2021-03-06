﻿9704198526191432198

https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Amount=1000000&vnp_BankCode=NCB&vnp_Command=pay&vnp_CreateDate=20200213155604&vnp_CurrCode=VND&vnp_IpAddr=%3a%3a1&vnp_Locale=vn&vnp_OrderInfo=Noi+dung+thanh+toan%3a20200213155555&vnp_OrderType=topup&vnp_ReturnUrl=http%3a%2f%2flocalhost%3a49490%2fView%2fBackEnd%2fvnpay_ipn.aspx&vnp_TmnCode=MJ9PCY3L&vnp_TxnRef=637172061641955212&vnp_Version=2.0.0&vnp_SecureHash=4a417c2ff6c35a38859595eb810f32108479d3ec61ff84c542666f663ea4857f



create database webDatTour;
use webDatTour;

-- Tạo các bảng

create table tblQuyen(
	iMaQuyen int identity(1,1) primary key not null,
	sTenQuyen nvarchar(100) not null,
);

create table tblNhanVien(
	iMaNhanVien int identitdonDatToury(1,1) primary key not null,
	sTenNhanVien nvarchar(100) not null,
	bGioiTinh bit null,
	dNgaySinh date,
	sDiaChi nvarchar(100),
	sSDT varchar(15),
	sUserName nvarchar(30),
	sPassWord varchar(150),
	iMaQuyen int not null
);

drop table tblNhanVien

alter table tblNhanVien add constraint FK_taikhoan_giangvien foreign key (iMaQuyen) references tblQuyen(iMaQuyen);

create table tblKhachHang(
	 int identity(1,1) primary key not null,
	sTenKhachHang nvarchar(100) not null,
	dNgaySinh iMaKhachHangdate null,
	sDiaChi nvarchar(100),
	sSDT int ,
	sEmail varchar(25),
	sUserName nvarchar(30),
	sPassWord varchar(150)
);

create table tblNhomTour(
	iMaNhomTour int identity(1,1) primary key not null,
	sTenNhomTour nvarchar(100) not null,
);
create table tblTrangThaiDonDatTour
(
iMaTrangThai int identity(1,1) primary key not null,
iTrangThai int,
sGhiChu nvarchar(100),
iMaDon int,
iMaNhanVien int,
dthoigian datetime
)

create table tblTour(
	iMaTour int identity(1,1) primary key not null,
	iMaNhanVien int not null,
	sTieuDe nvarchar(250),
	sMoTa nvarchar(900),
	sUrlAnh varchar(50),
	sTongThoiGian nvarchar(20),
	dNgayKhoiHanh date,
	iMaNhomTour int not null,
	iSoCho int

);

create table tblhinhanh(
	iMaHinhAnh int identity(1,1) primary key not null,
	sDuongDan varchar(100),
	iMaTour int not null
);
alter table tblhinhanh add constraint FK_tour_hinhanh foreign key (iMaTour) references tblTour(iMaTour);

create table tblTepThongTinKhachHang(
	 iMaTep int identity(1,1) primary key not null,
	 iMaKhachHang int not null,
	 sDuongDan varchar(150) not null
);


alter table tblTepThongTinKhachHang add constraint FK_tep_kh foreign key (iMaKhachHang) references tblkhachhang(iMaKhachHang);


alter table tbltour alter column smota nvarchar(4000) not null;

alter table tblTour add constraint FK_Tour_nhomTour foreign key (iMaNhomTour) references tblNhomTour(iMaNhomTour);
alter table tblTour add constraint FK_Tour_NhanVien foreign key (iMaNhanVien) references tblNhanVien(iMaNhanVien);


alter table tblnhomvegia add constraint FK_nhomve_gia foreign key (iMaNhomVe) references tblNhomVe(iMaNhomVe);

alter table tblchitietdondattour add constraint FK_nhomve_hoadonct foreign key (iMaNhomVe) references tblnhomve(iMaNhomVe);


alter table tbltrangthaidondattour add constraint FK_trangThai_DonDat foreign key (imadon) references tbldondattour(imadondattour);

create table tblDanhGia(
iMaDanhGia int identity(1,1) primary key not null,
iMaDonDatTour int not null,
dThoiGian datetime,
sNoiDung nvarchar(150),
iSoSao int,
 btrangthai bit 
);

alter table tblDanhGia add btrangthai bit 

alter table tblDanhGia add constraint FK_DonTour_BinhLuant foreign key (iMaDonDatTour) references tbldondattour(iMaDonDatTour);

select * from tbldondattour



create proc capNhatTrangThaiDanhGia
@id int
as
DECLARE @tt SMALLINT
set @tt = (select btrangthai from tblDanhGia where iMaDanhGia = @id)
if(@tt = 1)
begin
update tblDanhGia set btrangThai = 0 where iMaDanhGia = @id
end
else
begin
update tblDanhGia set btrangThai = 1 where iMaDanhGia = @id
end


 alter proc suaDanhGia
 @id int,
 @nd nvarchar(300),
 @sosao int
 as
 update tblDanhGia set sNoiDung = @nd , isoSao = @sosao where imadanhgia = @id

alter proc danhgia
@iddontour int,
@isosao int,
@thoigian datetime,
@noidung nvarchar(300)
as
insert into tbldanhgia(iMaDonDatTour, iSoSao, dThoiGian, sNoiDung, btrangthai) values
(@iddontour, @isosao, @thoigian, @noidung, 1)

create proc laydanhgia
@id int
as
select a.sTenKhachHang, c.dThoiGian, c.btrangthai, c.iMaDanhGia, c.iSoSao, c.sNoiDung , b.iMaDonDatTour, a.iMaKhachHang
from tblkhachhang a,  tbldondattour b , tblDanhGia c where b.imatour = @id and 
b.iMaDonDatTour = c.iMaDonDatTour and b.iMaKhachHang = a.iMaKhachHang


create table tblNhomVe(
	iMaNhomVe int identity(1,1) primary key not null,
	sTenNhomVe nvarchar(100) not null,
);




create table tblDonDatTour(
iMaDonDatTour int identity(1,1) primary key not null,
iMaTour int not null,
iMaKhachHang int not null,
dNgayDatTour date,
iTienDaThanhToan int DEFAULT 0,
sTrangThai nvarchar(25)
);

alter table tblDonDatTour add constraint FK_Tour_DonDatTour foreign key (iMaTour) references tblTour(iMaTour);

alter table tblDonDatTour add constraint FK_KhachHang_DonDatTour foreign key (iMaKhachHang) references tblKhachHang(iMaKhachHang);

--drop table tblNhomVe(
iMaNhomVe int identity(1,1) primary key not null,
sTenNhomVe nvarchar(20),
sMoTa nvarchar(30)
);
---bo

create table tblNhomVeGia
(
iMaTour int not null,
iMaNhomVe int not null,
iGiaVe int not null,
primary key (iMaTour, iMaNhomVe)
);

alter table tblNhomVeGia ADD iGiaVeGiam int null DEFAULT(0);

alter table tblNhomVeGia add constraint FK_nhomVeTour_Tour foreign key (iMaTour) references tblTour(iMaTour);
--alter table tblNhomVeTour add constraint FK_nhomVeTour_NhomVe foreign key (iMaNhomVe) references tblNhomVe(iMaNhomVe);

create table tblChiTietDonDatTour(
iMaDonDatTour int not null,
iMaNhomVe int not null,
soLuongVe int not null,
primary key (iMaNhomVe, iMaDonDatTour)

);

alter table tblChiTietDonDatTour add constraint FK_ChiTietDonDatTour_DonDatTour foreign key (iMaDonDatTour) references tblDonDatTour(iMaDonDatTour);

create table tblBinhLuan(
iMaBinhLuan int identity(1,1) primary key not null,
iMaKhachHang int not null,
iMaTour int not null,
dThoiGian datetime,
sNoiDung nvarchar(150)
);

alter table tblBinhLuan add constraint FK_Tour_BinhLuan foreign key (iMaTour) references tblTour(iMaTour);
alter table tblBinhLuan add constraint FK_KhachHang_BinhLuan foreign key (iMaKhachHang) references tblKhachHang(iMaKhachHang);


create proc themNhanVien
@tenNV nvarchar(100),
@tenDN nvarchar(30),
@mk varchar(150),
@sdt varchar(15),
@quequan nvarchar(100),
@ngaysinh datetime,
@gt bit,
@quyen int
as
insert into tblnhanvien(stennhanvien,susername,spassword,ssdt,sdiachi,dngaysinh,bgioitinh,imaquyen)
values (@tenNV ,@tenDN,@mk,@sinhsdt,@quequan,@ngaysinh,@gt,@quyen);


create proc themNhanVien1
@tennv nvarchar(100),
@tenDN nvarchar(30),
@mk varchar(150),
@sdt varchar(15),
@quequan nvarchar(100),
@ngaysinh datetime,
@gt bit,
@quyen int
as
insert into tblnhanvien(stennhanvien,susername,spassword,ssdt,sdiachi,dngaysinh,bgioitinh,imaquyen)
values (@tennv ,@tenDN,@mk,@sdt,@quequan,@ngaysinh,@gt,@quyen);

select * from tblnhanvien

create proc sp_danhSachNhanVien
as
select * from tblnhanvien

create proc sp_login
@tenkh nvarchar(170),
@ns date,
@diachi nvarchar(100),
@sdt varchar(13),
@email varchar(25),
@user nvarchar(30),
@pw varchar(150)
as
insert into tblKhachHang (sTenKhachHang,dNgaySinh,sDiaChi,sSDT,sEmail,sUserName,sPassWord) values 
(@tenkh,@ns,@diachi,@sdt,@email,@user,@pw);


create proc sp_login_kh
@user nvarchar(30),
@pw varchar(150)
as
select * from tblKhachHang where
sUserName = @user and sPassWord = @pw;


alter proc sp_themTour
@tieude nvarchar(250),
@mota nvarchar(4000),
@thoigian nvarchar(20),
@nhomtour int,
@socho int,
@manv int,
@noikhoihanh varchar(50),
@ngaytao date,
@imatour int out
as
insert into tblTour (iMaNhanVien,sTieuDe,sMoTa,sTongThoiGian,sNoiKhoiHanh,iMaNhomTour,iSoCho,dNgayTao)
OUTPUT INSERTED.iMaTour as id
values (@manv,@tieude,@mota,@thoigian,@noikhoihanh,@nhomtour,@socho,@ngaytao) set @imatour = SCOPE_IDENTITY()
return @imatour;
create proc sp_themThoiGianKhoiHanh
@imatour int,
@ngay date
as
insert into tblThoiGianKhoiHanh (iMaTour, dThoiGian) values (@imatour, @ngay)

alter proc sp_themGiave
@matour int,
@gianl int,
@giagiamnl int,
@hangiamnl date,
@giate int,
@giagiamte int,
@hangiamte date
as
insert into tblNhomVeGia(iMaTour,iMaNhomVe,iGiaVe,iGiaVeGiam, dHanGiamGia) 
values (@matour,1,@gianl,@giagiamnl, @hangiamnl),(@matour,2,@giate,@giagiamte,@hangiamte);


  


alter proc sp_updatetourID
@tieude nvarchar(250),
@mota nvarchar(max),
@thoigian nvarchar(20),
@noikhoihanh nvarchar(60),
@nhomtour int,
@socho int,
@imatour int
as
update tblTour set stieude = @tieude, sMoTa = @mota, sTongThoiGian = @thoigian,iSoCho = @socho, iMaNhomTour = @nhomtour, snoikhoihanh = @noikhoihanh
where iMaTour = @imatour

alter proc sp_updateGiaVe
@matour int,
@gianl int,
@giagiamnl int,
@hangiamnl date,
@giate int,
@giagiamte int,
@hangiamte date
as
update tblNhomVeGia set iGiaVe = @gianl, igiavegiam = @giagiamnl, dHanGiamGia = @hangiamnl where imatour = @matour and  iMaNhomVe = 1
update tblNhomVeGia set iGiaVe = @giate, igiavegiam = @giagiamte, dHanGiamGia = @hangiamte where imatour = @matour and  iMaNhomVe = 2


create proc sp_xoaNhanVien
@id int 
as delete from tblnhanvien where imanhanvien = @id

create proc sp_xoaTour
@id int 
as delete from tblTour where imatour = @id

create proc sp_xoaKhachHang
@id int 
as delete from tblKhachHang where imakhachhang = @id


alter proc sp_dstour1
as
select a.iMaTour,a.sTieuDe,d.dNgayKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,b3.surlanh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour ) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
  join
 (select imatour, min(dthoigian) as dNgayKhoiHanh from tblThoiGianKhoiHanh where --iMaTour = 36 and 
 getdate() < dthoigian and trangThai = 1
 group by iMaTour) as d on d.iMaTour= a.iMaTour 
 join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b3 on b3.imatour =a.iMaTour 


alter table tbldondattour add sghichu nvarchar(300) null

alter table tbltour add sNoiKhoiHanh nvarchar(50) null

alter table tbldondattour add imanvduyet int null

alter table tbltour add dNgayTao datetime null;

alter table tblThoiGianKhoiHanh add trangThai bit default 1


alter proc sp_dsThoiGianKhoiHanh
@id int
as
select * from tblThoiGianKhoiHanh where iMaTour = @id order by dThoiGian DESC

create proc sp_trangThaiThoiGianKH
@id int
as
DECLARE @tt SMALLINT
set @tt = (select trangthai from tblThoiGianKhoiHanh where iMaThoiGian = @id)
if(@tt = 1)
begin
update tblThoiGianKhoiHanh set trangThai = 0 where iMaThoiGian = @id
end
else
begin
update tblThoiGianKhoiHanh set trangThai = 1 where iMaThoiGian = @id
end


create proc sp_dsnhomtourbyid
@id int
as
select top 6 a.iMaTour,a.sTieuDe,a.dNgayKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,a.sUrlAnh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour where tblTour.iMaNhomTour = @id) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour 
 join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b3 on b3.imatour =a.iMaTour 



alter proc taoDonHang
  @idtour int,
  @ngay date,
  @idkh int,
  @tien int,
  @tt nvarchar(25),
  @ghichu nvarchar(300),
  @imadondattour int out
  as
  insert into tblDonDatTour (iMaTour, dNgayDatTour, iMaKhachHang, iTienDaThanhToan, strangthai, sghichu) 
   OUTPUT INSERTED.iMaDonDatTour as id
   values (@idtour, @ngay, @idkh, @tien, @tt,@ghichu)
   set @iMaDonDatTour = SCOPE_IDENTITY()
return @iMaDonDatTour;



   alter proc taoChiTietDonHang
   @madon int,
   @nl int, 
   @te int
   as
   insert into tblChiTietDonDatTour (iMaDonDatTour,imanhomve, soLuongVe) values(@madon,1,@nl),(@madon,2,@te)


 
   create proc sp_doiMatKhauKH
   @id int,
   @pw varchar(100)
   as
   update tblkhachhang set spassword = @pw where imakhachhang = @id

create proc sp_login_kh_id
   @id int,
@pw varchar(150)
as
select * from tblKhachHang where
iMaKhachHang = @id and sPassWord = @pw;

create proc sp_login_nv
   @user nvarchar(30),
@pw varchar(150)
as
select * from tblNhanVien where
susername = user and sPassWord = @pw;

select  d.sTieuDe , (sum(a.soLuongVe * c.iGiaVegiam)/2) + (sum(a.soLuongVe * c.iGiaVe) / 2 ) as 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblTour d
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour and d.iMaTour = b.iMaTour
group by  d.sTieuDe

select  d.sTieuDe , sum(b.iTienDaThanhToan) as 'tong thuc thu'
from  tblDonDatTour b, tblTour d
where   d.iMaTour = b.iMaTour
group by  d.sTieuDe

select b.iMaDonDatTour,sum(a.soLuongVe * c.iGiaVeGiam) as 'tong tien'  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour 
group by b.iMaDonDatTour

select  d.sTieuDe , sum(b.iTienDaThanhToan) as 'tong thuc thu'
from  tblDonDatTour b, tblTour d
where   d.iMaTour = b.iMaTour 
group by  d.sTieuDe



create proc layBinhLuan
@id int
as
select * from tblkhachhang, tblbinhluan where tblbinhluan.imatour = @id
and tblkhachhang.imakhachhang = tblbinhluan.imakhachhang



alter proc binhLuan
@idtour int,
@idkhachhang int,
@thoigian datetime,
@noidung nvarchar(300)
as
insert into tblBinhLuan(iMaKhachHang, iMaTour, dThoiGian, sNoiDung) values
(@idkhachhang, @idtour, @thoigian, @noidung)


create proc sp_dstouridnhom
@id int
as
select a.iMaTour,a.sTieuDe,a.dNgayKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,a.sUrlAnh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour where tblTour.iMaNhomTour = @id) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour




  create table tblGiaoDich(
    iMaThanhToan int identity(1,1) primary key not null,
	iMaDonTour int,
	tien int,
	thoigian date,
	idGiaoDich int,
	trangThai int,
	imaNhanVien int null
  )

  alter table tblGiaoDich add constraint FK_giaoDich_NhanVien foreign key (imaNhanVien) references tblNhanVien(imaNhanVien);

  create proc themGiaoDich
  @iMaDonTOur int,
  @thoigian date,
  @tien int,
  @trangThai int,
  @imagiaodich int out
  as
  insert into tblGiaoDich (iMaDonTour, thoigian, tien , trangThai)
   OUTPUT INSERTED.iMaGiaoDich as id
   values (@iMaDonTOur, @thoigian, @tien, @trangThai) 
   set @iMaGiaoDich = SCOPE_IDENTITY()
return @iMaGiaoDich;
   

 create proc themGiaoDichNV
  @iMaDonTOur int,
  @thoigian date,
  @tien int,
  @trangThai int,
  @nv int,
  @imagiaodich int out
  as
  insert into tblGiaoDich (iMaDonTour, thoigian, tien , trangThai, imaNhanVien)
   OUTPUT INSERTED.iMaGiaoDich as id
   values (@iMaDonTOur, @thoigian, @tien, @trangThai,@nv) 
   set @iMaGiaoDich = SCOPE_IDENTITY()
return @iMaGiaoDich;

  
  create table tblGiaoDich
  (
    iMaGiaoDich int identity(1,1) primary key not null,
	iMaDonTour int,
	tien int,
	thoigian date,
	idGiaoDichVNPAY bigint,
	trangThai int,
	imaNhanVien int null
  )

  alter table tblGiaoDich add constraint FK_giaoDich_NhanVien foreign key (imaNhanVien) references tblNhanVien(imaNhanVien);

 alter proc themGiaoDich
  @iMaDonTOur int,
  @thoigian datetime,
  @tien int,
  @trangThai int,
  @iMaGiaoDich int out
  as
  insert into tblGiaoDich (iMaDonTour, thoigian, tien , trangThai,imaNhanVien)
   OUTPUT INSERTED.iMaGiaoDich as id
   values (@iMaDonTOur, @thoigian, @tien, @trangThai,1) 
   set @iMaGiaoDich = SCOPE_IDENTITY()
return @iMaGiaoDich;
select * from tblGiaoDich
   

create proc updateTrangThaiGiaoDich
@trangThai int,
@id int,
@idvnpay bigint
as 
update tblGiaoDich set trangThai = @trangThai, idGiaoDichVNPAY = @idvnpay
where imagiaodich = @id

create proc layDanhSachDonDatTour
as
select * from tbldondattour a, tbltour b, tblkhachhang c where
 a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1) 
 and a.iMaTour = b.iMaTour and a.iMaKhachHang = c.iMaKhachHang

select a1.id_, a1.tongTien, b1.thucThu  from
(select b.iMaDonDatTour as id_,sum(a.soLuongVe * c.iGiaVeGiam) as tongTien  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour and b.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1) 
group by b.iMaDonDatTour) a1 join
(select a.iMaDonDatTour  as id_, SUM(tien) as thucThu from tbldondattour a, tblGiaoDich c where
 a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1) 
 and a.iMaDonDatTour = c.iMaDonTour 
 group by a.iMaDonDatTour) b1 on a1.id_ = b1.id_

alter proc sp_dsnhomtourbyid
@id int
as
select top 6 a.iMaTour,a.sTieuDe,d.dngaykhoihanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,b3.sUrlAnh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour where tblTour.iMaNhomTour = @id) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
  join
 (select imatour, min(dthoigian) as dngaykhoihanh from tblThoiGianKhoiHanh where --iMaTour = 36 and 
 getdate() < dthoigian and trangThai = 1
 group by iMaTour) as d on d.iMaTour= a.iMaTour 
 join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b3 on b3.imatour =a.iMaTour 

select b.iMaDonDatTour,sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as 'tong tien',sum(a.soLuongVe * c.iGiaVe) as 'tong tien2'  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour 
group by b.iMaDonDatTour
create proc layDanhSachDonDatTourByID
@id int
as
select * from tbldondattour a, tbltour b, tblkhachhang c where
 a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1) 
 and a.iMaTour = b.iMaTour and a.iMaKhachHang = c.iMaKhachHang and c.iMaKhachHang = @id
select a1.id_, a1.tongTien, b1.thucThu  from
(select b.iMaDonDatTour as id_,sum(a.soLuongVe * c.iGiaVeGiam) as tongTien  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour and b.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1) 
group by b.iMaDonDatTour) a1 join
(select a.iMaDonDatTour  as id_, SUM(tien) as thucThu from tbldondattour a, tblGiaoDich c where
 a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1) 
 and a.iMaDonDatTour = c.iMaDonTour 
 group by a.iMaDonDatTour) b1 on a1.id_ = b1.id_


select b.iMaDonDatTour,sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as 'tong tien',sum(a.soLuongVe * c.iGiaVe) as 'tong tien2'  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour 
group by b.iMaDonDatTour




 
alter proc donDatTour_
as
select (b1.doanhThu-b2.tien) as conLai,b1.doanhthu , b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, b1.iMaTour,b3.sGhiChu,b3.dthoigian,
b1.sTenKhachHang, b1.iMaKhachHang , b3.itrangthai, b3.iMaNhanVien , b1.dNgayDatTour , b1.sghichu , b1.stieude
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,
e.stieude ,e.iMaTour,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 or dHanGiamGia < b.dNgayDatTour  THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,e.stieude,
 e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour 
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian,imatrangthai, sghichu, imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1) b3 on b3.iMaDon = b2.iMaDonTour
order by b1.dNgayDatTour DESC



create proc thongKeDoanhThuTheoNgay
@batdau date,
@ketthuc date
as
 select sum(b1.doanhthu) as doanhthu  , sum(b2.tien) as thucthu, count(b1.iMaDonDatTour) as soDon
from
(select b.iMaDonDatTour,e.iMaTour,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour and
b.dNgayDatTour >= @ketthuc and b.dNgayDatTour <= @ketthuc
group by  b.iMaDonDatTour, e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour 




alter proc taoDonHang
  @idtour int,
  @ngay datetime,
  @idkh int,
  @ghichu nvarchar(300),
  @maThoiGian int,
  @imadondattour int out
  as
  insert into tblDonDatTour (iMaTour, dNgayDatTour, iMaKhachHang, sghichu,imathoigian) 
   OUTPUT INSERTED.iMaDonDatTour as id
   values (@idtour, @ngay, @idkh,@ghichu,@maThoiGian)
   set @iMaDonDatTour = SCOPE_IDENTITY()
return @iMaDonDatTour;

alter proc themThoiGianKhoiHanh
 @imatour int,
 @thoigian date
 as
 insert into tblThoiGianKhoiHanh(iMaTour,dThoiGian) 
 values (@imatour, @thoigian)

//thong ke ton tour 
select b1.iMaTour, b1.sTieuDe, b1.dThoiGian, b1.iSoCho,b3.veNguoiLon as veNguoiLon,b2.veTreEm as veTreEm,b1.iMaThoiGian from 
(select a.iMaTour, a.sTieuDe, b.dThoiGian, b.imathoigian, a.iSoCho from tblTour a, tblThoiGianKhoiHanh b where a.iMaTour = b.iMaTour) b1
join
(select soluongve as veNguoiLon,tblThoiGianKhoiHanh.imathoigian from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh
 where iMaNhomVe = 1 and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian 
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour and tblThoiGianKhoiHanh.iMaThoiGian = tblDonDatTour.imathoigian) b3 on b1.iMaThoiGian = b3.imathoigian
join
(select soluongve as veTreEm,tblThoiGianKhoiHanh.imathoigian
 from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh where tblChiTietDonDatTour.iMaNhomVe = 2
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour 
and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian) b2 on b2.iMaThoiGian = b1.iMaThoiGian

alter proc sp_soCho_Tour
as
select b1.iMaTour, b1.sTieuDe, b1.dThoiGian, b1.iSoCho,ISNULL(b3.veNguoiLon,0) as veNguoiLon,ISNULL(b2.veTreEm,0) as veTreEm,b1.iMaThoiGian from 
(select a.iMaTour, a.sTieuDe, b.dThoiGian, b.imathoigian, a.iSoCho from tblTour a, tblThoiGianKhoiHanh b where a.iMaTour = b.iMaTour
and b.dThoiGian > GETDATE() ) b1
left join
(  select  ISNULL(sum(soluongve),0) as veNguoiLon,tblThoiGianKhoiHanh.imathoigian, tblThoiGianKhoiHanh.dThoiGian from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh
 where iMaNhomVe = 1 and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian 
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour and tblThoiGianKhoiHanh.iMaThoiGian = tblDonDatTour.imathoigian
and tblThoiGianKhoiHanh.dThoiGian > GETDATE() 
group by  tblThoiGianKhoiHanh.imathoigian , tblThoiGianKhoiHanh.dThoiGian   ) b3 on b1.iMaThoiGian = b3.imathoigian
left join
(  select  ISNULL(sum(soluongve),0) as veTreEm,tblThoiGianKhoiHanh.imathoigian
 from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh where tblChiTietDonDatTour.iMaNhomVe = 2
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour 
and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian and tblThoiGianKhoiHanh.dThoiGian > GETDATE() 
group by  tblThoiGianKhoiHanh.imathoigian    ) b2 
on b2.iMaThoiGian = b3.iMaThoiGian


create proc sp_soCho_Tour
as
select b1.iMaTour, b1.sTieuDe, b1.dThoiGian, b1.iSoCho,b3.veNguoiLon as veNguoiLon,b2.veTreEm as veTreEm,b1.iMaThoiGian from 
(select a.iMaTour, a.sTieuDe, b.dThoiGian, b.imathoigian, a.iSoCho from tblTour a, tblThoiGianKhoiHanh b where a.iMaTour = b.iMaTour) b1
join
(select sum(soluongve) as veNguoiLon,tblThoiGianKhoiHanh.imathoigian from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh
 where iMaNhomVe = 1 and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian 
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour and tblThoiGianKhoiHanh.iMaThoiGian = tblDonDatTour.imathoigian
group by  tblThoiGianKhoiHanh.imathoigian) b3 on b1.iMaThoiGian = b3.imathoigian
join
(select sum(soluongve) as veTreEm,tblThoiGianKhoiHanh.imathoigian
 from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh where tblChiTietDonDatTour.iMaNhomVe = 2
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour 
and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian group by  tblThoiGianKhoiHanh.imathoigian) b2 
on b2.iMaThoiGian = b3.iMaThoiGian

alter proc sp_timsoCho_Tour
@tour nvarchar(80)
as
select b1.iMaTour, b1.sTieuDe, b1.dThoiGian, b1.iSoCho,ISNULL(b3.veNguoiLon,0) as veNguoiLon,ISNULL(b2.veTreEm,0) as veTreEm,b1.iMaThoiGian from 
(select a.iMaTour, a.sTieuDe, b.dThoiGian, b.imathoigian, a.iSoCho from tblTour a, tblThoiGianKhoiHanh b where a.iMaTour = b.iMaTour
and b.dThoiGian > GETDATE()  and a.sTieuDe like '%'+@tour+'%' ) b1
left join
(  select  ISNULL(sum(soluongve),0) as veNguoiLon,tblThoiGianKhoiHanh.imathoigian, tblThoiGianKhoiHanh.dThoiGian from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh
 where iMaNhomVe = 1 and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian 
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour and tblThoiGianKhoiHanh.iMaThoiGian = tblDonDatTour.imathoigian
and tblThoiGianKhoiHanh.dThoiGian > GETDATE()  
group by  tblThoiGianKhoiHanh.imathoigian , tblThoiGianKhoiHanh.dThoiGian   ) b3 on b1.iMaThoiGian = b3.imathoigian
left join
(  select  ISNULL(sum(soluongve),0) as veTreEm,tblThoiGianKhoiHanh.imathoigian
 from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh where tblChiTietDonDatTour.iMaNhomVe = 2
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour 
and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian and tblThoiGianKhoiHanh.dThoiGian > GETDATE() 
group by  tblThoiGianKhoiHanh.imathoigian    ) b2 
on b2.iMaThoiGian = b3.iMaThoiGian


alter proc sp_layChoChoCon
@idtour int,
@idtg int
as
select (b1.iSoCho - ISNULL(b3.veNguoiLon,0) - ISNULL(b2.veTreEm,0) )as soChoCon from 
(select a.iMaTour, a.sTieuDe, b.dThoiGian, b.imathoigian, a.iSoCho from tblTour a, tblThoiGianKhoiHanh b where a.iMaTour = b.iMaTour
and b.dThoiGian > GETDATE()  and a.iMaTour = @idtour and b.iMaThoiGian = @idtg) b1
left join
(  select  ISNULL(sum(soluongve),0) as veNguoiLon,tblThoiGianKhoiHanh.imathoigian, tblThoiGianKhoiHanh.dThoiGian from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh
 where iMaNhomVe = 1 and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian and dThoiGian >  GETDATE()
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour and tblThoiGianKhoiHanh.iMaThoiGian = tblDonDatTour.imathoigian
group by  tblThoiGianKhoiHanh.imathoigian , tblThoiGianKhoiHanh.dThoiGian   ) b3 on b1.iMaThoiGian = b3.imathoigian
 left join
(  select  ISNULL(sum(soluongve),0) as veTreEm,tblThoiGianKhoiHanh.imathoigian
 from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh where tblChiTietDonDatTour.iMaNhomVe = 2
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour 
and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian  and dThoiGian >  GETDATE()
group by  tblThoiGianKhoiHanh.imathoigian    ) b2 
on b2.iMaThoiGian = b3.iMaThoiGian   //DA SUA

  
alter proc xemDonDatTour
 @id int
as
select  b1.semail,b1.snoikhoihanh,b1.ssdt,b1.stongthoigian,b1.dthoigian,b4.veTE,b3.veNL,b1.doanhthu , b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, 
b1.sTenKhachHang, b1.iMaKhachHang , b1.dNgayDatTour , b1.sghichu , b1.stieude
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.dNgayDatTour, b.sghichu, e.stieude , g.dThoiGian, e.stongthoigian, d.sSDT, e.snoikhoihanh,d.sEmail,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e , tblThoiGianKhoiHanh g--, tblGiaoDich 
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour and e.imatour = g.imatour and b.imathoigian = g.iMaThoiGian
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour-- and b.iMaDonDatTour = @id
group by   g.dThoiGian,b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,e.stieude ,e.stongthoigian, d.sSDT, e.snoikhoihanh , d.semail) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour
join
(select sum(soLuongVe) as veNL, iMaDonDatTour from tblChiTietDonDatTour where iMaNhomVe = 1  group by iMaDonDatTour) b3 on b1.iMaDonDatTour = b3.iMaDonDatTour
join
(select sum(soLuongVe) as veTE, iMaDonDatTour from tblChiTietDonDatTour where iMaNhomVe = 2 group by iMaDonDatTour) b4 on b1.iMaDonDatTour = b4.iMaDonDatTour
 order by b1.dNgayDatTour DESC


 alter proc layDanhSachDonDatTourByIDkh
@id int
as
 select b3.itrangthai,b1.doanhthu , b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, 
b1.sTenKhachHang, b1.iMaKhachHang ,  b1.dNgayDatTour , b1.sghichu , b1.stieude, b1.iMaTour
from
(select  b.iMaTour,b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.dNgayDatTour, b.sghichu,
 e.stieude ,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 or c.dHanGiamGia < b.dNgayDatTour THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour and d.iMaKhachHang = @id
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.dNgayDatTour, b.sghichu,e.stieude, b.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour 
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu
FROM   (SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1) b3
on b3.iMaDon = b2.iMaDonTour
order by b1.dNgayDatTour DESC
 

create proc khachHangHuyTour
@id int
as
update tblDonDatTour set itrangthai = 2 where iMaDonDatTour = @id

alter proc capNhatTrangThaiTour
@id int,
@tt int,
@manv int,
@ngay datetime
as
update tblDonDatTour set itrangthai = @tt, imanvduyet = @manv, dThoiGianDuyet = @ngay where iMaDonDatTour = @id

create proc xemKhachHangID
@id int
as
select * from tblKhachHang where iMaKhachHang = @id

alter proc capNhapKhachHang
@id int,
@ten nvarchar(100),
@ngay datetime,
@dicchi nvarchar(100),
@sdt varchar(13),
@mail varchar(25)
as
update tblKhachHang set sTenKhachHang = @ten, dNgaySinh = @ngay, sDiaChi = @dicchi, sSDT = @sdt, sEmail = @mail
where iMaKhachHang = @id


alter proc sp_dsnhomtourbyid
@id int
as
select top 6 ISNULL(b5.soSao,0) as soSao,a.iMaTour,a.sTieuDe,d.dngaykhoihanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,b3.sUrlAnh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour where tblTour.iMaNhomTour = 18) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
  join
 (select imatour, min(dthoigian) as dngaykhoihanh from tblThoiGianKhoiHanh where --iMaTour = 36 and 
 getdate() < dthoigian and trangThai = 1
 group by iMaTour) as d on d.iMaTour= a.iMaTour 
 join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b3 on b3.imatour =a.iMaTour 
left join
(select iMaTour, ISNULL( avg(Cast(b.isosao as Float)) , 0 ) soSao from
 (select iMaTour, iMaDonDatTour from tblDonDatTour ) a
 left join 
( select iMaDonDatTour,isosao from tblDanhGia) b
on a.imadondattour = b.iMaDonDatTour group by iMaTour ) b5
on b5.iMaTour =  a.iMaTour 

alter proc thongKeDoanhThuTheoNgay
@batdau datetime,
@ketthuc datetime
as
 select ISNULL(sum(b1.doanhthu),0) as doanhthu  ,ISNULL(sum(b2.tien),0) as thucthu, count(b1.iMaDonDatTour) as soDon
from
(select b.iMaDonDatTour,e.iMaTour,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour
 and b.dNgayDatTour >= @batdau and b.dNgayDatTour <= @ketthuc
group by  b.iMaDonDatTour, e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour 
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian,imatrangthai, sghichu, imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1 and iTrangThai != 3 and iTrangThai !=2) b3 on b3.iMaDon = b2.iMaDonTour

alter proc thongKeDoanhThuTheoNgay_danhSach
@batdau datetime,
@ketthuc datetime
as
 select b1.ngay,ISNULL(sum(b1.doanhthu),0) as doanhthu  ,ISNULL(sum(b2.tien),0) as thucthu, count(b1.iMaDonDatTour) as soDon
from
(select b.iMaDonDatTour,e.iMaTour,convert(varchar(10),b.dNgayDatTour,103) as ngay,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour
 --and b.dNgayDatTour >= @batdau and b.dNgayDatTour <= @ketthuc
group by  b.iMaDonDatTour, e.iMaTour,convert(varchar(10),b.dNgayDatTour,103)) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour 
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian,imatrangthai, sghichu, imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1 and iTrangThai != 3 and iTrangThai !=2) b3 on b3.iMaDon = b2.iMaDonTour
group by b1.ngay



alter proc nhanVienthanhToan
@tien int,
@thoigian datetime,
@madon int,
@trangThai int,
@manv int
as
insert into tblGiaoDich (tien, thoigian, iMaDonTour, trangThai, imaNhanVien) values
(@tien, @thoigian, @madon, @trangThai, @manv)


create proc xemgiaodich
@id int
as
select * from tblNhanVien a, tblGiaoDich b
where a.imanhanvien = b.imaNhanVien and b.iMaDonTour = @id and trangThai = 1

create proc xemgiaodich
@id int
as
select * from tblNhanVien a, tblGiaoDich b
where a.imanhanvien = b.imaNhanVien and b.iMaDonTour = @id and trangThai = 1

select * from tblNhanVien
exec xemgiaodich 55

 alter proc themGiaoDich
  @iMaDonTOur int,
  @thoigian datetime,
  @tien int,
  @trangThai int,
  @iMaGiaoDich int out
  as
  insert into tblGiaoDich (iMaDonTour, thoigian, tien , trangThai,imaNhanVien)
   OUTPUT INSERTED.iMaGiaoDich as id
   values (@iMaDonTOur, @thoigian, @tien, @trangThai,1) 
   set @iMaGiaoDich = SCOPE_IDENTITY()
return @iMaGiaoDich;


alter proc timDonDatTour_
@tuKhoa nvarchar(30)
as
select (b1.doanhThu-b2.tien) as conLai,b1.doanhthu , b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, b1.iMaTour,
b1.sTenKhachHang, b1.iMaKhachHang ,b3.iTrangThai , b3.iMaNhanVien , b1.dNgayDatTour , b1.sghichu , b3.dthoigian, b1.stieude
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,
 e.stieude ,e.iMaTour,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour
and b.iMaDonDatTour  like '%'+@tuKhoa+'%'
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.dNgayDatTour, b.sghichu,e.stieude,
 e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu, imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1) b3
on b3.iMaDon = b2.iMaDonTour

order by b1.dNgayDatTour DESC
alter proc timDonDatTourKH
@tuKhoa nvarchar(30)
as
select (b1.doanhThu-b2.tien) as conLai,b1.doanhthu , b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, b1.iMaTour,
b1.sTenKhachHang, b1.iMaKhachHang ,b3.iTrangThai , b3.iMaNhanVien , b1.dNgayDatTour , b1.sghichu , b3.dthoigian, b1.stieude
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,
 e.stieude ,e.iMaTour,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour
and d.sTenKhachHang  like '%'+@tuKhoa+'%'
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.dNgayDatTour, b.sghichu,e.stieude,
 e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu, imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1) b3
on b3.iMaDon = b2.iMaDonTour

order by b1.dNgayDatTour DESC


  alter proc sp_timKiemTour
@ten nvarchar(50)
as
select a.iMaTour,a.sTieuDe,d.dNgayKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,b4.sUrlAnh , b.imatour, b.iGiaVe as igianl,
 b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam , d.dNgayKhoiHanh as dThoiGian
from
(
select * from tblTour where sTieuDe like '%' + @ten + '%') as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
join
 (select imatour, min(dthoigian) as dNgayKhoiHanh from tblThoiGianKhoiHanh where --iMaTour = 36 and 
 getdate() < dthoigian and trangThai = 1
 group by iMaTour) as d on d.iMaTour= a.iMaTour 
  join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b3 on b3.imatour =a.iMaTour 
  join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour =a.iMaTour 

alter table tblgiaodich add thoigian datetime null
alter table tblgiaodich add thoigian datetime null 
alter table tbldondattour alter column dthoigianduyet datetime null  

alter proc sp_capNhatTrangThaiDonHang 
@madon int,
@thoigian datetime,
@ghichu nvarchar(100),
@trangThai int,
@manv int
as
insert into tblTrangThaiDonDatTour (iMaDon,dthoigian,iTrangThai,sghichu,imanhanvien) values
(@madon, @thoigian, @trangThai,@ghichu,@manv)


create proc sp_capNhatTrangThaiDonHangNV 
@madon int,
@thoigian datetime,
@ghichu nvarchar(100),
@trangThai int,
@manv int
as
insert into tblTrangThaiDonDatTour (iMaDon,dthoigian,iTrangThai,sghichu,iMaNhanVien) values
(@madon, @thoigian, @trangThai,@ghichu,@manv)

create proc sp_capNhatTrangThaiDonHangKH  Khách Hàng
@madon int,
@thoigian datetime,
@ghichu nvarchar(100)
as
insert into tblTrangThaiDonDatTour (iMaDon,dthoigian,iTrangThai,sghichu) values
(@madon, @thoigian, 2,@ghichu)

SELECT iMaDon, iTrangThai, dthoigian
FROM   (SELECT iMaDon, iTrangThai, dthoigian,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1


alter proc xemTrangThaiNV
@id int
as
select a.imanhanvien, a.dthoigian, a.sghichu, a.itrangthai, a.imadon, isnull(b.stennhanvien,'Khach Hang') as stennhanvien from
(select iMaNhanVien,max(dthoigian) as dthoigian, sghichu, itrangThai, imadon from
  tblTrangThaiDonDatTour b where b.iMaDon = @id
 group by imanhanvien, sghichu, itrangthai, imadon  )  a
 left join
(select stennhanvien, iMaNhanVien from tblNhanVien ) b
on a.imanhanvien = b.imanhanvien
alter table tblbinhluan drop column itrangthai bit default 0

create proc capNhatTrangThaiBinhLuan
@id int
as
DECLARE @tt SMALLINT
set @tt = (select itrangthai from tblbinhluan where iMabinhLuan = @id)
if(@tt = 1)
begin
update tblbinhluan set itrangThai = 0 where iMabinhLuan = @id
end
else
begin
update tblbinhluan set itrangThai = 1 where iMabinhLuan = @id
end


create proc tourhot //chua exec
as
select SUM(b.soLuongVe) as soLuong, c.sTieuDe , c.iMaTour from tbldondattour a, tblChiTietDonDatTour b , tblTour c
where a.iMaDonDatTour = b.iMaDonDatTour and a.imatour = c.iMaTour and a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1)
and a.iMaDonDatTour not in (select iMaDon from tblTrangThaiDonDatTour where iMaTrangThai = 3 or iMaTrangThai = 2)
group by c.sTieuDe, c.iMaTour 
order by soLuong DESC

alter table tbltour add bTrangThai bit default 1


alter proc toutMoiNhat 
as 
select top 8 isnull(b5.soSao, 0 ) as soSao,a.sTongThoiGian,a1.thoiGianDI,a.dNgayTao, a.iMaTour, a.sTieuDe,sNoiKhoiHanh,b4.sUrlAnh, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
 from
(select * from tblTour where btrangthai = 1
) as a 
join
 (select imatour, min(dThoiGian) as thoiGianDI from tblThoiGianKhoiHanh where trangthai = 1 and dthoigian > GETDATE() group by iMaTour) as a1 
 on a.imatour = a1.imatour
 JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
  join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour =a.iMaTour 
left join
(select iMaTour, ISNULL( avg(Cast(b.isosao as Float)) , 0 ) soSao from
 (select iMaTour, iMaDonDatTour from tblDonDatTour ) a
 left join 
( select iMaDonDatTour,isosao from tblDanhGia) b
on a.imadondattour = b.iMaDonDatTour group by iMaTour ) b5
on b5.iMaTour =  a1.iMaTour 
 order by a.dNgayTao DESC


alter proc sp_timKiemTour
@ten nvarchar(50)
as
select a.iMaTour,a.sTieuDe,d.dNgayKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,b4.sUrlAnh , b.imatour, b.iGiaVe as igianl,
 b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam , d.dNgayKhoiHanh as dThoiGian
from
(
select * from tblTour where sTieuDe like '%' + @ten + '%') as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
join
 (select imatour, min(dthoigian) as dNgayKhoiHanh from tblThoiGianKhoiHanh where --iMaTour = 36 and 
 getdate() < dthoigian and trangThai = 1
 group by iMaTour) as d on d.iMaTour= a.iMaTour 
  join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b3 on b3.imatour =a.iMaTour 
join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour =a.iMaTour 



alter proc tourhotTuan
as
DECLARE @ngay date
set @ngay = (SELECT DATEADD(DAY, -7, getdate()))
select top 8 a1.sTongThoiGian,a2.thoiGianDI, a1.iMaTour, a1.sTieuDe,a1.sNoiKhoiHanh,b4.sUrlAnh, b.iGiaVe as igianl,
 b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam, b5.sosao
 from
(select top 8 SUM(b.soLuongVe) as soLuong, c.sTieuDe , c.iMaTour ,c.sTongThoiGian, c.sNoiKhoiHanh
from tbldondattour a, tblChiTietDonDatTour b , tblTour c
where a.iMaDonDatTour = b.iMaDonDatTour and a.imatour = c.iMaTour and a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1)
and a.iMaDonDatTour not in (sexlect iMaDon from tblTrangThaiDonDatTour where iMaTrangThai = 3 or iMaTrangThai = 2)
and c.bTrangThai = 1 and a.dNgayDatTour >= @ngay
group by c.sTieuDe, c.iMaTour ,c.sTongThoiGian,  c.sNoiKhoiHanh
order by soLuong DESC ) a1
join
 (select imatour, min(dThoiGian) as thoiGianDI from tblThoiGianKhoiHanh where trangthai = 1 and dthoigian > GETDATE() group by iMaTour) as a2
 on a2.imatour = a1.imatour
 JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a1.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a1.iMaTour
     join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour = a1.iMaTour 
 join
(select iMaTour, ISNULL( avg(Cast(b.isosao as Float)) , 0 ) soSao from
 (select iMaTour, iMaDonDatTour from tblDonDatTour ) a
 left join 
( select iMaDonDatTour,isosao from tblDanhGia) b
on a.imadondattour = b.iMaDonDatTour group by iMaTour ) b5
on b5.iMaTour =  a1.iMaTour 




create proc tourhotThang
as
DECLARE @ngay date
set @ngay = (SELECT DATEADD(DAY, -30, getdate()))
select top 8 b5.soSao,a1.sTongThoiGian,a2.thoiGianDI, a1.iMaTour, a1.sTieuDe,a1.sNoiKhoiHanh,b4.sUrlAnh, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
 from
(select top 8 SUM(b.soLuongVe) as soLuong, c.sTieuDe , c.iMaTour ,c.sTongThoiGian,  c.sNoiKhoiHanh
from tbldondattour a, tblChiTietDonDatTour b , tblTour c
where a.iMaDonDatTour = b.iMaDonDatTour and a.imatour = c.iMaTour and a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1)
and a.iMaDonDatTour not in (select iMaDon from tblTrangThaiDonDatTour where iMaTrangThai = 3 or iMaTrangThai = 2)
and c.bTrangThai = 1 and a.dNgayDatTour >= @ngay
group by c.sTieuDe, c.iMaTour ,c.sTongThoiGian, c.sNoiKhoiHanh
order by soLuong DESC ) a1
join
 (select imatour, min(dThoiGian) as thoiGianDI from tblThoiGianKhoiHanh where trangthai = 1 and dthoigian > GETDATE() group by iMaTour) as a2
 on a2.imatour = a1.imatour
 JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a1.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a1.iMaTour
  join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour =a1.iMaTour 
 join
(select iMaTour, ISNULL( avg(Cast(b.isosao as Float)) , 0 ) soSao from
 (select iMaTour, iMaDonDatTour from tblDonDatTour ) a
 left join 
( select iMaDonDatTour,isosao from tblDanhGia) b
on a.imadondattour = b.iMaDonDatTour group by iMaTour ) b5
on b5.iMaTour =  a1.iMaTour 


create proc updateNhanVien
 @ten nvarchar(50),
 @gt bit,
 @ns date,
 @dc nvarchar(50),
 @dt varchar(16),
 @id int
 as
 update tblNhanVien set sTenNhanVien = @ten, bGioiTinh = @gt, dNgaySinh =  @ns, sDiaChi = @dc, ssdt= @dt
 where iMaNhanVien = @id 

alter proc sp_tourTheoNhom
@id int
as
select isnull(b5.soSao, 0) as soSao,a.iMaTour,a.sNoiKhoiHanh,a.sTieuDe,b2.thoigiandi,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,b4.surlanh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour where tblTour.iMaNhomTour = @id
) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
  join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour =a.iMaTour 
join
 (select imatour, min(dThoiGian) as thoiGiandi from tblThoiGianKhoiHanh 
 where trangthai = 1 and dthoigian > GETDATE() group by iMaTour) as b2
 on b2.imatour = a.imatour
left join
(select iMaTour, ISNULL( avg(Cast(b.isosao as Float)) , 0 ) soSao from
 (select iMaTour, iMaDonDatTour from tblDonDatTour ) a
 left join 
( select iMaDonDatTour,isosao from tblDanhGia) b
on a.imadondattour = b.iMaDonDatTour group by iMaTour ) b5
on b5.iMaTour =  a.iMaTour



create proc kiemTraQuyenBinhLuan
@makh int,
@idtour int
as
select a.iMaTour, a.iMaDonDatTour,a.iMaKhachHang
from tblDonDatTour a ,tblThoiGianKhoiHanh b where a.iMaTour = @idtour and a.iMaKhachHang = @makh and 
a.imathoigian = b.iMaThoiGian and b.dThoiGian < GETDATE()
and a.iMaDonDatTour in (SELECT iMaDon
FROM   (SELECT iMaDon, iTrangThai, dthoigian,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour where itrangthai = 1) t
WHERE  rk = 1)

 create proc suaBinhLuan
 @id int,
 @nd nvarchar(100)
 as
 update tblBinhLuan set sNoiDung = @nd where iMaBinhLuan = @id

 create proc sp_trangThaiTour
@id int
as
DECLARE @tt SMALLINT
set @tt = (select btrangthai from tblTour where iMaTour = @id)
if(@tt = 1)
begin
update tblTour set btrangthai = 0 where iMaTour = @id
end
else
begin
update tblTour set btrangthai = 1 where iMaTour = @id
end

create proc sp_trangThaiNhomTourTour
@id int
as
DECLARE @tt SMALLINT
set @tt = (select btrangthai from tblnhomtour where iMaNhomTour = @id)
if(@tt = 1)
begin
update tblnhomtour set btrangthai = 0 where iMaNhomTour = @id
end
else
begin
update tblnhomtour set btrangthai = 1 where iMaNhomTour = @id
end

create proc sp_thongkedoanhsotheotour
@tour nvarchar(80)
as
select sum(b1.doanhThu-b2.tien) as conLai,sum(b1.doanhthu) as doanhthu , sum(b2.tien) as thucthu,b1.dThoiGian as thoigiandi, b1.iMaThoiGian as mathoigiandi,b1.imatour, b1.sTieuDe
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,
e.stieude ,e.iMaTour,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu, g.dthoigian, g.iMaThoiGian  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e, tblthoigiankhoihanh g --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour and b.imathoigian = g.iMaThoiGian
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour  and e.sTieuDe like '%'+@tour+'%'
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,e.stieude, g.dthoigian, g.iMaThoiGian  ,
 e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour 
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian,imatrangthai, sghichu, imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1) b3 on b3.iMaDon = b2.iMaDonTour

group by  b1.dThoiGian, b1.iMaThoiGian,b1.imatour, b1.sTieuDe


create proc sp_thongkedoanhsotheotatcatour
as
select sum(b1.doanhThu-b2.tien) as conLai,sum(b1.doanhthu) as doanhthu , sum(b2.tien) as thucthu,b1.dThoiGian as thoigiandi, b1.iMaThoiGian as mathoigiandi,b1.imatour, b1.sTieuDe
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,
e.stieude ,e.iMaTour,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu, g.dthoigian, g.iMaThoiGian  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e, tblthoigiankhoihanh g --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour and b.imathoigian = g.iMaThoiGian
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour 
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,e.stieude, g.dthoigian, g.iMaThoiGian  ,
 e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour 
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian,imatrangthai, sghichu, imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1) b3 on b3.iMaDon = b2.iMaDonTour

group by  b1.dThoiGian, b1.iMaThoiGian,b1.imatour, b1.sTieuDe


alter proc sp_timKiemTour_ds
@ten nvarchar(50)
 as
select a.imatour, a.btrangthai,  a.stieude, a.sTongThoiGian, a.iSoCho, a.sNoiKhoiHanh, b4.surlanh as sduongdan, a.dngaytao  from 
(select tbltour.iMaTour,tbltour.bTrangThai,tbltour.sTieuDe, tbltour.sNoiKhoiHanh, tbltour.sTongThoiGian,tbltour.iSoCho, tblTour.dNgayTao
from tblTour  where tblTour.sTieuDe like '%'+@ten+'%' ) a
   join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour =a.iMaTour 
 order by dngaytao DESC
 

alter proc sp_layChoChoCon
@idtour int,
@idtg int
as
select (b1.iSoCho - ISNULL(b3.veNguoiLon,0) - ISNULL(b2.veTreEm,0) )as soChoCon from 
(select a.iMaTour, a.sTieuDe, b.dThoiGian, b.imathoigian, a.iSoCho from tblTour a, tblThoiGianKhoiHanh b where a.iMaTour = b.iMaTour
and b.dThoiGian > GETDATE()  and a.iMaTour = @idtour and b.iMaThoiGian = @idtg ) b1
left join
(  select  ISNULL(sum(soluongve),0) as veNguoiLon,tblThoiGianKhoiHanh.imathoigian, tblThoiGianKhoiHanh.dThoiGian from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh
 where iMaNhomVe = 1 and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian and dThoiGian >  GETDATE()
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour and tblThoiGianKhoiHanh.iMaThoiGian = tblDonDatTour.imathoigian
and tblDonDatTour.iMaTour = @idtour and tblDonDatTour.imathoigian =  @idtg and tblDonDatTour.iMaDonDatTour in ((SELECT iMaDon
FROM   (SELECT iMaDon, iTrangThai,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour ) t
WHERE  rk = 1 and t.iTrangThai != 2 and t.iTrangThai != 3)) and tblDonDatTour.iMaDonDatTour in (select imadontour from tblGiaoDich where tblGiaoDich.trangThai = 1)
group by  tblThoiGianKhoiHanh.imathoigian , tblThoiGianKhoiHanh.dThoiGian   ) b3 on b1.iMaThoiGian = b3.imathoigian
 left join
(  select  ISNULL(sum(soluongve),0) as veTreEm,tblThoiGianKhoiHanh.imathoigian
 from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh where tblChiTietDonDatTour.iMaNhomVe = 2
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour 
and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian  and dThoiGian >  GETDATE()
and tblDonDatTour.iMaTour = @idtour and tblDonDatTour.imathoigian =  @idtg and tblDonDatTour.iMaDonDatTour in (SELECT iMaDon
FROM   (SELECT iMaDon, iTrangThai,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour ) t
WHERE  rk = 1 and t.iTrangThai != 2 and t.iTrangThai != 3
   ) 
    and tblDonDatTour.iMaDonDatTour in (select imadontour from tblGiaoDich where tblGiaoDich.trangThai = 1)
group by  tblThoiGianKhoiHanh.imathoigian    ) b2 
on b2.iMaThoiGian = b3.iMaThoiGian


alter proc sp_layDanhSachTOur
 as
select a.imatour, a.btrangthai,  a.stieude, a.sTongThoiGian, a.iSoCho, a.sNoiKhoiHanh, b4.surlanh, a.dngaytao  from 
(select tbltour.iMaTour,tbltour.bTrangThai,tbltour.sTieuDe, tbltour.sNoiKhoiHanh, tbltour.sTongThoiGian,tbltour.iSoCho, tblTour.dNgayTao
from tblTour) a
   join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour =a.iMaTour 
 order by dngaytao DESC
 
alter proc sp_timKiemTourTheoNgay
@batDau date,
@ketThuc date
as
select a.iMaTour,a.sTieuDe,d.dNgayKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,b4.sUrlAnh , b.imatour, b.iGiaVe as igianl,
 b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam , d.dNgayKhoiHanh as dThoiGian
from
(
select * from tblTour where imatour in 
( select iMaTour from tblThoiGianKhoiHanh where @batDau <= dthoigian and dthoigian <= @ketThuc)  ) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
join
 (select imatour, min(dthoigian) as dNgayKhoiHanh from tblThoiGianKhoiHanh where --iMaTour = 36 and 
 getdate() < dthoigian and trangThai = 1
 group by iMaTour) as d on d.iMaTour= a.iMaTour 
  join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour =a.iMaTour 
  
alter proc [dbo].[sp_xemTourId]
@idtour int
as
select b5.soSao, b4.surlanh,a.iMaTour,a.sTieuDe,a.sNoiKhoiHanh,a.iMaNhanVien,a.iSoCho,b.dHanGiamGia as hanGiamNL, c.dHanGiamGia as hanGiamTE,a.sMoTa,a.sTongThoiGian, a.imanhomtour,b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour where tblTour.iMaTour = @idtour) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
   join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour =a.iMaTour 
 left join
(select iMaTour, ISNULL( avg(Cast(b.isosao as Float)) , 0 ) soSao from
 (select iMaTour, iMaDonDatTour from tblDonDatTour ) a
 left join 
( select iMaDonDatTour,isosao from tblDanhGia) b
on a.imadondattour = b.iMaDonDatTour group by iMaTour ) b5
on b5.iMaTour =  a.iMaTour 


create table tbldanhGiaSao
(
imaDanhGia int identity(1,1) primary key not null,
iSoSao int,
iDonDatTour int
)

alter table tbldanhGiaSao add constraint FK_danhGiaSao_donTour foreign key (iDonDatTour) references tbldondattour(iMaDonDatTour);
create proc sp_danhGiaTour
@iMaTour int,
@soSao int
as
insert into tbldanhGiaSao (iDonDatTour, iSoSao)  values (@iMaTour, @soSao)


create table tblDanhGia(
iMaBinhLuan int identity(1,1) primary key not null,
iMaDonDatTour int not null,
dThoiGian datetime,
sNoiDung nvarchar(150),
iSoSao int
);

alter table tblDanhGia add constraint FK_DonTour_BinhLuan foreign key (iMaDonDatTour) references tbldondattour(iMaDonDatTour);

alter proc sp_xemTourId_
@idtour int
as 
select  b4.surlanh,a.iMaTour,a.sTieuDe,b.dHanGiamGia as hanGiamNL, c.dHanGiamGia as hanGiamTE,a.sNoiKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sTongThoiGian, b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour where tblTour.iMaTour = @idtour) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
   join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour =a.iMaTour 
 left join
(select iMaTour, ISNULL( avg(Cast(b.isosao as Float)) , 0 ) soSao from
 (select iMaTour, iMaDonDatTour from tblDonDatTour ) a
 left join 
( select iMaDonDatTour,isosao from tblDanhGia) b
on a.imadondattour = b.iMaDonDatTour group by iMaTour ) b5
on b5.iMaTour =  a.iMaTour 


alter proc sp_kiemTraQuyenDanhGia
@id int
as
select bang1.imadondattour, bang2.conLai, bang1.dThoiGian, bang1.dNgayDatTour from
(select iMaDonDatTour, dThoiGian,dNgayDatTour from tblDonDatTour, tblThoiGianKhoiHanh
where tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian
and tbldondattour.iMaDonDatTour in (SELECT iMaDon
FROM   (SELECT iMaDon, iTrangThai,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour ) t
WHERE  rk = 1 and t.iTrangThai = 1
   )  and tblThoiGianKhoiHanh.dThoiGian < GETDATE()-- and tbldondattour.iMaDonDatTour = @id
   ) as bang1
join
(select (b1.doanhThu-b2.tien) as conLai,b2.imadontour, b1.iMaDonDatTour, b1.iMaTour,
b1.sTenKhachHang, b1.iMaKhachHang ,b3.iTrangThai , b3.iMaNhanVien , b1.dNgayDatTour , b1.sghichu , b3.dthoigian, b1.stieude
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,
 e.stieude ,e.iMaTour,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour --and b.iMaDonDatTour = @id
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.dNgayDatTour, b.sghichu,e.stieude,
 e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu, imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1) b3
on b3.iMaDon = b2.iMaDonTour) as bang2 on bang2.imadondattour = bang1.imadondattour where bang2.conLai <= 0

   create proc laydanhgia_danhGia
@id int
as
DECLARE @tour int
set @tour = (select tblDonDatTour.iMaTour from tblDanhGia, tblDonDatTour where tblDanhGia.iMaDonDatTour = tblDonDatTour.iMaDonDatTour and
tblDanhGia.iMaDanhGia  = @id)
select a.sTenKhachHang, c.dThoiGian, c.btrangthai, c.iMaDanhGia, c.iSoSao, c.sNoiDung , b.iMaDonDatTour, a.iMaKhachHang
from tblkhachhang a,  tbldondattour b , tblDanhGia c where b.imatour = @tour and 
b.iMaDonDatTour = c.iMaDonDatTour and b.iMaKhachHang = a.iMaKhachHang


 create proc sp_layHinhAnhCuaTour
 @id int
 as
 select * from tblhinhanh where iMaTour = @id

 alter proc sp_layDanhSachTOur---bo
 as
select tbltour.iMaTour,tbltour.bTrangThai,tbltour.sTieuDe, tbltour.sNoiKhoiHanh, tbltour.sTongThoiGian,tbltour.iSoCho, tblhinhanh.sDuongDan 
from tbltour,tblhinhanh where tblTour.iMaTour = tblhinhanh.iMaTour  order by dngaytao DESC
k
create proc updatehinhanh
@id int,
@duongDan varchar(100)
as
update tblhinhanh
set sDuongDan = @duongdan where iMaHinhAnh = @id

create proc sp_ThongKeTaiKhoan
as
select a.soTaiKhoanNV, b.soNV, c.soAdmin, d.sokh from
(select count(iMaNhanVien) soTaiKhoanNV, 1 as stt from tblNhanVien where iMaQuyen != 3) a
left join
(select count(iMaNhanVien) as soNV ,1 as stt from tblNhanVien where iMaQuyen = 1) b
on a.stt = b.stt
left join
(select count(iMaNhanVien) as soAdmin ,1 as stt  from tblNhanVien where iMaQuyen = 2) c on c.stt = b.stt
left join
(select count(iMaKhachHang) as soKH ,1 as stt from tblKhachHang ) d on d.stt = b.stt4



 create proc kiemTraTenDangNhap
 @ten nvarchar(30)
 as
  select * from tblNhanVien where sUserName = @ten


create proc sp_layTourLienQuan
@id int
as
DECLARE @idNhomTour int
set @idNhomTour = (SELECT iMaNhomTour from tbltour where iMaTour = @id)
select top 5 b5.soSao,a.iMaTour,a.sTieuDe,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,b3.sUrlAnh , b.imatour, b.iGiaVe as igianl,
 b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam , d.dThoiGian
from
(
select * from tblTour where tblTour.iMaNhomTour = @idNhomTour) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
join
 (select imatour, min(dthoigian) as dthoigian from tblThoiGianKhoiHanh where --iMaTour = 36 and 
 getdate() < dthoigian and trangThai = 1
 group by iMaTour) as d on d.iMaTour= a.iMaTour 
  join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b3 on b3.imatour =a.iMaTour 
 left join
(select iMaTour, ISNULL( avg(Cast(b.isosao as Float)) , 0 ) soSao from
 (select iMaTour, iMaDonDatTour from tblDonDatTour ) a
 left join 
( select iMaDonDatTour,isosao from tblDanhGia) b
on a.imadondattour = b.iMaDonDatTour group by iMaTour ) b5
on b5.iMaTour =  a.iMaTour 

create proc kiemTraNgayKhoiHanh
 @id int,
 @ngay date
 as
 select  * from tblThoiGianKhoiHanh where iMaTour = @id and dThoiGian = @ngay

alter proc layTenNhomTour
@id int
as
select sTenNhomTour from tblNhomTour where imanhomtour = @id
 


alter proc sp_dsnhomtourbyid
@id int
as
select top 6 ISNULL(b5.soSao,0) as soSao,a.iMaTour,a.sTieuDe,d.dngaykhoihanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,b3.sUrlAnh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour where tblTour.iMaNhomTour = @id) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
  join
 (select imatour, min(dthoigian) as dngaykhoihanh from tblThoiGianKhoiHanh where --iMaTour = 36 and 
 getdate() < dthoigian and trangThai = 1
 group by iMaTour) as d on d.iMaTour= a.iMaTour 
 join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b3 on b3.imatour =a.iMaTour 
left join
(select iMaTour, ISNULL( avg(Cast(b.isosao as Float)) , 0 ) soSao from
 (select iMaTour, iMaDonDatTour from tblDonDatTour ) a
 left join 
( select iMaDonDatTour,isosao from tblDanhGia) b
on a.imadondattour = b.iMaDonDatTour group by iMaTour ) b5
on b5.iMaTour =  a.iMaTour 


alter proc sp_kiemTraQuyenDanhGia===
@id int
as
select bang1.imadondattour, bang2.conLai, bang1.dThoiGian, bang1.dNgayDatTour from
(select iMaDonDatTour, dThoiGian,dNgayDatTour from tblDonDatTour, tblThoiGianKhoiHanh
where tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian
and tbldondattour.iMaDonDatTour in (SELECT iMaDon
FROM   (SELECT iMaDon, iTrangThai,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour ) t
WHERE  rk = 1 and t.iTrangThai = 1
   )  and tblThoiGianKhoiHanh.dThoiGian < GETDATE()-- and tbldondattour.iMaDonDatTour = @id
   ) as bang1
join
(select (b1.doanhThu-b2.tien) as conLai,b2.imadontour, b1.iMaDonDatTour, b1.iMaTour,
b1.sTenKhachHang, b1.iMaKhachHang ,b3.iTrangThai , b3.iMaNhanVien , b1.dNgayDatTour , b1.sghichu , b3.dthoigian, b1.stieude
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,
 e.stieude ,e.iMaTour,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour --and b.iMaDonDatTour = @id
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.dNgayDatTour, b.sghichu,e.stieude,
 e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu, imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1) b3
on b3.iMaDon = b2.iMaDonTour) as bang2 on bang2.imadondattour = bang1.imadondattour where bang2.conLai <= 0



alter proc layThongTinTour_gopTour
@id int
as
select b1.iMaTour, b1.sTieuDe, b1.dThoiGian, b1.iSoCho, isnull(b3.veNguoiLon,0) as veNguoiLon, isnull(b2.veTreEm ,0) as veTreEm,b1.iMaThoiGian, ( b1.iSoCho - isnull(b2.veTreEm,0) -isnull(b3.veNguoiLon,0) ) as veConLai, b3.iMaDonDatTour from 
(select a.iMaTour, a.sTieuDe, b.dThoiGian, b.imathoigian, a.iSoCho from tblTour a, tblThoiGianKhoiHanh b where a.iMaTour = b.iMaTour) b1
left join
(select isnull(sum(soluongve), 0 ) as veNguoiLon,tblThoiGianKhoiHanh.imathoigian, tblDonDatTour.iMaDonDatTour from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh
 where iMaNhomVe = 1 and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian -- and tblThoiGianKhoiHanh.iMaThoiGian = @id
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour and tblThoiGianKhoiHanh.iMaThoiGian = tblDonDatTour.imathoigian
group by  tblThoiGianKhoiHanh.imathoigian, tblDonDatTour.iMaDonDatTour) b3 on b1.iMaThoiGian = b3.imathoigian
left join
(select  isnull(sum(soluongve), 0) as veTreEm,tblThoiGianKhoiHanh.imathoigian
 from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh where tblChiTietDonDatTour.iMaNhomVe = 2
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour 
and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian group by  tblThoiGianKhoiHanh.imathoigian) b2 
on b2.iMaThoiGian = b3.iMaThoiGian

create proc layngaydi_
@id int
as
DECLARE @idtour int
set @idtour = (SELECT iMaTour from tblThoiGianKhoiHanh where iMaThoiGian = @id)
select iMaThoiGian, dThoiGian from tblThoiGianKhoiHanh where iMaTour = @idtour and iMaThoiGian != @id



alter proc kiemTraHoanTien
@id int
as
select (b1.doanhThu-b2.tien) as conLai,b1.doanhthu ,b2.tien, b1.dThoiGian,b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, b1.iMaTour,b3.sGhiChu,
b1.sTenKhachHang, b1.iMaKhachHang , b3.itrangthai, b3.iMaNhanVien , b1.dNgayDatTour , b1.sghichu , b1.stieude
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,
e.stieude ,e.iMaTour,g.dThoiGian,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e , tblThoiGianKhoiHanh g--, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour and b.imathoigian = g.iMaThoiGian
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour
and  (SELECT DATEADD(DAY, 7, getdate())) <  g.dThoiGian and b.iMaDonDatTour = @id
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,e.stieude,g.dThoiGian,
 e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour 
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian,imatrangthai, sghichu, imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour where iTrangThai = 2) t
WHERE  rk = 1) b3 on b3.iMaDon = b2.iMaDonTour
order by b1.dNgayDatTour DESC

bát chánh đạo, phẩm trở đạo


alter proc kiemTraChoConCuaMaThoiGian
@id int
as
select b1.iMaTour, b1.sTieuDe, b1.dThoiGian, b1.iSoCho,isnull(b3.veNguoiLon, 0 ) as veNguoiLon,isnull(b2.veTreEm, 0 ) as veTreEm,b1.iMaThoiGian, ( b1.iSoCho - isnull(b2.veTreEm , 0 )-isnull(b3.veNguoiLon, 0 ) ) as veConLai from 
(select a.iMaTour, a.sTieuDe, b.dThoiGian, b.imathoigian, a.iSoCho from tblTour a, tblThoiGianKhoiHanh b where a.iMaTour = b.iMaTour) b1
left join
(select sum(soluongve) as veNguoiLon,tblThoiGianKhoiHanh.imathoigian from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh
 where iMaNhomVe = 1 and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian  and tblThoiGianKhoiHanh.iMaThoiGian = @id
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour and tblThoiGianKhoiHanh.iMaThoiGian = tblDonDatTour.imathoigian
group by  tblThoiGianKhoiHanh.imathoigian) b3 on b1.iMaThoiGian = b3.imathoigian
left join
(select sum(soluongve) as veTreEm,tblThoiGianKhoiHanh.imathoigian
 from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh where tblChiTietDonDatTour.iMaNhomVe = 2
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour 
and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian group by  tblThoiGianKhoiHanh.imathoigian) b2 
on b2.iMaThoiGian = b3.iMaThoiGian

create proc laySoVeTheoDon
@id int 
as
select a.soluongve as nl, a.imadondattour as madon, b.soluongve as te from
(select iMaDonDatTour, soLuongVe from tblChiTietDonDatTour where iMaDonDatTour = @id and iMaNhomVe = 1) a
join
(select iMaDonDatTour, soLuongVe from tblChiTietDonDatTour where iMaDonDatTour = @id and iMaNhomVe = 1) b
on a.imadondattour = b.imadondattour

create proc capnhatdondattour
@id int,
@nl int, 
@te int
as
update tblChiTietDonDatTour set soLuongVe = soLuongVe - @nl where iMaDonDatTour = @id and iMaNhomVe = 1
update tblChiTietDonDatTour set soLuongVe = soLuongVe - @te where iMaDonDatTour = @id and iMaNhomVe = 2


create proc layNgayChuyen
@id int 
as
select a.iMaThoiGian, a.dThoiGian, a.iMaTour, b.conlai from
(select * from tblThoiGianKhoiHanh where trangThai = 1 and dthoigian > getdate() and iMaTour = @id) a
join
(select b1.iMaTour, b1.sTieuDe, b1.dThoiGian, (b1.iSoCho -  ISNULL(b3.veNguoiLon,0) - ISNULL(b2.veTreEm,0)) as conlai ,b1.iMaThoiGian from 
(select a.iMaTour, a.sTieuDe, b.dThoiGian, b.imathoigian, a.iSoCho from tblTour a, tblThoiGianKhoiHanh b where a.iMaTour = b.iMaTour
and b.dThoiGian > GETDATE() ) b1
left join
(  select  ISNULL(sum(soluongve),0) as veNguoiLon,tblThoiGianKhoiHanh.imathoigian, tblThoiGianKhoiHanh.dThoiGian from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh
 where iMaNhomVe = 1 and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian 
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour and tblThoiGianKhoiHanh.iMaThoiGian = tblDonDatTour.imathoigian
and tblThoiGianKhoiHanh.dThoiGian > GETDATE() 
group by  tblThoiGianKhoiHanh.imathoigian , tblThoiGianKhoiHanh.dThoiGian   ) b3 on b1.iMaThoiGian = b3.imathoigian
left join
(  select  ISNULL(sum(soluongve),0) as veTreEm,tblThoiGianKhoiHanh.imathoigian
 from tblChiTietDonDatTour, tblDonDatTour,tblThoiGianKhoiHanh where tblChiTietDonDatTour.iMaNhomVe = 2
and tblChiTietDonDatTour.iMaDonDatTour = tblDonDatTour.iMaDonDatTour 
and tblDonDatTour.imathoigian = tblThoiGianKhoiHanh.iMaThoiGian and tblThoiGianKhoiHanh.dThoiGian > GETDATE() 
group by  tblThoiGianKhoiHanh.imathoigian    ) b2 
on b2.iMaThoiGian = b3.iMaThoiGian) b on a.imathoigian = b.imathoigian order by a.dthoigian ASC 


