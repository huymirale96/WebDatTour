using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebDatTour.Object
{
    public class DanhGia
    {

        private int maDanhGia;
        private int maDonDatTour;
        private int soSao;
        private DateTime thoiGian;
        private string noiDung;

        public DanhGia()
        {
        }

        public DanhGia(int maDanhGia, int maDonDatTour, int soSao, DateTime thoiGian, string noiDung)
        {
            this.maDanhGia = maDanhGia;
            this.maDonDatTour = maDonDatTour;
            this.soSao = soSao;
            this.thoiGian = thoiGian;
            this.noiDung = noiDung;
        }

        public int MaDanhGia { get => maDanhGia; set => maDanhGia = value; }
        public int MaDonDatTour { get => maDonDatTour; set => maDonDatTour = value; }
        public int SoSao { get => soSao; set => soSao = value; }
        public DateTime ThoiGian { get => thoiGian; set => thoiGian = value; }
        public string NoiDung { get => noiDung; set => noiDung = value; }
    }
}