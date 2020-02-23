using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Model;
using System.Diagnostics;
namespace WebDatTour.View.FontEnd
{
    public partial class TimKiemTour : System.Web.UI.Page
    {

        TourModel tourModel = new TourModel();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["ten"] != null)
            {
                Debug.WriteLine("ten timkiem  : " + Request.QueryString["ten"]);
                layTour(Request.QueryString["ten"].ToString());
                Paging(Request.QueryString["ten"].ToString());
            }
            else
            {
                
            }
        }
        //timKiemTour
        public void layTour(string id)
        {
            txttuKhoa.InnerHtml = "Từ Khóa Tìm Kiếm : " + id;
            rptTour.DataSource = tourModel.timKiemTour(id);
            rptTour.DataBind();
        }
        private void Paging(string id)
        {

            #region page for repeater
            // Starting paging here.
            PagedDataSource pds = new PagedDataSource();
            DataView dt = tourModel.timKiemTour(id).DefaultView;

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
                    urls += "<li><a href='" + Request.CurrentExecutionFilePath + "?page=" + i + "&id=" + id + "'>" + i + "</a></li>";
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
    }
}