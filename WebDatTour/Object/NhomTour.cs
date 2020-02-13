using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebDatTour.Object
{
    public class NhomTour
    {
        private int maNhom;
        private string tenNhom;

        public NhomTour(int maNhom, string tenNhom)
        {
            this.MaNhom = maNhom;
            this.TenNhom = tenNhom;
        }

        public NhomTour()
        {
            this.MaNhom = 0;
            this.TenNhom = "";
        }

        public int MaNhom { get => maNhom; set => maNhom = value; }
        public string TenNhom { get => tenNhom; set => tenNhom = value; }
    }
}