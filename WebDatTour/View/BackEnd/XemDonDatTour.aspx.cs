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
        DonDatTourController datTourController = new DonDatTourController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["id"] != null)
            {
                layDuLieu(Request.QueryString["id"].ToString());
            }
        }
        public void layDuLieu(string id)
        {
            //  System.Diagnostics.Debug.WriteLine("id don : " + id);
            try
            {
                rptGiaoDich.DataSource = datTourController.xemgiaodich(id);
                rptGiaoDich.DataBind();
                rptTrangThai.DataSource = datTourController.xemTrangThaiNV(id);
                rptTrangThai.DataBind();

                DataTable datatable = new DataTable();
                datatable = tourController.xemDonDatTour(id);

                Repeater2.DataSource = datatable;
                Repeater2.DataBind();

                /*txtEmail.InnerText = "Email :" + datatable.Rows[0]["sEmail"].ToString();
                txtMa.InnerText = "Mã Đơn Đặt TOur: " + datatable.Rows[0]["imadontour"].ToString();
                txtNgaykhoiHnah.InnerText = "Thời Gian Đi: " + DateTime.Parse(datatable.Rows[0]["dthoigian"].ToString()).ToString("dd/MM/yyyy");
                txtNL.InnerText = "Số Vé Người Lớn" + datatable.Rows[0]["veNL"].ToString();
                txtNoiKhoiHanh.InnerText = "Nơi Khởi Hành: " + datatable.Rows[0]["snoikhoihanh"].ToString();
                //  txtNoiKhoiHanh.InnerText = "" + datatable.Rows[0][""].ToString();

                txtNgayD.InnerText = "Ngày Đặt: " + DateTime.Parse(datatable.Rows[0]["dngaydattour"].ToString()).ToString("dd/MM/yyyy");
                txtsdt.InnerText = "Số Điện Thoại: " + datatable.Rows[0]["sSDT"].ToString();
                txtTE.InnerText = "Số Vé Trẻ Em: " + datatable.Rows[0]["veTE"].ToString();
                txtTen.InnerText = "Tên Khách Hàng : " + datatable.Rows[0]["sTenKhachHang"].ToString();
                txtTien.InnerText = "Tổng Giá Trị Đơn: " + datatable.Rows[0]["doanhthu"].ToString() + " VND";
                txttientt.InnerText = "Tiền Đã Thanh Toán : " + datatable.Rows[0]["thucthu"].ToString() + " VND";
                txtTieuDe.InnerText = "Tour: " + datatable.Rows[0]["stieude"].ToString();
                txttgtong.InnerText = "Tổng Thời Gian" + datatable.Rows[0]["stongthoigian"].ToString();
                txtGhiChu.InnerText = "Ghi Chú" + datatable.Rows[0]["sghichu"].ToString();*/
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
            }

        }
        protected String toCurruncy(int x)
        {
            return x.ToString("#,##0")+" VNĐ";
        }
        public string trangThai(string id)
        {
            switch (id)
            {
                case "0": return "<label class='label label-warning'>Chờ Xác Nhận</label>";
                case "1": return "<label class='label label-success'>Đã Xác Nhận</label>";
                case "2": return "<label class='label label-danger'>KH Đã Hủy</label>";
                case "3": return "<label class='label label-danger'> Đã Bị Hủy</label>";
                case "4": return "<label class='label label-info'> Đã Hoàn Tiền</label>";
                default: return "";

            }
        }
    }
}