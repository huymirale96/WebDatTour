using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Model;

namespace WebDatTour.View.BackEnd
{
    public partial class DanhSachDatTour : System.Web.UI.Page
    {
        DonDatTourModel donDatTourModel = new DonDatTourModel();
        protected void Page_Load(object sender, EventArgs e)
        {
            layDonDatTour();
            Paging();
        }
        public void layDonDatTour()
        {
            rptdondattour.DataSource = donDatTourModel.donDatTour();
                rptdondattour.DataBind();
        }
        private void Paging()
        {

            #region page for repeater
            // Starting paging here.
            PagedDataSource pds = new PagedDataSource();
            DataView dt = donDatTourModel.donDatTour().DefaultView;

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

            rptdondattour.DataSource = pds;
            rptdondattour.DataBind();

        }
        protected String toCurruncy(int x)
        {
            return x.ToString("#,##0");
        }
    }
}