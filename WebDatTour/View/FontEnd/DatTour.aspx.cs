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
using System.Configuration;

namespace WebDatTour.View.FontEnd
{
    public partial class DatTour : System.Web.UI.Page
    {
        TourController tourController = new TourController();
        DonDatTourModel danDatTourModel = new DonDatTourModel();
        DonDatTourController datTourController = new DonDatTourController();
        KhachHangModel khachHangModel = new KhachHangModel();
       // HiddenField tien_tt = (HiddenField)FindControl("tien_");
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
            String emailKH = "";
            String sdtKH = "";
            SqlDataReader rdkh = khachHangModel.xemKhachHangID(HttpContext.Current.Session["maKH"].ToString());
            if (rdkh.HasRows)
            {
                while (rdkh.Read())
                {
                    emailKH = "Email: " + rdkh["sEmail"].ToString();
                    sdtKH = "Số Điện Thoại: " + rdkh["sSDT"].ToString();
                    txtEmail.InnerHtml = emailKH;
                    txtSDT.InnerHtml = sdtKH;
                    txtTen.InnerHtml = "Khách Hàng " + rdkh["sTenKhachHang"].ToString();
                }
            }
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
                    // + Session["tenKH"].ToString();
                   
                    txtNL.InnerHtml = "Số Chỗ Người Lớn Là: &nbsp" + nl + "&nbsp chỗ x &nbsp" + giaNL_.ToString("#,##0") + "&nbspVNĐ";
                    txtTE.InnerHtml = "Số Chỗ Trẻ Em Là: &nbsp" + te + "&nbsp chỗ x &nbsp" + giaTE_.ToString("#,##0") + "&nbspVNĐ";
                    txtTong.InnerHtml = "Tổng Tiền Là:&nbsp" + (te * giaTE_ + nl * giaNL_).ToString("#,##0") + "&nbspVNĐ";
                    tien_tt.Value = (te * giaTE_ + nl * giaNL_).ToString();
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
            //Get Config Info
            string vnp_Returnurl = ConfigurationManager.AppSettings["vnp_Returnurl"]; //URL nhan ket qua tra ve 
            string vnp_Url = ConfigurationManager.AppSettings["vnp_Url"]; //URL thanh toan cua VNPAY 
            string vnp_TmnCode = ConfigurationManager.AppSettings["vnp_TmnCode"]; //Ma website
            string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; //Chuoi bi mat


            if (!phanTramDat.Text.Equals("none"))
            
               { 
                // Debug.WriteLine(Convert.ToInt32(tienThanhToan_));
                DonDatTour donDatTour = new DonDatTour();
                donDatTour.ChoNL = Convert.ToInt32(iNL.Value);
                donDatTour.ChoTE = Convert.ToInt32(iTE.Value);
                donDatTour.MaTour = Convert.ToInt32(tour.Value);
                donDatTour.GhiChu = txtGhiChu.Text;
                donDatTour.NgayDat = DateTime.Now; //DateTime.UtcNow.Date;
                donDatTour.TienDaThanhToan = Convert.ToInt32(tien_tt.Value);//tienThanhToan_(tour.Value.ToString(), Convert.ToInt32(iTE.Value), Convert.ToInt32(iNL.Value));
                donDatTour.TrangThai = 0;
                donDatTour.MaKH = 1;
                float phantram = (float)Convert.ToDouble(phanTramDat.SelectedValue);
                float tien_1 = Convert.ToInt32(tien_tt.Value) * phantram;
                int tien_ = Convert.ToInt32(tien_1);
                Debug.WriteLine(Convert.ToInt32(tien_tt.Value) + "  tien "  + tien_1);
                int maThanhToan = datTourController.themDonDatTour(donDatTour, tien_);
                if (maThanhToan != 0)
                {

                    //Build URL for VNPAY
                    VnPayLibrary vnpay = new VnPayLibrary();

                    vnpay.AddRequestData("vnp_Version", "2.0.0");
                    vnpay.AddRequestData("vnp_Command", "pay");
                    vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
                    vnpay.AddRequestData("vnp_Locale", "vn");
                    vnpay.AddRequestData("vnp_CurrCode", "VND");
                    vnpay.AddRequestData("vnp_TxnRef", maThanhToan.ToString());
                    vnpay.AddRequestData("vnp_OrderInfo", "ghi chu");
                    vnpay.AddRequestData("vnp_OrderType", "other"); //default value: other
                    vnpay.AddRequestData("vnp_Amount", (tien_ * 100).ToString());
                    vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
                    vnpay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress());
                    vnpay.AddRequestData("vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss"));

                    if (bank.SelectedItem != null && !string.IsNullOrEmpty(bank.SelectedItem.Value))
                    {
                        vnpay.AddRequestData("vnp_BankCode", bank.SelectedItem.Value);
                        Debug.WriteLine("bank " + bank.SelectedItem.Value);

                    }

                    string paymentUrl = vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);
                    //  log.InfoFormat("VNPAY URL: {0}", paymentUrl);
                    Debug.WriteLine(paymentUrl);
                    Response.Redirect(paymentUrl);

                    Debug.WriteLine("Dat TOur thanh Cong.");

                }
                else
                {
                    Debug.WriteLine("Dat Tour THat Bai");
                }
            }
        }
    }
}