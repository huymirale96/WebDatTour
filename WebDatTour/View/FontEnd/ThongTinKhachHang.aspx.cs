using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Controllers;
using WebDatTour.Object;
using System.Diagnostics;

namespace WebDatTour.View.FontEnd
{
    public partial class ThongTinKhachHang : System.Web.UI.Page
    {
        KhachHangController khachHangController = new KhachHangController();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!HttpContext.Current.Session["maKH"].ToString().Equals(""))
            {
                if (!IsPostBack)
                {
                    layDuLieu(HttpContext.Current.Session["maKH"].ToString());
                }
            }

            else
            {
                Response.Redirect("index.aspx");
            }
        }
        public void layDuLieu(string id)
        {
           // DataTable dataTable = new DataTable();
            DataTable table  = khachHangController.xemKhachHangbyID(id);
            if(table.Rows.Count > 0)
            {
               
                    txtDC.InnerText = "ĐỊA CHỈ:  " + table.Rows[0]["sdiachi"].ToString();
                    txtDN.InnerText = "TÊN ĐĂNG NHẬP:  " + table.Rows[0]["susername"].ToString();
                    txtEMAIL.InnerText = " EMAIL: " + table.Rows[0]["semail"].ToString();
                    txtNS.InnerText = "NGÀY SINH: " + table.Rows[0]["dngaysinh"].ToString();
                txtSDT.InnerText = "SỐ ĐIỆN THOẠI: " + table.Rows[0]["ssdt"].ToString();//.Substring(0, 9);
                    txtTen.InnerText = "TÊN KHÁCH HÀNG: " + table.Rows[0]["stenkhachhang"].ToString();

                    txtDC_.Text = table.Rows[0]["sdiachi"].ToString();
                    txtEmail_.Text = table.Rows[0]["semail"].ToString();
                   // DateTime date = DateTime.ParseExact(rd["dngaysinh"].ToString(), "dd/MM/YYYY", null);
                    txtNgaySinh_.Text =DateTime.Parse(table.Rows[0]["dngaysinh"].ToString()).ToString("yyyy-MM-dd");// DateTime.Parse().ToString("yyyy-MM-dd");
                   /// Debug.WriteLine("date " + DateTime.Parse(rd["dngaysinh"].ToString()).ToString("MM-dd-yyyy"));
                    txtTen_.Text = table.Rows[0]["stenkhachhang"].ToString();
                    txtSDT_.Text = table.Rows[0]["ssdt"].ToString();
                
            }
        }

        protected void btnCapNhat_Click(object sender, EventArgs e)
        {
            KhachHang khachHang = new KhachHang();
            khachHang.TenKhachHang = txtTen_.Text;
            khachHang.SoDienThoai = txtSDT_.Text;
            khachHang.Email = txtEmail_.Text;
            khachHang.NgaySinh = DateTime.Parse(txtNgaySinh_.Text);
            khachHang.DiaChi = txtDC_.Text;
            khachHang.MaKH = Convert.ToInt32(HttpContext.Current.Session["maKH"]);
            if(khachHangController.capNhapKhachHang(khachHang))
            {
                noti.Text = "Cập Nhật Thành Công";
                Response.Redirect("thongtinkhachhang.aspx");
            }
            else
            {
                noti.Text = "Cập Nhật Thất Bại";
            }
        }
    }
}