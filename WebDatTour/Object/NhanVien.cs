using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebDatTour.Object
{
    public class NhanVien
    {
        private string tenNhanVien;
        private string matKhau;
        private string soDienThoai;
        private string queQuan;
        private string stenDangNhap;
        private DateTime ngaySinh;
        private bool gioiTinh;
        private int quyen;

        public NhanVien(string tenNhanVien, string matKhau, string soDienThoai, string queQuan, string stenDangNhap, DateTime ngaySinh, bool gioiTinh, int quyen)
        {
            this.tenNhanVien = tenNhanVien;
            this.matKhau = matKhau;
            this.soDienThoai = soDienThoai;
            this.queQuan = queQuan;
            this.stenDangNhap = stenDangNhap;
            this.ngaySinh = ngaySinh;
            this.gioiTinh = gioiTinh;
            this.quyen = quyen;
        }
        public NhanVien()
        {
            this.tenNhanVien = "";
            this.matKhau = "";
            this.soDienThoai = "";
            this.queQuan = "";
            this.stenDangNhap = "";
            this.ngaySinh = DateTime.Parse("05/05/2005");
            this.gioiTinh = false;
            this.quyen = 0;
        }

        public string TenNhanVien { get => tenNhanVien; set => tenNhanVien = value; }
        public string MatKhau { get => matKhau; set => matKhau = value; }
        public string SoDienThoai { get => soDienThoai; set => soDienThoai = value; }
        public string QueQuan { get => queQuan; set => queQuan = value; }
        public string StenDangNhap { get => stenDangNhap; set => stenDangNhap = value; }
        public DateTime NgaySinh { get => ngaySinh; set => ngaySinh = value; }
        public bool GioiTinh { get => gioiTinh; set => gioiTinh = value; }
        public int Quyen { get => quyen; set => quyen = value; }
    }
}