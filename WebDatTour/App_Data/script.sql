USE [webDatTour]
GO
/****** Object:  StoredProcedure [dbo].[binhLuan]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[binhLuan]
@idtour int,
@idkhachhang int,
@thoigian datetime,
@noidung nvarchar(300)
as
insert into tblBinhLuan(iMaKhachHang, iMaTour, dThoiGian, sNoiDung) values
(@idkhachhang, @idtour, @thoigian, @noidung)
GO
/****** Object:  StoredProcedure [dbo].[capNhapKhachHang]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[capNhapKhachHang]
@id int,
@ten nvarchar(100),
@ngay datetime,
@dicchi nvarchar(100),
@sdt varchar(13),
@mail varchar(25)
as
update tblKhachHang set sTenKhachHang = @ten, dNgaySinh = @ngay, sDiaChi = @dicchi, sSDT = @sdt, sEmail = @mail
where iMaKhachHang = @id
GO
/****** Object:  StoredProcedure [dbo].[capNhatTrangThaiBinhLuan]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[capNhatTrangThaiBinhLuan]
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
GO
/****** Object:  StoredProcedure [dbo].[capNhatTrangThaiDanhGia]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[capNhatTrangThaiDanhGia]
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

GO
/****** Object:  StoredProcedure [dbo].[capNhatTrangThaiTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[capNhatTrangThaiTour]
@id int,
@tt int,
@manv int,
@ngay datetime
as
update tblDonDatTour set itrangthai = @tt, imanvduyet = @manv, dThoiGianDuyet = @ngay where iMaDonDatTour = @id

GO
/****** Object:  StoredProcedure [dbo].[danhgia]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[danhgia]
@iddontour int,
@isosao int,
@thoigian datetime,
@noidung nvarchar(300)
as
insert into tbldanhgia(iMaDonDatTour, iSoSao, dThoiGian, sNoiDung, btrangthai) values
(@iddontour, @isosao, @thoigian, @noidung, 1)
GO
/****** Object:  StoredProcedure [dbo].[donDatTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[donDatTour]

as
select (b1.doanhThu-b2.tien) as conLai,b1.doanhthu , b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, b1.iMaTour,
b1.sTenKhachHang, b1.iMaKhachHang , b1.itrangthai , b1.imanvduyet , b1.dNgayDatTour , b1.sghichu , b1.dThoiGianDuyet, b1.stieude, b1.itrangthai
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.itrangthai,b.imanvduyet,b.dNgayDatTour, b.sghichu,
b.dThoiGianDuyet, e.stieude ,e.iMaTour,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.itrangthai,b.imanvduyet,b.dNgayDatTour, b.sghichu,e.stieude,
b.dThoiGianDuyet,b.itrangthai, e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour order by b1.dNgayDatTour DESC
GO
/****** Object:  StoredProcedure [dbo].[donDatTour_]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[donDatTour_]

as
select (b1.doanhThu-b2.tien) as conLai,b1.doanhthu , b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, b1.iMaTour,b3.sGhiChu,b3.dthoigian,
b1.sTenKhachHang, b1.iMaKhachHang , b3.itrangthai, b3.iMaNhanVien , b1.dNgayDatTour , b1.sghichu , b1.stieude
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,
e.stieude ,e.iMaTour,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
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
GO
/****** Object:  StoredProcedure [dbo].[khachHangHuyTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[khachHangHuyTour]
@id int
as
update tblDonDatTour set itrangthai = 2 where iMaDonDatTour = @id
GO
/****** Object:  StoredProcedure [dbo].[kiemTraNgayKhoiHanh]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[kiemTraNgayKhoiHanh]
 @id int,
 @ngay date
 as
 select  * from tblThoiGianKhoiHanh where iMaTour = @id and dThoiGian = @ngay
GO
/****** Object:  StoredProcedure [dbo].[kiemTraQuyenBinhLuan]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[kiemTraQuyenBinhLuan]
@makh int,
@idtour int
as
select a.iMaTour from tblDonDatTour a ,tblThoiGianKhoiHanh b where a.iMaTour = @idtour
and a.iMaKhachHang = @makh and a.imathoigian = b.iMaThoiGian and b.dThoiGian < GETDATE()
and a.iMaDonDatTour in (SELECT iMaDon
FROM   (SELECT iMaDon, iTrangThai, dthoigian,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour where itrangthai = 1) t
WHERE  rk = 1)
GO
/****** Object:  StoredProcedure [dbo].[kiemTraTenDangNhap]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[kiemTraTenDangNhap]
 @ten nvarchar(30)
 as
  select * from tblNhanVien where sUserName = @ten

GO
/****** Object:  StoredProcedure [dbo].[layBinhLuan]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[layBinhLuan]
@id int
as
select top 6 * from tblkhachhang, tblbinhluan where tblbinhluan.imatour = @id
and tblkhachhang.imakhachhang = tblbinhluan.imakhachhang order by tblBinhLuan.dThoiGian DESC
GO
/****** Object:  StoredProcedure [dbo].[laydanhgia]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[laydanhgia]
@id int
as
select a.sTenKhachHang, c.dThoiGian, c.btrangthai, c.iMaDanhGia, c.iSoSao, c.sNoiDung , b.iMaDonDatTour, a.iMaKhachHang
from tblkhachhang a,  tbldondattour b , tblDanhGia c where b.imatour = @id and 
b.iMaDonDatTour = c.iMaDonDatTour and b.iMaKhachHang = a.iMaKhachHang

GO
/****** Object:  StoredProcedure [dbo].[laydanhgia_danhGia]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[laydanhgia_danhGia]
@id int
as
DECLARE @tour int
set @tour = (select tblDonDatTour.iMaTour from tblDanhGia, tblDonDatTour where tblDanhGia.iMaDonDatTour = tblDonDatTour.iMaDonDatTour and
tblDanhGia.iMaDanhGia  = @id)
select a.sTenKhachHang, c.dThoiGian, c.btrangthai, c.iMaDanhGia, c.iSoSao, c.sNoiDung , b.iMaDonDatTour, a.iMaKhachHang
from tblkhachhang a,  tbldondattour b , tblDanhGia c where b.imatour = @tour and 
b.iMaDonDatTour = c.iMaDonDatTour and b.iMaKhachHang = a.iMaKhachHang
GO
/****** Object:  StoredProcedure [dbo].[layDanhSachDonDatTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[layDanhSachDonDatTour]
as
select * from tbldondattour a, tbltour b, tblkhachhang c where
 a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1) 
 and a.iMaTour = b.iMaTour and a.iMaKhachHang = c.iMaKhachHang
GO
/****** Object:  StoredProcedure [dbo].[layDanhSachDonDatTourByIDkh]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[layDanhSachDonDatTourByIDkh]
@id int
as
 select b3.itrangthai,b1.doanhthu , b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, 
b1.sTenKhachHang, b1.iMaKhachHang ,  b1.dNgayDatTour , b1.sghichu , b1.stieude, b1.iMaTour
from
(select  b.iMaTour,b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.dNgayDatTour, b.sghichu,
 e.stieude ,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
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
 
GO
/****** Object:  StoredProcedure [dbo].[nhanVienthanhToan]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[nhanVienthanhToan]
@tien int,
@thoigian datetime,
@madon int,
@trangThai int,
@manv int
as
insert into tblGiaoDich (tien, thoigian, iMaDonTour, trangThai, imaNhanVien) values
(@tien, @thoigian, @madon, @trangThai, @manv)
GO
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHang]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_capNhatTrangThaiDonHang] 
@madon int,
@thoigian datetime,
@ghichu nvarchar(100),
@trangThai int,
@manv int
as
insert into tblTrangThaiDonDatTour (iMaDon,dthoigian,iTrangThai,sghichu,imanhanvien) values
(@madon, @thoigian, @trangThai,@ghichu,@manv)
GO
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHangKH]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_capNhatTrangThaiDonHangKH]
@madon int,
@thoigian datetime,
@ghichu nvarchar(100)
as
insert into tblTrangThaiDonDatTour (iMaDon,dthoigian,iTrangThai,sghichu) values
(@madon, @thoigian, 2,@ghichu)
GO
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHangNV]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_capNhatTrangThaiDonHangNV] 
@madon int,
@thoigian datetime,
@ghichu nvarchar(100),
@trangThai int,
@manv int
as
insert into tblTrangThaiDonDatTour (iMaDon,dthoigian,iTrangThai,sghichu,iMaNhanVien) values
(@madon, @thoigian, @trangThai,@ghichu,@manv)
GO
/****** Object:  StoredProcedure [dbo].[sp_dangki]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_dangki]
@tenkh nvarchar(170),
@ns date,
@diachi nvarchar(100),
@sdt varchar(13),
@email varchar(25),
@user nvarchar(30),
@pw varchar(150)
as
insert into tblKhachHang (sTenKhachHang, dngaysinh,sDiaChi,sSDT,sEmail,sUserName,sPassWord)
values (@tenkh,@ns,@diachi,@sdt,@email,@user,@pw);
GO
/****** Object:  StoredProcedure [dbo].[sp_danhGiaTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_danhGiaTour]
@iMaTour int,
@soSao int
as
insert into tbldanhGiaSao (iDonDatTour, iSoSao)  values (@iMaTour, @soSao)

GO
/****** Object:  StoredProcedure [dbo].[sp_danhSachNhanVien]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_danhSachNhanVien]
as
select * from tblNhanVien;
GO
/****** Object:  StoredProcedure [dbo].[sp_danhSachTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_danhSachTour]
as
select * from tblTour;
GO
/****** Object:  StoredProcedure [dbo].[sp_doiMatKhauKH]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[sp_doiMatKhauKH]
   @id int,
   @pw varchar(150)
   as
   update tblkhachhang set spassword = @pw where imakhachhang = @id
GO
/****** Object:  StoredProcedure [dbo].[sp_dsnhomtourbyid]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_dsnhomtourbyid]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_dsThoiGianKhoiHanh]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_dsThoiGianKhoiHanh]
@id int
as
select * from tblThoiGianKhoiHanh where iMaTour = @id order by dThoiGian DESC
GO
/****** Object:  StoredProcedure [dbo].[sp_dstour1]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_dstour1]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_dstournhom1]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_dstournhom1]
as
select top 6 a.iMaTour,a.sTieuDe,a.dNgayKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,a.sUrlAnh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
GO
/****** Object:  StoredProcedure [dbo].[sp_kiemTraQuyenDanhGia]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_kiemTraQuyenDanhGia]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_layChoChoCon]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_layChoChoCon]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_layDanhSachTOur]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_layDanhSachTOur]
 as
select a.imatour, a.btrangthai,  a.stieude, a.sTongThoiGian, a.iSoCho, a.sNoiKhoiHanh, b4.surlanh as sduongdan, a.dngaytao  from 
(select tbltour.iMaTour,tbltour.bTrangThai,tbltour.sTieuDe, tbltour.sNoiKhoiHanh, tbltour.sTongThoiGian,tbltour.iSoCho, tblTour.dNgayTao
from tblTour) a
   join
 (SELECT iMaHinhAnh, imatour,sDuongDan as surlanh
FROM   (SELECT  iMaHinhAnh, imatour, sDuongDan,
               RANK() OVER (PARTITION BY imatour ORDER BY iMaHinhAnh asc) AS rk
        FROM   tblhinhanh) t
WHERE  rk = 1 ) b4 on b4.imatour =a.iMaTour 
 order by dngaytao DESC
GO
/****** Object:  StoredProcedure [dbo].[sp_layHinhAnhCuaTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[sp_layHinhAnhCuaTour]
 @id int
 as
 select * from tblhinhanh where iMaTour = @id
GO
/****** Object:  StoredProcedure [dbo].[sp_layTourLienQuan]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_layTourLienQuan]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_login_kh]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_login_kh]
@user nvarchar(30),
@pw varchar(150)
as
select * from tblKhachHang where sUserName = @user
and sPassWord = @pw;
GO
/****** Object:  StoredProcedure [dbo].[sp_login_kh_id]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_login_kh_id]
   @id int,
@pw varchar(150)
as
select * from tblKhachHang where
iMaKhachHang = @id and sPassWord = @pw;
GO
/****** Object:  StoredProcedure [dbo].[sp_login_nv]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_login_nv]
   @user nvarchar(30),
@pw varchar(150)
as
select * from tblNhanVien where
susername = @user and sPassWord = @pw;
GO
/****** Object:  StoredProcedure [dbo].[sp_soCho_Tour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_soCho_Tour]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_themGiave]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_themGiave]
@matour int,
@gianl int,
@giagiamnl int,
@giate int,
@giagiamte int
as
insert into tblNhomVeGia(iMaTour,iMaNhomVe,iGiaVe,iGiaVeGiam) 
values (@matour,1,@gianl,@giagiamnl),(@matour,2,@giate,@giagiamte);
GO
/****** Object:  StoredProcedure [dbo].[sp_themThoiGianKhoiHanh]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_themThoiGianKhoiHanh]
@imatour int,
@ngay date
as
insert into tblThoiGianKhoiHanh (iMaTour, dThoiGian) values (@imatour, @ngay)
GO
/****** Object:  StoredProcedure [dbo].[sp_themtour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_themtour]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_thongkedoanhsotheotatcatour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_thongkedoanhsotheotatcatour]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_thongkedoanhsotheotour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_thongkedoanhsotheotour]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_ThongKeTaiKhoan]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_ThongKeTaiKhoan]
as
select a.soTaiKhoanNV, b.soNV, c.soAdmin, d.sokh from
(select count(iMaNhanVien) soTaiKhoanNV, 1 as stt from tblNhanVien where iMaQuyen != 3) a
left join
(select count(iMaNhanVien) as soNV ,1 as stt from tblNhanVien where iMaQuyen = 1) b
on a.stt = b.stt
left join
(select count(iMaNhanVien) as soAdmin ,1 as stt  from tblNhanVien where iMaQuyen = 2) c on c.stt = b.stt
left join
(select count(iMaKhachHang) as soKH ,1 as stt from tblKhachHang ) d on d.stt = b.stt
 
GO
/****** Object:  StoredProcedure [dbo].[sp_timKiemTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE proc [dbo].[sp_timKiemTour]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_timKiemTour_ds]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_timKiemTour_ds]
@ten nvarchar(50)
 as
select tbltour.iMaTour,tbltour.bTrangThai,tbltour.sTieuDe, tbltour.sNoiKhoiHanh, tbltour.sTongThoiGian,tbltour.iSoCho, tblhinhanh.sDuongDan 
from tbltour,tblhinhanh where tblTour.iMaTour = tblhinhanh.iMaTour and tblTour.sTieuDe like '%'+@ten+'%'  order by dngaytao DESC
GO
/****** Object:  StoredProcedure [dbo].[sp_timKiemTourTheoNgay]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_timKiemTourTheoNgay]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_timsoCho_Tour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_timsoCho_Tour]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_tourTheoNhom]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_tourTheoNhom]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_trangThaiThoiGianKH]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_trangThaiThoiGianKH]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_trangThaiTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[sp_trangThaiTour]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_update]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_update]
as
update tbltour set isocho = 9 where imatour = 1
update tbltour set isocho = 3 where imatour = 3
GO
/****** Object:  StoredProcedure [dbo].[sp_updateGiaVe]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_updateGiaVe]
@matour int,
@gianl int,
@giagiamnl int,
@giate int,
@giagiamte int
as
update tblNhomVeGia set iGiaVe = @gianl, igiavegiam = @giagiamnl where imatour = @matour and  iMaNhomVe = 1
update tblNhomVeGia set iGiaVe = @giate, igiavegiam = @giagiamte where imatour = @matour and  iMaNhomVe = 2
GO
/****** Object:  StoredProcedure [dbo].[sp_updatetourID]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE proc [dbo].[sp_updatetourID]
@tieude nvarchar(250),
@mota nvarchar(900),
@thoigian nvarchar(20),
@noikhoihanh nvarchar(60),
@nhomtour int,
@socho int,
@imatour int
as
update tblTour set stieude = @tieude, sMoTa = @mota, sTongThoiGian = @thoigian,iSoCho = @socho, iMaNhomTour = @nhomtour, snoikhoihanh = @noikhoihanh
where iMaTour = @imatour
GO
/****** Object:  StoredProcedure [dbo].[sp_xemTourId]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_xemTourId]
@idtour int
as
select b5.soSao, b4.surlanh,a.iMaTour,a.sTieuDe,a.sNoiKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian, a.imanhomtour,b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaKhachHang]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaKhachHang]
@id int 
as delete from tblKhachHang where imakhachhang = @id
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaNhanVien]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaNhanVien]
@id int 
as delete from tblnhanvien where imanhanvien =   @id
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaTour]
@id int 
as delete from tblTour where imatour = @id
GO
/****** Object:  StoredProcedure [dbo].[suaBinhLuan]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[suaBinhLuan]
 @id int,
 @nd nvarchar(100)
 as
 update tblBinhLuan set sNoiDung = @nd where iMaBinhLuan = @id
GO
/****** Object:  StoredProcedure [dbo].[suaDanhGia]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[suaDanhGia]
 @id int,
 @nd nvarchar(300),
 @sosao int
 as
 update tblDanhGia set sNoiDung = @nd , isoSao = @sosao where imadanhgia = @id
GO
/****** Object:  StoredProcedure [dbo].[taoChiTietDonHang]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[taoChiTietDonHang]
   @madon int,
   @nl int, 
   @te int
   as
   insert into tblChiTietDonDatTour (iMaDonDatTour,imanhomve, soLuongVe) values(@madon,1,@nl),(@madon,2,@te)
GO
/****** Object:  StoredProcedure [dbo].[taoDonHang]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

   CREATE proc [dbo].[taoDonHang]
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
GO
/****** Object:  StoredProcedure [dbo].[tesst]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[tesst]
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
GO
/****** Object:  StoredProcedure [dbo].[themGiaoDich]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[themGiaoDich]
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
   
GO
/****** Object:  StoredProcedure [dbo].[themNhanVien]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[themNhanVien]
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
values (@tenNV ,@tenDN,@mk,@sdt,@quequan,@ngaysinh,@gt,@quyen);
GO
/****** Object:  StoredProcedure [dbo].[themNhanVien1]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[themNhanVien1]
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
GO
/****** Object:  StoredProcedure [dbo].[themThoiGianKhoiHanh]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[themThoiGianKhoiHanh]
 @imatour int,
 @thoigian date
 as
 insert into tblThoiGianKhoiHanh(iMaTour,dThoiGian) 
 values (@imatour, @thoigian)

GO
/****** Object:  StoredProcedure [dbo].[thongKeDoanhThuTheoNgay]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[thongKeDoanhThuTheoNgay]
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
GO
/****** Object:  StoredProcedure [dbo].[thongKeDoanhThuTheoNgay_danhSach]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[thongKeDoanhThuTheoNgay_danhSach]
@batdau datetime,
@ketthuc datetime
as
 select b1.ngay,ISNULL(sum(b1.doanhthu),0) as doanhthu  ,ISNULL(sum(b2.tien),0) as thucthu--, count(b1.iMaDonDatTour) as soDon
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
GO
/****** Object:  StoredProcedure [dbo].[timDonDatTour_]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[timDonDatTour_]
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
GO
/****** Object:  StoredProcedure [dbo].[timDonDatTourKH]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[timDonDatTourKH]
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
GO
/****** Object:  StoredProcedure [dbo].[tourhot]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[tourhot]--7ngay
as
DECLARE @ngay date
set @ngay = (SELECT DATEADD(DAY, -7, getdate()))
select * from
(select top 8 SUM(b.soLuongVe) as soLuong, c.sTieuDe , c.iMaTour ,c.sTongThoiGian, c.sUrlAnh, c.sNoiKhoiHanh
from tbldondattour a, tblChiTietDonDatTour b , tblTour c
where a.iMaDonDatTour = b.iMaDonDatTour and a.imatour = c.iMaTour and a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1)
and a.iMaDonDatTour not in (select iMaDon from tblTrangThaiDonDatTour where iMaTrangThai = 3 or iMaTrangThai = 2)
and c.bTrangThai = 1 --and a.dNgayDatTour >= @ngay
group by c.sTieuDe, c.iMaTour ,c.sTongThoiGian, c.sUrlAnh, c.sNoiKhoiHanh
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
GO
/****** Object:  StoredProcedure [dbo].[tourhotThang]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[tourhotThang]
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
GO
/****** Object:  StoredProcedure [dbo].[tourhotTuan]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[tourhotTuan]
as
DECLARE @ngay date
set @ngay = (SELECT DATEADD(DAY, -7, getdate()))
select top 8 a1.sTongThoiGian,a2.thoiGianDI, a1.iMaTour, a1.sTieuDe,a1.sNoiKhoiHanh,b4.sUrlAnh, b.iGiaVe as igianl,
 b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam, b5.sosao
 from
(select top 8 SUM(b.soLuongVe) as soLuong, c.sTieuDe , c.iMaTour ,c.sTongThoiGian, c.sNoiKhoiHanh
from tbldondattour a, tblChiTietDonDatTour b , tblTour c
where a.iMaDonDatTour = b.iMaDonDatTour and a.imatour = c.iMaTour and a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1)
and a.iMaDonDatTour not in (select iMaDon from tblTrangThaiDonDatTour where iMaTrangThai = 3 or iMaTrangThai = 2)
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

GO
/****** Object:  StoredProcedure [dbo].[toutMoiNhat]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[toutMoiNhat] 
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
GO
/****** Object:  StoredProcedure [dbo].[updatehinhanh]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[updatehinhanh]
@id int,
@duongDan varchar(100)
as
update tblhinhanh
set sDuongDan = @duongdan where iMaHinhAnh = @id
GO
/****** Object:  StoredProcedure [dbo].[updateNhanVien]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[updateNhanVien]
 @ten nvarchar(50),
 @gt bit,
 @ns date,
 @dc nvarchar(50),
 @dt varchar(16),
 @id int
 as
 update tblNhanVien set sTenNhanVien = @ten, bGioiTinh = @gt, dNgaySinh =  @ns, sDiaChi = @dc, ssdt= @dt
 where iMaNhanVien = @id 
GO
/****** Object:  StoredProcedure [dbo].[updateTrangThaiGiaoDich]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[updateTrangThaiGiaoDich]
@trangThai int,
@id int,
@idvnpay bigint
as 
update tblGiaoDich set trangThai = @trangThai, idGiaoDichVNPAY = @idvnpay
where imagiaodich = @id
GO
/****** Object:  StoredProcedure [dbo].[xemDonDatTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[xemDonDatTour]
 @id int
as
select  b1.semail,b1.snoikhoihanh,b1.ssdt,b1.stongthoigian,b1.dthoigian,b4.veTE,b3.veNL,b1.doanhthu , b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, 
b1.sTenKhachHang, b1.iMaKhachHang , b1.dNgayDatTour , b1.sghichu , b1.stieude
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.dNgayDatTour, b.sghichu, e.stieude , g.dThoiGian, e.stongthoigian, d.sSDT, e.snoikhoihanh,d.sEmail,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e , tblThoiGianKhoiHanh g--, tblGiaoDich 
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour and e.imatour = g.imatour and b.imathoigian = g.iMaThoiGian
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour and b.iMaDonDatTour = @id
group by   g.dThoiGian,b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,e.stieude ,e.stongthoigian, d.sSDT, e.snoikhoihanh , d.semail) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour
join
(select sum(soLuongVe) as veNL, iMaDonDatTour from tblChiTietDonDatTour where iMaNhomVe = 1  group by iMaDonDatTour) b3 on b1.iMaDonDatTour = b3.iMaDonDatTour
join
(select sum(soLuongVe) as veTE, iMaDonDatTour from tblChiTietDonDatTour where iMaNhomVe = 2 group by iMaDonDatTour) b4 on b1.iMaDonDatTour = b4.iMaDonDatTour
 order by b1.dNgayDatTour DESC
GO
/****** Object:  StoredProcedure [dbo].[xemgiaodich]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[xemgiaodich]
@id int
as
select * from tblNhanVien a, tblGiaoDich b
where a.imanhanvien = b.imaNhanVien and b.iMaDonTour = @id and trangThai = 1
GO
/****** Object:  StoredProcedure [dbo].[xemKhachHangID]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[xemKhachHangID]
@id int
as
select * from tblKhachHang where iMaKhachHang = @id
GO
/****** Object:  StoredProcedure [dbo].[xemTrangThaiNV]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[xemTrangThaiNV]
@id int
as
select a.stennhanvien, b.dthoigian, b.sghichu, b.itrangThai, b.imadon from
 tblNhanVien a, tblTrangThaiDonDatTour b where a.iMaNhanVien = b.imanhanvien
and b.iMaDon = @id
GO
/****** Object:  Table [dbo].[tblChiTietDonDatTour]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblChiTietDonDatTour](
	[iMaDonDatTour] [int] NOT NULL,
	[iMaNhomVe] [int] NOT NULL,
	[soLuongVe] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaNhomVe] ASC,
	[iMaDonDatTour] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDanhGia]    Script Date: 3/18/2020 10:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDanhGia](
	[iMaDanhGia] [int] IDENTITY(1,1) NOT NULL,
	[iMaDonDatTour] [int] NOT NULL,
	[dThoiGian] [datetime] NULL,
	[sNoiDung] [nvarchar](150) NULL,
	[iSoSao] [int] NULL,
	[btrangthai] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaDanhGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDonDatTour]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDonDatTour](
	[iMaDonDatTour] [int] IDENTITY(1,1) NOT NULL,
	[iMaTour] [int] NOT NULL,
	[iMaKhachHang] [int] NOT NULL,
	[dNgayDatTour] [datetime] NULL,
	[sghichu] [nvarchar](300) NULL,
	[imathoigian] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaDonDatTour] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblGiaoDich]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblGiaoDich](
	[iMaGiaoDich] [int] IDENTITY(1,1) NOT NULL,
	[iMaDonTour] [int] NULL,
	[tien] [int] NULL,
	[idGiaoDichVNPAY] [bigint] NULL,
	[trangThai] [int] NULL,
	[imaNhanVien] [int] NULL,
	[thoigian] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaGiaoDich] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblhinhanh]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblhinhanh](
	[iMaHinhAnh] [int] IDENTITY(1,1) NOT NULL,
	[sDuongDan] [varchar](100) NULL,
	[iMaTour] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaHinhAnh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblKhachHang]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblKhachHang](
	[iMaKhachHang] [int] IDENTITY(1,1) NOT NULL,
	[sTenKhachHang] [nvarchar](100) NOT NULL,
	[dNgaySinh] [date] NULL,
	[sDiaChi] [nvarchar](100) NULL,
	[sSDT] [varchar](13) NULL,
	[sEmail] [varchar](25) NULL,
	[sUserName] [nvarchar](30) NULL,
	[sPassWord] [varchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblNhanVien]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblNhanVien](
	[iMaNhanVien] [int] IDENTITY(1,1) NOT NULL,
	[sTenNhanVien] [nvarchar](100) NOT NULL,
	[bGioiTinh] [bit] NULL,
	[dNgaySinh] [date] NULL,
	[sDiaChi] [nvarchar](100) NULL,
	[sSDT] [varchar](15) NULL,
	[sUserName] [nvarchar](30) NULL,
	[sPassWord] [varchar](150) NULL,
	[iMaQuyen] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblNhomTour]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNhomTour](
	[iMaNhomTour] [int] IDENTITY(1,1) NOT NULL,
	[sTenNhomTour] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaNhomTour] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblNhomVe]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNhomVe](
	[iMaNhomVe] [int] IDENTITY(1,1) NOT NULL,
	[sTenNhomVe] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaNhomVe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblNhomVeGia]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNhomVeGia](
	[iMaTour] [int] NOT NULL,
	[iMaNhomVe] [int] NOT NULL,
	[iGiaVe] [int] NOT NULL,
	[iGiaVeGiam] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaTour] ASC,
	[iMaNhomVe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblQuyen]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblQuyen](
	[iMaQuyen] [int] IDENTITY(1,1) NOT NULL,
	[sTenQuyen] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaQuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThoiGianKhoiHanh]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThoiGianKhoiHanh](
	[iMaThoiGian] [int] IDENTITY(1,1) NOT NULL,
	[iMaTour] [int] NOT NULL,
	[dThoiGian] [date] NOT NULL,
	[trangThai] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaThoiGian] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTour]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTour](
	[iMaTour] [int] IDENTITY(1,1) NOT NULL,
	[sTieuDe] [nvarchar](250) NULL,
	[sMoTa] [nvarchar](max) NOT NULL,
	[sTongThoiGian] [nvarchar](20) NULL,
	[iMaNhomTour] [int] NOT NULL,
	[iSoCho] [int] NULL,
	[sNoiKhoiHanh] [nvarchar](50) NULL,
	[iMaNhanVien] [int] NULL,
	[dNgayTao] [datetime] NULL,
	[bTrangThai] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaTour] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTrangThaiDonDatTour]    Script Date: 3/18/2020 10:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTrangThaiDonDatTour](
	[iMaTrangThai] [int] IDENTITY(1,1) NOT NULL,
	[iTrangThai] [int] NULL,
	[sGhiChu] [nvarchar](100) NULL,
	[iMaDon] [int] NULL,
	[iMaNhanVien] [int] NULL,
	[dthoigian] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaTrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (113, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (114, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (113, 2, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (114, 2, 0)
SET IDENTITY_INSERT [dbo].[tblDanhGia] ON 

INSERT [dbo].[tblDanhGia] ([iMaDanhGia], [iMaDonDatTour], [dThoiGian], [sNoiDung], [iSoSao], [btrangthai]) VALUES (13, 113, CAST(0x0000AB82016BF681 AS DateTime), N'Tour Rất Đẹp', 5, 1)
SET IDENTITY_INSERT [dbo].[tblDanhGia] OFF
SET IDENTITY_INSERT [dbo].[tblDonDatTour] ON 

INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (113, 56, 14, CAST(0x0000AB8201631A93 AS DateTime), N'Dat tour.', 1160)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (114, 54, 14, CAST(0x0000AB820166AF52 AS DateTime), N'dat tour', 1153)
SET IDENTITY_INSERT [dbo].[tblDonDatTour] OFF
SET IDENTITY_INSERT [dbo].[tblGiaoDich] ON 

INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (83, 113, 2650000, 13267727, 1, 1, CAST(0x0000AB8201631A93 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (84, 113, 2650000, NULL, 1, 24, CAST(0x0000AB820163516B AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (85, 114, 3261000, 13267757, 1, 1, CAST(0x0000AB820166AF52 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (86, 114, 3261000, NULL, 1, 24, CAST(0x0000AB820167CB3B AS DateTime))
SET IDENTITY_INSERT [dbo].[tblGiaoDich] OFF
SET IDENTITY_INSERT [dbo].[tblhinhanh] ON 

INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (32, N'bay-ngam-canh-34dao-dau-lau34-kingkong-bang-thuy-phi-co_tnmbac040301_0.jpg', 54)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (33, N'bay-ngam-canh-34dao-dau-lau34-kingkong-bang-thuy-phi-co_tnmbac040301_1.jpg', 54)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (34, N'bay-ngam-canh-34dao-dau-lau34-kingkong-bang-thuy-phi-co_tnmbac040301_2.jpg', 54)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (35, N'Dam-van-long-ninh-binh.jpg', 54)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (36, N'suoi-nuoc-nong-kenh-ga-ninh-binh.jpg', 54)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (37, N'Vinh-ha-long.jpg', 54)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (38, N'ha-noi--yen-tu_nd1018-01-110214mb_2.jpg', 55)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (39, N'ha-noi--yen-tu_nd1018-01-110214mb_0.jpg', 55)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (40, N'ha-noi--yen-tu_nd1018-01-110214mb_1.jpg', 55)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (41, N'ha-noi--yen-tu_nd1018-01-110214mb_2.jpg', 55)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (42, N'ha-noi--sapa_nd1018-02-110214mb_1.jpg', 56)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (43, N'ha-noi--sapa_nd1018-02-110214mb_0.jpg', 56)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (44, N'ha-noi--sapa_nd1018-02-110214mb_1.jpg', 56)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (45, N'ha-noi--sapa_nd1018-02-110214mb_2.jpg', 56)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (46, N'Bien-ky-co-binh-dinh.jpg', 57)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (47, N'Mo-han-mac-tu.jpg', 57)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (48, N'quy-nhon-thanh-pho-binh-yen_ttbd030302_0.jpg', 57)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (49, N'quy-nhon-thanh-pho-binh-yen_ttbd030302_1.jpg', 57)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (50, N'quy-nhon-thanh-pho-binh-yen_ttbd030302_2.jpg', 57)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (51, N'ystH4ur.jpg', 58)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (52, N'nha-trang-vinperland-bien-dao-ky-thu_tnnhat030201_0.jpg', 58)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (53, N'nha-trang-vinperland-bien-dao-ky-thu_tnnhat030201_2.jpg', 58)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (54, N'VPxgjHs.jpg', 58)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (55, N'ystH4ur.jpg', 58)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (56, N'da-nang--hue_nddn11021401_1.jpg', 59)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (57, N'da-nang--hue_nddn11021401_0.jpg', 59)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (58, N'da-nang--hue_nddn11021401_1.jpg', 59)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (59, N'da-nang--hue_nddn11021401_2.jpg', 59)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (60, N'da-nang--son-tra--hoi-an--hue_nddn11021402_2.jpg', 60)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (61, N'da-nang--son-tra--hoi-an--hue_nddn11021402_0.jpg', 60)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (62, N'da-nang--son-tra--hoi-an--hue_nddn11021402_1.jpg', 60)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (63, N'da-nang--son-tra--hoi-an--hue_nddn11021402_2.jpg', 60)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (64, N'mien-tay-song-nuoc_tnmien040301_1.jpg', 61)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (65, N'Cho-noi-cai-rang-du-lich-can-tho.jpg', 61)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (66, N'Chua-doi-soc-trang.jpg', 61)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (67, N'Dat-mui-ca-mau.jpg', 61)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (68, N'mien-tay-song-nuoc_tnmien040301_0.jpg', 61)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (69, N'mien-tay-song-nuoc_tnmien040301_2.jpg', 61)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (70, N'Xu-dua-ben-tre.jpg', 61)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (71, N'Vinpearl-phu-quoc(1).jpg', 62)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (72, N'Bai-Sao-Phu-Quoc.jpg', 62)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (73, N'Dinh-cau-ph-quoc.jpg', 62)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (74, N'kham-pha-thien-duong-ruc-nang_tnphuq030201_1.jpg', 62)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (75, N'kham-pha-thien-duong-ruc-nang_tnphuq030201_2.jpg', 62)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (76, N'Suoi-tranh-phu-quoc.jpg', 62)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (77, N'my tho can tho.jpg', 63)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (78, N'can-tho--khu-du-lich-phu-sa_ndct03031401_0.jpg', 63)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (79, N'can-tho--khu-du-lich-phu-sa_ndct03031401_1.jpg', 63)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (80, N'can-tho--khu-du-lich-phu-sa_ndct03031401_2.jpg', 63)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (81, N'du lich my tho.jpg', 63)
SET IDENTITY_INSERT [dbo].[tblhinhanh] OFF
SET IDENTITY_INSERT [dbo].[tblKhachHang] ON 

INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (14, N'Ngo Dang Huy', CAST(0x08160B00 AS Date), N'Ha Noi', N'0862655656', N'huyhuy@gmail.com', N'huy123', N'6291F146521F9B2DB100BD16F019B931')
SET IDENTITY_INSERT [dbo].[tblKhachHang] OFF
SET IDENTITY_INSERT [dbo].[tblNhanVien] ON 

INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (1, N'VN PAY', 1, CAST(0xAA400B00 AS Date), N'KHONG', N'KHONG', N'KHONG', N'', 3)
INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (24, N'Ngo Dang Huy', 1, CAST(0xCE400B00 AS Date), N'ha noi', N'23423432', N'huyhuy123', N'D81EE40811DFCBB563868685BD26A1AD', 2)
SET IDENTITY_INSERT [dbo].[tblNhanVien] OFF
SET IDENTITY_INSERT [dbo].[tblNhomTour] ON 

INSERT [dbo].[tblNhomTour] ([iMaNhomTour], [sTenNhomTour]) VALUES (18, N'Miền Bắc')
INSERT [dbo].[tblNhomTour] ([iMaNhomTour], [sTenNhomTour]) VALUES (19, N'Miền Trung')
INSERT [dbo].[tblNhomTour] ([iMaNhomTour], [sTenNhomTour]) VALUES (20, N'Miền Nam')
SET IDENTITY_INSERT [dbo].[tblNhomTour] OFF
SET IDENTITY_INSERT [dbo].[tblNhomVe] ON 

INSERT [dbo].[tblNhomVe] ([iMaNhomVe], [sTenNhomVe]) VALUES (1, N'Ve Nguoi Lon')
INSERT [dbo].[tblNhomVe] ([iMaNhomVe], [sTenNhomVe]) VALUES (2, N'Ve Tre Em')
INSERT [dbo].[tblNhomVe] ([iMaNhomVe], [sTenNhomVe]) VALUES (3, N'dasdew')
INSERT [dbo].[tblNhomVe] ([iMaNhomVe], [sTenNhomVe]) VALUES (4, N'x')
INSERT [dbo].[tblNhomVe] ([iMaNhomVe], [sTenNhomVe]) VALUES (5, N'x')
INSERT [dbo].[tblNhomVe] ([iMaNhomVe], [sTenNhomVe]) VALUES (6, N'x')
INSERT [dbo].[tblNhomVe] ([iMaNhomVe], [sTenNhomVe]) VALUES (7, N'')
SET IDENTITY_INSERT [dbo].[tblNhomVe] OFF
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (54, 1, 6980000, 6522000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (54, 2, 5200000, 4600000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (55, 1, 2400000, 2250000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (55, 2, 1800000, 1750000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (56, 1, 2400000, 2100000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (56, 2, 1800000, 1600000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (57, 1, 4280000, 4180000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (57, 2, 3080000, 3280000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (58, 1, 3590000, 3390000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (58, 2, 3090000, 2590000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (59, 1, 4800000, 4600000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (59, 2, 4500000, 4100000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (60, 1, 4500000, 4400000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (60, 2, 4100000, 4000000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (61, 1, 4800000, 4700000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (61, 2, 4600000, 4399999)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (62, 1, 3800000, 3600000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (62, 2, 3100000, 3400000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (63, 1, 2400000, 2300000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (63, 2, 2000000, 1850000)
SET IDENTITY_INSERT [dbo].[tblQuyen] ON 

INSERT [dbo].[tblQuyen] ([iMaQuyen], [sTenQuyen]) VALUES (1, N'MemBer')
INSERT [dbo].[tblQuyen] ([iMaQuyen], [sTenQuyen]) VALUES (2, N'Admin')
INSERT [dbo].[tblQuyen] ([iMaQuyen], [sTenQuyen]) VALUES (3, N'PAY')
SET IDENTITY_INSERT [dbo].[tblQuyen] OFF
SET IDENTITY_INSERT [dbo].[tblThoiGianKhoiHanh] ON 

INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1153, 54, CAST(0x21410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1154, 54, CAST(0x1A410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1155, 55, CAST(0x24410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1156, 55, CAST(0x32410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1157, 55, CAST(0x0B410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1158, 56, CAST(0x40410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1159, 56, CAST(0x3F410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1160, 56, CAST(0x14410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1161, 57, CAST(0x51410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1162, 57, CAST(0x01410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1163, 57, CAST(0x02410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1164, 58, CAST(0x16410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1165, 58, CAST(0xF4400B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1166, 58, CAST(0x3F410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1167, 59, CAST(0x19410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1168, 59, CAST(0x26410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1169, 60, CAST(0x0A410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1170, 60, CAST(0x19410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1171, 61, CAST(0x0C410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1172, 61, CAST(0x2A410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1173, 61, CAST(0x01410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1174, 62, CAST(0x27410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1175, 62, CAST(0x31410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1176, 63, CAST(0x20410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1177, 63, CAST(0x08410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1178, 58, CAST(0xE7400B00 AS Date), 1)
SET IDENTITY_INSERT [dbo].[tblThoiGianKhoiHanh] OFF
SET IDENTITY_INSERT [dbo].[tblTour] ON 

INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (54, N'Bay ngắm cảnh "Đảo đầu lâu" Kingkong bằng thủy phi cơ', N'<p style="text-align:center"><strong><span style="color:#ff0000"><span style="font-size:18px"><span style="background-color:#ffff00">BAY NGẮM CẢNH "ĐẢO ĐẦU LÂU" KINGKONG BẰNG THỦY PHI CƠ</span></span></span></strong></p>

<p style="text-align:center"><strong><span style="color:#ff0000"><span style="font-size:18px"><span style="background-color:#ffff00">HÀ NỘI - VÂN LONG - KÊNH GÀ - HẠ LONG</span></span></span></strong></p>

<p style="text-align:justify"><span style="font-size:14px"><strong>Tour theo dấu chân Kingkong để tận mắt chiêm ngưỡng vẻ đẹp mê hồn của nơi làm bối cảnh quay siêu phẩm "Đảo đầu lâu" bằng thủy phi cơ.</strong></span></p>

<ul>
	<li style="text-align:justify"><span style="font-size:14px"><em>Sau khi bộ phim <strong>“Kong: Đảo Đầu Lâu” (Kong: Skull Island)</strong> chính thức ra mắt khán giả Việt Nam, du khách đã có thể đặt tour đi <strong>Ninh Bình, Hạ Long</str', N'4 Ngày 3 Đêm', 18, 50, N'Hà Nội', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (55, N'Hà Nội – Yên Tử ', N'<div class="tab-pane active" id="program">
<p style="text-align:justify"><span style="font-size:12px"><em>Hà Nô</em><em>̣</em><em>i </em><em>n</em><em>ơ</em><em>i hô</em><em>̣</em><em>i tu</em><em>̣</em><em> nga</em><em>̀</em><em>n n</em><em>ă</em><em>m v</em><em>ă</em><em>n hiê</em><em>́</em><em>n - tra</em><em>́</em><em>i tim cu</em><em>̉</em><em>a ca</em><em>̉</em><em> n</em><em>ướ</em><em>c - niê</em><em>̀</em><em>m tin va</em><em>̀</em><em> hy vo</em><em>̣</em><em>ng. Thu</em><em>̉</em><em> đ</em><em>ô </em><em>Hà Nô</em><em>̣</em><em>i </em><em>xuâ</em><em>́</em><em>t hiê</em><em>̣</em><em>n trong li</em><em>̣</em><em>ch s</em><em>ử</em><em> dân tô</em><em>̣</em><em>c Viê</em><em>̣</em><em>t Nam va</em><em>̀</em><em>o n</em><em>ă</em><em>m 1010 v</em><em>ớ</em><em>i tên go</em><em>̣</em><em>i Th</em><em>ă</em><em>ng Long mang y</em><em>́</em><em> nghi</em><em>̃</em><em>a “Rô</em><em>̀</em><em>ng bay lên”, t</em><em>ượ</em><em>ng tr</em><em>ư</em><em>ng cho khi </em><em>́</em><em>thê</em><em>́</em><em> v</em><em>ươ</em><em>n lên cu</em><em>̉</em><em>a dân tô</em><em>̣</em><em>c, m</em><em>ở </em><em>đ</em><em>â</em><em>̀</em><em>u cho mô</em><em>̣</em><em>t giai </em><em>đ</em><em>oa</em><em>̣</em><em>n pha</em><em>́</em><em>t triê</em><em>̉</em><em>n cu</em><em>̉</em><em>a </em><em>đ</em><em>â</em><em>́</em><em>t n</em><em>ướ</em><em>c. V</em><em>ớ</em><em>i gâ</em><em>̀</em><em>n 1000 n</em><em>ă</em><em>m tuô</em><em>̉</em><em>i nên&nbsp; có </em><em> râ</em><em>́</em><em>t nhiê</em><em>̀</em><em>u chu</em><em>̀</em><em>a chiê</em><em>̀</em><em>n va</em><em>̀</em><em> th</em><em>ắ</em><em>ng ca</em><em>̉</em><em>nh cô</em><em>̉</em><em> ki</em><em>́</em><em>nh thiêng liêng. </em><em>Hà Nô</em><em>̣</em><em>i</em><em> cũng là mảnh </em><em>đ</em><em>â</em><em>́</em><em>t anh du</em><em>̃</em><em>ng va</em><em>̀</em><em> ha</em><em>̀</em><em>o hu</em><em>̀</em><em>ng </em><em>trải qua hai cuô</em><em>̣</em><em>c kha</em><em>́</em><em>ng chiê</em><em>́</em><em>n tr</em><em>ườ</em><em>ng ky</em><em>̀</em><em> va</em><em>̀ </em><em>gian khô</em><em>̉</em><em> chô</em><em>́</em><em>ng Pha</em><em>́</em><em>p va</em><em>̀ </em><em>chô</em><em>́</em><em>ng My</em><em>̃</em><em>. Chi</em><em>́</em><em>nh vi</em><em>̀ </em><em>v</em><em>ậ</em><em>y</em><em> H</em><em>à</em><em> N</em><em>ộ</em><em>i</em><em> cũng là thành phô</em><em>́</em><em> co</em><em>́ </em><em>ve</em><em>̉ </em><em>đ</em><em>e</em><em>̣</em><em>p kiê</em><em>́</em><em>n tru</em><em>́</em><em>c cô</em><em>̉</em><em> đ</em><em>iê</em><em>̉n kiê</em><em>̉</em><em>u Pha</em><em>́</em><em>p, hiê</em><em>̣</em><em>n </em><em>đ</em><em>a</em><em>̣</em><em>i kiê</em><em>̉</em><em>u My</em><em>̃</em><em>.</em></span></p>

<p style="text-align:justify"><span style="font-size:12px"><em>V</em><em>ị</em><em>nh H</em><em>ạ </em><em>Long, m</em><em>ộ</em><em>t tuy</em><em>ệ</em><em>t tác do thiên nhiên t</em><em>ạ</em><em>o ra có m</em><em>ộ</em><em>t không hai trên </em><em>th</em><em>ế </em><em>gi</em><em>ớ</em><em>i </em><em>đ</em><em>ã </em><em>đượ</em><em>c UNESCO hai l</em><em>ầ</em><em>n công nh</em><em>ậ</em><em>n l</em><em>à</em><em> Di s</em><em>ả</em><em>n thiên nhiên th</em><em>ế </em><em>gi</em><em>ớ</em><em>i</em><em> v</em><em>ề</em><em> giá tr</em><em>ị</em><em> c</em><em>ả</em><em>nh quan v</em><em>à </em><em>giá tr</em><em>ị</em><em> khoa h</em><em>ọ</em><em>c </em><em>đị</em><em>a ch</em><em>ấ</em><em>t </em><em>đị</em><em>a m</em><em>ạ</em><em>o n</em><em>ă</em><em>m 2000. Ban </em><em>t</em><em>ổ</em><em> ch</em><em>ứ</em><em>c New Open Wo</em><em>rld c</em><em>ũ</em><em>ng </em><em>đề</em><em> c</em><em>ử</em><em> V</em><em>ị</em><em>nh H</em><em>ạ</em><em> Long v</em><em>à</em><em>o danh sách b</em><em>ấ</em><em>u ch</em><em>ọ</em><em>n</em><em> kì quan thiên nhiên th</em><em>ế</em><em> gi</em><em>ớ</em><em>i</em><em>.</em></span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><st', N'4 Ngày 3 Đêm', 18, 50, N'Hà N?i', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (56, N'Hà Nội - Sapa', N'<p><span style="font-size:12px"><em>hương trình Sa Pa (Lào Cai) là thị trấn nghỉ mát thuộc tỉnh Lào Cai ở độ cao 1600 m so với mặt biển, có khí hậu ôn đới, nhiệt độ trung bình từ 15 đến 18 độ C, quanh năm mát mẻ, mùa đông có tuyết nhẹ. Từ những năm đầu thế kỷ người Pháp đã tìm thấy sức hấp dẫn của Sa Pa về cảnh quan, khí hậu và nguồn nước.... vì thế du khách có thể chiêm ngưỡng vẻ đẹp của kiến trúc Pháp của hơn 200 biệt thự nghỉ mát. Sa Pa, một địa danh nguyên sơ với làng bản của các dân tộc ít người như H’Mông, Dao, Tày, Xá Phó... với Thác Bạc, cổng Trời, cầu Mây, hang Gió, núi Hàm Rồng... xứng đáng là một nơi dành cho những ai yêu thích thiên nhiên muốn tìm hiểu phong tục tập quán của người dân miền núi.</em></span></p>

<p style="text-align:justify"><span style="font-size:12px"><em>Hạ Long - di sản của thế giới rộng hơn 1500 km với hàng ngàn đảo đá, mỗi đảo đá một vẻ, có đảo cao vút nhưng có những đảo chỉ cao hơn mặt biển vài chục mét, có đảo đứng chơi vơi ngoài biển khơi, cũng có đảo dựa vào những dãy đảo lớn hơn. Có đảo hình cánh buồm, hình gà chọi, hình con rùa, hình cái tháp, muôn hình ngàn vẻ... đó là sự sáng tạo kì diệu của thiên nhiên</em></span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong>NGÀY 1: HCM – HÀ NỘI (ĂN: TRƯA, TỐI)</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Sáng:</strong> Xe và HDV đón Quý khách tại sân bay Nội Bài, đưa&nbsp; về khách sạn, nhận phòng, nghỉ ngơi. Quý khách ăn trưa tại nhà hàng.</span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Chiều: </strong>Quý khách thăm <strong>chùa Trấn Quốc<em>–</em></strong>Ngôi chùa Trấn Bắc cổ kính nhất Việt Nam với 1.500 năm tuổi nằm trên bán đảo cồn Quy linh thiêng, với truyền thuyết và huyền thoại về Hồ Tây, hồ Trúc Bạch. Quý khách tiếp tục thăm quan <strong>Đền Ngọc Sơn, hồ Hoàn Kiếm</strong> - Trực tiếp chứng kiến cụ Rùa dài 2,1m, ngang 1,2m được trưng bày tại đền Ngọc Sơn. Quý khách ghé thăm <strong>Văn Miếu - Quốc Tử Giám</strong> – Nơi đựoc xem như Trường Đại học đầu tiên của Việt Nam với 82 tấm bia Tiến sỹ còn lưu danh sử sách.</span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Tối: </strong>Quý khách tự do dạo chơi thăm <strong>phố cổ Hà Nội, dạo Hồ Gươm, mua sắm tại Chợ đêm Hà Nội sầm uất</strong>,.. Nghỉ đêm tại khách sạn.</span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong>NGÀY 2: HÀ NỘI-HẠ LONG- CẦU BÃI CHÁY (ĂN: SÁNG,TRƯA, TỐI)</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Sáng:</strong> Quý khách lên xe khởi hành đi Hạ Long, ngắm cảnh đẹp yên bình của vùng nông thôn Bắc Bộ. 11h00 Quý khách đến Hạ Long, ra bến xuống tàu đi thăm vịnh Hạ Long, thưởng thức bữa trưa trên tàu với các món Hải sản biển tươi sống.</span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Chiều: </strong>Quý khách <strong>tham quan vịnh Hạ Long</strong> – Di sản thiên nhiên thế giới duy nhất được UNESCO công nhận hai lần vào năm 1994 và 2001. <strong>Thăm động Thiên Cung, hang Dấu Gỗ</strong> - Nơi gắn liền với truyền thuyết tên Hạ Long cùng dấu tích trận chiến Bạch Đằng của người anh hùng Ngô Quyền, ngắm nhìn những hòn đảo kỳ thú: <strong>Hòn chó đá, Lư hương, gà chọi, hòn Cô Đơn</strong>...</span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Tối:</strong> Quý khách <strong>dạo chơi Công viên Hoàng Gia dọc biển Bãi Cháy, đi mua sắm hàng hóa tại khu Chợ Đêm Hạ Long sầm uất với các sản phẩm đặc trưng Hạ Long, lên cầu Bãi Cháy –</strong> cây cầu dây văng dài nhất Việt Nam ngắm Hạ Long về đêm.</span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="fon', N'4 Ngày 3 Đêm', 18, 50, N' Hà N?i', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (57, N'Quy Nhơn - Thành phố bình yên', N'<p style="text-align:center"><span style="color:#ff0000"><span style="font-size:18px"><strong><span style="background-color:#ffff00">QUY NHƠN - THÀNH PHỐ BÌNH YÊN</span></strong></span></span></p>

<h2 style="text-align:justify"><strong><u>NGÀY 1:</u> ĐÓN KHÁCH - QUY NHƠN CITY TOUR<em>(Ăn trưa, tối)</em></strong></h2>

<ul>
	<li style="text-align:justify"><span style="font-size:14px"><u><strong>Sáng:</strong></u> Quý khách tập trung tại sân bay Tân Sơn Nhất (ga quốc nội), đáp chuyến bay đi Quy Nhơn. Đến Quy Nhơn, xe đón đưa quý khách về khách sạn nhận phòng (nếu có, vì giờ nhận phòng là 14h00).</span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px">Ăn Trưa tại nhà hàng địa phương.&nbsp; Sau bữa trưa, về lại khách sạn nghỉ ngơi.</span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px"><u><strong>Chiều:</strong></u> Thă', N'4 Ngày 3 Đêm', 19, 50, N'Quy Nhon City', 24, CAST(0x0000AB8200000000 AS DateTime), 0)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (58, N'Nha Trang - Vinperland - Biển đảo kỳ thú', N'<div id="program">
<p><strong>NHA TRANG - BIỂN ĐẢO KỲ THÚ</strong></p>

<p><em><strong>Tour du lịch Nha Trang 3 ngày 2 đêm lễ 30/4 và 1/5</strong> khám phá Vinpearl Land, Biển đảo kì thú và tắm suối nước nóng...đem đến cho du khách một kỳ nghỉ dưỡng đúng nghĩa với nhiều điểm tham quan độc đáo và đẹp nhất của Nha Trang.</em></p>

<h2><strong><u>NGÀY 1:</u> TP. HCM - NHA TRANG<em>(Ăn chiều)</em></strong></h2>

<p>Quý khách tập trung tại điểm hẹn, khởi hành đến&nbsp;<a href="http://cholontourist.com.vn/du-ngoan-dao-tour-du-lich-nha-trang/nht000001"><strong>Tour Nha Trang 3 ngày 2 đêm</strong></a>:</p>

<p><strong>Đi máy bay</strong>: quý khách tập trung tại sân bay Tân Sơn Nhất (ga quốc nội).</p>

<p>Đến Nha Trang, xe và hướng dẫn viên địa phương đón đoàn về khách sạn nhận phòng, nghỉ ngơi.</p>

<p><strong>14h00: </strong>Khởi hành đến <strong>Thiên đường giải trí Vinpearl Land', N'5 Ngày 6 Đêm', 18, 50, N'Nha Trang', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (59, N'Đà Nẵng - Huế', N'<div class="tab-pane active" id="program">
<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong>NGÀY 1: </strong><strong>TP HCM – SƠN TRÀ - ĐÀ NẴNG (ĂN: TR</strong><strong>ƯA, CHIỀU)</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px">-&nbsp;&nbsp; Sáng-trưa: Đón quý khách tại Đà Nẵng (Sân bay, Ga, Bến Xe...) từ <strong><u>07h00 đến 13h00</u></strong> <strong><em>(sau thời gian này, quý khách tự túc nhập đoàn)</em></strong> đưa đi ăn trưa với đặc sản nổi tiếng Đà Nẵng “<em>Bánh tráng thịt heo 2 đầu da &amp; Mỳ Quảng”</em>. Nhận phòng K/sạn nghỉ ngơi.</span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong><em>(nếu quý khách muốn tham quan Bà Nà, đặt chuyến bay muộn nhất 08’00 hạ cánh đến Đà Nẵng, , mua thêm Tour ghép đi Bà Nà, phụ thu thêm 650,000 đ/khách (bao gồm xe, hướng dẫn viên, vé cáp treo khứ hồi, trưa về tiếp tục nhập đoàn)</em></strong></span></p>

<p style="text-align:justify"><span style="font-size:12px">-&nbsp;&nbsp; Chiều: Khởi hành đi <strong>Bán Đảo Sơn Trà (Monkey Mountain)</strong> quay một vòng quanh Bán Đảo để thưởng ngoạn toàn cảnh phố biển Đà Nẵng trên cao, viếng <strong>Linh Ứng Tự</strong> - nơi có tượng Phật Bà 65m cao nhất Việt Nam &nbsp;và tắm biển <strong>Mỹ Khê Đà Nẵng</strong></span></p>

<p style="text-align:justify"><span style="font-size:12px">-&nbsp;&nbsp; Tối: Ăn tối Nhà hàng. Quý khách thưởng thức chương trình <strong>Nghệ Thuật Truyền Thống Việt Nam</strong> và tự do khám phá <strong>Phố Biển Đà Nẵng về đêm</strong>: Cầu Quay sông Hàn, Trung Tâm Thương Mại, Khu phố ẩm thực, Café - Bar - Discotheque...&nbsp;&nbsp;</span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong>NGÀY 2: </strong><strong>ĐÀ NẴNG – NGŨ HÀNH SƠN -&nbsp; ĐÔ THỊ CỔ HỘI AN – ĐÀ NẴNG (ĂN: SÁNG, TR</strong><strong>ƯA, CHIỀU)</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px">-&nbsp;&nbsp; Sáng: Điểm tâm. Khởi hành tham quan khu di tích – danh thắng <strong>Ngũ Hành Sơn</strong> (khám phá các hang động, vãn cảnh đẹp non nước trời mây, viếng những ngôi chùa thiêng), <strong>Làng Nghề Điêu Khắc Đá Non Nước.</strong>&nbsp;&nbsp;</span></p>

<p style="text-align:justify"><span style="font-size:12px">-&nbsp;&nbsp; Trưa: Ăn trưa nhà hàng tại Đà Nẵng</span></p>

<p style="text-align:justify"><span style="font-size:12px">-&nbsp;&nbsp; Chiều: Khởi hành vào Hội An bách bộ tham quan và mua sắm <strong>Phố Cổ</strong> với: <strong>Chùa Cầu Nhật Bản, Bảo tàng văn hóa Sa Huỳnh, Nhà Cổ hàng trăm năm tuổi, Hội Quán Phước Kiến &amp; Xưởng thủ công mỹ nghệ - thưởng thức ca nhạc truyền thống lúc 15h15.</strong></span></p>

<p style="text-align:justify"><span style="font-size:12px">-&nbsp;&nbsp; Tối: Ăn tối nhà hàng, <strong>thưởng thức đặc sản Hội An (<em>Cao Lầu - Bánh Bao - Bánh Vạc Hoành Thánh</em>)</strong>. Xe đưa quý khách về lại Đà Nẵng dọc đường biển để ngắm thành phố Đà Nẵng tuyệt đẹp về đêm với hàng loạt khu nghĩ dưỡng và Resort cao cấp. Ngủ KS tại Đà Nẵng.</span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong>NGÀY 3: </strong><strong>ĐÀ NẴNG - CỐ ĐÔ HUẾ - QUẢNG BÌNH (ĂN: SÁNG, TR</strong><strong>ƯA, CHIỀU)</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px">-&nbsp;&nbsp; Sáng: Điểm tâm. Rời Đà Nẵng đi <strong>Cố Đô Huế</strong> - <em>Di sản văn hoá Thế Giới</em>, tiếp tục hành trình xuyên hầm đường bộ đèo Hải Vân đến Huế, tham quan <strong>L</strong><strong>ăng Khải Định </strong>lộng lẫy- kết hợp tinh xảo hai nền kiến trúc, văn hoá Đông – Tây.</span></p>

<p style="text-align:justify"><span style="font-size:12px">-&nbsp;&nbsp; Trưa: Ăn trưa nhà hàng. Khởi hành đi Quảng Bình Viếng thăm <strong>Thánh Địa La Vang</strong> (Được phong tặng là Tiểu Vương Cung Thánh Đường) và chụp ảnh Vĩ tuyến 17 - <strong>Cầu Hiền Lương</strong> - Sông Bến Hải (', N'5 Ngày 6 Đêm', 19, 50, N'Ðà N?ng', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (60, N'Đà Nẵng - Sơn Trà - Hội An - Huế', N'<div class="tab-pane active" id="program">
<p style="text-align:justify"><span style="font-size:12px"><span style="color:#005baa"><strong>NGÀY 1:TP HCM – SƠN TRÀ - ĐÀ NẴNG(ĂN: TRƯA, CHIỀU)</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px">Sáng : Quý khách ra sân bay Tân Sơn Nhất làm thủ tục đáp chuyến bay đi Đà Nẵng. Xe và HDV đón quý khách tại sân bay và đưa đi dùng bữa trưa với đặc sản nổi tiếng Đà Nẵng “<em>Bánh tráng thịt heo 2 đầu da &amp; Mỳ Quảng”</em>. Nhận phòng K/sạn nghỉ ngơi.</span></p>

<p style="text-align:justify"><span style="font-size:12px">Chiều: Quý khách khởi hành đi Bán Đảo Sơn Trà (Monkey Mountain) quay một vòng quanh Bán Đảo để thưởng ngoạn toàn cảnh phố biển Đà Nẵng trên cao. Xe đưa quý khách dọc theo triền núi Đông Nam để chiêm ngưỡng vẻ đẹp tuyệt mỹ của biển Đà Nẵng, viếng Linh Ứng Tự - nơi có tượng Phật Bà 65m cao nhất Việt Nam &nbsp;và tắm biển Mỹ Khê Đà Nẵng (Được tạp chí Forbes bình chọn là 1 trong những bãi biển quyến rũ nhất Hành Tinh).&nbsp;&nbsp;&nbsp;</span></p>

<p style="text-align:justify"><span style="font-size:12px">Tối: Dùng tối hải sản. Quý khách thưởng thức chương trình Nghệ Thuật Truyền Thống Việt Nam và tự do khám phá Phố Biển Đà Nẵng về đêm: Cầu Quay sông Hàn, Trung Tâm Thương Mại, Khu phố ẩm thực, Café - Bar - Discotheque...</span></p>

<p style="margin-left:4.5pt; text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong>NGÀY 2:ĐÀ NẴNG – NGŨ HÀNH SƠN -&nbsp; ĐÔ THỊ CỔ HỘI AN (ĂN: SÁNG, TRƯA, CHIỀU)</strong></span></span></p>

<p style="margin-left:4.5pt; text-align:justify"><span style="font-size:12px">Sáng: Quý khách dùng điểm tâm. Khởi hành tham quan khu di tích – danh thắng Ngũ Hành Sơn (khám phá các hang động, vãn cảnh đẹp non nước trời mây, viếng những ngôi chùa thiêng), Làng Nghề Điêu Khắc Đá&nbsp; Non Nước. Tiếp tục vào Hội An nhận phòng KS nghỉ ngơi.&nbsp;</span></p>

<p style="margin-left:4.5pt; text-align:justify"><span style="font-size:12px">Trưa: Ăn trưa nhà hàng tại Hội An</span></p>

<p style="margin-left:4.5pt; text-align:justify"><span style="font-size:12px">Chiều: Bách bộ tham quan và mua sắm Phố Cổ với: Chùa Cầu Nhật Bản, Bảo tàng văn hóa Sa Huỳnh, Nhà Cổ hàng trăm năm tuổi, Hội Quán Phước Kiến &amp; Xưởng thủ công mỹ nghệ - thưởng thức ca nhạc truyền thống lúc 15h15.</span></p>

<p style="margin-left:4.5pt; text-align:justify"><span style="font-size:12px">Tối: Ăn tối nhà hàng, thưởng thức đặc sản Hội An (<em>Cao Lầu - Bánh Bao - Bánh Vạc - Hoành Thánh</em>). Tự do thưởng ngoạn vẻ đẹp Phố Cổ Hội An, rực rỡ soi bóng bên dòng sông Hoài, từng là thương cảng sầm uất của người Chăm thế kỉ thứ II và Việt Nam từ thế kỉ XVI.</span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong>NGÀY 3:HỘI AN - CỐ ĐÔ HUẾ (ĂN: SÁNG, TRƯA, CHIỀU)</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px">Sáng: Quý khách dùng điểm tâm. Rời Hội An đi Cố Đô Huế - <em>Di sản văn hoá Thế Giới</em>, ghé tham quan mua sắm tại Siêu Thị Đặc Sản Miền Trung, tiếp tục hành trình xuyên hầm đường bộ đèo Hải vân, dừng chân chụp ảnh làng Chài Lăng Cô.</span></p>

<p style="text-align:justify"><span style="font-size:12px">Trưa: Ăn trưa nhà hàng và nhận phòng K/sạn nghỉ ngơi.</span></p>

<p style="text-align:justify"><span style="font-size:12px">Chiều: Tham quan Đại Nội (Hoàng Cung của 13 vị vua triều Nguyễn, triều đại phong kiến cuối cùng của Việt Nam: Ngọ Môn, Điện Thái Hoà, Tử Cấm Thành, Thế Miếu, Hiển Lâm Các, Cửu Đỉnh) và Chùa Thiên Mụ cổ kính, xây dựng từ những năm đầu của thế kỉ XVII.</span></p>

<p style="text-align:justify"><span style="font-size:12px">Tối: Ăn tối nhà hàng với đặc sản xứ Huế (Bánh bèo, lọc, nậm, khoái,...). Ngồi thuyền Rồng nghe CA HUẾ và thả hoa đăng cầu may trên dòng Hương thơ mộng.</span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong>NGÀY 4: HUẾ (ĂN: SÁNG', N'4 Ngày 3 Đêm', 19, 50, N'Ðà N?ng', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (61, N'Miền Tây sông nước', N'<p style="text-align:center"><span style="color:#ff0000"><span style="font-size:18px"><strong><span style="background-color:#ffff00">TIỀN GIANG - KIÊN GIANG - CÀ MAU - SÓC TRĂNG - CẦN THƠ</span></strong></span></span></p>

<p style="text-align:justify"><span style="font-size:14px"><span style="color:#ff0000"><u><em><strong>T</strong></em></u></span>our du lịch miền Tây 4 ngày 3 đêm đưa du khách đến với miền Tây sông nước, tham quan các điểm đến Tiền Giang - Kiên Giang - Cà Mau - Sóc Trăng - Cần Thơ.</span></p>

<h2 style="text-align:justify"><strong><u>NGÀY 1:</u> SÀI GÒN - LONG AN - TIỀN GIANG - VĨNH LONG - KIÊN GIANG (267 km)<em>(Ăn 3 bữa)</em></strong></h2>

<ol style="list-style-type:lower-roman">
	<li>
	<p style="text-align:justify"><span style="font-size:14px"><strong><em>Buổi sáng</em></strong>, xe khởi hành từ Cung Văn hóa Lao động TP.Hồ Chí Minh, đưa Quý khách đi theo đường<strong><em> cao tốc TP.Hồ Chí Minh – Trung Lương</em></strong>, tới Mỹ Tho dùng điểm tâm sáng. Đoàn đi qua vài khu phố thị, tham quan một thoáng thành phố đã có thời rất phồn vinh với tên <strong><em>“Mỹ Tho Đại Phố”.</em></strong></span></p>
	</li>
	<li>
	<p style="text-align:justify"><span style="font-size:14px">Tới bến tàu du lịch, Quý khách ngồi tàu<strong><em> vượt sông Tiền</em></strong>, thưởng ngoạn phong cảnh xanh tươi của cây trái, trên các <strong><em>cù lao Long, Lân, Quy, Phụng.</em></strong></span></p>
	</li>
</ol>

<p style="text-align:center">&nbsp;</p>

<ol style="list-style-type:lower-roman">
	<li>
	<p style="text-align:justify"><span style="font-size:14px">Tàu dừng <strong><em>Cồn Lân</em></strong> (cù lao Thới Sơn), đoàn tham quan cơ sở nuôi ong lấy mật, lò làm kẹo dừa; Quý khách <strong><em>thưởng thức các loại trái cây theo mùa</em></strong>, <strong><em>uống trà tắc pha mật ong nguyên chất</em></strong> tại nhà vườn, giao lưu đờn ca tài tử cải lương Nam Bộ, <strong><em>đi xuồng chèo</em></strong> trong các con rạch nhỏ, khám phá cuộc sống nơi sông nước miệt vườn.</span></p>
	</li>
	<li>
	<p style="text-align:justify"><span style="font-size:14px">Tàu tiếp tục đưa đoàn đi qua <strong><em>Cồn Phụng</em></strong> thăm <strong><em>di tích&nbsp; ông Đạo Dừa</em></strong>. Sau bữa cơm trưa, Quý khách lên xe ngựa đi qua những đường quê xanh mát bóng dừa, thưởng ngoạn <strong><em>phong cảnh Bến Tre</em></strong>.</span></p>
	</li>
</ol>

<p style="text-align:center">&nbsp;</p>

<ol style="list-style-type:lower-roman">
	<li>
	<p style="text-align:justify"><span style="font-size:14px"><strong><em>Buổi chiều, </em></strong>đến thành phố <strong><em>Rạch Giá, </em></strong>xe đưa đoàn<strong><em> đi dạo một vòng quanh phố thị trung tâm Rạch Giá,</em></strong> ngang qua<strong><em> khu lấn biển</em></strong> thoáng đãng, sạch đẹp, đông đúc và náo nhiệt về đêm với nhiều quán cà phê, nhiều nhà hàng và dịch vụ vui chơi giải trí khác<strong><em>. </em></strong>Quý khách nhận phòng và dùng cơm tối.</span></p>
	</li>
	<li>
	<p style="text-align:justify"><span style="font-size:14px"><strong><em>Buổi tối,</em></strong> Quý khách tự do dạo phố. Nghỉ đêm tại Rạch Giá<strong><em>.</em></strong></span></p>
	</li>
</ol>

<h2 style="text-align:justify"><strong><u>NGÀY 2:</u> RẠCH GIÁ - CÀ MAU - ĐẤT MŨI (250 km)<em>(Ăn 3 bữa)</em></strong></h2>

<ol style="list-style-type:lower-roman">
	<li>
	<p style="text-align:justify"><span style="font-size:14px"><strong><em>Buổi sáng</em></strong>, Quý khách dùng điểm tâm, trả phòng. Đoàn đi Rạch Sỏi, qua <strong><em>cầu Cái Bé – cầu Cái Lớn</em></strong>, về <strong><em>Miệt Thứ</em></strong>., theo đường <strong><em>Hành lang ven biển phía Nam</em></strong> tới thành phố <strong><em>Cà Mau</em></strong> .</span></p>
	</li>
	<li>
	<p style="text-align:justify"><span style="font-size:14px">Đoàn tiếp tục khởi hành đi <strong><em>Năm Căn</em></strong>, Quý khách được chinh phục những cây số cuối cùng của <strong><em>con đường thiên lý Bắc - Nam.</em></strong></span></p>
	</', N'4 Ngày 3 Đêm', 20, 50, N'TP HCM', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (62, N'Châu Đốc - Hà Tiên', N'<p style="text-align:justify"><span style="font-size:12px"><span style="color:#005baa"><strong><em><u>Ngày 1</u></em></strong><strong><em>: Tp.Hồ Chí Minh - Hà Tiên</em></strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px">Xe Cty DV Du Lịch Chợ Lớn đón quý khách và khởi hành đi <strong><em><u>Hà Tiên</u></em></strong> . Quý khách dùng điểm tâm tại Trung Lương. Đoàn tiếp tục đi Hà Tiên trên&nbsp; đường đi ghé&nbsp; tham quan&nbsp; <strong><em><u>Cầu Mỹ Thuận</u></em></strong> – một công trình của thế kỷ đối với người dân Đồng Bằng Sông Cửu Long. Xe qua phà Vàm Cống, đến&nbsp; Long Xuyên quý khách dùng cơm trưa. Chiều đến&nbsp; Hà Tiên. Quý khách nhận phòng -&nbsp; nghỉ ngơi, dùng cơm chiều. Tối dạo phố&nbsp; Hà Tiên.</span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong><em><u>Ngày 2</u></em></strong><strong>: <em>Tham quan Hà Tiên</em></strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px">Quý khách dùng điểm tâm, đoàn khởi hành tham quan: <strong><em>C<u>hùa Tam Bảo,</u> <u>Lăng Mạc Cửu</u>, <u>Thạch Động</u>, <u>chùa Phù Dung</u></em></strong>, tắm biển tại bãi biển <strong><em><u>Mũi Nai</u></em></strong>. Quý khách dùng cơm trưa. Chiều khởi hành đi&nbsp; <strong><em><u>Hòn Chông</u></em></strong>, tham quan&nbsp; <strong><em><u>Chùa Hang</u></em></strong>, <strong><em><u>Hòn Phụ Tử , tắm biển</u> . </em></strong>Quý Khách dùng cơm chiều . Tối sinh họat tự do.</span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong><em><u>Ngày 3</u></em></strong><strong>: <em>Hà Tiên – Châu Đốc – Tp. HCM </em></strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px">Qúy Khách dùng điểm tâm sáng, khởi hành về Châu Đốc, tham quan <strong><em><u>Chùa Bà Chúa Xứ</u></em></strong>, <strong><em><u>Lăng Thọai Ngọc Hầu</u></em></strong>, <strong><em><u>Chùa Thầy&nbsp; Tây An</u></em></strong>,&nbsp; sau đó dùng cơm trưa tại tại Châu Đốc. Chiều quý khách ghé chợ Châu Đốc mua đặc sản. Khởi hành về Tp. HCM .</span></p>

<p style="text-align:justify"><span style="font-size:12px">Đến Tp. HCM chia tay, kết thúc chuyến tham quan. Hẹn gặp lại <strong><em><u>trên những nẽo đường khác của Quê Hương Việt Nam.</u></em></strong></span></p>
', N'3 Ngày 3 Đêm', 20, 50, N'TP HCM', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (63, N'Cà Mau - Điểm cực Nam của Tổ quốc', N'<p style="text-align:justify"><span style="font-size:12px"><span style="color:#005baa"><strong><em><u>Ngày 1</u></em></strong><strong><em>: Tp.Hồ Chí Minh – Cà Mau</em></strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px">05&nbsp;:00 Xe Cty DV Du Lịch Chợ Lớn đón quý khách tại điểm hẹn và khởi hành đi <strong><em><u>Cà Mau</u></em></strong>. Dùng điểm tâm tại Trung&nbsp;Lương.&nbsp; Trên đường dừng chân tham quan <strong><em><u>cầu Mỹ Thuận</u></em></strong>. Dùng cơm trưa tại&nbsp; Cần Thơ.</span></p>

<p style="text-align:justify"><span style="font-size:12px">Chiều tiếp tục đi Cà Mau, ngắm <strong><em><u>chợ nổi Phụng Hiệp</u></em></strong>. Đến Cà Mau nhận phòng. 17h30 tham quan <strong><em><u>sân chim Cà Mau</u></em></strong>. Dùng cơm chiều.</span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong><em><u>Ngày 2</u></em></strong><strong><em>: Tham quan Cà Mau</em></strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px">Dùng điểm tâm. Khởi hành đi ca nô tham quan <strong><em><u>chợ nổi Cà Mau</u></em></strong>, <strong><em><u>khu bảo tồn đa dạng sinh học</u></em></strong> – <strong><em><u>hệ sinh thái rừng ngập mặn</u></em></strong> – <strong><em><u>vuông tôm</u></em></strong>, tham quan <strong><em><u>Làng Rừng Kháng Chiến</u></em></strong>. Tiếp tục đi Mũi Cà Mau, tham quan và chụp ảnh lưu niệm tại <strong><em><u>Khu Văn Hóa Du Lịch Mũi Cà Mau</u></em></strong> – điểm cực Nam Tổ quốc, nơi hàng năm được phù sa lấn biển từ 80 đến 100 m. Dùng cơm trưa tại <strong><em>nhà hàng Đất Mũi</em></strong> với các món ăn Nam Bộ.</span></p>

<p style="text-align:justify"><span style="font-size:12px">Chiều trở về <strong><em><u>thị trấn Năm Căn</u></em></strong> – thị trấn Cực Nam, giàu có nguồn tài nguyên thủy hải sản, tham quan <strong><em><u>tượng đài Phan Ngọc Hiển</u></em></strong>, <strong><em><u>chợ Năm Căn</u></em></strong>. Chiều trở về Cà Mau, dùng cơm chiều. Tối tự do.</span></p>

<p style="text-align:justify"><span style="color:#005baa"><span style="font-size:12px"><strong><em><u>Ngày 3</u></em></strong><strong><em>: Cà Mau – Tp.HCM</em></strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px">Dùng điểm tâm, làm thủ tục trả phòng. Khởi hành về Tp.HCM. đến Sóc Trăng tham quan <strong><em><u>chùa Dơi</u></em></strong>, <strong><em><u>chùa Đất Sét</u></em></strong>.&nbsp; Đến Cần Thơ tham quan <strong><em><u>nhà cổ Bình Thủy</u></em></strong>. Dùng cơm trưa tại Cần Thơ.</span></p>

<p style="text-align:justify"><span style="font-size:12px">Chiều về đến Tp.HCM, xe đưa đoàn về điểm hẹn, kết thúc chuyến tham quan.</span></p>
', N'3 Ngày 2 Đêm', 20, 50, N'TP HCM', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tblTour] OFF
SET IDENTITY_INSERT [dbo].[tblTrangThaiDonDatTour] ON 

INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (77, 0, N'', 113, 15, CAST(0x0000AB8201631A98 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (78, 1, N'', 113, 15, CAST(0x0000AB8201634DE7 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (79, 0, N'', 114, 15, CAST(0x0000AB820166AF5E AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (80, 1, N'', 114, 15, CAST(0x0000AB820166E9ED AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (81, 3, N'', 113, 24, CAST(0x0000AB820167EB34 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (82, 1, N'', 113, 24, CAST(0x0000AB820169B92C AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (83, 2, N'huy tour', 114, 24, CAST(0x0000AB82016A33AC AS DateTime))
SET IDENTITY_INSERT [dbo].[tblTrangThaiDonDatTour] OFF
ALTER TABLE [dbo].[tblNhomVeGia] ADD  DEFAULT ((0)) FOR [iGiaVeGiam]
GO
ALTER TABLE [dbo].[tblThoiGianKhoiHanh] ADD  DEFAULT ((1)) FOR [trangThai]
GO
ALTER TABLE [dbo].[tblTour] ADD  DEFAULT ((1)) FOR [bTrangThai]
GO
ALTER TABLE [dbo].[tblChiTietDonDatTour]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonDatTour_DonDatTour] FOREIGN KEY([iMaDonDatTour])
REFERENCES [dbo].[tblDonDatTour] ([iMaDonDatTour])
GO
ALTER TABLE [dbo].[tblChiTietDonDatTour] CHECK CONSTRAINT [FK_ChiTietDonDatTour_DonDatTour]
GO
ALTER TABLE [dbo].[tblChiTietDonDatTour]  WITH CHECK ADD  CONSTRAINT [FK_nhomve_hoadonct] FOREIGN KEY([iMaNhomVe])
REFERENCES [dbo].[tblNhomVe] ([iMaNhomVe])
GO
ALTER TABLE [dbo].[tblChiTietDonDatTour] CHECK CONSTRAINT [FK_nhomve_hoadonct]
GO
ALTER TABLE [dbo].[tblDanhGia]  WITH CHECK ADD  CONSTRAINT [FK_DonTour_BinhLuan] FOREIGN KEY([iMaDonDatTour])
REFERENCES [dbo].[tblDonDatTour] ([iMaDonDatTour])
GO
ALTER TABLE [dbo].[tblDanhGia] CHECK CONSTRAINT [FK_DonTour_BinhLuan]
GO
ALTER TABLE [dbo].[tblDanhGia]  WITH CHECK ADD  CONSTRAINT [FK_DonTour_BinhLuant] FOREIGN KEY([iMaDonDatTour])
REFERENCES [dbo].[tblDonDatTour] ([iMaDonDatTour])
GO
ALTER TABLE [dbo].[tblDanhGia] CHECK CONSTRAINT [FK_DonTour_BinhLuant]
GO
ALTER TABLE [dbo].[tblDonDatTour]  WITH CHECK ADD  CONSTRAINT [FK_KhachHang_DonDatTour] FOREIGN KEY([iMaKhachHang])
REFERENCES [dbo].[tblKhachHang] ([iMaKhachHang])
GO
ALTER TABLE [dbo].[tblDonDatTour] CHECK CONSTRAINT [FK_KhachHang_DonDatTour]
GO
ALTER TABLE [dbo].[tblDonDatTour]  WITH CHECK ADD  CONSTRAINT [FK_Tour_DonDatTour] FOREIGN KEY([iMaTour])
REFERENCES [dbo].[tblTour] ([iMaTour])
GO
ALTER TABLE [dbo].[tblDonDatTour] CHECK CONSTRAINT [FK_Tour_DonDatTour]
GO
ALTER TABLE [dbo].[tblGiaoDich]  WITH CHECK ADD  CONSTRAINT [FK_giaoDich_NhanVien] FOREIGN KEY([imaNhanVien])
REFERENCES [dbo].[tblNhanVien] ([iMaNhanVien])
GO
ALTER TABLE [dbo].[tblGiaoDich] CHECK CONSTRAINT [FK_giaoDich_NhanVien]
GO
ALTER TABLE [dbo].[tblhinhanh]  WITH CHECK ADD  CONSTRAINT [FK_tour_hinhanh] FOREIGN KEY([iMaTour])
REFERENCES [dbo].[tblTour] ([iMaTour])
GO
ALTER TABLE [dbo].[tblhinhanh] CHECK CONSTRAINT [FK_tour_hinhanh]
GO
ALTER TABLE [dbo].[tblNhanVien]  WITH CHECK ADD  CONSTRAINT [FK_nhanVien_Quyen] FOREIGN KEY([iMaQuyen])
REFERENCES [dbo].[tblQuyen] ([iMaQuyen])
GO
ALTER TABLE [dbo].[tblNhanVien] CHECK CONSTRAINT [FK_nhanVien_Quyen]
GO
ALTER TABLE [dbo].[tblNhomVeGia]  WITH CHECK ADD  CONSTRAINT [FK_nhomve_gia] FOREIGN KEY([iMaNhomVe])
REFERENCES [dbo].[tblNhomVe] ([iMaNhomVe])
GO
ALTER TABLE [dbo].[tblNhomVeGia] CHECK CONSTRAINT [FK_nhomve_gia]
GO
ALTER TABLE [dbo].[tblThoiGianKhoiHanh]  WITH CHECK ADD  CONSTRAINT [FK_tour_tgian] FOREIGN KEY([iMaTour])
REFERENCES [dbo].[tblTour] ([iMaTour])
GO
ALTER TABLE [dbo].[tblThoiGianKhoiHanh] CHECK CONSTRAINT [FK_tour_tgian]
GO
ALTER TABLE [dbo].[tblTour]  WITH CHECK ADD  CONSTRAINT [FK_Tour_NhanVien] FOREIGN KEY([iMaNhanVien])
REFERENCES [dbo].[tblNhanVien] ([iMaNhanVien])
GO
ALTER TABLE [dbo].[tblTour] CHECK CONSTRAINT [FK_Tour_NhanVien]
GO
ALTER TABLE [dbo].[tblTour]  WITH CHECK ADD  CONSTRAINT [FK_Tour_nhomTour] FOREIGN KEY([iMaNhomTour])
REFERENCES [dbo].[tblNhomTour] ([iMaNhomTour])
GO
ALTER TABLE [dbo].[tblTour] CHECK CONSTRAINT [FK_Tour_nhomTour]
GO
ALTER TABLE [dbo].[tblTrangThaiDonDatTour]  WITH CHECK ADD  CONSTRAINT [FK_trangThai_DonDat] FOREIGN KEY([iMaDon])
REFERENCES [dbo].[tblDonDatTour] ([iMaDonDatTour])
GO
ALTER TABLE [dbo].[tblTrangThaiDonDatTour] CHECK CONSTRAINT [FK_trangThai_DonDat]
GO
