using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Controllers;
using WebDatTour.Object;

namespace WebDatTour.View.BackEnd
{
    public partial class ThongTinNhanVien : System.Web.UI.Page
    {
        NhanVienController nhanVienController = new NhanVienController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["maNV"].ToString().Equals(""))
                {
                    Response.Redirect("dangnhap.aspx");
                }
                else
                {
                    layDuLieu(Session["maNV"].ToString());
                }
            }
        }
        void layDuLieu(string id)
        {
            DataTable dataTable = nhanVienController.layThongTinNhanVienM(id);
            txtDC.InnerHtml = "Địa Chỉ: " + dataTable.Rows[0]["sdiachi"];
            txtSDT.InnerHtml = "SĐT: " + dataTable.Rows[0]["ssdt"];
            txtDN.InnerHtml = "Tên Đăng Nhập : " + dataTable.Rows[0]["susername"];
            txtTen.InnerHtml = "Tên Nhân Viên: " + dataTable.Rows[0]["stennhanvien"];
            txtNS.InnerHtml = "Ngày Sinh: " + DateTime.Parse(dataTable.Rows[0]["dngaysinh"].ToString()).ToString("dd/MM/yyyy");
            txtNgaySinh.Text = DateTime.Parse(dataTable.Rows[0]["dngaysinh"].ToString()).ToString("yyyy-MM-dd");
            txtName.Text = dataTable.Rows[0]["stennhanvien"].ToString();
            queQuan.Text = dataTable.Rows[0]["sdiachi"].ToString();
            TextBox1.Text = dataTable.Rows[0]["ssdt"].ToString();
            if (dataTable.Rows[0]["bgioitinh"].ToString().Equals("True"))
            {
                rdoNu.Checked = false;
            }
            else
            {
                rdoNu.Checked = true;
            }

        }
        protected void btnDangKi_Click(object sender, EventArgs e)
        {
            NhanVien nv = new NhanVien();
            nv.QueQuan = queQuan.Text;
            nv.SoDienThoai = TextBox1.Text;
            nv.TenNhanVien = txtName.Text;
            nv.NgaySinh = DateTime.Parse(txtNgaySinh.Text);
            if(rdoNam.Checked == true)
            {
                nv.GioiTinh = true;
            }
            else
            {
                nv.GioiTinh = false;
            }
            if(nhanVienController.updateNhanVien(nv))
            {
                notil.Text = "Cập Nhật Thành Công.";
                Response.Redirect("thongtinnhanvien.aspx");
            }
            else
            {
                notil.Text = "Cập Nhật Thất Bại.";
            }
        }
        
    }
}