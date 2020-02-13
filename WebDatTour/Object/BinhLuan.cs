using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebDatTour.Object
{
    public class BinhLuan
    {
        private int maBinhLuan;
        private int maKH;
        private int maTour;
        private DateTime thoiGian;
        private string noiDung;

        public BinhLuan(int maBinhLuan, int maKH, int maTour, DateTime thoiGian, string noiDung)
        {
            this.MaBinhLuan = maBinhLuan;
            this.MaKH = maKH;
            this.MaTour = maTour;
            this.ThoiGian = thoiGian;
            this.NoiDung = noiDung;
        }


        public BinhLuan()
        {
            this.MaBinhLuan = 0;
            this.MaKH = 0;
            this.MaTour = 0;
            this.ThoiGian = DateTime.Parse("05/05/2005");
            this.NoiDung = "";
        }

        public int MaBinhLuan { get => maBinhLuan; set => maBinhLuan = value; }
        public int MaKH { get => maKH; set => maKH = value; }
        public int MaTour { get => maTour; set => maTour = value; }
        public DateTime ThoiGian { get => thoiGian; set => thoiGian = value; }
        public string NoiDung { get => noiDung; set => noiDung = value; }
    }
}