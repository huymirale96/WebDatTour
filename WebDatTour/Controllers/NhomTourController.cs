using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebDatTour.Model;
using System.Data;

namespace WebDatTour.Controllers
{
    public class NhomTourController
    {
        NhomTourModel nhomTourModel = new NhomTourModel();
        public DataTable danhSachNT()
        {
            return nhomTourModel.danhSachNT();
        }
        public Boolean themNT(String ten)
        {
            return nhomTourModel.themNhomTour(ten);
        }
    }
}