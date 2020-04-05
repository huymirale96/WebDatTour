using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Controllers;
using WebDatTour.Model;

namespace WebDatTour.View.BackEnd
{
    
    public partial class DanhSachNhomTour : System.Web.UI.Page
    {
        NhomTourController nhomTourController = new NhomTourController();
        Connector cn = new Connector();
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

      public string View(string x)
        {
            return x.Equals("1") ? "success" : "warning";
        }

        protected void btnFix_Click(object sender, EventArgs e)
        {

            LinkButton linkButton = (LinkButton)sender;
            string id = linkButton.CommandArgument.ToString();
            try
            {
               
                SqlCommand cmd = new SqlCommand("sp_trangThaiNhomTourTour", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                int i = cmd.ExecuteNonQuery();
                System.Diagnostics.Debug.WriteLine(i+ "id: " + id);
                Response.Redirect("danhsachnhomtour.aspx");
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
    }
}