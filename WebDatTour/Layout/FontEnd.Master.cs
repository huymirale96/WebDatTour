using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Model;

namespace WebDatTour.Layout
{
    public partial class FontEnd : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hienNhomTOur();
            //Debug.WriteLine(Session["tenTK"].ToString());
            if (!IsPostBack)
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
        public void hienNhomTOur()
        {
            Connector cn = new Connector();
            try
            {
                SqlCommand cmd = new SqlCommand("select * from tblnhomtour where btrangthai = 1 or imanhomtour = 18 or imanhomtour = 19 or imanhomtour = 20", cn.connect());
                cmd.CommandType = CommandType.Text;
                
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                rptNhomTour.DataSource = table;
                rptNhomTour.DataBind();

            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error " + ex.Message);

               
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