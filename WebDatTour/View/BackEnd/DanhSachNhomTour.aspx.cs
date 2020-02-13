using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Controllers;

namespace WebDatTour.View.BackEnd
{
    
    public partial class DanhSachNhomTour : System.Web.UI.Page
    {
        NhomTourController nhomTourController = new NhomTourController();

        protected void Page_Load(object sender, EventArgs e)
        {
           rptds.DataSource =  nhomTourController.danhSachNT();
           rptds.DataBind();
            if(Request.Form["chucNang"] != null && !IsPostBack)
            {
              //  System.Diagnostics.Debug.WriteLine("FUNCTION them tour`11 ");
                if (Request.Form["chucNang"].ToString().Equals("themNhom"))
                {
                    // System.Diagnostics.Debug.WriteLine("FUNCTION them tour ");
                    if (nhomTourController.themNT(Request.Form["stennhomtour"].ToString()))
                    {
                        //Response.Write("<script language=javascript>alert('Thêm Thành Công');</script>");
                        Response.Redirect("danhsachnhomtour.aspx");
                    }
                }
            }
           
        }
        //[WebMethod]
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        //  [ScriptMethod(UseHttpGet = false)]
        //  [ScriptMethod(UseHttpPost = true)]
        public static String themNhomTour(String x)
        {
            System.Diagnostics.Debug.WriteLine("FUNCTION them tour "+x);
            //if (Request.QueryString["tennt"] != null)
            //  {
            //String tennt = tennt;// Request.QueryString["tennt"].ToString();
            //01nhomTourController.themNT(tennt);
            return  x;
           // }
          //  else
          //  {
            //    return "no";
            //}
        }


    }
}