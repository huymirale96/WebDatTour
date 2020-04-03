using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using WebDatTour.Model;
using System.Data.SqlClient;
using System.Diagnostics;
using WebDatTour.Controllers;

namespace WebDatTour.View.BackEnd
{
    public partial class GopTour : System.Web.UI.Page
    {
        Connector connector = new Connector();
        TourController tourcontroller = new TourController();
        DonDatTourController datTourController = new DonDatTourController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                layTour();
                divThongTin.Visible = false;
            }
        }

        protected void ddlTour_SelectedIndexChanged(object sender, EventArgs e)
        {
            /// Debug.WriteLine("ID TOUR: " + ddlTour.SelectedValue);
            layThoiGian(ddlTour.SelectedValue);
            divThongTin.Visible = true;
            divDonDatTour.Visible = false;

        }
        public void layTour()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("select stieude, imatour from tbltour ", connector.connect());
                cmd.CommandType = CommandType.Text;
               
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                ddlTour.DataSource =  table;
                ddlTour.DataTextField = "stieude";
                ddlTour.DataValueField = "imatour";
                ddlTour.DataBind();

            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error " + ex.Message);

               // return null;
            }
        }
        public void layThoiGianTourChuyen(string id)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("layngaydi_", connector.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                /* DataRow dataRow = table.NewRow();
                 dataRow["dthoigian"] = "Chọn Thời Gian";
                 dataRow["imathoigian"] = "none";
                 table.Rows.InsertAt(dataRow, 0);*/
               // DataTable table = tourcontroller.layNgayDiTour(Convert.ToInt32(id));
                DataColumn newCol = new DataColumn("dthoigian_", typeof(string));
                newCol.AllowDBNull = true;
                table.Columns.Add(newCol);
                foreach (DataRow row in table.Rows)
                {
                    // DataColumn col = new DataColumn();
                    row["dthoigian_"] = DateTime.Parse(row["dthoigian"].ToString()).ToString("dd-MM-yyyy");
                }
                ddlTourChuyen.DataSource = table;
                ddlTourChuyen.DataTextField = "dthoigian_";
                ddlTourChuyen.DataValueField = "imathoigian";
                ddlTourChuyen.DataBind();
               // ddlTourChuyen.Text = "Dá";

            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error " + ex.Message);

                // return null;
            }
        }
        public void layDonDatTour(string id)
        {
           
            layThoiGianTourChuyen(id);
            try
            {
                SqlCommand cmd = new SqlCommand("layThongTinTour_gopTour", connector.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                rptDondattour.DataSource = table;

                rptDondattour.DataBind();

            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error " + ex.Message);

                // return null;
            }
        }
        
        public void layThoiGian(string id)
        {
            DataTable table = tourcontroller.layNgayDiTour(Convert.ToInt32(id));
            DataColumn newCol = new DataColumn("dthoigian_", typeof(string));
            newCol.AllowDBNull = true;
            table.Columns.Add(newCol);
            foreach (DataRow row in table.Rows)
            {
                // DataColumn col = new DataColumn();
                row["dthoigian_"] = DateTime.Parse(row["dthoigian"].ToString()).ToString("dd-MM-yyyy")+" - Còn "+ row["conlai"].ToString()+" chỗ";
            }

            ddlNgayDi.DataSource = table;
            ddlNgayDi.DataValueField = "imathoigian";
            ddlNgayDi.DataTextField = "dthoigian_";
            ddlNgayDi.DataBind();
           
        }

        protected void ddlNgayDi_SelectedIndexChanged(object sender, EventArgs e)
        {
           // Debug.WriteLine("ID TOUR: " + ddlNgayDi.SelectedValue);
            layDonDatTour(ddlNgayDi.SelectedValue);
            divDonDatTour.Visible = true;
        }

        protected void ddlTourChuyen_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }

        protected void btnGopTour_Click(object sender, EventArgs e)
        {
            int soLuongVeCanChuyen = 0;
            int soLuongVeCon = 0;
            soLuongVeCon = Convert.ToInt32(datTourController.kiemTraChoConCuaMaThoiGian(ddlTourChuyen.SelectedValue));
             Debug.WriteLine("so luon ve con la: " + soLuongVeCon);
            List<string> dsMaDon = new List<string>();
            for (int i = 0; i < rptDondattour.Items.Count; i++)
            {
                CheckBox chk = (CheckBox)rptDondattour.Items[i].FindControl("ck_");
               // Debug.WriteLine("id: " + chk.Text + chk.Checked);
                if (chk.Checked)
                {
                   
                    HiddenField iMaTour = (HiddenField)rptDondattour.Items[i].FindControl("iddondattour");
                    dsMaDon.Add(iMaTour.Value);
                   // Debug.WriteLine("ids: " + chk.Text + "  " + iMaTour.Value);
                    // Rpt += (chk.Text + "<br />");
                }
            }

            //Debug.WriteLine("ds: " + dsMaDon[0]+"  "+ddlTourChuyen.SelectedValue);
            string script = "update tblDonDatTour set imathoigian = " + ddlTourChuyen.SelectedValue + " where ";
            string scriptSoChoCon = "select  SUM(soluongve) as tongSoVe from tblChiTietDonDatTour where ";
            for (int i = 0; i < dsMaDon.Count; i++)
            {
                if (i != (dsMaDon.Count - 1))
                {
                    script += "imadondattour = " + dsMaDon[i]+" or ";
                    scriptSoChoCon += "imadondattour = " + dsMaDon[i] + " or ";
                }
                else
                {
                    script += "imadondattour = " + dsMaDon[i];
                    scriptSoChoCon += "imadondattour = " + dsMaDon[i] ;
                }
            }
            //Debug.WriteLine("scripr: " + script);
            //Debug.WriteLine("scripr2: " + scriptSoChoCon);
            try
            {
                SqlCommand cmd = new SqlCommand(scriptSoChoCon, connector.connect());
                cmd.CommandType = CommandType.Text;
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                soLuongVeCanChuyen = Convert.ToInt32(table.Rows[0]["tongSoVe"].ToString());
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error " + ex.Message);
               
            }
            if(soLuongVeCanChuyen <= soLuongVeCon)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand(script, connector.connect());
                    cmd.CommandType = CommandType.Text;
                    int i = cmd.ExecuteNonQuery();
                    if (i > 0)
                    {
                        divThongTin.Visible = false;
                        //scriptMain = "";
                        string myScript = "\n<script type=\"text/javascript\" language=\"Javascript\" id=\"EventScriptBlock\">\n";
                        myScript += "toastr.success(\"Thao Tác Thành Công\",\"Thông Báo\");";
                        myScript += "\n\n </script>";
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", myScript, false);
                        script_.InnerHtml = myScript;
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("Error " + ex.Message);

                    // return null;
                }
            }
            else
            {
                lblnoti.Text = "<strong>Thông Báo!</strong> Ngày Cần Chuyển Chỉ Còn "+ soLuongVeCon +"Chỗ.";
                lblnoti.Visible = true;
            }
            
        }

        protected void rptDondattour_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
           
        }

        protected void id1_Click(object sender, EventArgs e)
        {
            layThoiGian(ddlTour.SelectedValue);
            divThongTin.Visible = true;
            divDonDatTour.Visible = false;
        }

        protected void id2_Click(object sender, EventArgs e)
        {
            layDonDatTour(ddlNgayDi.SelectedValue);
            divDonDatTour.Visible = true;
        }
    }
}