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
            if (Request.QueryString["id"] != null)
            {
                layTour(Request.QueryString["id"].ToString());
            }
            else
            {
                Response.Redirect("danhsachkhachhang.aspx");
            }
            //Debug.WriteLine("laytour+++ ");
            
        }
        [WebMethod]
        public static string layThongTinTour(string id)
        {
            TourModel tourModel = new TourModel();
            DataTable data1 = tourModel.xemTour2(id);
            DataColumn newCol = new DataColumn("bgiamNL", typeof(string));
            newCol.AllowDBNull = true;
            data1.Columns.Add(newCol);
            DataColumn newCol2 = new DataColumn("bgiamTE", typeof(string));
            newCol.AllowDBNull = true;
            data1.Columns.Add(newCol2);
           // foreach (DataRow row in data1.Rows)
           // {
                // DataColumn col = new DataColumn();
                if( DateTime.Parse(data1.Rows[0]["hangiamNL"].ToString()) > DateTime.Now)
                {
                    Debug.WriteLine("");
                data1.Rows[0]["bgiamNL"] = 1;
                }
                else
                {
                data1.Rows[0]["bgiamNL"] = 0;
                }

                if (DateTime.Parse(data1.Rows[0]["hangiamTE"].ToString()) > DateTime.Now)
                {
                data1.Rows[0]["bgiamTE"] = 1;
                }
                else
                {
                data1.Rows[0]["bgiamTE"] = 0;
                }
          //  }

            DataTable data2 = tourModel.dsThoiGianKhoiHanh(Convert.ToInt32(id));
            Data data = new Data(data1, data2);
            return JsonConvert.SerializeObject(data);
             }


        [WebMethod]
        public static string taoDonDatTour(string idTour, string idNgay, string idKH, string soTE, string soNL, string tien)
        {
            Debug.WriteLine(idTour + "  "+ idNgay + "  "+ idKH + "  "+ soTE + "  "+ soNL + "  "+ tien + "  ");
             DonDatTour donDatTour = new DonDatTour();
             donDatTour.ChoNL = Convert.ToInt32(soNL);
             donDatTour.ChoTE = Convert.ToInt32(soTE);
             donDatTour.MaTour = Convert.ToInt32(idTour);
             donDatTour.NgayDat = DateTime.Now; //DateTime.UtcNow.Date;
             donDatTour.TienDaThanhToan = Convert.ToInt32(tien);
             donDatTour.MaNgaydi = Convert.ToInt32(idNgay);
             donDatTour.TrangThai = 0;
             donDatTour.MaKH = Convert.ToInt32(idKH);
             DonDatTourModel donDatTourModel = new DonDatTourModel();
            if (donDatTourModel.taoDonDatTour_NV(donDatTour))
            {
                // Response.Redirect("toanthanhthanhtoan.aspx?id=1");
                return "true";

            }
            else
            {
                return "false";
            }
           // return "ok";

           
        }
        public void layTour(string id)
        {
            idkhhidden.InnerHtml = "<input type='hidden' id='idkhh' value='"+ id +"'>";
            KhachHangModel khachHangModel = new KhachHangModel();
            tenKhachHAng.InnerHtml = "Khách Hàng: "+ khachHangModel.layTenKhachHang(id);
            rptour.DataSource = tourModel.layTourtt1();
            rptour.DataBind();
        }
    }
}