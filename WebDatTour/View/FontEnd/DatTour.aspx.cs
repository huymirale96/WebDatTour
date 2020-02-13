using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Controllers;
using System.Data;
using System.Diagnostics;
using System.Data.SqlClient;
using WebDatTour.Model;
using WebDatTour.Object;

namespace WebDatTour.View.FontEnd
{
    public partial class DatTour : System.Web.UI.Page
    {
        TourController tourController = new TourController();
        DonDatTourModel danDatTourModel = new DonDatTourModel();
        DonDatTourController datTourController = new DonDatTourController();
        protected void Page_Load(object sender, EventArgs e)
        {
           // int tt =  tienThanhToan("29", 2, 2);
           // Debug.WriteLine("Dat Tour "+tt);
         /*   SqlDataReader rd2 = tourController.xemTour("29");
           // SqlDataReader rd = tourController.xemTour(id);
            if (rd2.HasRows)
            {
                while (rd2.Read())
                {
                    Debug.WriteLine("rd: " + Convert.ToInt32(rd2["igiategiam"]));
                }
            }*/
                   // Debug.WriteLine("rd: " + rd2);
            
            if (Request.QueryString["ite"] != null && Request.QueryString["inl"] != null && Request.QueryString["idTour"] != null)
            {
                Debug.WriteLine("load1");
                hienThongTin(Request.QueryString["idTour"].ToString(), Convert.ToInt32(Request.QueryString["ite"]), Convert.ToInt32(Request.QueryString["inl"]));
            }
            else
            {
                Response.Redirect("index.aspx");
            }
            
        }
        private void hienThongTin(String id, int te, int nl)
        {
            iTE.Value = te.ToString();
            iNL.Value = nl.ToString();
            tour.Value = id;
            SqlDataReader rd = tourController.xemTour(id);
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    string[] urls = rd["sUrlAnh"].ToString().Split('/');
                    //System.Diagnostics.Debug.WriteLine("url: " + urls[0]);
                    linkAnh.InnerHtml = "<img src='../../Upload/" + urls[0]+ "' alt='' class='img-responsive'>";
                    tieuDe.InnerHtml = "Đặt Tour: &nbsp" + rd["sTieuDe"].ToString();
                    int giaTE = Convert.ToInt32(rd["igiate"]);//.ToString();
                    int giaTEgiam = Convert.ToInt32(rd["igiategiam"]);
                    int giaNL = Convert.ToInt32(rd["igianl"]);
                    int giaNLgiam = Convert.ToInt32(rd["igianlgiam"]);
                    int giaNL_ = 0;
                    int giaTE_ = 0;
                    if (giaNLgiam == 0)
                    {
                        giaNL_ = giaNL;
                    }
                    else
                    {
                        giaNL_ = giaNLgiam;
                    }

                    if (giaTEgiam == 0)
                    {
                        giaTE_ = giaTE;
                    }
                    else
                    {
                        giaTE_ = giaTEgiam;
                    }
                    txtTen.InnerHtml = "Khách Hàng " + Session["tenKH"].ToString();
                    txtNL.InnerHtml = "Số Chỗ Người Lớn Là: &nbsp" + nl + "&nbsp chỗ x &nbsp" + giaNL_ + "&nbspVNĐ";
                    txtTE.InnerHtml = "Số Chỗ Trẻ Em Là: &nbsp" + te + "&nbsp chỗ x &nbsp" + giaTE_ + "&nbspVNĐ";
                    txtTong.InnerHtml = "Tổng Tiền Là:&nbsp" + (te * giaTE_ + nl * giaNL_) + "&nbspVNĐ";
                    tien.Value = (te * giaTE_ + nl * giaNL_).ToString();
                }
            }

        }

        private int tienThanhToan_(String id, int te, int nl)
        {
            int tientt = 0;

            SqlDataReader rd2 = tourController.xemTour2(id);
            Debug.WriteLine("rd: " + id + " " + te+ " " +nl);
            if (rd2.HasRows)
            {
                Debug.WriteLine("HAS ROW");
                while (rd2.Read())
                {
                   int giaTE = Convert.ToInt32(rd2["igiate"]);//.ToString();
                    int giaTEgiam = Convert.ToInt32(rd2["igiategiam"]);
                    int giaNL = Convert.ToInt32(rd2["igianl"]);
                    int giaNLgiam = Convert.ToInt32(rd2["igianlgiam"]);
                    int giaNL_ = 0;
                    int giaTE_ = 0;
                    if (giaNLgiam == 0)
                    {
                        giaNL_ = giaNL;
                    }
                    else
                    {
                        giaNL_ = giaNLgiam;
                    }

                    if (giaTEgiam == 0)
                    {
                        giaTE_ = giaTE;
                    }
                    else
                    {
                        giaTE_ = giaTEgiam;
                    }

                    tientt = (te * giaTE_ + nl * giaNL_);
                }
            }
            else

            {
                Debug.WriteLine("NO ROW");
                return tientt;
            }
            return tientt;

        }

        protected void btnDatVe_Click(object sender, EventArgs e)
        {
            //Debug.WriteLine(tour.Value.ToString()+ Convert.ToInt32(iTE.Value)+ Convert.ToInt32(iNL.Value));
            DonDatTour donDatTour = new DonDatTour();
            donDatTour.ChoNL = Convert.ToInt32(iNL.Value);
            donDatTour.ChoTE = Convert.ToInt32(iTE.Value);
            donDatTour.MaTour = Convert.ToInt32(tour.Value);
            donDatTour.GhiChu = txtGhiChu.Text;
            donDatTour.NgayDat = DateTime.Now; //DateTime.UtcNow.Date;
            donDatTour.TienDaThanhToan = Convert.ToInt32(tien.Value);//tienThanhToan_(tour.Value.ToString(), Convert.ToInt32(iTE.Value), Convert.ToInt32(iNL.Value));
            donDatTour.TrangThai = "Da thanh toan";
            donDatTour.MaKH = 1;
            if(datTourController.themDonDatTour(donDatTour))
            {
                Debug.WriteLine("Dat TOur thanh Cong.");
            }
            else
            {
                Debug.WriteLine("Dat Tour THat Bai");
            }

        }
    }
}