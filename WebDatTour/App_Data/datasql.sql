USE [webDatTour]
GO
/****** Object:  StoredProcedure [dbo].[binhLuan]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[capNhapKhachHang]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[capNhatTrangThaiBinhLuan]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[capNhatTrangThaiTour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[donDatTour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[donDatTour_]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[khachHangHuyTour]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[khachHangHuyTour]
@id int
as
update tblDonDatTour set itrangthai = 2 where iMaDonDatTour = @id
GO
/****** Object:  StoredProcedure [dbo].[kiemTraQuyenBinhLuan]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[layBinhLuan]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[layDanhSachDonDatTour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[layDanhSachDonDatTourByIDkh]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[layDanhSachDonDatTourByIDkh]
@id int
as
 select b3.itrangthai,b1.doanhthu , b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, 
b1.sTenKhachHang, b1.iMaKhachHang ,  b1.dNgayDatTour , b1.sghichu , b1.stieude
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.dNgayDatTour, b.sghichu,
 e.stieude ,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e --, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour and d.iMaKhachHang = @id
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang, b.dNgayDatTour, b.sghichu,e.stieude) b1 join
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
/****** Object:  StoredProcedure [dbo].[nhanVienthanhToan]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHang]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_capNhatTrangThaiDonHang] 
@madon int,
@thoigian datetime,
@ghichu nvarchar(100),
@trangThai int
as
insert into tblTrangThaiDonDatTour (iMaDon,dthoigian,iTrangThai,sghichu,imanhanvien) values
(@madon, @thoigian, @trangThai,@ghichu,15)
GO
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHangKH]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHangNV]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_dangki]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_danhSachNhanVien]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_danhSachNhanVien]
as
select * from tblNhanVien;
GO
/****** Object:  StoredProcedure [dbo].[sp_danhSachTour]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_danhSachTour]
as
select * from tblTour;
GO
/****** Object:  StoredProcedure [dbo].[sp_doiMatKhauKH]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_dsnhomtourbyid]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_dsnhomtourbyid]
@id int
as
select top 6 a.iMaTour,a.sTieuDe,d.dngaykhoihanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,a.sUrlAnh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
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

GO
/****** Object:  StoredProcedure [dbo].[sp_dsThoiGianKhoiHanh]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_dsThoiGianKhoiHanh]
@id int
as
select * from tblThoiGianKhoiHanh where iMaTour = @id order by dThoiGian DESC
GO
/****** Object:  StoredProcedure [dbo].[sp_dstour1]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[sp_dstour1]
as
select a.iMaTour,a.sTieuDe,d.dNgayKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,a.sUrlAnh , b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour) as a
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
GO
/****** Object:  StoredProcedure [dbo].[sp_dstournhom1]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_layChoChoCon]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_login_kh]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_login_kh_id]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_login_nv]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_soCho_Tour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_themGiave]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_themThoiGianKhoiHanh]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_themtour]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE proc [dbo].[sp_themtour]
@tieude nvarchar(250),
@mota nvarchar(4000),
@urlanh varchar(300),
@thoigian nvarchar(20),
@nhomtour int,
@socho int,
@manv int,
@ngaytao date,
@imatour int out
as
insert into tblTour (iMaNhanVien,sTieuDe,sMoTa,sUrlAnh,sTongThoiGian,iMaNhomTour,iSoCho,dNgayTao)
OUTPUT INSERTED.iMaTour as id
values (@manv,@tieude,@mota,@urlanh,@thoigian,@nhomtour,@socho,@ngaytao) set @imatour = SCOPE_IDENTITY()
return @imatour;
GO
/****** Object:  StoredProcedure [dbo].[sp_thongkedoanhsotheotatcatour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_thongkedoanhsotheotour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_timKiemTour]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_timKiemTour]
@ten nvarchar(50)
as
select a.iMaTour,a.sTieuDe,d.dNgayKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,a.sUrlAnh , b.imatour, b.iGiaVe as igianl,
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

GO
/****** Object:  StoredProcedure [dbo].[sp_timsoCho_Tour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_tourTheoNhom]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE proc [dbo].[sp_tourTheoNhom]
@id int
as
select a.iMaTour,a.sTieuDe,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,a.sUrlAnh , b.imatour, b.iGiaVe as igianl,
 b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam , d.dThoiGian
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
 (select imatour, min(dthoigian) as dthoigian from tblThoiGianKhoiHanh where --iMaTour = 36 and 
 getdate() < dthoigian and trangThai = 1
 group by iMaTour) as d on d.iMaTour= a.iMaTour 
GO
/****** Object:  StoredProcedure [dbo].[sp_trangThaiThoiGianKH]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_trangThaiTour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_update]
as
update tbltour set isocho = 9 where imatour = 1
update tbltour set isocho = 3 where imatour = 3
GO
/****** Object:  StoredProcedure [dbo].[sp_updateGiaVe]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_updatetourID]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[sp_updatetourID]
@tieude nvarchar(250),
@mota nvarchar(900),
@urlanh varchar(1000),
@thoigian nvarchar(20),
@noikhoihanh nvarchar(60),
@nhomtour int,
@socho int,
@imatour int
as
update tblTour set stieude = @tieude, sMoTa = @mota, sTongThoiGian = @thoigian, sUrlAnh = @urlanh, iSoCho = @socho, iMaNhomTour = @nhomtour, snoikhoihanh = @noikhoihanh
where iMaTour = @imatour
GO
/****** Object:  StoredProcedure [dbo].[sp_xemTourId]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_xemTourId]
@idtour int
as
select a.iMaTour,a.sTieuDe,a.sNoiKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sMoTa,a.sTongThoiGian,a.sUrlAnh , a.imanhomtour,b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
from
(
select * from tblTour where tblTour.iMaTour = @idtour) as a
JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 1) as b
  ON b.imatour = a.imatour
  JOIN
(select * from tblNhomVeGia where tblNhomVeGia.iMaNhomVe = 2) as c
  ON c.imatour = a.iMaTour
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaKhachHang]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaKhachHang]
@id int 
as delete from tblKhachHang where imakhachhang = @id
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaNhanVien]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaNhanVien]
@id int 
as delete from tblnhanvien where imanhanvien =   @id
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaTour]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaTour]
@id int 
as delete from tblTour where imatour = @id
GO
/****** Object:  StoredProcedure [dbo].[suaBinhLuan]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[taoChiTietDonHang]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[taoDonHang]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[tesst]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themGiaoDich]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themNhanVien]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themNhanVien1]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themThoiGianKhoiHanh]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[themThoiGianKhoiHanh]
 @imatour int,
 @thoigian date,
@hanDat date
 as
 insert into tblThoiGianKhoiHanh(iMaTour,dThoiGian,dHanDatTour) 
 values (@imatour, @thoigian,@hanDat )
GO
/****** Object:  StoredProcedure [dbo].[thongKeDoanhThuTheoNgay]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[thongKeDoanhThuTheoNgay_danhSach]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[timDonDatTour_]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[timDonDatTourKH]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[tourhot]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[tourhotThang]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[tourhotThang]
as
DECLARE @ngay date
set @ngay = (SELECT DATEADD(DAY, -30, getdate()))
select top 8 a1.sTongThoiGian,a2.thoiGianDI, a1.iMaTour, a1.sTieuDe,a1.sNoiKhoiHanh,a1.sUrlAnh, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
 from
(select top 8 SUM(b.soLuongVe) as soLuong, c.sTieuDe , c.iMaTour ,c.sTongThoiGian, c.sUrlAnh, c.sNoiKhoiHanh
from tbldondattour a, tblChiTietDonDatTour b , tblTour c
where a.iMaDonDatTour = b.iMaDonDatTour and a.imatour = c.iMaTour and a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1)
and a.iMaDonDatTour not in (select iMaDon from tblTrangThaiDonDatTour where iMaTrangThai = 3 or iMaTrangThai = 2)
and c.bTrangThai = 1 and a.dNgayDatTour >= @ngay
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
/****** Object:  StoredProcedure [dbo].[tourhotTuan]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[tourhotTuan]--7ngay
as
DECLARE @ngay date
set @ngay = (SELECT DATEADD(DAY, -7, getdate()))
select top 8 a1.sTongThoiGian,a2.thoiGianDI, a1.iMaTour, a1.sTieuDe,a1.sNoiKhoiHanh,a1.sUrlAnh, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
 from
(select top 8 SUM(b.soLuongVe) as soLuong, c.sTieuDe , c.iMaTour ,c.sTongThoiGian, c.sUrlAnh, c.sNoiKhoiHanh
from tbldondattour a, tblChiTietDonDatTour b , tblTour c
where a.iMaDonDatTour = b.iMaDonDatTour and a.imatour = c.iMaTour and a.iMaDonDatTour in (select iMaDonTour from tblGiaoDich where trangThai = 1)
and a.iMaDonDatTour not in (select iMaDon from tblTrangThaiDonDatTour where iMaTrangThai = 3 or iMaTrangThai = 2)
and c.bTrangThai = 1 and a.dNgayDatTour >= @ngay
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
/****** Object:  StoredProcedure [dbo].[toutMoiNhat]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[toutMoiNhat] 
as 
select top 8 a.sTongThoiGian,a1.thoiGianDI,a.dNgayTao, a.iMaTour, a.sTieuDe,sNoiKhoiHanh,a.sUrlAnh, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
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
 order by a.dNgayTao DESC
GO
/****** Object:  StoredProcedure [dbo].[updateNhanVien]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updateTrangThaiGiaoDich]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[xemDonDatTour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour and e.imatour = g.imatour
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
/****** Object:  StoredProcedure [dbo].[xemgiaodich]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  StoredProcedure [dbo].[xemKhachHangID]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[xemKhachHangID]
@id int
as
select * from tblKhachHang where iMaKhachHang = @id
GO
/****** Object:  StoredProcedure [dbo].[xemTrangThaiNV]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  Table [dbo].[tblBinhLuan]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBinhLuan](
	[iMaBinhLuan] [int] IDENTITY(1,1) NOT NULL,
	[iMaKhachHang] [int] NOT NULL,
	[iMaTour] [int] NOT NULL,
	[dThoiGian] [datetime] NULL,
	[sNoiDung] [nvarchar](150) NULL,
	[itrangthai] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaBinhLuan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblChiTietDonDatTour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  Table [dbo].[tblDonDatTour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  Table [dbo].[tblGiaoDich]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  Table [dbo].[tblKhachHang]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  Table [dbo].[tblNhanVien]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  Table [dbo].[tblNhomTour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  Table [dbo].[tblNhomVe]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  Table [dbo].[tblNhomVeGia]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  Table [dbo].[tblQuyen]    Script Date: 3/3/2020 5:46:31 PM ******/
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
/****** Object:  Table [dbo].[tblThoiGianKhoiHanh]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThoiGianKhoiHanh](
	[iMaThoiGian] [int] IDENTITY(1,1) NOT NULL,
	[iMaTour] [int] NOT NULL,
	[dThoiGian] [date] NOT NULL,
	[trangThai] [bit] NULL,
	[dHanDatTour] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaThoiGian] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTour]    Script Date: 3/3/2020 5:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTour](
	[iMaTour] [int] IDENTITY(1,1) NOT NULL,
	[sTieuDe] [nvarchar](250) NULL,
	[sMoTa] [nvarchar](max) NOT NULL,
	[sUrlAnh] [varchar](300) NOT NULL,
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTrangThaiDonDatTour]    Script Date: 3/3/2020 5:46:31 PM ******/
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
SET IDENTITY_INSERT [dbo].[tblBinhLuan] ON 

INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (3, 4, 18, CAST(0x0000AB6000000000 AS DateTime), N'dasd', NULL)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (4, 4, 18, CAST(0x0000AB6000000000 AS DateTime), N'dasd', NULL)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (5, 4, 18, CAST(0x0000AB6000000000 AS DateTime), N'huy dz', NULL)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (6, 4, 18, CAST(0x0000AB6000000000 AS DateTime), N'asdsad', NULL)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (7, 4, 18, CAST(0x0000AB6000000000 AS DateTime), N'', NULL)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (8, 4, 18, CAST(0x0000AB6000000000 AS DateTime), N'dsdsfd', NULL)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (13, 7, 18, CAST(0x0000AB6900000000 AS DateTime), N'huy', 0)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (14, 7, 18, CAST(0x0000AB6900000000 AS DateTime), N'đá', 1)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (15, 7, 18, CAST(0x0000AB6900000000 AS DateTime), N'huy', 1)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (16, 7, 18, CAST(0x0000AB6900000000 AS DateTime), N'huydz', 1)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (17, 7, 18, CAST(0x0000AB6900000000 AS DateTime), N'huy1', 0)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (18, 7, 18, CAST(0x0000AB69012D761D AS DateTime), N'Toi khong quan tam ok', 0)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (19, 7, 18, CAST(0x0000AB69012DB5C4 AS DateTime), N'hihii787', 1)
INSERT [dbo].[tblBinhLuan] ([iMaBinhLuan], [iMaKhachHang], [iMaTour], [dThoiGian], [sNoiDung], [itrangthai]) VALUES (20, 7, 18, CAST(0x0000AB7001100506 AS DateTime), N'huy dep zai', 0)
SET IDENTITY_INSERT [dbo].[tblBinhLuan] OFF
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (65, 1, 10)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (66, 1, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (67, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (68, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (69, 1, 50000)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (70, 1, 3556)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (71, 1, 4001)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (72, 1, 3001)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (73, 1, 1001)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (74, 1, 10101)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (75, 1, 10101)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (76, 1, 2001)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (77, 1, 101)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (78, 1, 101)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (79, 1, 3000)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (80, 1, 7000)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (81, 1, 401)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (82, 1, 2001)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (83, 1, 3)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (84, 1, 222)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (85, 1, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (86, 1, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (87, 1, 28)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (88, 1, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (89, 1, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (90, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (91, 1, 24)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (92, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (93, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (94, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (95, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (96, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (65, 2, 15)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (66, 2, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (67, 2, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (68, 2, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (69, 2, 4)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (70, 2, 3)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (71, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (72, 2, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (73, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (74, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (75, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (76, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (77, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (78, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (79, 2, 7)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (80, 2, 13)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (81, 2, 4)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (82, 2, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (83, 2, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (84, 2, 6)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (85, 2, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (86, 2, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (87, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (88, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (89, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (90, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (91, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (92, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (93, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (94, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (95, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (96, 2, 0)
SET IDENTITY_INSERT [dbo].[tblDonDatTour] ON 

INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (57, 29, 1, CAST(0x0000AB5500000000 AS DateTime), N'asdd', 1)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (65, 18, 1, CAST(0x0000AB6200000000 AS DateTime), N'', 1)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (66, 41, 7, CAST(0x0000AB6300000000 AS DateTime), N'', 20)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (67, 41, 7, CAST(0x0000AB6300000000 AS DateTime), N'', 20)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (68, 41, 1, CAST(0x0000AB6300000000 AS DateTime), N'', 19)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (69, 18, 1, CAST(0x0000AB690001325A AS DateTime), N'ád', 10)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (70, 18, 7, CAST(0x0000AB690009B545 AS DateTime), N'', 123)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (71, 19, 1, CAST(0x0000AB6900F20C93 AS DateTime), N'đá', 115)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (72, 18, 1, CAST(0x0000AB690106CEFF AS DateTime), N'ádsad', 123)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (73, 19, 1, CAST(0x0000AB69010DBF48 AS DateTime), N'', 106)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (74, 19, 1, CAST(0x0000AB6D0117B4F2 AS DateTime), N'đấ', 60)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (75, 19, 1, CAST(0x0000AB6D0117CA72 AS DateTime), N'đấ', 60)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (76, 19, 1, CAST(0x0000AB6D013373B2 AS DateTime), N'áda', 60)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (77, 29, 1, CAST(0x0000AB6A0133B9E9 AS DateTime), N'', 9)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (78, 29, 1, CAST(0x0000AB6B0133E3E2 AS DateTime), N'', 9)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (79, 20, 1, CAST(0x0000AB6E0103D0ED AS DateTime), N'dsads', 108)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (80, 18, 1, CAST(0x0000AB6F0128B12B AS DateTime), N'k co tien dau', 114)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (81, 18, 1, CAST(0x0000AB6F0129F4A4 AS DateTime), N'ok', 66)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (82, 18, 1, CAST(0x0000AB6F012A3477 AS DateTime), N'okk', 123)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (83, 43, 1, CAST(0x0000AB6F016C518B AS DateTime), N'sdas', 131)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (84, 18, 1, CAST(0x0000AB7001164510 AS DateTime), N'', 14)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (85, 43, 1, CAST(0x0000AB71000DF62A AS DateTime), N'xsdsa', 131)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (86, 43, 1, CAST(0x0000AB72000CB542 AS DateTime), N'sddas', 131)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (87, 43, 1, CAST(0x0000AB72000CBF4E AS DateTime), N'dasdas', 131)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (88, 43, 1, CAST(0x0000AB7200111503 AS DateTime), N'', 130)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (89, 43, 1, CAST(0x0000AB720016EAD2 AS DateTime), N'', 131)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (90, 43, 1, CAST(0x0000AB7200174437 AS DateTime), N'dasda', 131)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (91, 43, 1, CAST(0x0000AB7200175B0A AS DateTime), N'sdas', 131)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (92, 43, 1, CAST(0x0000AB7200188B04 AS DateTime), N'', 131)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (93, 43, 1, CAST(0x0000AB720019FB1F AS DateTime), N'', 131)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (94, 43, 1, CAST(0x0000AB72001A8045 AS DateTime), N'', 131)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (95, 43, 1, CAST(0x0000AB72001AD0E3 AS DateTime), N'', 131)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (96, 43, 1, CAST(0x0000AB72001B4188 AS DateTime), N'', 131)
SET IDENTITY_INSERT [dbo].[tblDonDatTour] OFF
SET IDENTITY_INSERT [dbo].[tblGiaoDich] ON 

INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (1, 41, 33033, 2, 2, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (2, 42, 33033, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (3, 43, 660033, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (4, 44, 660033, 13230006, 1, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (5, 45, 66033, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (6, 46, 66033, 13230291, 1, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (7, 47, 180023, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (8, 48, 180023, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (9, 49, 120012, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (10, 50, 120012, 13231468, 1, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (11, 51, 60006, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (12, 52, 60006, 13231472, 1, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (13, 53, 15003, 13231476, 1, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (14, 54, 9600, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (15, 55, 19201, 13231481, 1, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (16, 55, 12000, 122112, 1, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (17, 65, 13233, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (18, 66, 600000, 13231625, 1, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (19, 67, 600000, 13231628, 1, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (20, 68, 1200000, 13231629, 1, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (21, 66, 600000, 13232610, 1, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (22, 67, 600000, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (23, 67, 600000, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (24, 67, 600000, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (25, 53, 15003, NULL, 1, 2, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (26, 67, 600000, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (27, 67, 600000, NULL, 0, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (28, 55, 160811, NULL, 1, 2, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (29, 67, 600000, 0, 2, 1, NULL)
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (30, 69, 825066, 13241646, 1, 1, CAST(0x0000AB690001325A AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (31, 70, 117447, 13241649, 1, 1, CAST(0x0000AB690009B545 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (32, 67, 600000, NULL, 0, 1, CAST(0x0000AB690012BD48 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (33, 71, 128032, 13241753, 1, 1, CAST(0x0000AB6900F20C93 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (34, 72, 99066, 13241900, 1, 1, CAST(0x0000AB690106CEFF AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (35, 73, 32032, 13241928, 1, 1, CAST(0x0000AB69010DBF48 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (36, 74, 323232, NULL, 0, 1, CAST(0x0000AB6D0117B4F2 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (37, 75, 161616, 13247372, 1, 1, CAST(0x0000AB6D0117CA72 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (38, 76, 32016, 13247779, 1, 1, CAST(0x0000AB6D013373B2 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (39, 77, 6060, NULL, 1, 1, CAST(0x0000AB6D0133B9E9 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (40, 78, 30300, 13247786, 1, 1, CAST(0x0000AB6D0133E3E2 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (41, 79, 49542, 13249937, 1, 1, CAST(0x0000AB6E0103D0ED AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (42, 80, 0, NULL, 1, 1, CAST(0x0000AB6F0128B12B AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (43, 81, 0, NULL, 1, 1, CAST(0x0000AB6F0129F4A4 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (44, 82, 33033, 13253070, 1, 1, CAST(0x0000AB6F012A3477 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (45, 83, 19000, 13253741, 1, 1, CAST(0x0000AB6F016C518B AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (46, 81, 13365, NULL, 1, 2, CAST(0x0000AB6F01739210 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (47, 83, 19000, NULL, 1, 2, CAST(0x0000AB6F0173B988 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (48, 84, 0, NULL, 1, 1, CAST(0x0000AB7001164510 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (49, 85, 14000, 13255916, 1, 1, CAST(0x0000AB71000DF62A AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (50, 86, 0, NULL, 1, 1, CAST(0x0000AB72000CB542 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (51, 87, 140000, NULL, 0, 1, CAST(0x0000AB72000CBF4E AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (52, 88, 0, NULL, 1, 1, CAST(0x0000AB7200111503 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (53, 89, 0, NULL, 1, 1, CAST(0x0000AB720016EAD2 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (54, 90, 0, NULL, 1, 1, CAST(0x0000AB7200174437 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (55, 91, 0, NULL, 1, 1, CAST(0x0000AB7200175B0A AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (56, 92, 0, NULL, 1, 1, CAST(0x0000AB7200188B04 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (57, 93, 0, NULL, 1, 1, CAST(0x0000AB720019FB1F AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (58, 94, 0, NULL, 1, 1, CAST(0x0000AB72001A8045 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (59, 95, 0, NULL, 1, 1, CAST(0x0000AB72001AD0E3 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (60, 96, 0, NULL, 1, 1, CAST(0x0000AB72001B4188 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (61, 96, 10000, NULL, 1, 2, CAST(0x0000AB730001F137 AS DateTime))
SET IDENTITY_INSERT [dbo].[tblGiaoDich] OFF
SET IDENTITY_INSERT [dbo].[tblKhachHang] ON 

INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (1, N'adsad', NULL, N'adsad', N'adsad', N'adsad', N'adsad', N'6291F146521F9B2DB100BD16F019B931')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (2, N'asd', NULL, N'ds', N'das', N'asd', N'asd', N'asd')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (3, N'qe', CAST(0xC0400B00 AS Date), N'ewq', N'ueq', N'uq', N'qưe', N'uqe')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (4, N'aa', CAST(0xCE400B00 AS Date), N'aa', N'aaaaa', N'aa', N'aa', N'594F803B380A41396ED63DCA39503542')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (5, N'qưe', CAST(0xC0400B00 AS Date), N'aaa', N'342343', N'aaaa', N'qưe', N'C987ED9C20CC7D892442E6C5AA1BB72E')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (6, N'123', CAST(0xC1400B00 AS Date), N'123', N'123', N'123', N'123', N'202CB962AC59075B964B07152D234B70')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (7, N'Ngo Dang Huy', CAST(0xBA400B00 AS Date), N'1239', N'12345', N'123', N'huy', N'6291F146521F9B2DB100BD16F019B931')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (8, N'dasdsad', CAST(0xC7400B00 AS Date), N'dasda', N'dassd', N'sadas', N'aa', N'38E1C3108EBC24E58492592B56318AFA')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (9, N'asdasd', CAST(0xC2400B00 AS Date), N'asd', N'asd', N'asd', N'asdasd', N'196B0F14EBA66E10FBA74DBF9E99C22F')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (10, N'dasd', CAST(0xC7400B00 AS Date), N'asdas', N'dasd', N'dasd', N'dsad2', N'0DF01AE7DD51CEC48FED56952F40842B')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (11, N'dsa', CAST(0xC9400B00 AS Date), N'ád', N'sada', N'dsad', N'aaa3', N'8BCA6E3F27EB82EC660E1AEE492E45DD')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (12, N'ád', CAST(0xBA400B00 AS Date), N'ád', N'1', N'adsd', N'ads11', N'051B437123132B21B41C40B7CCF9C074')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (13, N'Ngo Dang Huy', CAST(0xB9400B00 AS Date), N'123', N'234342343', N'huyhuy@gmail.com', N'huy123', N'6291F146521F9B2DB100BD16F019B931')
SET IDENTITY_INSERT [dbo].[tblKhachHang] OFF
SET IDENTITY_INSERT [dbo].[tblNhanVien] ON 

INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (1, N'VN PAY', 1, CAST(0xAA400B00 AS Date), N'KHONG', N'KHONG', N'KHONG', N'', 3)
INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (2, N'aa', 1, CAST(0x14310B00 AS Date), N'aa', N'aa', N'huydz', N'123', 2)
INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (12, N'2312', 0, CAST(0xB6400B00 AS Date), N'wqewqewqe', N'13232', N'aa', N'aaaaa', 2)
INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (13, N'sad', 1, CAST(0x4A2B0B00 AS Date), N'das', N'312', N'aa', N'aaaaa', 2)
INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (15, N'  Khách Hàng', 1, CAST(0xB0400B00 AS Date), N'sdiachi', NULL, N'1232132132', N'123123', 3)
INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (17, N'HUYDZ', 1, CAST(0x49210B00 AS Date), N'hn', N'09999999', N'huydz123456', N'E10ADC3949BA59ABBE56E057F20F883E', 1)
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
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (1, 1, 2, 3)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (1, 2, 2, 3)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (18, 1, 6665656, 33)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (18, 2, 33, 33)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (19, 1, 32, 32)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (19, 2, 19, 32)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (20, 1, 33, 0)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (20, 2, 12, 0)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (25, 1, 1234566, 1234566)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (25, 2, 1234566, 1234566)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (29, 1, 600, 0)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (29, 2, 0, 50)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (43, 1, 15000, 10000)
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam]) VALUES (43, 2, 13000, 8000)
SET IDENTITY_INSERT [dbo].[tblQuyen] ON 

INSERT [dbo].[tblQuyen] ([iMaQuyen], [sTenQuyen]) VALUES (1, N'MemBer')
INSERT [dbo].[tblQuyen] ([iMaQuyen], [sTenQuyen]) VALUES (2, N'Admin')
INSERT [dbo].[tblQuyen] ([iMaQuyen], [sTenQuyen]) VALUES (3, N'PAY')
SET IDENTITY_INSERT [dbo].[tblQuyen] OFF
SET IDENTITY_INSERT [dbo].[tblThoiGianKhoiHanh] ON 

INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (9, 29, CAST(0x433F0B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (10, 18, CAST(0x433F0B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (11, 18, CAST(0x433F0B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (12, 18, CAST(0x433F0B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (13, 18, CAST(0x6C410B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (14, 18, CAST(0x6C410B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (15, 18, CAST(0x69410B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (16, 18, CAST(0x6B410B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (17, 18, CAST(0xBB400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (18, 18, CAST(0xCB400B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (19, 41, CAST(0xBF400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (20, 41, CAST(0xC0400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (26, 1, CAST(0xC8400B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (27, 1, CAST(0xB2400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (28, 1, CAST(0xB2400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (29, 18, CAST(0xCA400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (30, 18, CAST(0xB6400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (31, 18, CAST(0xBC400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (32, 18, CAST(0xBC400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (33, 18, CAST(0xB6400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (34, 18, CAST(0xAF400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (35, 18, CAST(0x9C400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (36, 18, CAST(0x9E400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (37, 18, CAST(0xBD400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (38, 1, CAST(0xC8400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (39, 18, CAST(0xB4400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (40, 18, CAST(0xAE400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (41, 18, CAST(0xB3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (42, 18, CAST(0xB2400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (43, 19, CAST(0xC7400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (44, 18, CAST(0xCA400B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (45, 18, CAST(0xB2400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (46, 19, CAST(0xC3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (47, 18, CAST(0xB9400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (48, 18, CAST(0xB4400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (49, 18, CAST(0xC1400B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (50, 18, CAST(0xB9400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (51, 18, CAST(0xB5400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (52, 18, CAST(0xBB400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (53, 18, CAST(0xBD400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (54, 18, CAST(0xC0400B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (55, 18, CAST(0xBC400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (56, 18, CAST(0xB7400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (57, 18, CAST(0xC8400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (58, 18, CAST(0xBA400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (59, 18, CAST(0xB6400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (60, 19, CAST(0xCA400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (61, 18, CAST(0xB3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (62, 18, CAST(0xC9400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (63, 18, CAST(0xC0400B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (64, 18, CAST(0xC0400B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (65, 18, CAST(0xB0400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (66, 18, CAST(0xC6400B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (67, 19, CAST(0xC0400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (68, 18, CAST(0xBF400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (69, 18, CAST(0xC0400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (70, 18, CAST(0xB3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (71, 18, CAST(0xB2400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (72, 18, CAST(0xB2400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (73, 18, CAST(0xBA400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (74, 18, CAST(0xBA400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (75, 18, CAST(0xC7400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (76, 18, CAST(0xB7400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (77, 18, CAST(0xC8400B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (78, 18, CAST(0xB1400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (79, 18, CAST(0xB1400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (80, 19, CAST(0xC5400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (81, 18, CAST(0xB2400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (82, 19, CAST(0xC8400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (83, 19, CAST(0xB9400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (84, 19, CAST(0xC1400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (85, 18, CAST(0xB3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (86, 18, CAST(0xC7400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (87, 18, CAST(0xC7400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (88, 18, CAST(0xB8400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (89, 18, CAST(0xB9400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (90, 18, CAST(0xB1400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (91, 18, CAST(0xB8400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (92, 18, CAST(0xB3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (93, 18, CAST(0xB8400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (94, 18, CAST(0xC3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (95, 19, CAST(0xB3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (96, 18, CAST(0xC0400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (97, 19, CAST(0xBC400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (98, 19, CAST(0xBD400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (99, 18, CAST(0xB6400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (100, 19, CAST(0xB3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (101, 19, CAST(0xC3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (102, 19, CAST(0xC0400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (103, 19, CAST(0xB8400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (104, 19, CAST(0xC7400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (105, 19, CAST(0xB0400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (106, 19, CAST(0xAD400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (107, 20, CAST(0xC0400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (108, 20, CAST(0xC8400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (109, 20, CAST(0xC7400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (110, 20, CAST(0xD2400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (111, 20, CAST(0xC9400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (112, 19, CAST(0xBC400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
GO
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (113, 18, CAST(0xD2400B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (114, 18, CAST(0xAC400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (115, 19, CAST(0xB3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (116, 18, CAST(0xAF400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (117, 18, CAST(0xBA400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (118, 18, CAST(0xBC400B00 AS Date), 0, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (119, 18, CAST(0xBA400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (120, 18, CAST(0xAE400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (121, 18, CAST(0xB4400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (122, 18, CAST(0xAE400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (123, 18, CAST(0xAE400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (124, 18, CAST(0xA5400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (125, 18, CAST(0xB3400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (128, 18, CAST(0x593E0B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (129, 43, CAST(0xBF400B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (130, 43, CAST(0x70410B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (131, 43, CAST(0x9C410B00 AS Date), 1, CAST(0xEE400B00 AS Date))
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai], [dHanDatTour]) VALUES (132, 18, CAST(0xD0400B00 AS Date), 1, CAST(0xD1400B00 AS Date))
SET IDENTITY_INSERT [dbo].[tblThoiGianKhoiHanh] OFF
SET IDENTITY_INSERT [dbo].[tblTour] ON 

INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sUrlAnh], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (1, N'dad', N'<p>2343</p>
', N'dasdsads', N'dasd', 18, 9, NULL, NULL, NULL, 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sUrlAnh], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (18, N'Tieu ded', N'<p>Đèo Hải Vân dài 20km, nằm ở giữa địa giới tỉnh Thừa Thiên Huế và thành phố Đà Nẵng. Với độ cao gần 500m so với mực nước biển, đèo Hải Vân nổi tiếng là đường đèo đẹp nhất và cũng hiểm trở nhất Việt Nam. Từ đỉnh đèo Hải Vân, những phong cảnh ấn tượng về dải vờ biển tuyệt đẹp của tổ quốc hiện ra. Đó là làng chài Lăng Cô đẹp như tranh vẽ, thành phố Đà Nẵng hiện đại bên bờ sông Hàn, đỉnh Sơn Trà quanh năm mây phủ, dải cát trắng phau của bãi biển Non Nước, những tảng đá chênh vênh của Ngũ Hành Sơn… Hiện nay dù đã có hầm đường bộ Hải Vân, nhiều du khách vẫn cất công vượt đường đèo trắc trở với núi cao, vực sâu để được tận mắt ngắm nhìn những cảnh đẹp như tranh vẽ ấy.</p>
', N'cau-song-Han-Da-Nang.jpg/ba-na-hill-ivivu.jpg/author.jpg/ba-na-hill-ivivu.jpg/Cat-Cat.jpg', N'3dsa', 18, 232, N'npoi khoi hanh', NULL, NULL, 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sUrlAnh], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (19, N'3123', N'<div class="content">
<div class="listDay">
<div class="day active">
<div class="titDay">
<p>&lt;div class="content"&gt;<br />
&lt;div class="listDay"&gt;<br />
&lt;div class="day active"&gt;<br />
&lt;div class="titDay"&gt;NGÀY 1 | HÀ NỘI - MỘC CHÂU (Ăn trưa, tối)&lt;/div&gt;</p>

<p>&lt;div class="contDay" style="display: block;"&gt;<br />
&lt;div class="the-content desc"&gt;<br />
&lt;p&gt;&amp;nbsp;&lt;/p&gt;</p>

<p>&lt;div style="text-align: justify;"&gt;&lt;strong&gt;06h30: &lt;/strong&gt;Xe và hướng dẫn viên đón Quý khách tại điểm hẹn. Xe dừng chân trên đường tại khu vực Xuân Mai để Quý khách tự do ăn sáng.&lt;br /&gt;<br />
&lt;strong&gt;10h30:&lt;/strong&gt; Dừng chân trên &lt;strong&gt;đèo Thung Khe&lt;/strong&gt; để chụp ảnh và ngắm cảnh rừng núi hùng vỹ của Hòa Bình.&lt;/div&gt;</p>

<p>&lt;p&gt;&amp;nbsp;&lt;/p&gt;</p>

<p>&lt;p&gt;&amp;nbsp;&lt;/p&gt;ssss', N'  ', N'3123', 18, 1313, NULL, NULL, NULL, 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sUrlAnh], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (20, N'33', N'<p>21212</p>
', N'4d06fda30454472551758157b65dc6dd.jpg/32cd2d0d0e913272f05437ab7d666558.jpg', N'12', 18, 12, NULL, NULL, NULL, 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sUrlAnh], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (29, N'234', N'<p>432</p>
', N'', N'423', 18, 4234, NULL, 1, CAST(0x0000AB5D00000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sUrlAnh], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (41, N'then tour', N'<p>400000 them tour</p>
', N'Cat-Cat.jpg/cau-song-Han-Da-Nang.jpg/deo-hai-van-ivivu-1.jpg', N'then tour', 18, 40, NULL, 1, CAST(0x0000AB6300000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sUrlAnh], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (43, N'tour mau ', N'<p>mo ta tour</p>
', N'ban-dao-son-tra-ivivu - Copy.jpg/bk - Copy.jpg/bk.jpg/Cat-Cat.jpg', N'5 Ngày 6 Đêm', 20, 35, NULL, 2, CAST(0x0000AB6F00000000 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tblTour] OFF
SET IDENTITY_INSERT [dbo].[tblTrangThaiDonDatTour] ON 

INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (1, 0, N'', 70, 15, CAST(0x0000AB690009B551 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (2, 3, N'', 70, 15, CAST(0x0000AB69000D87BF AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (3, 4, N'', 70, 15, CAST(0x0000AB69000DA68E AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (4, 1, N'', 70, 15, CAST(0x0000AB69000DE930 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (5, 3, N'', 70, 2, CAST(0x0000AB69000DFE61 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (6, 2, N'ghi chu khach hang', 66, 15, CAST(0x0000AB69000F0596 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (7, 2, N'', 66, 15, CAST(0x0000AB6900142B67 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (8, 2, N'', 66, 15, CAST(0x0000AB690014B21C AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (9, 2, N'123', 66, 15, CAST(0x0000AB6900150298 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (10, 0, N'', 71, 15, CAST(0x0000AB6900F20C9A AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (11, 1, N'', 71, 15, CAST(0x0000AB6900F6D647 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (12, 3, N'', 71, 2, CAST(0x0000AB6900F6E3DC AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (13, 1, N'', 71, 15, CAST(0x0000AB6900F6E7F1 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (14, 0, N'', 72, 15, CAST(0x0000AB690106CF03 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (15, 0, N'', 73, 15, CAST(0x0000AB69010DBF4C AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (16, 1, N'', 73, 15, CAST(0x0000AB69010E14AF AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (17, 0, N'', 74, 15, CAST(0x0000AB6D0117B521 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (18, 0, N'', 75, 15, CAST(0x0000AB6D0117CA7B AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (19, 0, N'', 76, 15, CAST(0x0000AB6D013373C5 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (20, 0, N'', 77, 15, CAST(0x0000AB6D0133B9F8 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (21, 0, N'', 78, 15, CAST(0x0000AB6D0133E3E7 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (22, 0, N'', 79, 15, CAST(0x0000AB6E0103D0FF AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (23, 0, N'', 80, 15, CAST(0x0000AB6F0128B155 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (24, 1, N'', 80, 15, CAST(0x0000AB6F01294C1D AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (25, 0, N'', 81, 15, CAST(0x0000AB6F0129F4A9 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (26, 0, N'', 82, 15, CAST(0x0000AB6F012A3485 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (27, 0, N'', 83, 15, CAST(0x0000AB6F016C5190 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (28, 1, N'', 81, 15, CAST(0x0000AB6F01739DC4 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (29, 1, N'', 72, 15, CAST(0x0000AB6F0173AB4D AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (30, 1, N'', 82, 15, CAST(0x0000AB6F0173AFBC AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (31, 3, N'', 83, 2, CAST(0x0000AB6F0173B3B9 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (32, 1, N'', 83, 15, CAST(0x0000AB700115B55E AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (33, 0, N'', 84, 15, CAST(0x0000AB7001164520 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (34, 3, N'', 84, 2, CAST(0x0000AB7001168637 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (35, 1, N'', 84, 15, CAST(0x0000AB7001180548 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (36, 1, N'', 75, 15, CAST(0x0000AB7001181C6F AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (37, 0, N'', 85, 15, CAST(0x0000AB71000DF63B AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (38, 0, N'', 86, 15, CAST(0x0000AB72000CB554 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (39, 0, N'', 87, 15, CAST(0x0000AB72000CBF50 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (40, 0, N'', 88, 15, CAST(0x0000AB7200111507 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (41, 1, N'', 88, 15, CAST(0x0000AB7200116A94 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (42, 3, N'', 88, 2, CAST(0x0000AB72001179B1 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (43, 1, N'', 88, 15, CAST(0x0000AB720015071C AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (44, 0, N'', 89, 15, CAST(0x0000AB720016EAD4 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (45, 0, N'', 90, 15, CAST(0x0000AB7200174439 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (46, 0, N'', 91, 15, CAST(0x0000AB7200175B0C AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (47, 0, N'', 92, 15, CAST(0x0000AB7200188B0D AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (48, 0, N'', 93, 15, CAST(0x0000AB720019FB27 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (49, 0, N'', 94, 15, CAST(0x0000AB72001A8051 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (50, 0, N'', 95, 15, CAST(0x0000AB72001AD0E4 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (51, 0, N'', 96, 15, CAST(0x0000AB72001B4196 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (52, 1, N'', 96, 15, CAST(0x0000AB730001E3D4 AS DateTime))
SET IDENTITY_INSERT [dbo].[tblTrangThaiDonDatTour] OFF
ALTER TABLE [dbo].[tblBinhLuan] ADD  DEFAULT ((0)) FOR [itrangthai]
GO
ALTER TABLE [dbo].[tblNhomVeGia] ADD  DEFAULT ((0)) FOR [iGiaVeGiam]
GO
ALTER TABLE [dbo].[tblThoiGianKhoiHanh] ADD  DEFAULT ((1)) FOR [trangThai]
GO
ALTER TABLE [dbo].[tblTour] ADD  DEFAULT ((1)) FOR [bTrangThai]
GO
ALTER TABLE [dbo].[tblBinhLuan]  WITH CHECK ADD  CONSTRAINT [FK_KhachHang_BinhLuan] FOREIGN KEY([iMaKhachHang])
REFERENCES [dbo].[tblKhachHang] ([iMaKhachHang])
GO
ALTER TABLE [dbo].[tblBinhLuan] CHECK CONSTRAINT [FK_KhachHang_BinhLuan]
GO
ALTER TABLE [dbo].[tblBinhLuan]  WITH CHECK ADD  CONSTRAINT [FK_Tour_BinhLuan] FOREIGN KEY([iMaTour])
REFERENCES [dbo].[tblTour] ([iMaTour])
GO
ALTER TABLE [dbo].[tblBinhLuan] CHECK CONSTRAINT [FK_Tour_BinhLuan]
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
