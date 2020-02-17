using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebDatTour.Object
{
    public class DonDatTour
    {
       
        private int trangThai;
        
        //private string soDienThoai;
        private int tienDaThanhToan;
        private string ghiChu;
        private DateTime ngayDat; //DateTime.Parse("05/05/2005");
        private DateTime ngayDuyet;
        private int maDon;
        private int maKH;
        private int maTour;
        private int maNVduyet;
        private int choTE;
        private int choNL;
        private int maNgaydi;



        public DonDatTour()
        {
            this.trangThai = 0;
            this.tienDaThanhToan = 0;
            this.ghiChu = "";
            this.ngayDat = DateTime.Parse("05/05/2005");
            this.ngayDuyet = DateTime.Parse("05/05/2005");
            this.maDon = 0;
            this.maKH = 0;
            this.maTour = 0;
            this.maNVduyet = 0;
            this.choTE = 0;
            this.choNL = 0;
            this.maNgaydi = 0;
        }

        public DonDatTour(int trangThai, int tienDaThanhToan, string ghiChu, DateTime ngayDat, DateTime ngayDuyet, int maDon, int maKH, int maTour, int maNVduyet, int choTE, int choNL, int maNgaydi)
        {
            this.trangThai = trangThai;
            this.tienDaThanhToan = tienDaThanhToan;
            this.ghiChu = ghiChu;
            this.ngayDat = ngayDat;
            this.ngayDuyet = ngayDuyet;
            this.maDon = maDon;
            this.maKH = maKH;
            this.maTour = maTour;
            this.maNVduyet = maNVduyet;
            this.choTE = choTE;
            this.choNL = choNL;
            this.maNgaydi = maNgaydi;
        }


        public int TrangThai { get => trangThai; set => trangThai = value; }
        public int TienDaThanhToan { get => tienDaThanhToan; set => tienDaThanhToan = value; }
        public string GhiChu { get => ghiChu; set => ghiChu = value; }
        public DateTime NgayDat { get => ngayDat; set => ngayDat = value; }
        public DateTime NgayDuyet { get => ngayDuyet; set => ngayDuyet = value; }
        public int MaDon { get => maDon; set => maDon = value; }
        public int MaKH { get => maKH; set => maKH = value; }
        public int MaTour { get => maTour; set => maTour = value; }
        public int MaNVduyet { get => maNVduyet; set => maNVduyet = value; }
        public int ChoTE { get => choTE; set => choTE = value; }
        public int ChoNL { get => choNL; set => choNL = value; }
        public int MaNgaydi { get => maNgaydi; set => maNgaydi = value; }
    }
}