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
    public partial class ThongKeDoanhSoTheoTour : System.Web.UI.Page
    {
        TourController donDatTourController = new TourController();
        DonDatTourController donDatTourController_ = new DonDatTourController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Session["quyen"].ToString().Equals("2"))
            {
                Response.Redirect("admin.aspx");
            }
            layDuLieu();
            Paging();
        }
        public void layDuLieu()
        {
            rptTour.DataSource = donDatTourController_.thongKeDoanhSoTheoTour_();
            rptTour.DataBind();
        }
        private void Paging()
        {

            #region page for repeater
            // Starting paging here.
            PagedDataSource pds = new PagedDataSource();
            DataView dt = donDatTourController_.thongKeDoanhSoTheoTour_().DefaultView;

            pds.DataSource = dt;
            pds.AllowPaging = true;
            // Show number of product in one page.
            pds.PageSize = 15;
            // Specify sum of page.
            int numPage = pds.PageCount;
            int currentPage;
            if (Request.QueryString["page"] != null)
            {
                currentPage = Int32.Parse(Request.QueryString["page"]);
            }
            else
            {
                currentPage = 1;
            }
            // Because paging always start at 0.
            pds.CurrentPageIndex = currentPage - 1;
            // Show
            //Labelnv.Text = "Trang  " + currentPage + " cua " + pds.PageCount;

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



            #endregion

            rptTour.DataSource = pds;
            rptTour.DataBind();

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {

        }

        protected void timKiem_Click(object sender, EventArgs e)
        {
            rptTour.DataSource = donDatTourController.timSoCHo_Tour(txtTieuDe.Text);
            rptTour.DataBind();
            Paging2();
        }
        private void Paging2()
        {

            #region page for repeater
            // Starting paging here.
            PagedDataSource pds = new PagedDataSource();
            DataView dt = donDatTourController.timSoCHo_Tour(txtTieuDe.Text).DefaultView;

            pds.DataSource = dt;
            pds.AllowPaging = true;
            // Show number of product in one page.
            pds.PageSize = 15;
            // Specify sum of page.
            int numPage = pds.PageCount;
            int currentPage;
            if (Request.QueryString["page"] != null)
            {
                currentPage = Int32.Parse(Request.QueryString["page"]);
            }
            else
            {
                currentPage = 1;
            }
            // Because paging always start at 0.
            pds.CurrentPageIndex = currentPage - 1;
            // Show
            //Labelnv.Text = "Trang  " + currentPage + " cua " + pds.PageCount;

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



            #endregion

            rptTour.DataSource = pds;
            rptTour.DataBind();

        }
        protected String toCurruncy(string x)
        {

            return Convert.ToInt32(x).ToString("#,##0");
        }
    }
}