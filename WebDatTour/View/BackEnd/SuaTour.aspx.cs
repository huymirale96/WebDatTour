using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using WebDatTour.Controllers;
using System.Diagnostics;
using Newtonsoft.Json;
using WebDatTour.Model;
using System.Web.Services;

namespace WebDatTour.View.BackEnd
{
    public partial class SuaTour : System.Web.UI.Page
    {
        String cnnString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
        TourController tourController = new TourController();
        TourModel tourModel = new TourModel();
        protected void Page_Load(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("đâs");

            if (Request.QueryString["id"] != null )
            {
                // System.Diagnostics.Debug.WriteLine("id khong null");
                if (!IsPostBack)
                {
                    xemTour(Request.QueryString["id"]);
                    danhSachThoiGianKhoiHanh(Convert.ToInt32(Request.QueryString["id"]));
                }


                //xemTour(Request.QueryString["id"].ToString());

            }
            else
            {
                if (Request.QueryString["tg"] != null && !IsPostBack)
                //if(1==0)
                {
                   // Debug.WriteLine("tg != null");
                     tourController.upDateTrangThaiThoiGian(Convert.ToInt32(Request.QueryString["tg"]));
                     //tourController.upDateTrangThaiThoiGian(1);
                    // tourModel.upDateTrangThaiThoiGian(1);
                    //  Debug.WriteLine(tourController.update(1));
                    Response.Redirect("../suaTour.aspx?id="+ Request.QueryString["tour"]);
                }
                else
                {
                    Response.Redirect("suaTour.aspx?id=18");
                }
            }
        }

