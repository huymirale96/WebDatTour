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
using WebDatTour.Controllers;

namespace WebDatTour.View.BackEnd
{
    
    public partial class XemDonDatCuaKhachHang : System.Web.UI.Page
    {
        DonDatTourController datTourController = new DonDatTourController();
        Connector connector = new Connector();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                layDonDatTour(Request.QueryString["id"].ToString());
                layTepKH(Request.QueryString["id"].ToString());
            }
            else
            {
            
            }
        }
        public void layTepKH(string id)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("select * from tblTepThongTinKhachHang where iMaKhachHang = " + id, connector.connect());
                cmd.CommandType = CommandType.Text;

                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                rptTep.DataSource = table;
                rptTep.DataBind();
                if (table.Rows.Count == 0)
                {
                   // divtepkh.Visible = false;
                }

            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error " + ex.Message);

                // return null;
            }
        }
        public void layDonDatTour(string id)
        {
            rptdondattour.DataSource = datTourController.donHanh_khachHang(id);
            rptdondattour.DataBind();
        }
        public String toCurruncy_(int x)
        {
            return x.ToString("#,##0");
        }
        public string trangThai(string id)
        {
            switch (id)
            {
                case "0": return "<label class='label label-warning'>Chờ Xác Nhận</label>";
                case "1": return "<label class='label label-success'>Đã Xác Nhận</label>";
                case "2": return "<label class='label label-danger'> Đã Hủy</label>";
                case "3": return "<label class='label label-danger'> Đã Bị Hủy</label>";
                default: return "";

            }
        }
    }
}