USE [webDatTour]
GO
/****** Object:  StoredProcedure [dbo].[binhLuan]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[capNhapKhachHang]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[capNhatTrangThaiBinhLuan]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[capNhatTrangThaiDanhGia]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[capNhatTrangThaiTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[danhgia]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[donDatTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[donDatTour_]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[khachHangHuyTour]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[khachHangHuyTour]
@id int
as
update tblDonDatTour set itrangthai = 2 where iMaDonDatTour = @id
GO
/****** Object:  StoredProcedure [dbo].[kiemTraHoanTien]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[kiemTraHoanTien]
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

GO
/****** Object:  StoredProcedure [dbo].[kiemTraHoanTien_]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[kiemTraHoanTien_]
@id int
as
DECLARE @tt int
set @tt = ( SELECT iTrangThai
FROM   (SELECT iMaDon, iTrangThai, dthoigian,imatrangthai, sghichu, imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour where iMaDon = @id) t
WHERE  rk = 1  )
if(@tt = 2)
begin
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
        FROM   tblTrangThaiDonDatTour) t
WHERE  rk = 1) b3 on b3.iMaDon = b2.iMaDonTour
order by b1.dNgayDatTour DESC
end
if(@tt = 3)
begin
select (b1.doanhThu-b2.tien) as conLai,b1.doanhthu ,b2.tien, b1.dThoiGian,b2.tien as thucthu, b2.imadontour, b1.iMaDonDatTour, b1.iMaTour,b3.sGhiChu,
b1.sTenKhachHang, b1.iMaKhachHang , b3.itrangthai, b3.iMaNhanVien , b1.dNgayDatTour , b1.sghichu , b1.stieude
from
(select b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,
e.stieude ,e.iMaTour,g.dThoiGian,--sum(e.tien)/2 as thucThu, 
sum(a.soLuongVe * (CASE WHEN iGiaVeGiam = 0 THEN iGiaVe ELSE iGiaVeGiam END)) as doanhThu  -- b.iMaTour ,  sum(a.soLuongVe * c.iGiaVe) 'tong doanh thu2'
from tblChiTietDonDatTour a, tblNhomVeGia c , tblDonDatTour b, tblkhachhang d , tbltour e , tblThoiGianKhoiHanh g--, tblGiaoDich e
where  a.iMaNhomVe = c.iMaNhomVe and c.iMaTour = b.iMaTour and b.imathoigian = g.iMaThoiGian
and a.iMaDonDatTour = b.iMaDonDatTour and d.iMaKhachHang = b.imakhachhang and e.iMaTour = b.iMaTour
and b.iMaDonDatTour = @id
group by  b.iMaDonDatTour,d.sTenKhachHang, d.iMaKhachHang,b.dNgayDatTour, b.sghichu,e.stieude,g.dThoiGian,
 e.iMaTour) b1 join
(
select Sum(tien) as tien, imadontour  from tblGiaoDich where trangThai = 1 group by imadontour
) b2 on b1.imadondattour = b2.imadontour 
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian,imatrangthai, sghichu, imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour ) t
WHERE  rk = 1) b3 on b3.iMaDon = b2.iMaDonTour
order by b1.dNgayDatTour DESC
end

GO
/****** Object:  StoredProcedure [dbo].[kiemTraNgayKhoiHanh]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[kiemTraQuyenBinhLuan]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[kiemTraTenDangNhap]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[kiemTraTenDangNhap]
 @ten nvarchar(30)
 as
  select * from tblNhanVien where sUserName = @ten

GO
/****** Object:  StoredProcedure [dbo].[layBinhLuan]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[laydanhgia]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[laydanhgia_danhGia]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[laydanhgiaChoKH]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[laydanhgiaChoKH]
@id int
as
select a.sTenKhachHang, c.dThoiGian, c.btrangthai, c.iMaDanhGia, c.iSoSao, c.sNoiDung , b.iMaDonDatTour, a.iMaKhachHang
from tblkhachhang a,  tbldondattour b , tblDanhGia c where b.imatour = @id and 
b.iMaDonDatTour = c.iMaDonDatTour and b.iMaKhachHang = a.iMaKhachHang and c.btrangthai = 1
GO
/****** Object:  StoredProcedure [dbo].[layDanhSachDonDatTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[layDanhSachDonDatTourByIDkh]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[layngaydi_]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[layngaydi_]
@id int
as
DECLARE @idtour int
set @idtour = (SELECT iMaTour from tblThoiGianKhoiHanh where iMaThoiGian = @id)
select iMaThoiGian, dThoiGian from tblThoiGianKhoiHanh where iMaTour = @idtour and iMaThoiGian != @id
GO
/****** Object:  StoredProcedure [dbo].[layTenNhomTour]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[layTenNhomTour]
@id int
as
select sTenNhomTour from tblNhomTour where imanhomtour = @id
GO
/****** Object:  StoredProcedure [dbo].[layThongTinTour_gopTour]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[layThongTinTour_gopTour]
@id int
as
select a.sTenKhachHang, a.iMaDonDatTour, a.sEmail, a.sSDT, b.nl, c.te, a.dNgayDatTour, a.iMaDonDatTour,(b.nl + c.te) as soCho from
(select c.sTenKhachHang, c.sSDT, c.sEmail, a.iMaDonDatTour, a.dNgayDatTour from tblDonDatTour a, tblThoiGianKhoiHanh b, tblkhachhang c 
where a.imathoigian = b.iMaThoiGian and a.iMaKhachHang = c.iMaKhachHang and b.iMaThoiGian = @id) a
join 
(select iMaDonDatTour,isnull( soLuongVe, 0 ) as nl from tblChiTietDonDatTour where iMaNhomVe = 1) b  on a.iMaDonDatTour = b.iMaDonDatTour
join
(select iMaDonDatTour,isnull( soLuongVe, 0 ) as te from tblChiTietDonDatTour where iMaNhomVe = 2)  c  on a.iMaDonDatTour = c.iMaDonDatTour
join
(SELECT iMaDon, iTrangThai, dthoigian, imatrangthai, sghichu,imanhanvien
FROM   (SELECT iMaDon, iTrangThai, dthoigian,imatrangthai, sghichu, imanhanvien,
               RANK() OVER (PARTITION BY iMaDon ORDER BY dthoigian DESC) AS rk
        FROM   tblTrangThaiDonDatTour where iTrangThai = 1) t
WHERE  rk = 1) d on d.iMaDon = a.iMaDonDatTour

GO
/****** Object:  StoredProcedure [dbo].[nhanVienthanhToan]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHang]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHangKH]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHangNV]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_dangki]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_danhGiaTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_danhSachNhanVien]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_danhSachNhanVien]
as
select * from tblNhanVien;
GO
/****** Object:  StoredProcedure [dbo].[sp_danhSachTour]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_danhSachTour]
as
select * from tblTour;
GO
/****** Object:  StoredProcedure [dbo].[sp_doiMatKhauKH]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_dsnhomtourbyid]    Script Date: 3/28/2020 11:49:08 PM ******/
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
select * from tblTour where tblTour.iMaNhomTour = @id and bTrangThai = 1) as a
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
/****** Object:  StoredProcedure [dbo].[sp_dsThoiGianKhoiHanh]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_dsThoiGianKhoiHanh]
@id int
as
select * from tblThoiGianKhoiHanh where iMaTour = @id order by dThoiGian DESC
GO
/****** Object:  StoredProcedure [dbo].[sp_dstour1]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_dstournhom1]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_kiemTraQuyenDanhGia]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_layChoChoCon]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_layDanhSachTOur]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_layHinhAnhCuaTour]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[sp_layHinhAnhCuaTour]
 @id int
 as
 select * from tblhinhanh where iMaTour = @id
GO
/****** Object:  StoredProcedure [dbo].[sp_layTourLienQuan]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_login_kh]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_login_kh_id]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_login_nv]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_soCho_Tour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_themGiave]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_themThoiGianKhoiHanh]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_themtour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_thongkedoanhsotheotatcatour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_thongkedoanhsotheotour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ThongKeTaiKhoan]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_timKiemTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_timKiemTour_ds]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_timKiemTour_ds]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_timKiemTourTheoNgay]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_timsoCho_Tour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_tourTheoNhom]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_trangThaiThoiGianKH]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_trangThaiTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_update]
as
update tbltour set isocho = 9 where imatour = 1
update tbltour set isocho = 3 where imatour = 3
GO
/****** Object:  StoredProcedure [dbo].[sp_updateGiaVe]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_updatetourID]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_updatetourID]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_xemTourId]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_xemTourId_]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xemTourId_]
@idtour int
as
select  b4.surlanh,a.iMaTour,a.sTieuDe,a.sNoiKhoiHanh,a.iMaNhanVien,a.iSoCho,a.sTongThoiGian, b.imatour, b.iGiaVe as igianl, b.iGiaVeGiam as igianlgiam, c.iGiaVe as igiate, c.iGiaVeGiam as igiategiam 
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
 join
(select iMaTour, ISNULL( avg(Cast(b.isosao as Float)) , 0 ) soSao from
 (select iMaTour, iMaDonDatTour from tblDonDatTour ) a
 left join 
( select iMaDonDatTour,isosao from tblDanhGia) b
on a.imadondattour = b.iMaDonDatTour group by iMaTour ) b5
on b5.iMaTour =  a.iMaTour 
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaKhachHang]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaKhachHang]
@id int 
as delete from tblKhachHang where imakhachhang = @id
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaNhanVien]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaNhanVien]
@id int 
as delete from tblnhanvien where imanhanvien =   @id
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaTour]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaTour]
@id int 
as delete from tblTour where imatour = @id
GO
/****** Object:  StoredProcedure [dbo].[suaBinhLuan]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[suaDanhGia]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[taoChiTietDonHang]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[taoDonHang]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[tesst]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themGiaoDich]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themGiaoDichNV]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[themGiaoDichNV]
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
GO
/****** Object:  StoredProcedure [dbo].[themNhanVien]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themNhanVien1]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themThoiGianKhoiHanh]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[thongKeDoanhThuTheoNgay]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[thongKeDoanhThuTheoNgay_danhSach]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[timDonDatTour_]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[timDonDatTourKH]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[tourhot]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[tourhotThang]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[tourhotTuan]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[toutMoiNhat]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updatehinhanh]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updateNhanVien]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updateTrangThaiGiaoDich]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[xemDonDatTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[xemgiaodich]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[xemKhachHangID]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[xemKhachHangID]
@id int
as
select * from tblKhachHang where iMaKhachHang = @id
GO
/****** Object:  StoredProcedure [dbo].[xemTrangThaiNV]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[xemTrangThaiNV]
@id int
as
select a.imanhanvien, a.dthoigian, a.sghichu, a.itrangthai, a.imadon, isnull(b.stennhanvien,'Khach Hang') as stennhanvien from
(select iMaNhanVien,max(dthoigian) as dthoigian, sghichu, itrangThai, imadon from
  tblTrangThaiDonDatTour b where b.iMaDon = 124
 group by imanhanvien, sghichu, itrangthai, imadon  )  a
 left join
(select stennhanvien, iMaNhanVien from tblNhanVien ) b
on a.imanhanvien = b.imanhanvien
GO
/****** Object:  Table [dbo].[tblChiTietDonDatTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblDanhGia]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblDonDatTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblGiaoDich]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblhinhanh]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblKhachHang]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblNhanVien]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblNhomTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblNhomVe]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblNhomVeGia]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblQuyen]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblTepThongTinKhachHang]    Script Date: 3/28/2020 11:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTepThongTinKhachHang](
	[iMaTep] [int] IDENTITY(1,1) NOT NULL,
	[iMaKhachHang] [int] NOT NULL,
	[sDuongDan] [varchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaTep] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblThoiGianKhoiHanh]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
/****** Object:  Table [dbo].[tblTrangThaiDonDatTour]    Script Date: 3/28/2020 11:49:08 PM ******/
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
ALTER TABLE [dbo].[tblTepThongTinKhachHang]  WITH CHECK ADD  CONSTRAINT [FK_tep_kh] FOREIGN KEY([iMaKhachHang])
REFERENCES [dbo].[tblKhachHang] ([iMaKhachHang])
GO
ALTER TABLE [dbo].[tblTepThongTinKhachHang] CHECK CONSTRAINT [FK_tep_kh]
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
