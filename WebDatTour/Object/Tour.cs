using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebDatTour.Object
{
    public class Tour
    {

        private int maNhomTour;
        private string tongThoiGian;
        private string urlAnh;
        private string moTa;
        //private string sNoiKhoiHanh;
        private string tieuDe;
        private string noiKhoiHanh;
        private DateTime ngayKhoiHanh;
        private int maTour;
        private int maNV;
        private int soCho;
        private DateTime ngayTao;
        private List<DateTime> dsNgayKhoiHanh;
        private List<String> dsAnh;



        public Tour(int maNhomTour, string tongThoiGian, string urlAnh, string moTa,  string tieuDe, string noiKhoiHanh, DateTime ngayKhoiHanh, int maTour)
        {
            this.MaNhomTour = maNhomTour;
            this.TongThoiGian = tongThoiGian;
            this.UrlAnh = urlAnh;
            this.MoTa = moTa;
           // this.SNoiKhoiHanh = sNoiKhoiHanh;
            this.TieuDe = tieuDe;
            this.NoiKhoiHanh = noiKhoiHanh;
            this.NgayKhoiHanh = ngayKhoiHanh;
            this.MaTour = maTour;
        }


        public Tour()
        {
            this.MaNhomTour = 1;
            this.TongThoiGian = "";
            this.UrlAnh = "";
            this.MoTa = "";
          //  this.SNoiKhoiHanh = "";
            this.TieuDe = "";
            this.NoiKhoiHanh = "";
            this.NgayKhoiHanh = DateTime.Parse("05/05/2005");
            this.MaTour = 0;
            this.MaNV = 0;
            this.SoCho = 0;
            this.ngayTao = DateTime.Parse("05/05/2005");
           // this.dsNgayKhoiHanh = new List<DateTime>;
        }

        public int MaNhomTour { get => maNhomTour; set => maNhomTour = value; }
        public string TongThoiGian { get => tongThoiGian; set => tongThoiGian = value; }
        public string UrlAnh { get => urlAnh; set => urlAnh = value; }
        public string MoTa { get => moTa; set => moTa = value; }
       // public string SNoiKhoiHanh { get => sNoiKhoiHanh; set => sNoiKhoiHanh = value; }
        public string TieuDe { get => tieuDe; set => tieuDe = value; }
        public string NoiKhoiHanh { get => noiKhoiHanh; set => noiKhoiHanh = value; }
        public DateTime NgayKhoiHanh { get => ngayKhoiHanh; set => ngayKhoiHanh = value; }
        public int MaTour { get => maTour; set => maTour = value; }
        public int MaNV { get => maNV; set => maNV = value; }
        public int SoCho { get => soCho; set => soCho = value; }
        public DateTime NgayTao { get => ngayTao; set => ngayTao = value; }
        public List<DateTime> DsNgayKhoiHanh { get => dsNgayKhoiHanh; set => dsNgayKhoiHanh = value; }
        public List<string> DsAnh { get => dsAnh; set => dsAnh = value; }
    }
}