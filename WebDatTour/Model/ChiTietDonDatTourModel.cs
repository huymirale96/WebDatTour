using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace WebDatTour.Model
{
    public class ChiTietDonDatTourModel
    {
        Connector cn = new Connector();
        XuLy xuLy = new XuLy();
    }
}