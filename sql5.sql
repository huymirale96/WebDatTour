USE [webDatTour]
GO
/****** Object:  StoredProcedure [dbo].[binhLuan]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[capNhapKhachHang]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[capnhatdondattour]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[capnhatdondattour]
@id int,
@nl int, 
@te int
as
update tblChiTietDonDatTour set soLuongVe = soLuongVe - @nl where iMaDonDatTour = @id and iMaNhomVe = 1
update tblChiTietDonDatTour set soLuongVe = soLuongVe - @te where iMaDonDatTour = @id and iMaNhomVe = 2
GO
/****** Object:  StoredProcedure [dbo].[capNhatTrangThaiBinhLuan]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[capNhatTrangThaiDanhGia]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[capNhatTrangThaiTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[danhgia]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[donDatTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[donDatTour_]    Script Date: 4/14/2020 7:57:44 PM ******/
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

GO
/****** Object:  StoredProcedure [dbo].[khachHangHuyTour]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[khachHangHuyTour]
@id int
as
update tblDonDatTour set itrangthai = 2 where iMaDonDatTour = @id
GO
/****** Object:  StoredProcedure [dbo].[kiemTraChoConCuaMaThoiGian]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[kiemTraChoConCuaMaThoiGian]
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

GO
/****** Object:  StoredProcedure [dbo].[kiemTraHoanTien]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[kiemTraHoanTien_]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[kiemTraNgayKhoiHanh]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[kiemTraQuyenBinhLuan]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[kiemTraTenDangNhap]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[kiemTraTenDangNhap]
 @ten nvarchar(30)
 as
  select * from tblNhanVien where sUserName = @ten

GO
/****** Object:  StoredProcedure [dbo].[layBinhLuan]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[laydanhgia]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[laydanhgia_danhGia]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[laydanhgiaChoKH]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[layDanhSachDonDatTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[layDanhSachDonDatTourByIDkh]    Script Date: 4/14/2020 7:57:44 PM ******/
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
GO
/****** Object:  StoredProcedure [dbo].[layNgayChuyen]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[layNgayChuyen]
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
GO
/****** Object:  StoredProcedure [dbo].[layngaydi_]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[laySoVeTheoDon]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[laySoVeTheoDon]
@id int 
as
select a.soluongve as nl, a.imadondattour as madon, b.soluongve as te from
(select iMaDonDatTour, soLuongVe from tblChiTietDonDatTour where iMaDonDatTour = @id and iMaNhomVe = 1) a
join
(select iMaDonDatTour, soLuongVe from tblChiTietDonDatTour where iMaDonDatTour = @id and iMaNhomVe = 1) b
on a.imadondattour = b.imadondattour

GO
/****** Object:  StoredProcedure [dbo].[layTenNhomTour]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[layTenNhomTour]
@id int
as
select sTenNhomTour from tblNhomTour where imanhomtour = @id
GO
/****** Object:  StoredProcedure [dbo].[layThongTinTour_gopTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[nhanVienthanhToan]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHang]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHangKH]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_capNhatTrangThaiDonHangNV]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_dangki]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_danhGiaTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_danhSachNhanVien]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_danhSachNhanVien]
as
select * from tblNhanVien;
GO
/****** Object:  StoredProcedure [dbo].[sp_danhSachTour]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_danhSachTour]
as
select * from tblTour;
GO
/****** Object:  StoredProcedure [dbo].[sp_doiMatKhauKH]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_dsnhomtourbyid]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_dsThoiGianKhoiHanh]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_dsThoiGianKhoiHanh]
@id int
as
select * from tblThoiGianKhoiHanh where iMaTour = @id order by dThoiGian DESC
GO
/****** Object:  StoredProcedure [dbo].[sp_dstour1]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_dstournhom1]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_kiemTraQuyenDanhGia]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_layChoChoCon]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_layDanhSachTOur]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_layHinhAnhCuaTour]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[sp_layHinhAnhCuaTour]
 @id int
 as
 select * from tblhinhanh where iMaTour = @id
GO
/****** Object:  StoredProcedure [dbo].[sp_layTourLienQuan]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_login_kh]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_login_kh_id]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_login_nv]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_soCho_Tour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_themGiave]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_themGiave]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_themThoiGianKhoiHanh]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_themtour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_thongkedoanhsotheotatcatour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_thongkedoanhsotheotour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ThongKeTaiKhoan]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_timKiemTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_timKiemTour_ds]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_timKiemTourTheoNgay]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_timsoCho_Tour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_tourTheoNhom]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_trangThaiNhomTourTour]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_trangThaiNhomTourTour]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_trangThaiThoiGianKH]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_trangThaiTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_update]
as
update tbltour set isocho = 9 where imatour = 1
update tbltour set isocho = 3 where imatour = 3
GO
/****** Object:  StoredProcedure [dbo].[sp_updateGiaVe]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_updateGiaVe]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_updatetourID]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_xemTourId]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_xemTourId]
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

GO
/****** Object:  StoredProcedure [dbo].[sp_xemTourId_]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_xemTourId_]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaKhachHang]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaKhachHang]
@id int 
as delete from tblKhachHang where imakhachhang = @id
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaNhanVien]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaNhanVien]
@id int 
as delete from tblnhanvien where imanhanvien =   @id
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaTour]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_xoaTour]
@id int 
as delete from tblTour where imatour = @id
GO
/****** Object:  StoredProcedure [dbo].[suaBinhLuan]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[suaDanhGia]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[taoChiTietDonHang]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[taoDonHang]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[tesst]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themGiaoDich]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themGiaoDichNV]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themNhanVien]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themNhanVien1]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[themThoiGianKhoiHanh]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[thongKeDoanhThuTheoNgay]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[thongKeDoanhThuTheoNgay_danhSach]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[timDonDatTour_]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[timDonDatTourKH]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[tourhot]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[tourhotThang]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[tourhotTuan]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[toutMoiNhat]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updatehinhanh]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updateNhanVien]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updateTrangThaiGiaoDich]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[xemDonDatTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[xemgiaodich]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[xemKhachHangID]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[xemKhachHangID]
@id int
as
select * from tblKhachHang where iMaKhachHang = @id
GO
/****** Object:  StoredProcedure [dbo].[xemTrangThaiNV]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[xemTrangThaiNV]
@id int
as
select a.imanhanvien, a.dthoigian, a.sghichu, a.itrangthai, a.imadon, isnull(b.stennhanvien,'Khach Hang') as stennhanvien from
(select iMaNhanVien,max(dthoigian) as dthoigian, sghichu, itrangThai, imadon from
  tblTrangThaiDonDatTour b where b.iMaDon = @id
 group by imanhanvien, sghichu, itrangthai, imadon  )  a
 left join
(select stennhanvien, iMaNhanVien from tblNhanVien ) b
on a.imanhanvien = b.imanhanvien
GO
/****** Object:  Table [dbo].[tblChiTietDonDatTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblDanhGia]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblDonDatTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblGiaoDich]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblhinhanh]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblKhachHang]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblNhanVien]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblNhomTour]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNhomTour](
	[iMaNhomTour] [int] IDENTITY(1,1) NOT NULL,
	[sTenNhomTour] [nvarchar](100) NOT NULL,
	[bTrangThai] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaNhomTour] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblNhomVe]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblNhomVeGia]    Script Date: 4/14/2020 7:57:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNhomVeGia](
	[iMaTour] [int] NOT NULL,
	[iMaNhomVe] [int] NOT NULL,
	[iGiaVe] [int] NOT NULL,
	[iGiaVeGiam] [int] NULL,
	[dHanGiamGia] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[iMaTour] ASC,
	[iMaNhomVe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblQuyen]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblTepThongTinKhachHang]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblThoiGianKhoiHanh]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
/****** Object:  Table [dbo].[tblTrangThaiDonDatTour]    Script Date: 4/14/2020 7:57:44 PM ******/
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
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (115, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (116, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (117, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (119, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (120, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (121, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (122, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (123, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (124, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (125, 1, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (126, 1, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (127, 1, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (128, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (129, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (130, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (131, 1, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (113, 2, 2)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (114, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (115, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (116, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (117, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (119, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (120, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (121, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (122, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (123, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (124, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (125, 2, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (126, 2, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (127, 2, 0)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (128, 2, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (129, 2, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (130, 2, 1)
INSERT [dbo].[tblChiTietDonDatTour] ([iMaDonDatTour], [iMaNhomVe], [soLuongVe]) VALUES (131, 2, 1)
SET IDENTITY_INSERT [dbo].[tblDanhGia] ON 

INSERT [dbo].[tblDanhGia] ([iMaDanhGia], [iMaDonDatTour], [dThoiGian], [sNoiDung], [iSoSao], [btrangthai]) VALUES (13, 113, CAST(0x0000AB82016BF681 AS DateTime), N'Tour Rất Đẹp', 4, 1)
SET IDENTITY_INSERT [dbo].[tblDanhGia] OFF
SET IDENTITY_INSERT [dbo].[tblDonDatTour] ON 

INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (113, 56, 14, CAST(0x0000AB8201631A93 AS DateTime), N'Dat tour.', 1160)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (114, 54, 14, CAST(0x0000AB820166AF52 AS DateTime), N'dat tour', 1153)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (115, 55, 14, CAST(0x0000AB8400013CB9 AS DateTime), N'Dat tour', 1157)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (116, 56, 14, CAST(0x0000AB84017D04EE AS DateTime), N'', 1158)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (117, 60, 14, CAST(0x0000AB870011E01D AS DateTime), N'Dat Tour', 1169)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (119, 54, 14, CAST(0x0000AB870177ED13 AS DateTime), N'', 1154)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (120, 54, 14, CAST(0x0000AB87017AA1C6 AS DateTime), N'', 1154)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (121, 55, 14, CAST(0x0000AB87017BA95E AS DateTime), N'', 1156)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (122, 66, 14, CAST(0x0000AB88002ADBE0 AS DateTime), N'Dat Tour', 1182)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (123, 67, 14, CAST(0x0000AB8800BF3BD5 AS DateTime), N'Dat Tour', 1184)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (124, 67, 14, CAST(0x0000AB8800BF42C6 AS DateTime), N'Dat Tour', 1184)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (125, 65, 14, CAST(0x0000AB8B00056297 AS DateTime), N'', 1181)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (126, 56, 14, CAST(0x0000AB9C00F4D6DB AS DateTime), N'dat tour', 1160)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (127, 54, 14, CAST(0x0000AB9C00F827E0 AS DateTime), N'', 1153)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (128, 56, 14, CAST(0x0000AB9D00FB16EA AS DateTime), N'HUy', 1160)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (129, 56, 14, CAST(0x0000AB9D00FC161C AS DateTime), N'huy', 1160)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (130, 56, 14, CAST(0x0000AB9D011090EF AS DateTime), N'', 1158)
INSERT [dbo].[tblDonDatTour] ([iMaDonDatTour], [iMaTour], [iMaKhachHang], [dNgayDatTour], [sghichu], [imathoigian]) VALUES (131, 55, 14, CAST(0x0000AB9D01197AF3 AS DateTime), N'', 1155)
SET IDENTITY_INSERT [dbo].[tblDonDatTour] OFF
SET IDENTITY_INSERT [dbo].[tblGiaoDich] ON 

INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (83, 113, 2650000, 13267727, 1, 1, CAST(0x0000AB8201631A93 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (84, 113, 2650000, NULL, 1, 24, CAST(0x0000AB820163516B AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (85, 114, 3261000, 13267757, 1, 1, CAST(0x0000AB820166AF52 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (86, 114, 3261000, NULL, 1, 24, CAST(0x0000AB820167CB3B AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (87, 115, 1125000, 13269069, 1, 1, CAST(0x0000AB8400013CB9 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (88, 116, 1050000, 13269420, 1, 1, CAST(0x0000AB84017D04EE AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (89, 117, 2200000, 13269805, 1, 1, CAST(0x0000AB870011E01D AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (98, 117, 2200000, NULL, 1, 24, CAST(0x0000AB8700131A77 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (99, 119, 6522000, NULL, 1, 1, CAST(0x0000AB870177ED13 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (100, 120, 6522000, NULL, 1, 24, CAST(0x0000AB8700000000 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (101, 121, 2250000, NULL, 1, 24, CAST(0x0000AB8700000000 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (102, 122, 2200000, 13270216, 1, 1, CAST(0x0000AB88002ADBE0 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (103, 123, 1600000, NULL, 0, 1, CAST(0x0000AB8800BF3BD5 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (104, 124, 1600000, 13270349, 1, 1, CAST(0x0000AB8800BF42C6 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (105, 124, 1600000, NULL, 1, 24, CAST(0x0000AB8800C001F7 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (106, 125, 12200000, 13271797, 1, 1, CAST(0x0000AB8B00056297 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (107, 126, 2900000, 13281595, 1, 1, CAST(0x0000AB9C00F4D6DB AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (108, 126, 2900000, NULL, 1, 24, CAST(0x0000AB9C00F53343 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (109, 127, 6522000, NULL, 1, 24, CAST(0x0000AB9C00000000 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (110, 128, 1950000, NULL, 0, 1, CAST(0x0000AB9D00FB16EA AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (111, 129, 1850000, 13282102, 1, 1, CAST(0x0000AB9D00FC161C AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (112, 129, 1850000, NULL, 0, 1, CAST(0x0000AB9D010A8ABC AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (113, 129, 1850000, NULL, 0, 1, CAST(0x0000AB9D010AEEC6 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (114, 129, 1850000, 13282177, 1, 1, CAST(0x0000AB9D010AF596 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (115, 130, 3700000, NULL, 1, 28, CAST(0x0000AB9D00000000 AS DateTime))
INSERT [dbo].[tblGiaoDich] ([iMaGiaoDich], [iMaDonTour], [tien], [idGiaoDichVNPAY], [trangThai], [imaNhanVien], [thoigian]) VALUES (116, 131, 2000000, NULL, 1, 28, CAST(0x0000AB9D00000000 AS DateTime))
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
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (82, N'chua huong 2.jpg', 64)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (83, N'chua huong 2.jpg', 64)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (84, N'Chua Huong(1).jpeg', 64)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (85, N'Chua Huong5.jpeg', 64)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (86, N'ha-giang-dong-van-tan-trao-ba-be-cao-bang_tnmieb070601_0.jpg', 65)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (87, N'Chien-khu-tan-trao.jpg', 65)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (88, N'Cot-co-lung-cu-ha-giang.jpg', 65)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (89, N'ha-giang-dong-van-tan-trao-ba-be-cao-bang_tnmieb070601_1.jpg', 65)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (90, N'ha-giang-dong-van-tan-trao-ba-be-cao-bang_tnmieb070601_2.jpg', 65)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (91, N'Nui-doi-quan-ba.jpg', 65)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (92, N'cao-bang--bac-can--lang-son_ndcb03031401_0.jpg', 66)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (93, N'cao-bang--bac-can--lang-son_ndcb03031401_0.jpg', 66)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (94, N'cao-bang--bac-can--lang-son_ndcb03031401_1.jpg', 66)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (95, N'cao-bang--bac-can--lang-son_ndcb03031401_0.jpg', 67)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (96, N'cao-bang--bac-can--lang-son_ndcb03031401_0.jpg', 67)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (97, N'cao-bang--bac-can--lang-son_ndcb03031401_1.jpg', 67)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (98, N'cao-bang--bac-can--lang-son_ndcb03031401_2.jpg', 67)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (99, N'Bien-ky-co-binh-dinh.jpg', 68)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (100, N'Mo-han-mac-tu.jpg', 68)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (101, N'quy-nhon-thanh-pho-binh-yen_ttbd030302_0.jpg', 68)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (102, N'quy-nhon-thanh-pho-binh-yen_ttbd030302_1.jpg', 68)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (103, N'quy-nhon-thanh-pho-binh-yen_ttbd030302_2.jpg', 68)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (104, N'da-nang--hoi-an--hue--dong-thien-duong_nddn03031402_0.jpg', 69)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (105, N'da-nang--hoi-an--hue--dong-thien-duong_nddn03031402_0.jpg', 69)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (106, N'da-nang--hoi-an--hue--dong-thien-duong_nddn03031402_1.jpg', 69)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (107, N'da-nang--hoi-an--hue--dong-thien-duong_nddn03031402_2.jpg', 69)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (108, N'da-nang--hoi-an--hue--dong-thien-duong_nddn03031402_1.jpg', 70)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (109, N'Khu-du-lich-i-resort-du-lich-nha-trang.jpg', 70)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (110, N'nha-trang-bien-xanh-vay-goi_tnntte4301_0.jpg', 70)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (111, N'nha-trang-bien-xanh-vay-goi_tnntte4301_1.jpg', 70)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (112, N'Thap-ba-ponagar.jpg', 71)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (113, N'Khu-du-lich-i-resort-du-lich-nha-trang.jpg', 71)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (114, N'nha-trang-bien-xanh-vay-goi_tnntte4301_0.jpg', 71)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (115, N'nha-trang-bien-xanh-vay-goi_tnntte4301_1.jpg', 71)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (116, N'nha-trang-bien-xanh-vay-goi_tnntte4301_2.jpg', 71)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (117, N'nha-trang-bien-xanh-vay-goi_tnntte4301_0.jpg', 72)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (118, N'ca-mau--diem-cuc-nam-cua-to-quoc_ndcm03031401_1.png', 73)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (119, N'ca-mau--diem-cuc-nam-cua-to-quoc_ndcm03031401_0.png', 73)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (120, N'ca-mau--diem-cuc-nam-cua-to-quoc_ndcm03031401_1.png', 73)
INSERT [dbo].[tblhinhanh] ([iMaHinhAnh], [sDuongDan], [iMaTour]) VALUES (121, N'ca-mau--diem-cuc-nam-cua-to-quoc_ndcm03031401_2.png', 73)
SET IDENTITY_INSERT [dbo].[tblhinhanh] OFF
SET IDENTITY_INSERT [dbo].[tblKhachHang] ON 

INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (14, N'Ngo Dang Huy', CAST(0x08160B00 AS Date), N'Ha Noi', N'0862655656', N'huyhuy@gmail.com', N'huy123', N'6291F146521F9B2DB100BD16F019B931')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (15, N'huy', CAST(0x7C1D0B00 AS Date), N'ha noi', N'0892521222', N'huyhuy@gmail.com', N'huy1234', N'6291F146521F9B2DB100BD16F019B931')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (16, N'Ngo Dang Huy', CAST(0x421D0B00 AS Date), N'ha noi', N'0796232', N'huyhuy@gmail.com', N'huyhuyas', N'6291F146521F9B2DB100BD16F019B931')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (17, N'Ngo Dang Huy', CAST(0x421D0B00 AS Date), N'ha noi', N'0796232', N'huyhuy@gmail.com', N'huyhuyas', N'6291F146521F9B2DB100BD16F019B931')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (18, N'ng huy', CAST(0x421D0B00 AS Date), N'hn', N'0782656', N'huyhuy1@gmail.com', N'huya1', N'6291F146521F9B2DB100BD16F019B931')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (19, N'Ngo Dang Huy', CAST(0x421D0B00 AS Date), N'ha noi', N'0655565567', N'huy123@gmail.com', N'huya2', N'6291F146521F9B2DB100BD16F019B931')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (20, N'Ngo Dang Huy', CAST(0x421D0B00 AS Date), N'Ha Noi', N'1323131312', N'huyhuy1@gmail.com', N'huyhuy1234', N'CC0D45BC2F499FC4666D09691485A0F9')
INSERT [dbo].[tblKhachHang] ([iMaKhachHang], [sTenKhachHang], [dNgaySinh], [sDiaChi], [sSDT], [sEmail], [sUserName], [sPassWord]) VALUES (21, N'huy ngo', CAST(0x421D0B00 AS Date), N'ha noi', N'09526556', N'huy@gmail.com', N'huyhuy1234a', N'6291F146521F9B2DB100BD16F019B931')
SET IDENTITY_INSERT [dbo].[tblKhachHang] OFF
SET IDENTITY_INSERT [dbo].[tblNhanVien] ON 

INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (1, N'VN PAY', 1, CAST(0xAA400B00 AS Date), N'KHONG', N'KHONG', N'KHONG', N'', 3)
INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (24, N'Ngo Dang Huy', 1, CAST(0xCE400B00 AS Date), N'ha noi', N'23423432', N'huyhuy123', N'D81EE40811DFCBB563868685BD26A1AD', 2)
INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (25, N'Ngo Dang huy', 1, CAST(0x91320B00 AS Date), N'Ha Noi', N'098232652', N'huyhuy1234', N'6291F146521F9B2DB100BD16F019B931', 2)
INSERT [dbo].[tblNhanVien] ([iMaNhanVien], [sTenNhanVien], [bGioiTinh], [dNgaySinh], [sDiaChi], [sSDT], [sUserName], [sPassWord], [iMaQuyen]) VALUES (28, N'Ngo Dang Huy', 1, CAST(0xA8290B00 AS Date), N'Ha Noi', N'0989456258', N'huyhuys12', N'6291F146521F9B2DB100BD16F019B931', 1)
SET IDENTITY_INSERT [dbo].[tblNhanVien] OFF
SET IDENTITY_INSERT [dbo].[tblNhomTour] ON 

INSERT [dbo].[tblNhomTour] ([iMaNhomTour], [sTenNhomTour], [bTrangThai]) VALUES (18, N'Miền Bắc', 1)
INSERT [dbo].[tblNhomTour] ([iMaNhomTour], [sTenNhomTour], [bTrangThai]) VALUES (19, N'Miền Trung', 1)
INSERT [dbo].[tblNhomTour] ([iMaNhomTour], [sTenNhomTour], [bTrangThai]) VALUES (20, N'Miền Nam', 1)
INSERT [dbo].[tblNhomTour] ([iMaNhomTour], [sTenNhomTour], [bTrangThai]) VALUES (21, N'Tour Lễ Hội', 1)
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
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (54, 1, 6980000, 6522000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (54, 2, 5200000, 4600000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (55, 1, 2400000, 2250000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (55, 2, 1800000, 1750000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (56, 1, 2400000, 2100000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (56, 2, 1800000, 1600000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (57, 1, 4280000, 4180000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (57, 2, 3080000, 3280000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (58, 1, 3590000, 3390000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (58, 2, 3090000, 2590000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (59, 1, 4800000, 4600000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (59, 2, 4500000, 4100000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (60, 1, 4500000, 4400000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (60, 2, 4100000, 4000000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (61, 1, 4800000, 4700000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (61, 2, 4600000, 4399999, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (62, 1, 3800000, 3600000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (62, 2, 3100000, 3400000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (63, 1, 2400000, 2300000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (63, 2, 2000000, 1850000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (64, 1, 500000, 480000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (64, 2, 450000, 440000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (65, 1, 5400000, 4400000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (65, 2, 5200000, 3400000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (66, 1, 5400000, 4400000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (66, 2, 5200000, 3400000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (67, 1, 4200000, 3200000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (67, 2, 4100000, 3500000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (68, 1, 6500000, 2400000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (68, 2, 6100000, 2300000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (69, 1, 6400000, 5300000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (69, 2, 5400000, 4600000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (70, 1, 4700000, 4500000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (70, 2, 4500000, 3900000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (71, 1, 5400000, 5200000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (71, 2, 4400000, 4000000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (72, 1, 1500000, 1400000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (72, 2, 1300000, 1200000, CAST(0x2D410B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (73, 1, 600000, 400000, CAST(0xFF400B00 AS Date))
INSERT [dbo].[tblNhomVeGia] ([iMaTour], [iMaNhomVe], [iGiaVe], [iGiaVeGiam], [dHanGiamGia]) VALUES (73, 2, 350000, 250000, CAST(0xF6400B00 AS Date))
SET IDENTITY_INSERT [dbo].[tblQuyen] ON 

INSERT [dbo].[tblQuyen] ([iMaQuyen], [sTenQuyen]) VALUES (1, N'MemBer')
INSERT [dbo].[tblQuyen] ([iMaQuyen], [sTenQuyen]) VALUES (2, N'Admin')
INSERT [dbo].[tblQuyen] ([iMaQuyen], [sTenQuyen]) VALUES (3, N'PAY')
SET IDENTITY_INSERT [dbo].[tblQuyen] OFF
SET IDENTITY_INSERT [dbo].[tblTepThongTinKhachHang] ON 

INSERT [dbo].[tblTepThongTinKhachHang] ([iMaTep], [iMaKhachHang], [sDuongDan]) VALUES (1, 14, N'nha-trang-bien-xanh-vay-goi_tnntte4301_2.jpg')
INSERT [dbo].[tblTepThongTinKhachHang] ([iMaTep], [iMaKhachHang], [sDuongDan]) VALUES (2, 14, N'Thap-ba-ponagar.jpg')
INSERT [dbo].[tblTepThongTinKhachHang] ([iMaTep], [iMaKhachHang], [sDuongDan]) VALUES (3, 14, N'New Text Document.txt')
INSERT [dbo].[tblTepThongTinKhachHang] ([iMaTep], [iMaKhachHang], [sDuongDan]) VALUES (4, 18, N'New Text Document.txt')
SET IDENTITY_INSERT [dbo].[tblTepThongTinKhachHang] OFF
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
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1179, 64, CAST(0x40410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1180, 65, CAST(0x1B410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1181, 65, CAST(0x21410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1182, 66, CAST(0x1A410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1183, 66, CAST(0x26410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1184, 67, CAST(0x40410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1185, 67, CAST(0x5E410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1186, 68, CAST(0x3E410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1187, 69, CAST(0x1A410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1188, 70, CAST(0x36410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1189, 71, CAST(0x1E410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1190, 72, CAST(0x00410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1191, 72, CAST(0x08410B00 AS Date), 1)
INSERT [dbo].[tblThoiGianKhoiHanh] ([iMaThoiGian], [iMaTour], [dThoiGian], [trangThai]) VALUES (1192, 73, CAST(0x0E410B00 AS Date), 1)
SET IDENTITY_INSERT [dbo].[tblThoiGianKhoiHanh] OFF
SET IDENTITY_INSERT [dbo].[tblTour] ON 

INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (54, N'Bay ngắm cảnh "Đảo đầu lâu" Kingkong bằng thủy phi cơ', N'<p style="text-align:center"><strong><span style="color:#ff0000"><span style="font-size:18px"><span style="background-color:#ffff00">BAY NGẮM CẢNH "ĐẢO ĐẦU LÂU" KINGKONG BẰNG THỦY PHI CƠ</span></span></span></strong></p>

<p style="text-align:center"><strong><span style="color:#ff0000"><span style="font-size:18px"><span style="background-color:#ffff00">HÀ NỘI - VÂN LONG - KÊNH GÀ - HẠ LONG</span></span></span></strong></p>

<p style="text-align:justify"><span style="font-size:14px"><strong>Tour theo dấu chân Kingkong để tận mắt chiêm ngưỡng vẻ đẹp mê hồn của nơi làm bối cảnh quay siêu phẩm "Đảo đầu lâu" bằng thủy phi cơ.</strong></span></p>

<ul>
	<li style="text-align:justify"><span style="font-size:14px"><em>Sau khi bộ phim <strong>“Kong: Đảo Đầu Lâu” (Kong: Skull Island)</strong> chính thức ra mắt khán giả Việt Nam, du khách đã có thể đặt tour đi <strong>Ninh Bình, Hạ Long</str', N'4 Ngày 3 Đêm', 18, 50, N'Hà Nội', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (55, N'Hà Nội – Yên Tử ', N'<div class="tab-pane active" id="program">
<p style="text-align:justify"><span style="font-size:14px"><em>Hà Nộ</em><em>i </em><em>n</em><em>ơ</em><em>i hô</em><em>̣</em><em>i tu</em><em>̣</em><em> nga</em><em>̀</em><em>n n</em><em>ă</em><em>m v</em><em>ă</em><em>n hiê</em><em>́</em><em>n - tra</em><em>́</em><em>i tim cu</em><em>̉</em><em>a ca</em><em>̉</em><em> n</em><em>ướ</em><em>c - niê</em><em>̀</em><em>m tin va</em><em>̀</em><em> hy vo</em><em>̣</em><em>ng. Thu</em><em>̉</em><em> đ</em><em>ô </em><em>Hà Nô</em><em>̣</em><em>i </em><em>xuâ</em><em>́</em><em>t hiê</em><em>̣</em><em>n trong li</em><em>̣</em><em>ch s</em><em>ử</em><em> dân tô</em><em>̣</em><em>c Viê</em><em>̣</em><em>t Nam va</em><em>̀</em><em>o n</em><em>ă</em><em>m 1010 v</em><em>ớ</em><em>i tên go</em><em>̣</em><em>i Th</em><em>ă</em><em>ng Long mang y</em><em>́</em><em> nghi</em><em>̃</em><em>a “Rô</em><em>̀', N'4 Ngày 3 Đêm', 18, 50, N'Hà N?i', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (56, N'Hà Nội - Sapa', N'<p><span style="font-size:12px"><em>hương trình Sa Pa (Lào Cai) là thị trấn nghỉ mát thuộc tỉnh Lào Cai ở độ cao 1600 m so với mặt biển, có khí hậu ôn đới, nhiệt độ trung bình từ 15 đến 18 độ C, quanh năm mát mẻ, mùa đông có tuyết nhẹ. Từ những năm đầu thế kỷ người Pháp đã tìm thấy sức hấp dẫn của Sa Pa về cảnh quan, khí hậu và nguồn nước.... vì thế du khách có thể chiêm ngưỡng vẻ đẹp của kiến trúc Pháp của hơn 200 biệt thự nghỉ mát. Sa Pa, một địa danh nguyên sơ với làng bản của các dân tộc ít người như H’Mông, Dao, Tày, Xá Phó... với Thác Bạc, cổng Trời, cầu Mây, hang Gió, núi Hàm Rồng... xứng đáng là một nơi dành cho những ai yêu thích thiên nhiên muốn tìm hiểu phong tục tập quán của người dân miền núi.</em></span></p>

<p style="text-align:justify"><span style="font-size:12px"><em>Hạ Long - di sản của thế giới rộng hơn 1500 km với hàng ngàn đảo đá, mỗi đảo đá một vẻ, có đảo cao vút nhưng có những đảo chỉ cao hơn mặt biển vài chục mét, có đảo đứng chơi vơi ngoài biển khơi, cũng có đảo dựa vào những dãy đảo lớn hơn. Có đảo hình cánh buồm, hình gà chọi, hình con rùa, hình cái tháp, muôn hình ngàn vẻ... đó là sự sáng tạo kì diệu của thiên nhiên</em></span></p>

<p style="text-align:justify"><span style="font-size:12px"><span style="color:#005baa"><strong>NGÀY 1: HCM – HÀ NỘI (ĂN: TRƯA, TỐI)</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Sáng:</strong> Xe và HDV đón Quý khách tại sân bay Nội Bài, đưa&nbsp; về khách sạn, nhận phòng, nghỉ ngơi. Quý khách ăn trưa tại nhà hàng.</span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Chiều: </strong>Quý khách thăm <strong>chùa Trấn Quốc<em>–</em></strong>Ngôi chùa Trấn Bắc cổ kính nhất Việt Nam với 1.500 năm tuổi nằm trên bán đảo cồn Quy linh thiêng, với truyền thuyết và huyền thoại về Hồ Tây, hồ Trúc Bạch. Quý khách tiếp tục thăm quan <strong>Đền Ngọc Sơn, hồ Hoàn Kiếm</strong> - Trực tiếp chứng kiến cụ Rùa dài 2,1m, ngang 1,2m được trưng bày tại đền Ngọc Sơn. Quý khách ghé thăm <strong>Văn Miếu - Quốc Tử Giám</strong> – Nơi đựoc xem như Trường Đại học đầu tiên của Việt Nam với 82 tấm bia Tiến sỹ còn lưu danh sử sách.</span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Tối: </strong>Quý khách tự do dạo chơi thăm <strong>phố cổ Hà Nội, dạo Hồ Gươm, mua sắm tại Chợ đêm Hà Nội sầm uất</strong>,.. Nghỉ đêm tại khách sạn.</span></p>

<p style="text-align:justify"><span style="font-size:12px"><span style="color:#005baa"><strong>NGÀY 2: HÀ NỘI-HẠ LONG- CẦU BÃI CHÁY (ĂN: SÁNG,TRƯA, TỐI)</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Sáng:</strong> Quý khách lên xe khởi hành đi Hạ Long, ngắm cảnh đẹp yên bình của vùng nông thôn Bắc Bộ. 11h00 Quý khách đến Hạ Long, ra bến xuống tàu đi thăm vịnh Hạ Long, thưởng thức bữa trưa trên tàu với các món Hải sản biển tươi sống.</span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Chiều: </strong>Quý khách <strong>tham quan vịnh Hạ Long</strong> – Di sản thiên nhiên thế giới duy nhất được UNESCO công nhận hai lần vào năm 1994 và 2001. <strong>Thăm động Thiên Cung, hang Dấu Gỗ</strong> - Nơi gắn liền với truyền thuyết tên Hạ Long cùng dấu tích trận chiến Bạch Đằng của người anh hùng Ngô Quyền, ngắm nhìn những hòn đảo kỳ thú: <strong>Hòn chó đá, Lư hương, gà chọi, hòn Cô Đơn</strong>...</span></p>

<p style="text-align:justify"><span style="font-size:12px"><strong>Tối:</strong> Quý khách <strong>dạo chơi Công viên Hoàng Gia dọc biển Bãi Cháy, đi mua sắm hàng hóa tại khu Chợ Đêm Hạ Long sầm uất với các sản phẩm đặc trưng Hạ Long, lên cầu Bãi Cháy –</strong> cây cầu dây văng dài nhất Việt Nam ngắm Hạ Long về đêm.</span></p>

<p style="text-align:justify">&nbsp;</p>
', N'4 Ngày 3 Đêm', 18, 50, N' Hà N?i', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (57, N'Quy Nhơn - Thành phố bình yên', N'<p style="text-align:center"><span style="color:#ff0000"><span style="font-size:18px"><strong><span style="background-color:#ffff00">QUY NHƠN - THÀNH PHỐ BÌNH YÊN</span></strong></span></span></p>

<h2 style="text-align:justify"><strong><u>NGÀY 1:</u> ĐÓN KHÁCH - QUY NHƠN CITY TOUR<em>(Ăn trưa, tối)</em></strong></h2>

<ul>
	<li style="text-align:justify"><span style="font-size:14px"><u><strong>Sáng:</strong></u> Quý khách tập trung tại sân bay Tân Sơn Nhất (ga quốc nội), đáp chuyến bay đi Quy Nhơn. Đến Quy Nhơn, xe đón đưa quý khách về khách sạn nhận phòng (nếu có, vì giờ nhận phòng là 14h00).</span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px">Ăn Trưa tại nhà hàng địa phương.&nbsp; Sau bữa trưa, về lại khách sạn nghỉ ngơi.</span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px"><u><strong>Chiều:</strong></u> Thă', N'4 Ngày 3 Đêm', 19, 50, N'Quy Nhon City', 24, CAST(0x0000AB8200000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (58, N'Nha Trang - Vinperland - Biển đảo kỳ thú', N'<div id="program">
<p><strong>NHA TRANG - BIỂN ĐẢO KỲ THÚ</strong></p>

<p><em><strong>Tour du lịch Nha Trang 3 ngày 2 đêm lễ 30/4 và 1/5</strong> khám phá Vinpearl Land, Biển đảo kì thú và tắm suối nước nóng...đem đến cho du khách một kỳ nghỉ dưỡng đúng nghĩa với nhiều điểm tham quan độc đáo và đẹp nhất của Nha Trang.</em></p>

<h2><strong><u>NGÀY 1:</u> TP. HCM - NHA TRANG<em>(Ăn chiều)</em></strong></h2>

<p>Quý khách tập trung tại điểm hẹn, khởi hành đến&nbsp;<a href="http://cholontourist.com.vn/du-ngoan-dao-tour-du-lich-nha-trang/nht000001"><strong>Tour Nha Trang 3 ngày 2 đêm</strong></a>:</p>

<p><strong>Đi máy bay</strong>: quý khách tập trung tại sân bay Tân Sơn Nhất (ga quốc nội).</p>

<p>Đến Nha Trang, xe và hướng dẫn viên địa phương đón đoàn về khách sạn nhận phòng, nghỉ ngơi.</p>

<p><strong>14h00: </strong>Khởi hành đến <strong>Thiên đường giải trí Vinpearl Land', N'5 Ngày 6 Đêm', 18, 50, N'Nha Trang', 24, CAST(0x0000AB8200000000 AS DateTime), 0)
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
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (64, N'Du Lịch Chùa Hương 1 Ngày - Lễ Phật Cầu Tài Lộc', N'<p><span style="font-size:small"><span style="font-family:arial"><span style="font-size:medium"><strong><span style="color:#000000">Hà Nội</span> - Chùa Hương - Hà Nội</strong> </span><br />
Thời gian: 01&nbsp;NGÀY - Khởi hành HÀNG NGÀY<br />
<br />
<em>&nbsp;</em></span></span></p>

<p style="text-align:justify"><em><strong><span style="font-size:small"><span style="font-family:arial"><span style="color:#000000">Du&nbsp; lịch 1 ngày đến với Chùa Hương</span></span></span></strong><span style="font-size:small"><span style="font-family:arial"><span style="color:#000000"> - cách nói trong dân gian, trên thực tế chùa Hương hay Hương Sơn là cả một quần thể văn hóa - tôn giáo Việt Nam, gồm hàng chục ngôi chùa thờ Phật, vài ngôi đền thờ thần, các ngôi đình, thờ tín ngưỡng nông nghiệp. Trung tâm chùa Hương nằm ở xã Hương Sơn, huyện Mỹ Đức, Hà Nội, nằm ven bờ phải sông Đáy.<br />
<br />
Trung tâm của cụm đền chùa tại vùng này chính là chùa Hương nằm trong động Hương Tích hay còn gọi là chùa Trong. Chùa Hương có nhiều công trình kiến trúc rải rác trong thung lũng suối Yến. Khu vực chính là chùa Ngoài, còn gọi là chùa Trò, tên chữ là chùa Thiên Trù</span></span></span></em><br />
<br />
<strong><span style="font-family:arial; font-size:small">07h00:</span></strong><span style="font-family:arial; font-size:small"> Xe và hướng dẫn viên của công ty đón quý khách tại điểm hẹn khởi hành đi </span><strong><span style="font-family:arial; font-size:small">du lịch Chùa Hương.</span></strong><br />
<strong><span style="font-family:arial; font-size:small">09h00</span></strong><span style="font-family:arial; font-size:small">: Sau 2 giờ đi ô tô qua thành phố Hà Đông, tới Vân Đình, đến bến Đục thì dừng xe để chuyển sang đi thuyền dọc suối Yến Vĩ. Dòng suối Yến dài chừng 3 km, uốn lượn dưới chân núi sẽ đưa quý khách đến điểm dừng chân đầu tiên: Đền Trình. Lễ xong đền Trình, Quý khách sẽ lên thuyền đi tiếp tới chùa Thiên Trù.</span><br />
<span style="font-family:arial; font-size:small">Trên đường đi, Quý khách sẽ được ngắm nhìn những ngọn núi mang các hình thù kỳ vĩ: sư tử phục, núi Mâm Xôi và đi qua cây cầu Hội rất đẹp và nổi tiếng của Chùa Hương.&nbsp;</span><br />
<span style="font-family:arial; font-size:small">Tiếp tục leo núi để đến động Hương Tích - nơi chúa Trịnh Sâm đến vãn cảnh và đặt tên cho động: "Nam thiên đệ nhất động". Động Hương Tích là nơi phong cảnh hữu tình mà Đức Phật Quan Thế Diệu Thiện đã tu hành đắc đạo.</span><br />
<strong><span style="font-family:arial; font-size:small">12h00</span></strong><span style="font-family:arial; font-size:small">: Quý khách quay trở lại bến đò Thiên Trù ăn trưa. Sau khi ăn trưa du khách lên thăm quan và thắp hương tại chùa Thiên Trù – Bếp của Trời.</span><br />
<strong><span style="font-family:arial; font-size:small">15h00:</span></strong><span style="font-family:arial; font-size:small"> Quý khách quay trở lại thuyền về bến lên xe ô tô về Hà Nội.&nbsp;</span><br />
<strong><span style="font-family:arial; font-size:small">18h30: </span></strong><span style="font-family:arial; font-size:small">Tới Hà Nội, hướng dẫn viên chia tay đoàn, kết thúc chuyến du lịch </span><strong><span style="font-family:arial; font-size:small">du lịch chùa Hương 1 ngày.</span></strong></p>
', N'1 Ngày', 21, 60, N'Hà N?i', 24, CAST(0x0000AB8300000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (65, N'HÀ GIANG - ĐỒNG VĂN - TÂN TRÀO - BA BỂ - CAO BẰNG', N'<div class="tab-pane active" id="program">
<div class="tab-pane active" id="program">
<p style="text-align:center"><span style="font-size:14px"><span style="color:#ff0000"><strong><span style="background-color:#ffff00">TOUR DU LỊCH ĐÔNG BẮC 7 NGÀY 6 ĐÊM</span></strong></span></span></p>

<p style="text-align:center"><span style="font-size:14px"><span style="color:#ff0000"><strong><span style="background-color:#ffff00">HÀ NỘI - HÀ GIANG - ĐỒNG VĂN - TÂN TRÀO - BA BỂ - CAO BẰNG</span></strong></span></span></p>

<p><span style="font-size:14px"><em>Tour du lịch Đông Bắc 7 ngày 6 đêm, Cholontourist sẽ cùng du khách khám phá vẻ đẹp hùng vĩ của cao nguyên đá Đồng Văn, về thăm lại chiến khu Tân Trào, hang Pác Pó. Hòa mình vào thiên nhiên xanh mát giữa hồ Ba Bể, thác Bản Giốc,...</em></span></p>

<h2 style="text-align:justify"><span style="font-size:14px"><strong>NGÀY 1: TP. HCM - HÀ NỘI - TÂN TRÀO - HÀ GIANG<em>(Ăn 3 bữa)</em></strong></span></h2>

<p><span style="font-size:14px"><strong><u>Sáng:</u></strong>&nbsp; Xe và HDV đón Quý khách tại sân bay Nội Bài (chuyến bay hạ cánh trước 08h30), khởi hành đi Hà Giang.&nbsp;Quý khách dừng chân ăn trưa tại Tân Trào.</span></p>

<p><span style="font-size:14px"><strong><u>Chiều:</u></strong>&nbsp;Quý khách thăm quan&nbsp; <strong>Khu di tích&nbsp;Tân Trào - thăm đình Hồng Thái,&nbsp;Cây đa Tân Trào,&nbsp;Lán Nà Lừa</strong>&nbsp;-&nbsp;nơi ở và làm việc của&nbsp;Bác Hồ&nbsp;từ tháng 6 đến tháng 8 năm 1945 chuẩn bị cho cuộc tổng khởi nghĩa. Đoàn tiếp tục hành trình đi&nbsp;Hà Giang, ngắm cảnh đẹp yên bình vùng cao hoang sơ đến kỳ ảo. Quý khách đến Hà Giang, nhận phòng, ăn tối, nghỉ ngơi&nbsp;</span></p>

<p style="text-align:center">&nbsp;</p>

<p><span style="font-size:14px"><strong><u>Tối:</u></strong>&nbsp;Tự do khám phá Hà Giang về đêm.</span></p>

<h2 style="text-align:justify"><span style="font-size:14px"><strong>NGÀY 2: HÀ GIANG - LŨNG CÚ - ĐỒNG VĂN<em>(Ăn 3 bữa)</em></strong></span></h2>

<p><span style="font-size:14px"><strong><u>Sáng:</u></strong>&nbsp;Quý khách khởi hành đi&nbsp;<strong>Cao nguyên đá Đồng Văn</strong> - Khám phá vẻ đẹp hoang sơ, hùng vĩ của núi rừng Đông Bắc, dừng chân tại&nbsp;<strong>Cổng Trời Quản Bạ</strong>&nbsp;ngắm toàn bộ thị trấnTam Sơn, xã&nbsp;Quản Bạ, dừng chân thăm &amp; chụp hình lưu niệm tại&nbsp;<strong>Núi Đôi (núi&nbsp;Cô Tiên</strong>) -&nbsp;một thắng cảnh đẹp nổi tiếng của thị trấn và cũng là một minh chứng về lòng chung thủy của nhân gian truyền lại từ đời này qua đời khác. Quý khách ăn trưa tại Yên Minh.</span></p>

<p style="text-align:center">&nbsp;</p>

<p><span style="font-size:14px"><strong><u>Chiều:</u></strong>&nbsp;Đoàn khởi hành thăm khu dinh thự&nbsp;<strong>vua Mèo Vương Chí Sình</strong> – Vị vua cai quản toàn bộ người Hmong trên vùng đất phiên dậu của Việt Nam. Tiếp tục khởi hành đi <strong>Lũng Cú </strong>-&nbsp;Điểm cực bắc của tổ quốc, tham quan và chụp ảnh tại đỉnh cao nhất của <strong>cột cờ Lũng Cú. </strong>Lên xe về Đồng Văn nhận phòng khách sạn</span></p>

<p style="text-align:center">&nbsp;</p>

<p><span style="font-size:14px"><strong><u>Tối:</u></strong>&nbsp;Ăn tối tại nhà hàng và thưởng thức các món ăn đặc sản của vùng&nbsp;Cao nguyên Núi Đá. Nghỉ đêm khách sạn tại Đồng Văn.</span></p>

<h2 style="text-align:justify"><span style="font-size:14px"><strong>NGÀY 3:&nbsp;ĐỒNG VĂN - MÈO VẠC - TUYÊN QUANG<em>(Ăn 3 bữa)</em></strong></span></h2>

<p><span style="font-size:14px"><strong><u>Sáng:</u></strong>&nbsp;Quý khách ăn sáng, khởi hành đi dọc con đường Hạnh Phúc với máu và sinh mạng của hàng nghìn người dân trên những mảng đá tai mèo lởm chởm – được xem như Vạn lý trường thành của Việt Nam. Quý khách dừng chân tại &nbsp;<strong>đèo Mã Pì Lèng, chụp hình lưu niệm, ngắm dòng sông Nho Quế mỏng manh như sợi chỉ dưới chân đèo… </strong>Tiếp tục khởi hành đến <strong>thị trấn Mèo Vạc</strong>, &nbsp;tự do thăm quan và mua sắm đặc sản vùng cao về làm quà. Đoàn đi qua con <strong>đường hình chữ M</strong> và dừng chân chụp ảnh lưu niệm (con đường có một không hai tại Việt Nam). Quý khách ăn trưa tại&nbsp;thị trấn Bắc Mê.</span></p>

<p><span style="font-size:14px"><strong><u>Chiều</u></strong>: Quý khách tiếp tục khởi hành về Tuyên Quang,&nbsp; nhận phòng nghỉ ngơi, Ăn tối tại nhà hàng và thưởng thức các món ăn đặc sản của địa phương. Nghỉ đêm tại khách sạn.</span></p>

<h2 style="text-align:justify"><span style="font-size:14px"><strong>NGÀY 4: TUYÊN QUANG - THÁI NGUYÊN - HỒ BA BỂ<em>(Ăn 3 bữa)</em></strong></span></h2>

<p><span style="font-size:14px"><strong><u>Sáng:</u></strong>&nbsp;Quý khách khởi hành đi&nbsp; Hồ Ba Bể ( theo QL3 tới ngã ba thị trấn Nà Phặc). Nhận phòng, ăn trưa, nghỉ ngơi.</span></p>

<p><span style="font-size:14px"><strong><u>Chiều:</u></strong>&nbsp;Quý khách ra bến xuống thuyền đi thăm <strong><u>hồ Ba Bể, thăm động Puông, Ao Tiên, đền An Mã</u></strong><u>.</u>..</span></p>

<p style="text-align:center">&nbsp;</p>

<p><span style="font-size:14px"><strong><u>Tối:</u></strong> Khám phá Ba Bể về đêm.</span></p>

<h2 style="text-align:justify"><span style="font-size:14px"><strong>NGÀY 5: BA BỂ - CAO BẰNG - PẮC PÓ<em>(Ăn 3 bữa)</em></strong></span></h2>

<p><span style="font-size:14px"><strong><u>Sáng:</u></strong> Quý khách khởi hành đi Cao Bằng, ngắm cảnh hũng vỹ Đông Bắc hoang sơ, nhận phòng, ăn trưa, nghỉ ngơi tại Cao Bằng.</span></p>

<p><span style="font-size:14px"><strong><u>Chiều:</u></strong> Quý khách lên xe đi thăm <strong><u>Khu di tích cách mạng Pắc Pó, suối Lê Nin</u> – Nơi Bác Hồ </strong>đã sống và làm việc nhiều năm tại đây<strong>, <u>ghé mộ anh Kim Đồng.</u></strong></span></p>

<p style="text-align:center">&nbsp;</p>

<p><span style="font-size:14px"><strong><u>Tối:</u></strong> Khám phá Cao Bằng về đêm.</span></p>

<h2 style="text-align:justify"><span style="font-size:14px"><strong>NGÀY 6: CAO BẰNG - THÁC BẢN GIỐC - ĐỘNG NGƯỜM NGAO - LẠNG SƠN<em>(Ăn 3 bữa)</em></strong></span></h2>

<p><span style="font-size:14px"><strong><u>Sáng:</u></strong> &nbsp;Quý khách khởi hành đi tham quan <strong><u>Thác Bản Giốc</u></strong> - nằm giữa Việt Nam và Trung Quốc , được xem là Đệ nhất thác với phong cảnh đẹp mê hồn. Quý khách tham quan <strong><u>Động Ngườm Ngao</u></strong> - chiêm ngưỡng khu “tứ trụ thiên đình” với những cột đá trông như cột chống trời.</span></p>

<p style="text-align:center">&nbsp;</p>

<p><span style="font-size:14px"><strong><u>Chiều:</u></strong> Quý khách khởi hành về Lạng Sơn, qua ngả Thất Kê, nhận phòng, ăn tối tại Lạng Sơn.</span></p>

<p><span style="font-size:14px"><strong><u>Tối:</u></strong> Khám phá Lạng Sơn về đêm.</span></p>

<h2 style="text-align:justify"><span style="font-size:14px"><strong>NGÀY 7: LẠNG SƠN - NỘI BÀI - TP. HCM<em>(Ăn sáng, trưa)</em></strong></span></h2>

<p><span style="font-size:14px"><strong><u>Sáng:</u></strong>&nbsp; Quý khách khởi hành về <strong>Lạng Sơn, <u>ghé chợ Đông Kinh mua sắm hàng hoá</u></strong>...ăn trưa tại nhà hàng.</span></p>

<p><span style="font-size:14px"><strong><u>Chiều:</u></strong> Quý khách tiếp tục khởi hành về sân bay Nội Bài, làm thủ tục lên chuyến bay chiều về TP.HCM. Chia tay Quý khách - Kết thúc chương trình và hẹn gặp lại.</span></p>

<p style="text-align:center"><span style="font-size:14px"><span style="color:#008000"><strong><em>KÍNH CHÚC QUÝ KHÁCH CHUYẾN ĐI VUI VẺ VÀ TRẢI NGHIỆM THÚ VỊ !!</em></strong></span></span></p>
</div>
</div>
', N'4 Ngày 3 Đêm', 18, 49, N'Hà N?i', 24, CAST(0x0000AB8800000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (66, N'Cao Bằng - Bắc Cạn - Lạng Sơn', N'<div class="tab-pane active" id="program">
<p style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><strong><em><u>Ngày 1:</u></em></strong>&nbsp;&nbsp; <strong>Tp.HCM – Hà Nội – Cao Bằng</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:14px">Xe đón đoàn tại điểm hẹn, đưa ra sân bay Tân Sơn Nhất đáp máy bay đi Hà Nội. Dùng điểm tâm trên máy bay. Đến Hà Nội, xe đón đoàn tại sân bay và khởi hành đi Cao Bằng. Dùng cơm trưa tại Bắc Kạn.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều đến Cao Bằng nhận phòng. Dùng cơm chiều. Tối dạo phố tự do.</span></p>

<p style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><strong><em><u>Ngày 2</u>:&nbsp;&nbsp; Cao Bằng – Pắc Bó – thác Bản Giốc</em></strong></span></span></p>

<p style="text-align:justify"><span style="font-size:14px">Dùng điểm tâm sáng tại khách sạn. Xe đưa đoàn đi <strong><em>Hà Quảng</em></strong> tham quan di tích <strong><em><u>hang Pắc Bó</u></em></strong> – <strong><em><u>núi Các Mác</u></em></strong> – <strong><em><u>súôi Lê Nin</u></em></strong>., nơi Bác Hồ đã ở&nbsp; &nbsp;và làm việc để lãnh đạo cách mạng Việt Nam sau 30 năm ra đi tìm đường cứu nước. Tham quan quê hương anh Kim Đồng tại <strong><em><u>bản Nà Mạ</u></em></strong>, viếng <strong><em><u>mộ anh Kim Đồng</u></em></strong> – người đội viên đầu tiên của Đội Thiếu Niên Tiền Phong Việt Nam. Dùng cơm trưa tại Trùng Khánh.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều tham quan <strong><em><u>động Ngườm Ngao</u></em></strong> – một hang động với những thạch nhủ kỳ ảo đủ màu sắc… tham quan <strong><em><u>thác Bản Giốc</u></em></strong> – một tuyệt phẩm hùng vĩ của thiên nhiên nằm giữa biên giới Việt – Trung. Trên đường về dừng chân tham quan <strong><em><u>làng rèn Phúc Sen</u></em></strong>. Dùng cơm chiều.&nbsp; Tối tự do. Nghỉ đêm tại Cao Bằng.</span></p>

<p style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><strong><em><u>Ngày 3</u>:&nbsp;&nbsp; Bắc Kạn – vườn quốc gia Ba Bể</em></strong></span></span></p>

<p style="text-align:justify"><span style="font-size:14px">Dùng điểm tâm, trả phòng. Rời Cao Bằng đi qua Nà Phặc, Chợ Rã đến <strong><em><u>vườn quốc gia Ba Bể</u></em></strong>. Nhận phòng. Dùng cơm trưa.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều xe đưa đoàn đến <strong><em><u>bến thuyền Buốc Lòm</u></em></strong>, đi thuyền trên <strong><em><u>sông Năng</u></em></strong> tham quan <strong><em><u>động Puông</u></em></strong>, <strong><em><u>thác Đầu Đẵng</u></em></strong>, tham quan <strong><em><u>làng dân tộc Pắc Ngòi</u></em></strong>. Đi thuyền tham quan thắng cảnh <strong><em><u>Hồ Ba Bể</u></em></strong> – một bức tranh sơn thủy tuyệt tác của thiên nhiên ban tặng. Trở về bến thuyền, xe đón đoàn đi xuyên qua rừng quốc gia Ba Bể về khách sạn. Dùng cơm chiều. Tối sinh hoạt tự do tại vườn.</span></p>

<p style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><strong><em><u>Ngày 4</u>:&nbsp; Bắc Kạn – Đồng Đăng – Lạng Sơn</em></strong></span></span></p>

<p style="text-align:justify"><span style="font-size:14px">Dùng điểm tâm.Trả phòng. Khởi hành đi Lạng Sơn, dùng cơm trưa tại Bình Gia.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều đến Lạng Sơn tham quan <strong><em><u>cửa khầu Hữu Nghị Quan</u></em></strong> – biên giới Việt – Trung. Nhận phòng khách sạn. Dùng cơm chiều. Tối tham quan và mua sắm tại <strong><em><u>chợ đêm Kỳ Lừa</u></em></strong>. Nghỉ đêm tại Lạng Sơn.</span></p>

<p style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><strong><em><u>Ngày 5</u>:&nbsp; Lạng Sơn – Mẫu Sơn – Hà Nội</em></strong></span></span></p>

<p style="text-align:justify"><span style="font-size:14px">Dùng điểm tâm tại khách sạn. Xe đưa đoàn tham quan <strong><em><u>thị trấn Đồng Đăn', N'4 Ngày 3 Đêm', 18, 50, N'TP HCM', 24, CAST(0x0000AB8800000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (67, N'Hà Nội - Hòa Bình - Mai Châu', N'<p style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><strong><u>Ngày 01:</u> Hà Nội – Mai Châu ( Ăn: Trưa, Tối)</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:14px">Sáng: Đón Quý khách tại&nbsp; điểm hẹn khởi hành đi <strong>Mai Châu. </strong>Trên đường đi xe dừng chân tại Lương Sơn, Hòa Bình cho Quý khách nghỉ ngơi, thư giãn. Qua dốc Cun quanh co hiểm trở, đèo Thung Nhuối thung lũng Mai Châu xinh đẹp sẽ được hiện ra dưới tầm mắt du khách với màu xanh ngút ngàn của đồng ruộng, thấp thoáng xa xa là những nếp nhà nằm nép mình trong dãy núi phủ kín mây mù.<br />
11h30: Đoàn nghỉ ngơi, ăn trưa tại bản Lác.<br />
Chiều:&nbsp; HDV đưa Quý khách đi thăm quan <strong>bản Lác,</strong> tìm hiểu cuộc sống và văn hóa của người Thái trắng. Quý khách&nbsp; ăn tối tại nhà sàn Thái ở bản Lác, sau khi ăn tối khách <strong>có thể tự do tham gia các chương trình ca nhạc dân tộc Thái</strong>. Khách ngủ tại nhà sàn Thái - bản Lác - Mai Châu</span></p>

<p style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><strong><u>Ngày 02</u>: Mai Châu - Hà Nội ( Ăn:&nbsp; Sáng, Trưa)</strong></span></span></p>

<p style="text-align:justify"><span style="font-size:14px">Sáng: Ăn sáng tại bản Lác,&nbsp; đi bộ 7km từ bản Lác qua bản Poom Cọng và Nà Pọn. Tour đi bộ kết thúc ở chợ Mai Châu.<br />
11h30 ăn trưa, sau đó khách sẽ nghỉ trưa tự do mua sắm &nbsp;tại bản Lác.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều: Xe đón khách về Hà Nội lúc 15h30. Tới Hà Nội, chia tay đoàn và hẹn ngày gặp lại.</span></p>
', N'2 Ngày 1 Đêm', 18, 47, N'Hà N?i', 24, CAST(0x0000AB8800000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (68, N'Quy Nhơn - Thành phố bình yên', N'<p style="text-align:center"><span style="color:#ff0000"><span style="font-size:18px"><strong><span style="background-color:#ffff00">QUY NHƠN - THÀNH PHỐ BÌNH YÊN</span></strong></span></span></p>

<h2 style="text-align:justify"><strong><u>NGÀY 1:</u> ĐÓN KHÁCH - QUY NHƠN CITY TOUR<em>(Ăn trưa, tối)</em></strong></h2>

<ul>
	<li style="text-align:justify"><span style="font-size:14px"><u><strong>Sáng:</strong></u> Quý khách tập trung tại sân bay Tân Sơn Nhất (ga quốc nội), đáp chuyến bay đi Quy Nhơn. Đến Quy Nhơn, xe đón đưa quý khách về khách sạn nhận phòng (nếu có, vì giờ nhận phòng là 14h00).</span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px">Ăn Trưa tại nhà hàng địa phương.&nbsp; Sau bữa trưa, về lại khách sạn nghỉ ngơi.</span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px"><u><strong>Chiều:</strong></u> Thăm quan <strong><u>KDL Ghềnh Ráng Tiên Sa - dốc Mộng Cầm, đồi Thi Nhân, viếng mộ Hàn Mặc Tử, Bãi tắm Hoàng Hậu, bãi tắm Tiên Sa</u></strong><em>.</em> Qúy khách được nghe thuyết minh về cuộc đời sự nghiệp tài hoa của thi sỹ Hàn Mặc Tử - Một của đời ngắn ngủi như đã kịp lóe sáng trên nền trời thơ ca Việt Nam và sống mãi trong lòng công chúng yêu thơ Hàn. Thưởng thức tài nghệ bút lửa Dũ Kha và cùng chia sẻ niềm đam mê thơ Hàn.&nbsp;</span></li>
</ul>

<p style="text-align:center">&nbsp;</p>

<ul>
	<li style="text-align:justify"><span style="font-size:14px">Quý khách ngắm nhìn toàn cảnh thành phố biển Quy Nhơn từ trên cao </span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px">&nbsp;Tham quan <strong><u>Nhà Thờ Chánh Tòa</u></strong><u>:</u> Được xây dựng vào năm 1938 bởi Giám mục Tardieu, do hội kiến trúc sư SIDEC thiết kế và khánh thành vào ngày 10 tháng 12 năm 1939 với tước hiệu Đức Mẹ Mân Côi. Nhà thờ được xây dựng theo bố cục hình thánh giá. Điểm đặc biệt là nhà thờ có một tháp nhọn 47,2m cao vút lên nền trời. Chính điều này lý giải vì sao người dân thường quen gọi đây là Nhà Thờ Nhọn. Đây là một điểm tham quan rất ấn tượng mang ý nghĩa lịch sử và gắn với quá trình hình thành và phát triển đô thị Quy Nhơn, nơi mà Quý Khách không nên bỏ qua khi đến với thành phố yên bình này.</span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px">Tiếp tục thăm quan <strong><u>Tháp Đôi</u></strong> – cụm tháp với 02 ngọn tháp cổ có lối kiến trúc Angkor, được xây dựng từ thế kỷ thứ XII nằm trên bình diện phẳng ngay trong lòng thành phố Quy Nhơn.</span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px">Quý khách thưởng thức bữa tối tại nhà hàng trong thành phố.</span></li>
	<li style="text-align:justify"><span style="font-size:14px">Tối về lại KS nghỉ ngơi.</span></li>
</ul>

<p style="text-align:justify">&nbsp;</p>

<h2 style="text-align:justify"><strong><u>NGÀY 2:</u> THIÊN ĐƯỜNG BIỂN ĐẢO KỲ CO<em>(Ăn sáng, trưa)</em></strong></h2>

<ul>
	<li style="text-align:justify"><span style="font-size:14px">Sáng 07h30: Xe và HDV đón quý khách tại điểm hẹn đưa quý khách khởi hành đi Nhơn Lý.</span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px">Vượt <strong><u>Cầu Thị Nại</u></strong> –&nbsp; cây cầu vượt biển dài nhất Việt Nam với chiều dài gần 2,5km. Tại đây Quý Khách có thể dừng chân, ngắm những tia nắng vàng rắc trên Đầm Thị Nại, và nghe kể về những trận thủy chiến bi tráng giữa Champa và Đại Việt, giữa Tây Sơn và nhà Nguyễn (Nguyễn Ánh) suốt hơn 5 thế kỷ.</span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px">Tham quan <strong><u>Eo Gió</u></strong> – một ghềnh đá quanh năm lộng gió. Đứng trên Eo Gió, phóng tầm mắt ra xa, quý khách chiêm ngưỡng bao quát cả vùng biển bao la rộng lớn, đắm say lòng người.</span></li>
</ul>

<ul>
	<li style="text-align:justify"><span style="font-size:14px"><strong><u>Tịnh xá Ngọc Hoà</u></strong> – chiêm ngưỡng tượng phật đôi cao nhất Việt Nam. Trong đó ', N'3 Ngày 2 Đêm', 19, 50, N'Quy Nhon City', 24, CAST(0x0000AB8800000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (69, N'Đà Nẵng - Hội An - Huế - Động Thiên Đường', N'<div class="tab-pane active" id="program">
<h4 style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><em><u>Ngày 1:</u></em><em> Tp.Hồ Chí Minh – Đà Nẵng</em></span></span></h4>

<p style="text-align:justify"><span style="font-size:14px">Xe của công ty đón quý khách tại điểm hẹn và đưa sa sân bay Tân Sơn Nhất, đáp máy bay đi Đà Nẵng.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Đến Đà Nẵng, đoàn dùng cơm trưa. Nhận phòng khách sạn, nghỉ ngơi.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều xe đưa đoàn tham quan <em><u>Ngũ Hành Sơn</u></em>, tham quan và mua sắm tại <strong><em><u>làng điêu khắc đá mỹ nghệ Non Nước</u></em></strong>. Đoàn tham quan <strong>bán đảo Sơn Trà</strong> và <strong>cảng Tiên Sa</strong>, viếng <strong><em><u>chùa Linh Ứng</u></em></strong>, Bãi Bụt, chiêm bái <strong><em><u>tượng Quan Thế Âm</u></em></strong> cao nhất Việt Nam. Đoàn <strong><em><u>tắm biển tại Mỹ Khê</u></em></strong>, một trong những bãi biển sạch và đẹp nhất Đà Nẵng.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Dùng cơm chiều. Tối tự do dạo phố Đà Nẵng về đêm.</span></p>

<h4 style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><em><u>Ngày 2</u>: Đà Nẵng – Hội An – Huế</em></span></span></h4>

<p style="text-align:justify"><span style="font-size:14px">Dùng điểm tâm. Xe đưa đoàn đi Quảng Nam , tham quan Phố Cổ Hội An - di sản văn hóa thế giới, tham quan <strong><em><u>chùa Cầu</u></em></strong>, <strong><em><u>Hội Quán Phúc Kiến</u></em></strong>, <strong><em><u>nhà cổ Phùng Hưng</u></em></strong>, <strong><em><u>Quan Công Miếu</u></em></strong>, <strong><em><u>Bảo Tàng Hội An</u></em></strong>… Dùng cơm trưa.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều&nbsp; đoàn khởi hành đi Huế, vượt&nbsp; đèo Hải Vân, đừng chân trên đỉnh đèo tham quan <strong><em><u>Hải Vân Đệ Nhất Hùng Quan</u></em></strong>, dừng chân tham quan <strong><em><u>bãi biển Lăng Cô</u></em></strong> dưới chân đèo.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Đến Huế nhận phòng. Tối đi thuyền thưởng thức <strong><em><u>Ca Huế trên sông Hương</u></em></strong>.</span></p>

<h4 style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><em><u>Ngày 3</u>: Huế&nbsp; – Quảng Bình:</em></span></span></h4>

<p style="text-align:justify"><span style="font-size:14px">Dùng điểm tâm. Đoàn viếng <strong><em><u>chùa Thiên Mụ</u></em></strong> nằm soi bóng bên dòng sông Hương, Tham quan <strong>Kinh Thành Huế ( Đại Nội) </strong>: <strong>Ngọ Môn, Lầu Ngũ Phụng, điện Thái Hòa, Thái Miếu</strong>… Dùng cơm trưa.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều đoàn đi Quảng Bình, trên đường dừng chân tham quan <strong><em><u>Vĩ Tuyến 17</u></em></strong>, <strong><em><u>cầu Hiền Lương</u></em></strong>, <strong><em><u>sông Bến Hải</u></em></strong>. đến Đồng Hới dùng cơm chiều, nhận phòng. Tối tự do dạo <strong><em><u>biển Nhật Lệ</u></em></strong>.</span></p>

<h4 style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><em><u>Ngày 4</u>: Quảng Bình – Động Thiên Đường – Huế</em></span></span></h4>

<p style="text-align:justify"><span style="font-size:14px">Dùng điểm tâm, trả phòng. Xe đưa đoàn tham quan <strong><em><u>động Thiên Đường</u></em></strong>, một hàng động kỳ vĩ và dài nhất thế giới, với hàng ngàn thạch nhủ mang nhiều hình dáng độc đáo, hoàng tráng … Dùng cơm trưa.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều đoàn khởi hành về Huế theo cung đường <strong><em>Hồ Chí Minh huyền thoại</em></strong>, viếng <strong><em><u>Nghĩa Trang Trường Sơn</u></em></strong>.&nbsp; Đến Huế dùng cơm chiều. Tối tự do.</span></p>

<h4 style="text-align:justify"><span style="font-size:14px"><span style="color:#005baa"><em><u>Ngày 5</u>: Huế – Tp.HCM</em><', N'5 Ngày 4 Đêm', 19, 50, N'Ðà N?ng', 24, CAST(0x0000AB8800000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (70, N'Đà Nẵng - Hội An - Huế', N'<div class="tab-pane active" id="program">
<p style="text-align:justify"><span style="font-size:14px"><strong><span style="color:#005baa"><em><u>Ngày 1</u></em><em>: Tp.Hồ Chí Minh – Đà Nẵng</em></span></strong></span></p>

<p style="text-align:justify"><span style="font-size:14px">5:00 Quí khách tập trung tại điểm hẹn, xe đón đoàn đưa ra sân bay Tân Sơn Nhất đáp máy bay đi Đà Nẵng. Đến Đà&nbsp; Nẵng quí khách nhận phòng, dùng cơm trưa.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều xe đưa đoàn&nbsp; <strong><em><u>tham quan Ngũ Hành Sơn</u></em></strong> : <strong><em><u>Vọng Giang Đài</u></em></strong>, <strong><em><u>Vọng</u></em></strong> <strong><em><u>&nbsp;Hải Đài</u></em></strong>, <strong><em><u>chùa Tam Thai</u></em></strong>, <strong><em><u>động Huyền Không</u></em></strong>, <strong><em><u>chùa Linh Ứng</u></em></strong>… Sau đó đoàn xuống núi tham quan và mua quà lưu niệm tại làng điêu khắc đá mỹ nghệ dưới chân núi, <strong><em><u>tắm biển Non Nước</u></em></strong>. Tối nghỉ đêm tại Hội An, tham quan&nbsp; <strong>“đêm phố cổ”</strong> (nếu vào ngày rằm AL).</span></p>

<p style="text-align:justify"><span style="font-size:14px"><strong><span style="color:#005baa"><em><u>Ngày 2</u>: Hội An - Huế</em></span></strong></span></p>

<p style="text-align:justify"><span style="font-size:14px">Dùng điểm tâm. Xe đưa đoàn tham quan <strong><em><u>Phố Cổ Hội An</u></em></strong> – di sản văn hóa thế giới, tham quan <strong><em><u>chùa Cầu</u></em></strong>, <strong><em><u>Hội Quán Phúc Kiến</u></em></strong>, <strong><em><u>nhà cổ Phùng Hưng</u></em></strong>, <strong><em><u>Quan Công Miếu</u></em></strong>, <strong><em><u>Bảo Tàng Hội An</u></em></strong>… Dùng cơm trưa.</span></p>

<p style="text-align:justify"><span style="font-size:14px">chiều trả phòng. Khởi hành đi Huế, vượt <strong><em><u>đèo Hải Vân</u></em></strong>, dừng chân trên đỉnh đèo tham quan <strong><em><u>Hải Vân Đệ Nhất Hùng Quan</u></em></strong>, ngắm nhìn <strong><em><u>bãi biển Lăng Cô</u></em></strong> từ trên cao. Đến Huế nhận phòng, dùng cơm chiều. Tối dạo phố tự do.</span></p>

<p style="text-align:justify"><span style="font-size:14px"><strong><span style="color:#005baa"><em><u>Ngày 3</u>: Tham quan Huế</em></span></strong></span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều đoàn Viếng &nbsp;<strong><em><u>lăng Vua Tự Đức</u></em></strong> – &nbsp;một quần thể kiến trúc hoành tráng và thơ mộng,&nbsp; <strong><em><u>lăng Vua Khải Định</u></em></strong>. Dùng cơm trưa</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều xe đưa đoàn viếng <strong><em><u>chùa Thiên Mụ</u></em></strong> cổ kính soi bóng bên dòng Hương giang. Tham quan&nbsp; <strong><em><u>Kinh Thành Triều Nguyễn</u></em></strong> : <strong><em><u>Ngọ Môn</u></em></strong>, <strong><em><u>lầu Ngũ Phụng</u></em></strong>, <strong><em><u>Điện Thái Hòa</u></em></strong>, <strong><em><u>Thế Miếu</u></em></strong>….&nbsp; Thưởng thức các nón đặc sản Huế thay bữa cơm chiều. Tối <strong><em><u>đi thuyền trên sông Hương nghe ca Huế.</u></em></strong></span></p>

<p style="text-align:justify"><span style="font-size:14px"><strong><span style="color:#005baa"><em><u>Ngày 4</u>: Huế – Tp.HCM</em></span></strong></span></p>

<p style="text-align:justify"><span style="font-size:14px">Dùng điểm tâm, trả phòng khách sạn. Xe đưa đoàn đi <strong><em><u>chợ Đông Ba</u></em></strong> mua đặc sản Huế. Xe đưa đoàn ra sân bay Phú Bài đáp máy bay về Tp.HCM.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Đến Tp.HCM xe đưa đoàn về điểm hẹn kết thúc chuyến tham quan.</span></p>
</div>
', N'4 Ngày 3 Đêm', 18, 50, N'Ðà N?ng', 24, CAST(0x0000AB8800000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (71, N'Đà Nẵng - Hội An - Huế', N'<div class="tab-pane active" id="program">
<p style="text-align:justify"><span style="font-size:14px"><strong><span style="color:#005baa"><em><u>Ngày 1</u></em><em>: Tp.Hồ Chí Minh – Đà Nẵng</em></span></strong></span></p>

<p style="text-align:justify"><span style="font-size:14px">5:00 Quí khách tập trung tại điểm hẹn, xe đón đoàn đưa ra sân bay Tân Sơn Nhất đáp máy bay đi Đà Nẵng. Đến Đà&nbsp; Nẵng quí khách nhận phòng, dùng cơm trưa.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều xe đưa đoàn&nbsp; <strong><em><u>tham quan Ngũ Hành Sơn</u></em></strong> : <strong><em><u>Vọng Giang Đài</u></em></strong>, <strong><em><u>Vọng</u></em></strong> <strong><em><u>&nbsp;Hải Đài</u></em></strong>, <strong><em><u>chùa Tam Thai</u></em></strong>, <strong><em><u>động Huyền Không</u></em></strong>, <strong><em><u>chùa Linh Ứng</u></em></strong>… Sau đó đoàn xuống núi tham quan và mua quà lưu niệm tại làng điêu khắc đá mỹ nghệ dưới chân núi, <strong><em><u>tắm biển Non Nước</u></em></strong>. Tối nghỉ đêm tại Hội An, tham quan&nbsp; <strong>“đêm phố cổ”</strong> (nếu vào ngày rằm AL).</span></p>

<p style="text-align:justify"><span style="font-size:14px"><strong><span style="color:#005baa"><em><u>Ngày 2</u>: Hội An - Huế</em></span></strong></span></p>

<p style="text-align:justify"><span style="font-size:14px">Dùng điểm tâm. Xe đưa đoàn tham quan <strong><em><u>Phố Cổ Hội An</u></em></strong> – di sản văn hóa thế giới, tham quan <strong><em><u>chùa Cầu</u></em></strong>, <strong><em><u>Hội Quán Phúc Kiến</u></em></strong>, <strong><em><u>nhà cổ Phùng Hưng</u></em></strong>, <strong><em><u>Quan Công Miếu</u></em></strong>, <strong><em><u>Bảo Tàng Hội An</u></em></strong>… Dùng cơm trưa.</span></p>

<p style="text-align:justify"><span style="font-size:14px">chiều trả phòng. Khởi hành đi Huế, vượt <strong><em><u>đèo Hải Vân</u></em></strong>, dừng chân trên đỉnh đèo tham quan <strong><em><u>Hải Vân Đệ Nhất Hùng Quan</u></em></strong>, ngắm nhìn <strong><em><u>bãi biển Lăng Cô</u></em></strong> từ trên cao. Đến Huế nhận phòng, dùng cơm chiều. Tối dạo phố tự do.</span></p>

<p style="text-align:justify"><span style="font-size:14px"><strong><span style="color:#005baa"><em><u>Ngày 3</u>: Tham quan Huế</em></span></strong></span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều đoàn Viếng &nbsp;<strong><em><u>lăng Vua Tự Đức</u></em></strong> – &nbsp;một quần thể kiến trúc hoành tráng và thơ mộng,&nbsp; <strong><em><u>lăng Vua Khải Định</u></em></strong>. Dùng cơm trưa</span></p>

<p style="text-align:justify"><span style="font-size:14px">Chiều xe đưa đoàn viếng <strong><em><u>chùa Thiên Mụ</u></em></strong> cổ kính soi bóng bên dòng Hương giang. Tham quan&nbsp; <strong><em><u>Kinh Thành Triều Nguyễn</u></em></strong> : <strong><em><u>Ngọ Môn</u></em></strong>, <strong><em><u>lầu Ngũ Phụng</u></em></strong>, <strong><em><u>Điện Thái Hòa</u></em></strong>, <strong><em><u>Thế Miếu</u></em></strong>….&nbsp; Thưởng thức các nón đặc sản Huế thay bữa cơm chiều. Tối <strong><em><u>đi thuyền trên sông Hương nghe ca Huế.</u></em></strong></span></p>

<p style="text-align:justify"><span style="font-size:14px"><strong><span style="color:#005baa"><em><u>Ngày 4</u>: Huế – Tp.HCM</em></span></strong></span></p>

<p style="text-align:justify"><span style="font-size:14px">Dùng điểm tâm, trả phòng khách sạn. Xe đưa đoàn đi <strong><em><u>chợ Đông Ba</u></em></strong> mua đặc sản Huế. Xe đưa đoàn ra sân bay Phú Bài đáp máy bay về Tp.HCM.</span></p>

<p style="text-align:justify"><span style="font-size:14px">Đến Tp.HCM xe đưa đoàn về điểm hẹn kết thúc chuyến tham quan.</span></p>
</div>
', N'4 Ngày 3 Đêm', 19, 50, N'Ðà N?ng', 24, CAST(0x0000AB8800000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (72, N'tout 1', N'<p>Noi dung</p>
', N'2 Ngày 1 Đêm', 21, 40, N'Hà N?i', 24, CAST(0x0000AB9700000000 AS DateTime), 1)
INSERT [dbo].[tblTour] ([iMaTour], [sTieuDe], [sMoTa], [sTongThoiGian], [iMaNhomTour], [iSoCho], [sNoiKhoiHanh], [iMaNhanVien], [dNgayTao], [bTrangThai]) VALUES (73, N'Tour Du Lich 1', N'<p>Tour Du Lịch Mới</p>
', N'3 Ngày 2 Đêm', 21, 20, N'Hà N?i', 28, CAST(0x0000AB9D00000000 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tblTour] OFF
SET IDENTITY_INSERT [dbo].[tblTrangThaiDonDatTour] ON 

INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (77, 0, N'', 113, 15, CAST(0x0000AB8201631A98 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (78, 1, N'', 113, 15, CAST(0x0000AB8201634DE7 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (79, 0, N'', 114, 15, CAST(0x0000AB820166AF5E AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (80, 1, N'', 114, 15, CAST(0x0000AB820166E9ED AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (81, 3, N'', 113, 24, CAST(0x0000AB820167EB34 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (82, 1, N'', 113, 24, CAST(0x0000AB820169B92C AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (83, 2, N'huy tour', 114, 24, CAST(0x0000AB82016A33AC AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (84, 0, N'', 115, 24, CAST(0x0000AB8400013D0E AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (85, 1, N'', 115, 24, CAST(0x0000AB8400024B9A AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (86, 0, N'', 116, 0, CAST(0x0000AB84017D050F AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (87, 1, N'', 116, 24, CAST(0x0000AB84017D9E60 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (88, 0, N'', 117, 0, CAST(0x0000AB870011E036 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (89, 1, N'', 117, 0, CAST(0x0000AB8700120220 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (90, 0, N'', 119, 0, CAST(0x0000AB870177ED22 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (91, 1, N'', 119, 0, CAST(0x0000AB8701781470 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (92, 0, N'', 120, 24, CAST(0x0000AB87017AA1CA AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (93, 0, N'', 121, 24, CAST(0x0000AB87017BA964 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (94, 1, N'', 121, 24, CAST(0x0000AB87017BC7CD AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (95, 1, N'', 120, 24, CAST(0x0000AB87017BC9BE AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (96, 0, N'', 122, 24, CAST(0x0000AB88002ADBE3 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (97, 0, N'', 123, 0, CAST(0x0000AB8800BF3C01 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (98, 0, N'', 124, 0, CAST(0x0000AB8800BF42C8 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (99, 1, N'', 124, 24, CAST(0x0000AB8800BF90A0 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (100, 0, N'', 125, 0, CAST(0x0000AB8B000562AD AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (101, 1, N'', 125, 0, CAST(0x0000AB8B000580CE AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (102, 1, N'', 122, 0, CAST(0x0000AB8B0113A946 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (103, 3, N'', 125, 0, CAST(0x0000AB8B01412AF1 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (104, 1, N'', 125, 0, CAST(0x0000AB8B01414169 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (105, 3, N'', 113, 0, CAST(0x0000AB8B01414DAC AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (106, 1, N'', 113, 0, CAST(0x0000AB8B01415183 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (107, 4, N'', 114, 0, CAST(0x0000AB8B01530F9D AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (108, 4, N'', 114, 0, CAST(0x0000AB8B0153CEC8 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (109, 4, N'', 114, 24, CAST(0x0000AB8B0155409E AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (110, 4, N'Hoàn Tiền : 3,913,200 VND', 114, 0, CAST(0x0000AB8B0156A8F5 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (111, 4, N'Hoàn Tiền : 3,913,200 VND', 114, 0, CAST(0x0000AB8B01854D43 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (112, 3, N'', 121, 0, CAST(0x0000AB8B018A2F2F AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (113, 1, N'', 121, 0, CAST(0x0000AB8B018A393A AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (114, 3, N'', 124, 0, CAST(0x0000AB8C00026C30 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (115, 4, N'Hoàn Tiền : 1,920,000 VND', 124, 0, CAST(0x0000AB8C0005B556 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (116, 3, N'', 124, 0, CAST(0x0000AB8C00090B6C AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (117, 1, N'', 124, 0, CAST(0x0000AB8C000913BE AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (118, 2, N'okkk', 125, 0, CAST(0x0000AB8C00098BBB AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (119, 3, N'', 124, 0, CAST(0x0000AB8C000A2198 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (120, 0, N'', 126, 0, CAST(0x0000AB9C00F4D708 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (121, 1, N'', 126, 24, CAST(0x0000AB9C00F5256D AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (122, 0, N'', 127, 24, CAST(0x0000AB9C00F827E7 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (123, 1, N'', 127, 24, CAST(0x0000AB9C00F8CCE3 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (124, 0, N'', 128, 28, CAST(0x0000AB9D00FB16F8 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (125, 0, N'', 129, 28, CAST(0x0000AB9D00FC1621 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (126, 1, N'', 129, 28, CAST(0x0000AB9D0105091D AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (127, 2, N'huy tour', 129, 28, CAST(0x0000AB9D010ADF8A AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (128, 1, N'', 129, 28, CAST(0x0000AB9D010B3A68 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (129, 0, N'', 130, 28, CAST(0x0000AB9D011090F7 AS DateTime))
INSERT [dbo].[tblTrangThaiDonDatTour] ([iMaTrangThai], [iTrangThai], [sGhiChu], [iMaDon], [iMaNhanVien], [dthoigian]) VALUES (130, 0, N'', 131, 28, CAST(0x0000AB9D01197AF5 AS DateTime))
SET IDENTITY_INSERT [dbo].[tblTrangThaiDonDatTour] OFF
ALTER TABLE [dbo].[tblNhomTour] ADD  DEFAULT ((1)) FOR [bTrangThai]
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
ALTER TABLE [dbo].[tblGiaoDich]  WITH CHECK ADD  CONSTRAINT [FK_giaoDich_DonDatTour] FOREIGN KEY([iMaDonTour])
REFERENCES [dbo].[tblDonDatTour] ([iMaDonDatTour])
GO
ALTER TABLE [dbo].[tblGiaoDich] CHECK CONSTRAINT [FK_giaoDich_DonDatTour]
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
ALTER TABLE [dbo].[tblNhomVeGia]  WITH CHECK ADD  CONSTRAINT [FK_nhomvegia_tour] FOREIGN KEY([iMaTour])
REFERENCES [dbo].[tblTour] ([iMaTour])
GO
ALTER TABLE [dbo].[tblNhomVeGia] CHECK CONSTRAINT [FK_nhomvegia_tour]
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
