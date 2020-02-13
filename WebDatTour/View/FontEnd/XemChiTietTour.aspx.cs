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

namespace WebDatTour.View.FontEnd
{
    public partial class XemChiTietTour : System.Web.UI.Page
    {
        TourController tourController = new TourController();
        BinhLuanController binhLuanController = new BinhLuanController();
        protected void Page_Load(object sender, EventArgs e)
        {
           if(HttpContext.Current.Session["maKH"].ToString().Equals(""))
            {
                txtBinhLuan.Visible = false;
                binhLuan.Visible = false;

            }
            if (Request.QueryString["id"] != null)
            {
                // System.Diagnostics.Debug.WriteLine("id khong null");
            
                    xemTour(Request.QueryString["id"]);
                    laybinhluan(Convert.ToInt32(Request.QueryString["id"]));
                }
                else
                {
                    xemTour("18");
                    laybinhluan(18);

                }
            
        }
        public void laybinhluan(int id)
        {
            rptBinhLuan.DataSource = binhLuanController.layBinhLuan(id);
            rptBinhLuan.DataBind();
        }
        public void xemTour(String id)
        {
            //System.Diagnostics.Debug.WriteLine("3");
            maTour_.Value = id;
            SqlDataReader rd = tourController.xemTour(id);
                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                      

                        string[] urls = rd["sUrlAnh"].ToString().Split('/');
                        //System.Diagnostics.Debug.WriteLine("url: " + urls[0]);

                        List<string> urlrpt = new List<string>();
                        List<string> idrpt = new List<string>(); // idrpt.Add(i.ToString());
                        DataTable dt1 = new DataTable();
                        dt1.Clear();
                        dt1.Columns.Add("id");
                        DataTable dt2 = new DataTable();
                        dt2.Clear();
                        dt2.Columns.Add("url");
                        for (int i = 1; i < urls.Length; i++)
                        {
                            DataRow row1 = dt1.NewRow();
                            DataRow row2 = dt2.NewRow();
                            row1["id"] =  i - 1;
                            row2["url"] = urls[i];
                            dt1.Rows.Add(row1);
                            dt2.Rows.Add(row2);
                          //  System.Diagnostics.Debug.WriteLine("id:  "+ (i-1).ToString() + "  " + urls[i] );

                        }
                        rpt1.DataSource = dt1;
                        rpt1.DataBind();
                        rpt2.DataSource = dt2;
                        rpt2.DataBind();

                        txtNoiDung.Text = rd["sMoTa"].ToString();
                       // System.Diagnostics.Debug.WriteLine(rd["sMoTa"].ToString());
                        txtTieuDe.Text = rd["sTieuDe"].ToString();
                        int giaTE = Convert.ToInt32(rd["igiate"]);//.ToString();
                    int giaTEgiam = Convert.ToInt32(rd["igiategiam"]);
                    int giaNL = Convert.ToInt32(rd["igianl"]);
                    int giaNLgiam = Convert.ToInt32(rd["igianlgiam"]);
                   // gia.InnerHtml = "<input type='hidden' id='giaNL' value ='" + gianl + "' /><input type='hidden' id ='giaTE' value = '" + giate + "' /> ";
                    string htmlGia = "<input type='hidden' id='giaNL' value ='";
                    if (giaNLgiam == 0)
                    {
                        htmlGia += giaNL;
                    }
                    else
                    {
                        htmlGia += giaNLgiam;
                    }

                    if (giaTEgiam == 0)
                    {
                        htmlGia += "' /><input type='hidden' id ='giaTE' value = '" + giaTE;
                    }
                    else
                    {
                        htmlGia += "' /><input type='hidden' id ='giaTE' value = '" + giaTEgiam;
                    }
                    gia.InnerHtml = htmlGia + "' /> ";
                    hiddenIdTour.InnerHtml = "<input type='hidden' id='idTour' name='idTour' value='" + rd["iMaTour"].ToString() + "' />";
                    // Label2.Text = "< button type = 'button' class='btn btn-primary'>Primary</button>";//;;tokens[0] + tokens.Length.ToString();
                    /*
                    txtMaTour.Value = rd["imatour"].ToString();
                    txtTieuDe.Text = rd["sTieuDe"].ToString();
                    txtMoTaTour.Text = rd["sMoTa"].ToString();
                    String date = String.Format("{0:yyyy-MM-dd}", rd["dNgayKhoiHanh"]);
                    txtNgayKhoiHanh.Text = date;
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
                    // rptDSanh.DataSource = dt;
                    //rptDSanh.DataBind();
                    //
                }*/

                }
            }
        }

        protected void binhLuan_Click(object sender, EventArgs e)
        {
            BinhLuan binhLuan = new BinhLuan();
            binhLuan.MaTour = Convert.ToInt32(maTour_.Value);
            binhLuan.ThoiGian = DateTime.Now;
            binhLuan.MaKH = Convert.ToInt32(HttpContext.Current.Session["maKH"]);
            binhLuan.NoiDung = txtBinhLuan.Text;
            binhLuanController.binhLuan(binhLuan);
            Response.Redirect("XemChiTietTour.aspx?id="+ maTour_.Value);
        }
    }
}