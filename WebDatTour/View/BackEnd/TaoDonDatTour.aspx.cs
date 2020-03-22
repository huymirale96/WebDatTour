using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using WebDatTour.Controllers;
using System.Diagnostics;
using WebDatTour.Object;
using System.Web.Services;
using Newtonsoft.Json;
using WebDatTour.Model;
namespace WebDatTour.View.BackEnd
{
    public partial class TaoDonDatTour : System.Web.UI.Page
    {
        TourModel tourModel = new TourModel();
        protected void Page_Load(object sender, EventArgs e)
        {
            layTour();
            //Debug.WriteLine("laytour+++ ");
        }
        [WebMethod]
        public static string layThongTinTour(string id)
        {
            TourModel tourModel = new TourModel();
            DataTable data1 = tourModel.xemTour2(id);
            DataTable data2 = tourModel.dsThoiGianKhoiHanh(Convert.ToInt32(id));
            Data data = new Data(data1, data2);
            return JsonConvert.SerializeObject(data);
             }
       public void layTour()
        {
            rptour.DataSource = tourModel.layTourtt1();
            rptour.DataBind();
        }
    }
}