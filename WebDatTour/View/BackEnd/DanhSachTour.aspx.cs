using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using WebDatTour.Controllers;

namespace WebDatTour.View.FontEnd
{
    public partial class DanhSachTour : System.Web.UI.Page
    {
        String cnnString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
        TourController tourController = new TourController();
        protected void Page_Load(object sender, EventArgs e)
        {
            xemDanhSachTour();
            Paging();
            if(Session["mess"].ToString().Equals("capnhattrangthaithanhcong"))
            {
                Session["mess"] = "";
                string myScript = "\n<script type=\"text/javascript\" language=\"Javascript\" id=\"EventScriptBlock\">\n";
                myScript += "toastr.success(\"Cập Nhật Trạng Thái Tour Thành Công\",\"Thông Báo\");";
                myScript += "\n\n </script>";
               
                script.InnerHtml = myScript;
               
            }
            if (Session["mess"].ToString().Equals("themtourthanhcong"))
            {
                Session["mess"] = "";
                string myScript = "\n<script type=\"text/javascript\" language=\"Javascript\" id=\"EventScriptBlock\">\n";
                myScript += "toastr.success(\"Thêm Tour Thành Công\",\"Thông Báo\");";
                myScript += "\n\n </script>";
                
                script.InnerHtml = myScript;

            }

        }
        public DataTable danhSachTour()
        {
            return tourController.layDanhSachTour();
        }

        public void xemDanhSachTour()
        {
            rptDanhSachTour.DataSource = danhSachTour();
            rptDanhSachTour.DataBind();
        }
        private void Paging()
        {

            #region page for repeater
            // Starting paging here.
            PagedDataSource pds = new PagedDataSource();
            DataView dt = danhSachTour().DefaultView;

            pds.DataSource = dt;
            pds.AllowPaging = true;
            // Show number of product in one page.
            pds.PageSize = 12;
            // Specify sum of page.
            int numPage = pds.PageCount;
            int currentPage;
            if (Request.QueryString["page"] != null)
            {
                currentPage = Int32.Parse(Request.QueryString["page"]);
                page_.Value = currentPage.ToString();
            }
            else
            {
                currentPage = 1;
            }
            System.Diagnostics.Debug.WriteLine("page : " + page_.Value);
            // Because paging always start at 0.
            pds.CurrentPageIndex = currentPage - 1;
            // Show
            Labelnv.Text = "Trang  " + currentPage + " cua " + pds.PageCount;

            string urls = "<ul class='pagination'>";
            for (int i = 1; i <= numPage; i++)
            {
                if (i != currentPage)
                {
                    urls += "<li><a href='" + Request.CurrentExecutionFilePath + "?page=" + i + "'>" + i + "</a></li>";
                }
                else
                {
                    urls += "<li class='active'><a href='" + Request.CurrentExecutionFilePath + "?page=" + i + "'>" + i + "</a></li>";
                }
            }
            url.Text = urls + "</ul>";

            // Config next - pre link.
            if (!pds.IsFirstPage)
            {
                lnkPre.NavigateUrl = Request.CurrentExecutionFilePath + "?page=" + Convert.ToString(currentPage - 1);
                lnkStart.NavigateUrl = Request.CurrentExecutionFilePath + "?page=1";
                

            }
            else
            {

                lnkPre.Visible = false;
            }
            if (!pds.IsLastPage)
            {
                lnkNext.NavigateUrl = Request.CurrentExecutionFilePath + "?page=" + Convert.ToString(currentPage + 1);
                lnkEnd.NavigateUrl = Request.CurrentExecutionFilePath + "?page=" + numPage;
                lnkEnd.Text = numPage.ToString();
            }
            else
            {
                lnkEnd.Text = numPage.ToString();
                lnkNext.Visible = false;
            }
            if (numPage < 2)
            {
                Labelnv.Visible = false;
                lnkStart.Visible = false;
                lnkEnd.Visible = false;
            }
            #endregion

            rptDanhSachTour.DataSource = pds;
            rptDanhSachTour.DataBind();
        }

        protected void btnFix_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string id = btn.CommandArgument;
            Response.Redirect("SuaTour.aspx?id=" + id);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string id = btn.CommandArgument;
            using (SqlConnection cnn = new SqlConnection(cnnString))
            {
                cnn.Open();
                SqlCommand cmd = new SqlCommand("sp_xoaTour", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                int i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    Response.Write("<script language=javascript>alert('DA XOA');</script>");
                    Response.Redirect("danhsachtour.aspx");

                }
                else
                {
                    Response.Write("<script language=javascript>alert('CHUA XOA DC');</script>");
                }
            }

        }
        public String urlAnhh(String url)
        {
            string[] urlAnh1 = url.Split('/');
            if (1 > 0)
            {
               
            }
            return urlAnh1[0];
        }
        /*
        public string stt(int i)
        {

            if (page_.Value != null)
            {
                return (i + (Convert.ToInt32(page_.Value) - 1) * 5).ToString();
            }
            else
            {
                return i.ToString();
            }
        }*/

        protected void btnTrangThai_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string id = btn.CommandArgument;
            string pageCurrent = "";
            if(page_.Value != null)
            {
                pageCurrent = page_.Value;
               
            }
            else
            {
                pageCurrent = "1";
            }
            tourController.capNhatTrangThaiTour(id);
            Session["mess"] = "capnhattrangthaithanhcong";
            Response.Redirect("danhsachtour.aspx?page="+pageCurrent);
        }

        protected void btnTimKiem_Click(object sender, EventArgs e)
        {
            rptDanhSachTour.DataSource = tourController.timKiemTour_tieuDe(txtTuKhoa.Text);
            rptDanhSachTour.DataBind();
        }
    }
}