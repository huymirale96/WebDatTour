using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Model;
using System.Diagnostics;
using WebDatTour.Controllers;
using Newtonsoft.Json;

namespace WebDatTour.View.BackEnd
{
    public partial class DanhSachDatTour : System.Web.UI.Page
    {
        DonDatTourModel donDatTourModel = new DonDatTourModel();
        DonDatTourController donDatTourController = new DonDatTourController();
        protected void Page_Load(object sender, EventArgs e)
        {
           // ItemMenuBtn.DataBind();

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
                pageid.Value = currentPage.ToString();
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

        protected void btnXacNhan_Click(object sender, EventArgs e)
        {
            LinkButton linkButton = (LinkButton)sender;
            string id = linkButton.CommandArgument.ToString();
            //Debug.WriteLine("id " + id);
            if(donDatTourController.sp_capNhatTrangThaiDonHang(id, "", 1))
            {
                lblnoti.CssClass = "text-success";
                lblnoti.Text = "Xác Nhận Đơn Đặt Tour Thành Công.";
                Response.Redirect("danhsachdattour.aspx?page="+ pageid.Value);
            }
            else
            {
                lblnoti.CssClass = "text-danger";
                lblnoti.Text = "Xác Nhận Đơn Đặt Tour Thất Bại.";
                Response.Redirect("danhsachdattour.aspx?page=" + pageid.Value);
            }
        //    Response.
        }
        public string trangThaiDon(int id)
        {
            switch(id)
            {
                case 0: return "<label class='label label-warning'>Chờ Xác Nhận</label>";
                case 1: return "<label class='label label-success'>Đã Xác Nhận</label>";
                case 2: return  "<label class='label label-danger'>KH Đã Hủy</label>";
                case 3: return  "<label class='label label-danger'>NV Đã Hủy</label>";
                default: return "";

            }
        }

        protected void btnHuy_Click(object sender, EventArgs e)
        {
            LinkButton linkButton = (LinkButton)sender;
            string id = linkButton.CommandArgument.ToString();
            //Debug.WriteLine("id " + id); 
            //if (donDatTourController.capNhatTrangThaiDatTour(id, 3,Session["manv"].ToString()))
            if (donDatTourController.sp_capNhatTrangThaiDonHangNV(id, "", 3))
            {
                lblnoti.CssClass = "text-success";
                lblnoti.Text = "Hủy Đơn Đặt Tour Thành Công.";
                Response.Redirect("danhsachdattour.aspx?page=" + pageid.Value);
            }
            else
            {
                lblnoti.CssClass = "text-danger";
                lblnoti.Text = "Hủy Đơn Đặt Tour Thất Bại.";
                Response.Redirect("danhsachdattour.aspx?page=" + pageid.Value);
            }
        }

        protected void btnThanhToan_Click(object sender, EventArgs e)
        {
            string[] agru = new string[2];
            LinkButton link = (LinkButton)sender;
            agru = link.CommandArgument.ToString().Split(';');
           // Debug.WriteLine("agrument : " + agru[0] +"  "+ agru[1]);
           if(donDatTourController.nhanVienthanhToan(agru[0],agru[1]))
            {
                Response.Redirect("danhsachdattour.aspx?page=" + pageid.Value);
            }
           else
            {
                lblnoti.CssClass = "text-danger";
                lblnoti.Text = "Thanh Toán "+ agru[1] + " Thất Bại.";
            }
        }

        protected void btnTimKiem_Click(object sender, EventArgs e)
        {
            if(!txtTuKhoa.Text.Equals(""))
            {
                if (rdDon.Checked)
                {
                    //Debug.WriteLine(txtTuKhoa.Text + " kq tim theo don" + JsonConvert.SerializeObject(donDatTourController.timDonDatTour(txtTuKhoa.Text)));
                    rptdondattour.DataSource = donDatTourController.timDonDatTour(txtTuKhoa.Text);
                    rptdondattour.DataBind();
                }
                else
                {
                    rptdondattour.DataSource = donDatTourController.timDonDatTourKH(txtTuKhoa.Text);
                    rptdondattour.DataBind();
                }
            }
        }
    }
}