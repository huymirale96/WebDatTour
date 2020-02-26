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
using WebDatTour.Object;
using System.Diagnostics;

namespace WebDatTour.View.BackEnd
{
    public partial class ThemTour : System.Web.UI.Page
    {
        String cnnString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
        NhomTourController nhomTourController = new NhomTourController();
        TourController tourController = new TourController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                layNhomTour();
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            /*
            if (fAnhBia.FileContent.Length > 0)
            {
                if (fAnhBia.FileName.EndsWith(".jpeg") || fAnhBia.FileName.EndsWith(".jpg") || fAnhBia.FileName.EndsWith(".png"))
                {
                    fAnhBia.SaveAs(Server.MapPath(Path.Combine("~/Upload/", fAnhBia.FileName)));// "~~/Upload/" + fAnhBia.FileName));
                }
            }

                    for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFile file = Request.Files[i];
                if (file.ContentLength > 0)
                {
                    string fname = Path.GetFileName(file.FileName);
                    file.SaveAs(Server.MapPath(Path.Combine("~/Upload/", fname)));

                }
            }
          //  Label1.Text = Request.Files.Count + " Images Has Been Saved Successfully";*/
        }
        protected void layNhomTour()
        {
            ddlNhomTour.DataSource = nhomTourController.danhSachNT();
            ddlNhomTour.DataTextField = "sTenNhomTour";
            ddlNhomTour.DataValueField = "iMaNhomTour";
            ddlNhomTour.DataBind();
        }
        private Boolean kiemTraNgayKH(List<DateTime> ngayKhoihanh, String ngay)
        {
            bool temp = true;
            foreach (DateTime x in ngayKhoihanh)
            {
                if(x == DateTime.Parse(ngay))
                {
                    temp = false;
                }
            }
            return temp;
        }
        protected void btnDangKi_Click(object sender, EventArgs e)
        {
            //Debug.WriteLine("nagy" + txtNKH1.Text);

            string urlanh = "";
            if (fAnhBia.FileContent.Length > 0)
            {
                if (fAnhBia.FileName.EndsWith(".jpeg") || fAnhBia.FileName.EndsWith(".jpg") || fAnhBia.FileName.EndsWith(".png"))
                {
                    fAnhBia.SaveAs(Server.MapPath(Path.Combine("~/Upload/", fAnhBia.FileName)));// "~~/Upload/" + fAnhBia.FileName));
                    urlanh += fAnhBia.FileName;
                }
            }

            for (int i = 1; i < Request.Files.Count; i++)
            {
                HttpPostedFile file = Request.Files[i];
                if (file.ContentLength > 0)
                {
                    string fname = Path.GetFileName(file.FileName);
                    file.SaveAs(Server.MapPath(Path.Combine("~/Upload/", fname)));
                    urlanh += "/" + fname;
                }
            }
            
            List<DateTime> ngayKhoihanh = new List<DateTime>();
            if(!txtNKH1.Text.Equals("") && kiemTraNgayKH(ngayKhoihanh, txtNKH1.Text) )
            {
                ngayKhoihanh.Add(DateTime.Parse(txtNKH1.Text));
            }
            if (!txtNKH2.Text.Equals("") && kiemTraNgayKH(ngayKhoihanh, txtNKH2.Text))
            {
                ngayKhoihanh.Add(DateTime.Parse(txtNKH2.Text));
            }
            if (!txtNKH3.Text.Equals("") && kiemTraNgayKH(ngayKhoihanh, txtNKH3.Text))
            {
                ngayKhoihanh.Add(DateTime.Parse(txtNKH3.Text));
            }
            if (!txtNKH4.Text.Equals("") && kiemTraNgayKH(ngayKhoihanh, txtNKH4.Text))
            {
                ngayKhoihanh.Add(DateTime.Parse(txtNKH4.Text));
            }
            if (!txtNKH5.Text.Equals("") && kiemTraNgayKH(ngayKhoihanh, txtNKH5.Text))
            {
                ngayKhoihanh.Add(DateTime.Parse(txtNKH5.Text));
            }
            if (!txtNKH6.Text.Equals("") && kiemTraNgayKH(ngayKhoihanh, txtNKH6.Text))
            {
                ngayKhoihanh.Add(DateTime.Parse(txtNKH6.Text));
            }
            //System.Diagnostics.Debug.WriteLine(txtMoTaTour.Text);
            Tour tour = new Tour();
            tour.MaNV = Convert.ToInt32(Session["maNV"]);
            tour.MaNhomTour = Convert.ToInt32(ddlNhomTour.SelectedValue);   Debug.WriteLine(ddlNhomTour.SelectedItem.Value  + " ma nhom tour value: " + ddlNhomTour.SelectedItem);
            tour.MoTa = txtMoTaTour.Text;
            tour.TieuDe = txtTieuDe.Text;
            //tour.NgayKhoiHanh = DateTime.Parse("02-02-2020");
            tour.NoiKhoiHanh = txtnoiKhoiHanh.Text;
            tour.SoCho = Convert.ToInt32(txtSoCho.Text);
            tour.TongThoiGian = txtSoNgayDi.Text;
            tour.UrlAnh = urlanh;
            tour.NgayTao = DateTime.Now;
            tour.DsNgayKhoiHanh = ngayKhoihanh;
            if (tourController.themTour(tour, Convert.ToInt32(txtGIaNL.Text), Convert.ToInt32(txtGiaNLgiam.Text), Convert.ToInt32(txtGiaTE.Text), Convert.ToInt32(txtGiaTEgiam.Text)))
                {
                // Response.Write("<script language=javascript>alert('OKK');</script>");
                Debug.WriteLine("Them Tour Thanh Cong");
                Response.Redirect("Danhsachtour.aspx");
                }
            else
            {
                Response.Write("<script language=javascript>alert('Lỗi');</script>");
            }

            /*using (SqlConnection cnn = new SqlConnection(cnnString))
            {
                SqlCommand cmd = new SqlCommand("sp_themtour", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@tieude", txtTieuDe.Text);
                cmd.Parameters.AddWithValue("@mota", txtMoTaTour.Text);
                cmd.Parameters.AddWithValue("@urlanh", urlanh);
                cmd.Parameters.AddWithValue("@thoigian", txtSoNgayDi.Text);
                cmd.Parameters.AddWithValue("@ngaykhoihanh", txtNgayKhoiHanh.Text);
                cmd.Parameters.AddWithValue("@nhomtour", 1);
                cmd.Parameters.AddWithValue("@manv", 1);
                cmd.Parameters.AddWithValue("@socho", txtSoCho.Text);
                cmd.Parameters.AddWithValue("@imatour", SqlDbType.Int).Direction = ParameterDirection.Output;
                cnn.Open();
                cmd.ExecuteNonQuery();
                String idMaTour = cmd.Parameters["@imatour"].Value.ToString();
                SqlCommand cmd2 = new SqlCommand("sp_themGiave", cnn);
                        cmd2.CommandType = CommandType.StoredProcedure;
                        cmd2.Parameters.AddWithValue("@matour", idMaTour);
                        cmd2.Parameters.AddWithValue("@gianl", txtGIaNL.Text);
                        cmd2.Parameters.AddWithValue("@giagiamnl", txtGiaNLgiam.Text);
                        cmd2.Parameters.AddWithValue("@giate", txtGiaTE.Text);
                        cmd2.Parameters.AddWithValue("@giagiamte", txtGiaTEgiam.Text);
                        int i = cmd2.ExecuteNonQuery();

                        if(i > 0)
                        {
                            Response.Write("<script language=javascript>alert('OKK');</script>");
                        }
                        else
                        {
                            Response.Write("<script language=javascript>alert('Rrror');</script>");
                        }


            }*/
        }
       
    }
}
