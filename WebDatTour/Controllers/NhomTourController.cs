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
        TourModel tourModel = new TourModel();
        public DataTable danhSachNT()
        {
            return nhomTourModel.danhSachNT();
        }
        public Boolean themNT(String ten)
        {
            return nhomTourModel.themNhomTour(ten);
        }
        public String layTenNhomTour(string id)
        {
            return tourModel.layTenNhomTour(id);
        }
    }
}