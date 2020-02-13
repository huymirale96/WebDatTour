using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebDatTour.Model;
using WebDatTour.Object;
using System.Data;

namespace WebDatTour.Controllers
{
   
    public class DonDatTourController
    {
        DonDatTourModel donDatTourModel = new DonDatTourModel();
        public int themDonDatTour(DonDatTour donDatTour, int tien)
        {
            return donDatTourModel.ThemDonDatTour(donDatTour, tien);
        }
        
             public Boolean updateTrangThaiGiaoDich(long idvnpay, int id, int tt)
        {
            return donDatTourModel.updateTrangThaiGiaoDich(idvnpay, id, tt);
        }
    }
}