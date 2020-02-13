using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebDatTour.Object
{
    public class DonDatVe
    {
        private int maDon;
        private DateTime ngayTao;
        private string trangThai;
        private int tienThanhToan;

        private int maKH;
        private int maTour;
        private string ghiChu;
        private int nl;
            private int te;
        private DateTime thoiGianDuyet;
        private int nvDuyet;

        public DonDatVe(int maDon, DateTime ngayTao, string trangThai, int tienThanhToan, int maKH, int maTour, string ghiChu, int nl, int te, DateTime thoiGianDuyet, int nvDuyet)
        {
            this.maDon = maDon;
            this.ngayTao = ngayTao;
            this.trangThai = trangThai;
            this.tienThanhToan = tienThanhToan;
            this.maKH = maKH;
            this.maTour = maTour;
            this.ghiChu = ghiChu;
            this.nl = nl;
            this.te = te;
            this.thoiGianDuyet = thoiGianDuyet;
            this.nvDuyet = nvDuyet;
        }

        public DonDatVe()
        {
            this.maDon = 0;
            this.ngayTao = DateTime.Parse("05-05-2002");
            this.trangThai = "";
            this.tienThanhToan = 0;
            this.maKH = 0;
            this.maTour = 0;
            this.ghiChu = "";
            this.nl = 0;
            this.te = 0;
            this.thoiGianDuyet = DateTime.Parse("05-05-2002");
            this.nvDuyet = 0;
                }

        public int MaDon { get => maDon; set => maDon = value; }
        public DateTime NgayTao { get => ngayTao; set => ngayTao = value; }
        public string TrangThai { get => trangThai; set => trangThai = value; }
        public int TienThanhToan { get => tienThanhToan; set => tienThanhToan = value; }
        public int MaKH { get => maKH; set => maKH = value; }
        public int MaTour { get => maTour; set => maTour = value; }
        public string GhiChu { get => ghiChu; set => ghiChu = value; }
        public int Nl { get => nl; set => nl = value; }
        public int Te { get => te; set => te = value; }
        public DateTime ThoiGianDuyet { get => thoiGianDuyet; set => thoiGianDuyet = value; }
        public int NvDuyet { get => nvDuyet; set => nvDuyet = value; }
    }
}