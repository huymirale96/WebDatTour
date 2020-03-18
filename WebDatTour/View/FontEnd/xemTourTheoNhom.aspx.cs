using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebDatTour.Model;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebDatTour.View.FontEnd
{
    public partial class xemNhomTour : System.Web.UI.Page
    {
        TourModel tourModel = new TourModel();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["id"] != null)
            {
                layTour(Convert.ToInt32(Request.QueryString["id"]));
                Paging(Convert.ToInt32(Request.QueryString["id"]));
            }

        }
        public void layTour(int id)
        {
            rptTour.DataSource = tourModel.layTourTheoNhom(id);
            rptTour.DataBind();
        }
        private void Paging(int id)
        {

            #region page for repeater
            // Starting paging here.
            PagedDataSource pds = new PagedDataSource();
            DataView dt = tourModel.layTourTheoNhom(id).DefaultView;

            pds.DataSource = dt;
            pds.AllowPaging = true;
            // Show number of product in one page.
            pds.PageSize = 5;
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
           // Labelnv.Text = "Trang  " + currentPage + " cua " + pds.PageCount;

            string urls = "<ul class='pagination'>";
            for (int i = 1; i <= numPage; i++)
            {
                if (i != currentPage)
                {
                    urls += "<li><a href='" + Request.CurrentExecutionFilePath + "?page=" + i + "&id="+ id +"'>" + i + "</a></li>";
                }
                else
                {
                    urls += "<li class='active'><a href='" + Request.CurrentExecutionFilePath + "?page=" + i + "'>" + i + "</a></li>";
                }
            }
            url.Text = urls + "</ul>";

            // Config next - pre link.
           /* if (!pds.IsFirstPage)
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
            }*/
            #endregion

            rptTour.DataSource = pds;
            rptTour.DataBind();
        }
        protected String toCurruncy(int x)
        {
            return x.ToString("#,##0");
        }
        public String anhDaiDien(String url)
        {
            string[] urlAnh1 = url.Split('/');
            if (1 > 0)
            {

            }
            return urlAnh1[0];
        }

        public String hienSoSao(String soSao)
        {
            if (soSao.Equals("0"))
            {
                return "";
            }
            else
            {
                return " <strong>Đánh Giá: <b>" + soSao + " </b><i class='fa fa-star' style='font - size: 18px; color: #ffca08;'></i></strong></div>";
            }
        }
    }
}