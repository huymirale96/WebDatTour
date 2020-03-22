using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Object;
using WebDatTour.Controllers;
using WebDatTour.Model;

namespace WebDatTour.View.BackEnd
{
    public partial class ThemNhanVien : System.Web.UI.Page
    {
        XuLy xuly = new XuLy();
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentDate = DateTime.Today.AddYears(-15).ToShortDateString();
           // System.Diagnostics.Debug.WriteLine("thoi gian " + currentDate);
            Comparevalidator1.ValueToCompare = currentDate;

            if (!HttpContext.Current.Session["quyen"].ToString().Equals("2"))
            {
                Response.Redirect("admin.aspx");
            }
        }

        protected void btnDangKi_Click(object sender, EventArgs e)
        {
            NhanVien nhanVien = new NhanVien();
            nhanVien.TenNhanVien = xuly.locKiTu(txtName.Text);
            nhanVien.StenDangNhap = xuly.locKiTu(txtTenDangNhap.Text);
            nhanVien.MatKhau = txtMK.Text;
            nhanVien.QueQuan = xuly.locKiTu(queQuan.Text);
            nhanVien.NgaySinh = DateTime.Parse(txtNgaySinh.Text);
            nhanVien.SoDienThoai = xuly.locKiTu(txtSDT.Text);
            if(rdoMember.Checked == true)
            {
                nhanVien.Quyen = 1;
            }
            else
            {
                nhanVien.Quyen = 2;
            }
            if (rdoNam.Checked == true)
            {
                nhanVien.GioiTinh = true;
            }
            else
            {
                nhanVien.GioiTinh = false;                
            }
            NhanVienController nhanVienController = new NhanVienController();
            if (nhanVienController.kiemTraTen(txtTenDangNhap.Text))
            {
                if (nhanVienController.ThemNhanVien(nhanVien))
                {
                    string myScript = "\n<script type=\"text/javascript\" language=\"Javascript\" id=\"EventScriptBlock\">\n";
                    myScript += "toastr.success(\"Thêm Tour Nhân Viên Thành Công\",\"Thông Báo\");";
                    myScript += "\n\n </script>";

                    notification.InnerHtml = myScript;
                    noti.Text = "Thêm Nhân Viên Thành Công";
                    // Response.Write("<script language=javascript>alert('OKK');</script>");
                }
                else
                {
                    noti.Text = "Thêm Nhân Viên Thất Bại";
                    //  Response.Write("<script language=javascript>alert('ERROR');</script>");
                }
            }
            else
            {
                noti.Text = "Tên Đăng Nhập Đã Được Sử Dụng.";
            }
            
        }
    }
}