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

        public DonDatTour(int trangThai, int tienDaThanhToan, string ghiChu, DateTime ngayDat, DateTime ngayDuyet, int maDon, int maKH, int maTour, int maNVduyet)
        {
            this.TrangThai = trangThai;
            this.TienDaThanhToan = tienDaThanhToan;
            this.GhiChu = ghiChu;
            this.NgayDat = ngayDat;
            this.NgayDuyet = ngayDuyet;
            this.MaDon = maDon;
            this.MaKH = maKH;
            this.MaTour = maTour;
            this.MaNVduyet = maNVduyet;
        }


        public DonDatTour()
        {
            this.TrangThai = 0;
            this.TienDaThanhToan = 0;
            this.GhiChu = "";
            this.NgayDat = DateTime.Parse("05/05/2005");
            this.NgayDuyet = DateTime.Parse("05/05/2005");
            this.MaDon = 0;
            this.MaKH = 0;
            this.MaTour = 0;
            this.MaNVduyet = 0;
            this.ChoNL = 0;
            this.ChoTE = 0;
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
    }
}