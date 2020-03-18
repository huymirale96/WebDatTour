using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using WebDatTour.Controllers;

namespace WebDatTour.View.BackEnd
{
    public partial class DanhSachNhanVien : System.Web.UI.Page
    {
        NhanVienController nhanVienController = new NhanVienController();
        protected void Page_Load(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("quyen " + Session["quyen"].ToString());
            if (!Session["quyen"].ToString().Equals("2"))
            {
                Response.Redirect("admin.aspx");
            }
            danhSachNhanVien();
            Paging();
            
        }
        protected void danhSachNhanVien()
        {
           
                rptNhanVien.DataSource = getDSNV();
                rptNhanVien.DataBind();

            System.Diagnostics.Debug.WriteLine("nv");
        }

        public DataTable getDSNV()
        {
           return nhanVienController.layDSNV();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("Delete");
            LinkButton btn = (LinkButton)(sender);
            string manhanvien = btn.CommandArgument;
            
                if(nhanVienController.xoaNhanVien(manhanvien))
                {
                    Response.Write("<script language=javascript>alert('DA XOA');</script>");
                    Response.Redirect("danhsachnhanvien.aspx");
                    
                }
                else
                {
                    Response.Write("<script language=javascript>alert('CHUA XOA DC');</script>");
                }
            

        }
        protected void btnFix_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("FIXX");
        }

        private void Paging()
        {

            #region page for repeater
            // Starting paging here.
            PagedDataSource pds = new PagedDataSource();
            DataView dt = getDSNV().DefaultView;

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
            Labelnv.Text = "Trang  " + currentPage + " cua " + pds.PageCount;
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

            rptNhanVien.DataSource = pds;
            rptNhanVien.DataBind();
        }

        protected void btnFix_Click1(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("FIX111X");
        }

        protected void btnFix_Command(object sender, CommandEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("FIX111Xsss");
        }
    }
}

/*

     String cnnString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            if (Request.QueryString["chucNang"] != null)
            {

                if (Request.QueryString["chucNang"].ToString().Equals("dangKi"))
                {

                    //Response.Write("đâsdas");
                    
                    using (SqlConnection cnn = new SqlConnection(cnnString))
                    {
                        SqlCommand cmd = new SqlCommand("sp_dangki", cnn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@tenkh", Request.QueryString["txtHTDK"]);
                        cmd.Parameters.AddWithValue("@ns", Request.QueryString["txtNS"].ToString());
                        cmd.Parameters.AddWithValue("@diachi", Request.QueryString["txtDCDK"]);
                        cmd.Parameters.AddWithValue("@sdt", Request.QueryString["txtSDTDK"]);
                        cmd.Parameters.AddWithValue("@email", Request.QueryString["txtEmalDK"]);
                        cmd.Parameters.AddWithValue("@user", Request.QueryString["txtTenDK"]);
                        cmd.Parameters.AddWithValue("@pw", GetMD5(Request.QueryString["txtMKDK"]));
                        cnn.Open();
                        int i = cmd.ExecuteNonQuery();
*/