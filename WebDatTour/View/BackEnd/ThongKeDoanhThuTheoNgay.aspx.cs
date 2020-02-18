using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using WebDatTour.Controllers;
using System.Data;

namespace WebDatTour.View.BackEnd
{
    public partial class ThongKeDoanhThuTheoNgay : System.Web.UI.Page
    {
        DonDatTourController datTourController = new DonDatTourController();
        protected void Page_Load(object sender, EventArgs e)
        {
            Debug.WriteLine("ngay " + batDau_.Value);
           if(!IsPostBack)
            {
                batDau_.Value = DateTime.Now.ToString("yyyy-MM-yy");
                ketThuc_.Value = DateTime.Now.ToString("yyyy-MM-yy");
            }
        }

        

        protected void tim__Click(object sender, EventArgs e)
        {
            noti.Text = "";
            txtDoanhSo.InnerText = " ";
            txtSoDon.InnerText = " ";
            txtThucThu.InnerText = "";
            if (DateTime.Parse(batDau_.Value) <= DateTime.Parse(ketThuc_.Value))
            {
                DataTable dataTable = datTourController.thongKeDoanhThu(batDau_.Value, ketThuc_.Value);
                if (dataTable.Rows.Count > 0)
                {
                    txtDoanhSo.InnerText = "TỔNG DOANH SỐ LÀ: " + Convert.ToInt32(dataTable.Rows[0]["doanhthu"]).ToString("#,##0")+" VND"; 
                    txtSoDon.InnerText = "TỔNG SỐ ĐƠN LÀ: " + dataTable.Rows[0]["soDOn"].ToString();
                    txtThucThu.InnerText = "TỔNG THỰC THU LÀ: " + Convert.ToInt32(dataTable.Rows[0]["thucthu"]).ToString("#,##0") + " VND";
                }
                else
                {
                    noti.Text = "Không Có Kết Quả.";
                }
            }
            else
            {
                noti.Text = "Ngày Bắt Đầu Và Ngày Tìm Kiếm Sai.";
            }
        }
    }
}