        protected void btnSuaTour_Click(object sender, EventArgs e)
        {
            HttpPostedFile file = Request.Files["anh"];
            System.Diagnostics.Debug.WriteLine("file" + file.FileName );
            //check file was submitted
            if (file != null && file.ContentLength > 0)
            {
                System.Diagnostics.Debug.WriteLine("anh uo:  " + Path.GetFileName(file.FileName));
                //  string fname = Path.GetFileName(file.FileName);
                //file.SaveAs(Server.MapPath(Path.Combine("~/App_Data/", fname)));
            }
            System.Diagnostics.Debug.WriteLine("BTN SUA " + txtGIaNL.Text);
            using (SqlConnection cnn = new SqlConnection(cnnString))
            {
                cnn.Open();
                SqlCommand cmd = new SqlCommand("sp_updatetourID", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@tieude", txtTieuDe.Text);
                cmd.Parameters.AddWithValue("@mota", txtMoTaTour.Text);
                cmd.Parameters.AddWithValue("@urlanh", "  ");
                cmd.Parameters.AddWithValue("@thoigian", txtSoNgayDi.Text);
                cmd.Parameters.AddWithValue("@ngaykhoihanh", txtNgayKhoiHanh1.Text);

                cmd.Parameters.AddWithValue("@nhomtour", 19);
                //cmd.Parameters.AddWithValue("@manv", 1);
                cmd.Parameters.AddWithValue("@socho", txtSoCho.Text);
                cmd.Parameters.AddWithValue("@imatour", txtMaTour.Value);
                int i1 = cmd.ExecuteNonQuery();

                //  String idMaTour = cmd.Parameters["@imatour"].Value.ToString();  15);//
                SqlCommand cmd2 = new SqlCommand("sp_updateGiaVe", cnn);
                cmd2.CommandType = CommandType.StoredProcedure;
                cmd2.Parameters.AddWithValue("@matour", Convert.ToInt32(txtMaTour.Value));
                cmd2.Parameters.AddWithValue("@gianl", Convert.ToInt32(txtGIaNL.Text));
                cmd2.Parameters.AddWithValue("@giagiamnl", Convert.ToInt32(txtGiaNLgiam.Text));
                cmd2.Parameters.AddWithValue("@giate", Convert.ToInt32(txtGiaTE.Text));
                cmd2.Parameters.AddWithValue("@giagiamte", Convert.ToInt32(txtGiaTEgiam.Text));

                int i = cmd2.ExecuteNonQuery();
                System.Diagnostics.Debug.WriteLine("cmd 2 " + txtMaTour.Value + "  " + txtGIaNL.Text + "  " + txtGiaNLgiam.Text + "  " + txtGiaTE.Text + "  " + txtGiaTEgiam.Text);


                if (i > 0)
                {
                    System.Diagnostics.Debug.WriteLine("succcccc");
                    Console.WriteLine("Updated Success!");
                    /// Response.Write("<script language=javascript>alert('OKK');</script>");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("succccccwwweeeeeeeee");
                    Console.WriteLine("Updated Fail!");
                    Response.Write("<script language=javascript>alert('Rrror');</script>");
                }
            }


        }
        public void danhSachThoiGianKhoiHanh(int id)
        {
            //Repeater rptTG1 = (Repeater)Master.FindControl("MainContent").FindControl("rptTG1");
            //Repeater rptTGs1 = Page.FindControl("rptTG1") as Repeater;
            Debug.WriteLine("id " + id);
            DataTable table = tourController.dsThoiGianKhoiHanh(id);
            rpt1.DataSource = table;
            rpt1.DataBind();
          //  Debug.WriteLine(JsonConvert.SerializeObject(table));
        }
        public void xemTour(String id)
        {
            System.Diagnostics.Debug.WriteLine("3");
            matour.Value = id;
            using (SqlConnection cnn = new SqlConnection(cnnString))
            {
                cnn.Open();
                SqlCommand cmd = new SqlCommand("sp_xemTourId", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idTour", id);
                SqlDataReader rd = cmd.ExecuteReader();
                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        txtMaTour.Value = rd["imatour"].ToString();
                      //  txtTieuDe.Text = rd["sTieuDe"].ToString();
                        txtMoTaTour.Text = rd["sMoTa"].ToString();
                        String date = String.Format("{0:yyyy-MM-dd}", rd["dNgayKhoiHanh"]);
                        txtNgayKhoiHanh1.Text = date;
                        txtSoNgayDi.Text = rd["sTongThoiGian"].ToString();
                        txtSoCho.Text = rd["iSoCho"].ToString();
                        txtGiaNLgiam.Text = rd["igianlgiam"].ToString();
                        txtGIaNL.Text = rd["igianl"].ToString();
                        txtGiaTE.Text = rd["igiate"].ToString();
                        txtGiaTEgiam.Text = rd["igiategiam"].ToString();


                        string[] tokens = rd["sUrlAnh"].ToString().Split('/');
                        // Label2.Text = "< button type = 'button' class='btn btn-primary'>Primary</button>";//;;tokens[0] + tokens.Length.ToString();
                        // Label2.Text = tokens[0];
                        DataTable dt = new DataTable();
                        dt.Clear();
                        dt.Columns.Add("url");
                        dt.Columns.Add("id");

                        for (int i = 0; i < tokens.Length; i++)
                        {
                            DataRow row = dt.NewRow();
                            row["url"] = tokens[i];
                            row["id"] = i;
                            dt.Rows.Add(row);
                        }
                        //Repeater Rpt1 = Page.FindControl("rptDSanh") as Repeater;

                        rptDSanh.DataSource = dt;
                        rptDSanh.DataBind();
                        //
                    }
                }
            }
           
        }
        public String anHien(String x)
        {
           // Debug.WriteLine("anhien : "+ x);
            if (x.Equals("True"))
            {
                return "Hiện";

            }
            else
            {
                return "Ẩn";
            }
        }

        [WebMethod]
        public static String themThoiGianKhoiHanh(string id, string date)
        {
            TourController tourController1 = new TourController();
            if (tourController1.themThoiGianKhoiHanh(Convert.ToInt32(id), DateTime.Parse(date)))
            {
                DataTable table = tourController1.dsThoiGianKhoiHanh(Convert.ToInt32(id));
                return JsonConvert.SerializeObject(table);
            }
            else
            {
                return null;
            }
        }

        protected void themNgay_Click(object sender, EventArgs e)
        {
            if (!ngayDi.Text.Equals(""))
            {
                bool x = tourController.themThoiGianKhoiHanh(Convert.ToInt32(matour.Value), DateTime.Parse(ngayDi.Text));
              
            }
            else
            {
                Response.Redirect("SuaTour.aspx?id=" + matour.Value);
            }
            
        }
        void cn()
        {
          //  a1.;
        }
    }
}
