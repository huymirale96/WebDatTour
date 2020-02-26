using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WebDatTour.Object
{
    public class ThongKeDoanhThu
    {
        DataTable data;
        string doanhThu;
        string thucThu;
        string soDon;

        public ThongKeDoanhThu()
        {
        }

        public ThongKeDoanhThu(DataTable data, string doanhThu, string thucThu, string soDon)
        {
            this.data = data;
            this.doanhThu = doanhThu;
            this.thucThu = thucThu;
            this.soDon = soDon;
        }

        public DataTable Data { get => data; set => data = value; }
        public string DoanhThu { get => doanhThu; set => doanhThu = value; }
        public string ThucThu { get => thucThu; set => thucThu = value; }
        public string SoDon { get => soDon; set => soDon = value; }
    }
}