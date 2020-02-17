using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Controllers;

namespace WebDatTour.View.BackEnd
{
    public partial class XemDonDatTour : System.Web.UI.Page
    {
        TourController tourController = new TourController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["id"] != null)
            {
                layDuLieu(Request.QueryString["id"].ToString());
            }
        }
        public void layDuLieu(string id)
        {
        DataTable datatable = new DataTable();
        datatable  = tourController.xemDonDatTour(id);
            txtEmail.InnerText = "Email :" + datatable.Rows[0]["sEmail"].ToString();
            txtMa.InnerText = "Mã Đơn Đặt TOur: " + datatable.Rows[0]["imadontour"].ToString();
            txtNgaykhoiHnah.InnerText = "Thời Gian Đi: " + datatable.Rows[0]["dthoigian"].ToString();
            txtNL.InnerText = "Số Vé Người Lớn" + datatable.Rows[0]["veNL"].ToString();
            txtNoiKhoiHanh.InnerText = "Nơi Khởi Hành: " + datatable.Rows[0]["snoikhoihanh"].ToString();
            //  txtNoiKhoiHanh.InnerText = "" + datatable.Rows[0][""].ToString();
            
            txtNgayD.InnerText = "Ngày Đặt: " + datatable.Rows[0]["dngaydattour"].ToString();
            txtsdt.InnerText = "Số Điện Thoại: " + datatable.Rows[0]["sSDT"].ToString();
            txtTE.InnerText = "Số Vé Trẻ Em: " + datatable.Rows[0]["veTE"].ToString(); 
            txtTen.InnerText = "Tên Khách Hàng : " + datatable.Rows[0]["sTenKhachHang"].ToString();
            txtTien.InnerText = "Tổng Giá Trị Đơn: " + datatable.Rows[0]["doanhthu"].ToString() + " VND";
            txttientt.InnerText = "Tiền Đã Thanh Toán : " + datatable.Rows[0]["thucthu"].ToString() + " VND";
            txtTieuDe.InnerText = "Tour: " + datatable.Rows[0]["stieude"].ToString();
            txttgtong.InnerText = "" + datatable.Rows[0]["stongthoigian"].ToString();
            txtGhiChu.InnerText = "" + datatable.Rows[0]["sghichu"].ToString();

        }
    }
}