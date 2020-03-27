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
using System.IO;
using WebDatTour.Model;

namespace WebDatTour.View.FontEnd
{
    public partial class ThongTinKhachHang : System.Web.UI.Page
    {
        KhachHangController khachHangController = new KhachHangController();
        Connector connector = new Connector();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["maKH"].ToString().Equals(""))
            {
                Response.Redirect("index.aspx");
            }

            if (!HttpContext.Current.Session["maKH"].ToString().Equals(""))
            {
                if (!IsPostBack)
                {
                    layDuLieu(HttpContext.Current.Session["maKH"].ToString());
                    layTepKH(HttpContext.Current.Session["maKH"].ToString());
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
                    txtNS.InnerText = "NGÀY SINH: " + DateTime.Parse(table.Rows[0]["dngaysinh"].ToString()).ToString("dd-MM-yyyy");//
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
        public void layTepKH(string id)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("select * from tblTepThongTinKhachHang where iMaKhachHang = "+id, connector.connect());
                cmd.CommandType = CommandType.Text;

                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                rptTep.DataSource = table;
                rptTep.DataBind();
                if(table.Rows.Count == 0)
                {
                    divtepkh.Visible = false;
                }

            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error " + ex.Message);

                // return null;
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
            List<string> dsHoSo = new List<string>();
            for (int i = 0; i < Request.Files.Count; i++)
            {
               
                HttpPostedFile file = Request.Files[i];
                if (file.ContentLength > 0)
                {
                    string fname = Path.GetFileName(file.FileName);
                    // Debug.WriteLine("File: " + fname);
                    dsHoSo.Add(fname);
                    file.SaveAs(Server.MapPath(Path.Combine("~/Upload/", fname)));
                    
                }
            }
           if (khachHangController.capNhapKhachHang(khachHang) && khachHangController.capNhapHoSoKhachHang(khachHang.MaKH.ToString(),dsHoSo))
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