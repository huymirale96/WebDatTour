using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebDatTour.Object
{
    public class KhachHang
    {
        private string tenKhachHang;
        private string matKhau;
        private string soDienThoai;
        private string tenDangNhap;
        //private string soDienThoai;
        private string email;
        private string diaChi;
        private DateTime ngaySinh;
        private int maKH;

        public KhachHang(string tenKhachHang, string matKhau, string soDienThoai, string tenDangNhap, string email, string diaChi, DateTime ngaySinh, int maKH)
        {
            this.tenKhachHang = tenKhachHang;
            this.matKhau = matKhau;
            this.soDienThoai = soDienThoai;
            this.tenDangNhap = tenDangNhap;
            this.email = email;
            this.diaChi = diaChi;
            this.ngaySinh = DateTime.Parse("05/05/2005");
            this.maKH = maKH;
        }
        public KhachHang()
        {
            this.tenKhachHang = "";
            this.matKhau = "";
            this.soDienThoai = "";
            this.tenDangNhap = "";
            this.email = "";
            this.diaChi = "";
            this.ngaySinh = DateTime.Parse("05/05/2005");
            this.maKH = 0;
        }

        public string TenKhachHang { get => tenKhachHang; set => tenKhachHang = value; }
        public string MatKhau { get => matKhau; set => matKhau = value; }
        public string SoDienThoai { get => soDienThoai; set => soDienThoai = value; }
        public string TenDangNhap { get => tenDangNhap; set => tenDangNhap = value; }
        public string Email { get => email; set => email = value; }
        public string DiaChi { get => diaChi; set => diaChi = value; }
        public DateTime NgaySinh { get => ngaySinh; set => ngaySinh = value; }
        public int MaKH { get => maKH; set => maKH = value; }
        // private bool gioiTinh;

    }
}