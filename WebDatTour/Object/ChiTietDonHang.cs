using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebDatTour.Object
{
    public class ChiTietDonHang
    {
        private int maDon;
        private int maNhomve;
        private int soLuong;

        public ChiTietDonHang(int maDon, int maNhomve, int soLuong)
        {
            this.MaDon = maDon;
            this.MaNhomve = maNhomve;
            this.SoLuong = soLuong;
        }

        public ChiTietDonHang()
        {
            this.MaDon = 0;
            this.MaNhomve = 0;
            this.SoLuong = 0;
        }

        public int MaDon { get => maDon; set => maDon = value; }
        public int MaNhomve { get => maNhomve; set => maNhomve = value; }
        public int SoLuong { get => soLuong; set => soLuong = value; }
    }
}