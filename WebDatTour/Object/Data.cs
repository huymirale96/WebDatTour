using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace WebDatTour.Object
{
    public class Data
    {
        private DataTable thongTinTour;
        private DataTable ngayDi;

        public Data()
        {
        }

        public Data(DataTable thongTinTour, DataTable ngayDi)
        {
            this.thongTinTour = thongTinTour;
            this.ngayDi = ngayDi;
        }

        public DataTable ThongTinTour { get => thongTinTour; set => thongTinTour = value; }
        public DataTable NgayDi { get => ngayDi; set => ngayDi = value; }
    }
}