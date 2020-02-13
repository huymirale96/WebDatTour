9704198526191432198

https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Amount=1000000&vnp_BankCode=NCB&vnp_Command=pay&vnp_CreateDate=20200213155604&vnp_CurrCode=VND&vnp_IpAddr=%3a%3a1&vnp_Locale=vn&vnp_OrderInfo=Noi+dung+thanh+toan%3a20200213155555&vnp_OrderType=topup&vnp_ReturnUrl=http%3a%2f%2flocalhost%3a49490%2fView%2fBackEnd%2fvnpay_ipn.aspx&vnp_TmnCode=MJ9PCY3L&vnp_TxnRef=637172061641955212&vnp_Version=2.0.0&vnp_SecureHash=4a417c2ff6c35a38859595eb810f32108479d3ec61ff84c542666f663ea4857f



create database webDatTour;
use webDatTour;

-- Tạo các bảng

create table tblQuyen(
	iMaQuyen int identity(1,1) primary key not null,
	sTenQuyen nvarchar(100) not null,
);

create table tblNhanVien(
	iMaNhanVien int identity(1,1) primary key not null,
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

alter table tbltour alter column smota nvarchar(4000) not null;

alter table tblTour add constraint FK_Tour_nhomTour foreign key (iMaNhomTour) references tblNhomTour(iMaNhomTour);
alter table tblTour add constraint FK_Tour_NhanVien foreign key (iMaNhanVien) references tblNhanVien(iMaNhanVien);


alter table tblnhomvegia add constraint FK_nhomve_gia foreign key (iMaNhomVe) references tblNhomVe(iMaNhomVe);

alter table tblchitietdondattour add constraint FK_nhomve_hoadonct foreign key (iMaNhomVe) references tblnhomve(iMaNhomVe);

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
@urlanh varchar(300),
@thoigian nvarchar(20),
@ngaykhoihanh date,
@nhomtour int,
@socho int,
@manv int,
@ngaytao date,
@imatour int out
as
insert into tblTour (iMaNhanVien,sTieuDe,sMoTa,sUrlAnh,sTongThoiGian,dNgayKhoiHanh,iMaNhomTour,iSoCho,dNgayTao)
OUTPUT INSERTED.iMaTour as id
values (@manv,@tieude,@mota,@urlanh,@thoigian,@ngaykhoihanh,@nhomtour,@socho,@ngaytao) set @imatour = SCOPE_IDENTITY()
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
@giate int,
@giagiamte int
as
insert into tblNhomVeGia(iMaTour,iMaNhomVe,iGiaVe,iGiaVeGiam) 
values (@matour,1,@gianl,@giagiamnl),(@matour,2,@giate,@giagiamte);

alter proc sp_xemTourId
@idtour int
as
select a.iMaTour,a.sTieuDe,a.dNgayKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,a.sUrlAnh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour where tblTour.iMaTour = @idtour) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour

alter proc sp_updatetourID
@tieude nvarchar(250),
@mota nvarchar(900),
@urlanh varchar(300),
@thoigian nvarchar(20),
@ngaykhoihanh date,
@nhomtour int,
@socho int,
@imatour int
as
update tblTour set stieude = @tieude, sMoTa = @mota, sTongThoiGian = @thoigian, sUrlAnh = @urlanh, iSoCho = @socho,dNgayKhoiHanh = @ngaykhoihanh, iMaNhomTour = @nhomtour
where iMaTour = @imatour

create proc sp_updateGiaVe
@matour int,
@gianl int,
@giagiamnl int,
@giate int,
@giagiamte int
as
update tblNhomVeGia set iGiaVe = @gianl, igiavegiam = @giagiamnl where imatour = @matour and  iMaNhomVe = 1
update tblNhomVeGia set iGiaVe = @giate, igiavegiam = @giagiamte where imatour = @matour and  iMaNhomVe = 2


create proc sp_xoaNhanVien
@id int 
as delete from tblnhanvien where imanhanvien = @id

create proc sp_xoaTour
@id int 
as delete from tblTour where imatour = @id

create proc sp_xoaKhachHang
@id int 
as delete from tblKhachHang where imakhachhang = @id


create proc sp_dstour1
as
select a.iMaTour,a.sTieuDe,a.dNgayKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,a.sUrlAnh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour


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


create proc binhLuan
@idtour int,
@idkhachhang int,
@thoigian date,
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

create proc sp_tourTheoNhom
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
  @thoigian date,
  @tien int,
  @trangThai int,
  @iMaGiaoDich int out
  as
  insert into tblGiaoDich (iMaDonTour, thoigian, tien , trangThai)
   OUTPUT INSERTED.iMaGiaoDich as id
   values (@iMaDonTOur, @thoigian, @tien, @trangThai) 
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