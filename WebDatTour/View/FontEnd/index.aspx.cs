using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using WebDatTour.Controllers;
using WebDatTour.Object;
using System.Diagnostics;
using System.Web.Services;

namespace WebDatTour.View.FontEnd
{
    public partial class index : System.Web.UI.Page
    {
        TourController TourController = new TourController();
        KhachHangController khachHangController = new KhachHangController();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //String cnnString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                layDanhSachTour();
                if (Request.QueryString["chucNang"] != null)
                {
                    if (Request.QueryString["chucNang"].ToString().Equals("dangxuat"))
                    {
                        HttpContext.Current.Session["tenKH"] = "";
                        Response.Redirect("index.aspx");
                    }
                    

                    if (Request.QueryString["chucNang"].ToString().Equals("dangKi"))
                    {

                        //Response.Write("đâsdas");


                        //Response.Write("đâsdas");
                        KhachHang khachHang = new KhachHang();
                        khachHang.DiaChi = Request.QueryString["txtDCDK"];
                        khachHang.Email = Request.QueryString["txtEmalDK"];
                        khachHang.MatKhau = Request.QueryString["txtMKDK"];
                        khachHang.SoDienThoai = Request.QueryString["txtSDTDK"];
                        khachHang.TenDangNhap = Request.QueryString["txtTenDK"];
                        khachHang.TenKhachHang = Request.QueryString["txtHTDK"];
                        khachHang.NgaySinh = DateTime.Parse(Request.QueryString["txtNS"]);
                        if (khachHangController.dangKy(khachHang))
                        {

                        }
                    }
                    else
                    {
                        if (Request.QueryString["chucNang"].ToString().Equals("dangNhap"))
                        {
                            KhachHang khachHang = new KhachHang();
                            khachHang.TenDangNhap = Request.QueryString["txtTenDN"];
                            khachHang.MatKhau = Request.QueryString["txtMKDN"];
                            if (khachHangController.dangNhap(khachHang))
                            {
                                //  lb1.Text = "DA DANG NHAP";
                                //  Debug.WriteLine("Logined..." + HttpContext.Current.Session["tenKH"]);


                            }
                            else
                            {
                                //  lb1.Text = "Chua DANG NHAP";
                                Debug.WriteLine("Logined Faile...");
                                // Session["maNV"] = "";
                            }
                            /*using (SqlConnection cnn = new SqlConnection(cnnString))
                            {
                                SqlCommand cmd = new SqlCommand("sp_login_kh", cnn);
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@user", Request.QueryString["txtTenDN"]);
                                cmd.Parameters.AddWithValue("@pw", GetMD5(Request.QueryString["txtMKDN"]));
                                cnn.Open();
                                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                                DataTable table = new DataTable();
                                dap.Fill(table);
                                if (table.Rows.Count > 0)
                                {
                                    lb1.Text = "DA DANG NHAP";
                                }
                                else
                                {
                                    lb1.Text = "Chua DANG NHAP";
                                }

                            }*/
                        }
                    }

                }
            }
            catch(Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }

            

            
        }
        [WebMethod]
       public static string dangnhapkh(string ten, string mk)
        {
            KhachHangController khachHangController_ = new KhachHangController();
            KhachHang khachHang = new KhachHang();
            khachHang.TenDangNhap = ten;
            khachHang.MatKhau = mk;
            string x = khachHangController_.dangNhapKH(khachHang);
          //  Debug.WriteLine("TEN Khach Hang: " + x);
            return x;
        }
        [WebMethod]
        public static Boolean kiemTraTen(string ten)
        {
           // Debug.WriteLine("ten dki ajax :" +ten);
            KhachHangController khachHangController = new KhachHangController();
           // Debug.WriteLine("ten dki ajax ket qua :" + khachHangController.kiemTraTen(ten));
            return khachHangController.kiemTraTen(ten);
        }
        protected void layTour(int id)
        {
            //rptTour.DataSource = TourController.layTour(1);
            //rptTour.DataBind();
        }
        protected void layDanhSachTour()
        {
            rpt1.DataSource = TourController.layTour(18);
            rpt1.DataBind();
            rpt2.DataSource = TourController.layTour(19);
            rpt2.DataBind();
            rpt3.DataSource = TourController.layTour(20);
            rpt3.DataBind();

        }
        protected void btndk_Click(object sender, EventArgs e)
        {

        }

        
        public String anhDaiDien(String url)
        {
            string[] urlAnh1 = url.Split('/');
            if (1 > 0)
            {

            }
            return urlAnh1[0];
        }
        protected String giave(int gia)
        {
            if(gia == 0)
            {
                return "";
            }
            else
            {
                return gia.ToString("#,##0");
            }
        }
        protected String toCurruncy(int x)
        {
            return x.ToString("#,##0");
        }
    }
}