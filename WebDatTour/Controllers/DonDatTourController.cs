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
        public Boolean themDonDatTour(DonDatTour donDatTour)
        {
            return donDatTourModel.ThemDonDatTour(donDatTour);
        }
    }
}