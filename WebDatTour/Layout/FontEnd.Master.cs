using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebDatTour.Layout
{
    public partial class FontEnd : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Debug.WriteLine(Session["tenTK"].ToString());
            if(!IsPostBack)
            {
                if (HttpContext.Current.Session["tenKH"].ToString().Equals(""))
                {
                    dangNhap.InnerHtml = "<li><a  id='dnn' >Đăng Nhập</a></li><li><a  id='dkk' >Đăng Ký</a></li>";
                    tendn.InnerText = "Tài Khoản";
                }
                else
                {
                    //dangNhap.InnerHtml = "<li><a  href='#' >Đăng Nhập</a></li>< li ><a  href='#'  > Đăng Ký </ a ></ li > ";
                    tendn.InnerText = HttpContext.Current.Session["tenKH"].ToString();
                    dangNhap.InnerHtml = "<li><a href='taikhoan.aspx' >Tài Khoản</a></li><li><a href='thongtinkhachhang.aspx'>Thông Tin</a></li><li><a href='doimatkhau.aspx' >Đổi Mật Khẩu</a></li> <li> <a href = 'DanhSachCacTourDaDat.aspx' > Các Đơn Đặt Tour</a ></li ><li><a href='index.aspx?chucNang=dangxuat' >Đăng Xuất</a></li>";
                }
            }

        }

        protected void btndk_Click(object sender, EventArgs e)
        {

        }
        protected void btndn_Click(object sender, EventArgs e)
        {

        }
    }
}