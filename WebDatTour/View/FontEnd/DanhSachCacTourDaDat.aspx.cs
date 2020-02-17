﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Controllers;
using System.Diagnostics;
using WebDatTour.Object;
using System.Configuration;
using WebDatTour.Model;

namespace WebDatTour.View.FontEnd
{
    public partial class DanhSachCacTourDaDat : System.Web.UI.Page
    {
        DonDatTourController donDatTourController = new DonDatTourController();
        KhachHangController khachHangController = new KhachHangController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Form["cn"] != null && Request.Form["id"] != null)
            {
                Debug.WriteLine("mk : " + Request.Form["id"] +" - " +Request.Form["pw"]);
                if (Request.Form["cn"].ToString().Equals("huy"))
                {
                    KhachHang khachHang = new KhachHang();
                    khachHang.MaKH = Convert.ToInt32(HttpContext.Current.Session["maKH"].ToString());
                    khachHang.MatKhau = Request.Form["pw"].ToString();
                    if (khachHangController.kiemTraDangNhap(khachHang))
                    {


                        if (donDatTourController.khhuy(Request.Form["id"].ToString()))
                        {

                            Debug.WriteLine("okkkk");
                            lblnoti.CssClass = "text-success";
                            lblnoti.Text = "Huy Thanh Cong.";
                        }
                        else
                        {
                            Debug.WriteLine("fail");
                            lblnoti.CssClass = "text-danger";
                            lblnoti.Text = "Huy That Bai.";
                        }
                    }
                    else
                    {
                        lblnoti.CssClass = "text-danger";
                        lblnoti.Text = "Mat khau sai.";
                    }
                }
                

                }

            if (Request.QueryString["cn"] != null && Request.QueryString["tien"] != null && Request.QueryString["id"] != null)
            {

                if (Request.QueryString["cn"].ToString().Equals("tt"))
                {

                    Debug.WriteLine(Request.QueryString["tien"] + Request.QueryString["id"]);
                }
            }
            if (Request.Form["cn"] != null && Request.Form["tientt"] != null && Request.Form["idtt"] != null && Request.Form["bank"] != null)
            {

                if (Request.Form["cn"].ToString().Equals("tt"))
                {
                    try
                    {
                        Debug.WriteLine(Request.Form["tientt"] + Request.Form["bank"]);
                        thanhToan(Convert.ToInt32(Request.Form["idtt"].ToString()), Convert.ToInt32(Request.Form["tientt"].ToString()), Request.Form["bank"].ToString());
                    }
                    catch(Exception ex)
                    {
                        throw ex;
                    }
                }
            }
            string id = HttpContext.Current.Session["maKH"].ToString();
            if (!id.Equals(""))
            {
                layDonDatTour(id);
                Paging(id);
                Debug.WriteLine("id khach hang dsdon: " + id);

            }
            else
            {
                Response.Redirect("index.aspx");
            }
            
        }
        
        public void layDonDatTour(string id)
        {
            rptdondattour.DataSource = donDatTourController.donHanh_khachHang(id);
            rptdondattour.DataBind();
        }
        private void Paging(string id)
        {

            #region page for repeater
            // Starting paging here.
            PagedDataSource pds = new PagedDataSource();
            DataView dt = donDatTourController.donHanh_khachHang(id).DefaultView;

            pds.DataSource = dt;
            pds.AllowPaging = true;
            // Show number of product in one page.
            pds.PageSize = 15;
            // Specify sum of page.
            int numPage = pds.PageCount;
            int currentPage;
            if (Request.QueryString["page"] != null)
            {
                currentPage = Int32.Parse(Request.QueryString["page"]);
            }
            else
            {
                currentPage = 1;
            }
            // Because paging always start at 0.
            pds.CurrentPageIndex = currentPage - 1;
            // Show
            //Labelnv.Text = "Trang  " + currentPage + " cua " + pds.PageCount;

            string urls = "<ul class='pagination'>";
            for (int i = 1; i <= numPage; i++)
            {
                if (i != currentPage)
                {
                    urls += "<li><a href='" + Request.CurrentExecutionFilePath + "?page=" + i + "'>" + i + "</a></li>";
                }
                else
                {
                    urls += "<li class='active'><a href='" + Request.CurrentExecutionFilePath + "?page=" + i + "'>" + i + "</a></li>";
                }
            }
            url.Text = urls + "</ul>";



            #endregion

            rptdondattour.DataSource = pds;
            rptdondattour.DataBind();

        }
        protected String toCurruncy(int x)
        {
            return x.ToString("#,##0");
        }
        public String toCurruncy_(int x)
        {
            return x.ToString("#,##0");
        }
        public void thanhToan(int id, int tien_, string bank)
        {
            //Get Config Info
            string vnp_Returnurl = ConfigurationManager.AppSettings["vnp_Returnurl"]; //URL nhan ket qua tra ve 
        string vnp_Url = ConfigurationManager.AppSettings["vnp_Url"]; //URL thanh toan cua VNPAY 
        string vnp_TmnCode = ConfigurationManager.AppSettings["vnp_TmnCode"]; //Ma website
        string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; //Chuoi bi mat



            // Debug.WriteLine(Convert.ToInt32(tienThanhToan_));
            
                int maThanhToan = donDatTourController.themGiaoDich(id, tien_);
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
                    vnpay.AddRequestData("vnp_Amount", (tien_* 100).ToString());
                    vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
                    vnpay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress());
                    vnpay.AddRequestData("vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss"));

                   
                        vnpay.AddRequestData("vnp_BankCode", bank);
                       

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