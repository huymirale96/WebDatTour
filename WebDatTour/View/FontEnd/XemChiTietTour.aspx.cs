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
using System.Diagnostics;
using WebDatTour.Object;
using System.Web.Services;
using Newtonsoft.Json;
using WebDatTour.Model;

namespace WebDatTour.View.FontEnd
{
    public partial class XemChiTietTour : System.Web.UI.Page
    {
        TourController tourController = new TourController();
        DanhGiaController danhGiaController = new DanhGiaController();
        //BinhLuanController binhLuanController = new BinhLuanController();
        ///BinhLuanModel binhLuanModel = new BinhLuanModel();
        protected void Page_Load(object sender, EventArgs e)
        {
           if(HttpContext.Current.Session["maKH"].ToString().Equals(""))
            {
                txtBinhLuan.Visible = false;
                binhLuan.Visible = false;

            }
            if (Request.QueryString["id"] != null)
            {
                System.Diagnostics.Debug.WriteLine("id khong null");
            
                    
                    layNgayDiTour(Convert.ToInt32(Request.QueryString["id"]));
                xemTour(Request.QueryString["id"]);
                laybinhluan(Convert.ToInt32(Request.QueryString["id"]));
                }
                else
                {
                    xemTour("18");
                  //  laybinhluan(18);

                }
            
        }
        public void laybinhluan(int id)
        {
            //Debug.WriteLine(JsonConvert.SerializeObject(binhLuanController.layBinhLuan(id)));
            rptBinhLuan.DataSource = danhGiaController.layDanhGia(id);
            rptBinhLuan.DataBind();
        }
        public string hienSao(string sosao)
        {
            string x = "";
            int soSao = Convert.ToInt32(sosao);
            for(int i = 0; i < soSao; i++)
            {
                x += "<i class='fa fa-star'  style='font - size:18px; color: #ffca08 ;'></i>";
            }
            for (int i = 0; i < 5 - soSao; i++)
            {
                x += "<i class='fa fa-star'  style='font - size:18px; '></i>";
            }
            return x;
        }
        public void layNgayDiTour(int id)
        {
            Debug.WriteLine("id tour cho ngay di: " + id);
            DataTable table = tourController.layNgayDiTour(id);
            string x = "<option value='none'>Thời Gian Khởi Hành</option>";
            for (int i = 0; i < table.Rows.Count; i++)
            {
                x += "<option value='" + table.Rows[i]["imathoigian"].ToString() + "'>" + DateTime.Parse(table.Rows[i]["dthoigian"].ToString()).ToString("dd-MM-yyyy") + "</option>";
            }

              x += "</select>";
            ngaydi.InnerHtml = "Chọn Ngày Khởi Hành: &nbsp<select id='mangaydi' name='mangaydi' class='form-control'>" + x;
            txtNgay.InnerHtml = "<select >" + x;
            // Debug.WriteLine(x);
        }

       public string test(string id)
        {
         
            return "";
        }
    
        public void xemTour(String id)
        {
            //System.Diagnostics.Debug.WriteLine("3");
            maTour_.Value = id;
            matourhidden.InnerHtml = "<input type='hidden' id='txtMaTour_' value = '"+ id + "'>";
            SqlDataReader rd = tourController.xemTour(id);
                if (rd.HasRows)
                {
                    while (rd.Read())
                    {

                    txtNKH.InnerHtml = rd["sNoiKhoiHanh"]+ "";
                    txtTG.InnerHtml = rd["stongthoigian"] + "";
                    txtTE.InnerHtml = "<strike style='color: red; display: inline;'>"+Convert.ToInt32(rd["igiate"].ToString()).ToString("#,##0") + "</strike>&nbsp&nbsp&nbsp<b style='color: green; display: inline;'>" + Convert.ToInt32(rd["igiategiam"].ToString()).ToString("#,##0") + "</b>VND";
                    txtNL.InnerHtml = "<strike style='color: red;display: inline;'>" + Convert.ToInt32(rd["igianl"].ToString()).ToString("#,##0") + "</strike>&nbsp&nbsp&nbsp<b style='color: green; display: inline;'>" + Convert.ToInt32(rd["igiategiam"].ToString()).ToString("#,##0") + "</b>VND";
                  
                    DataTable dataTable = tourController.layHinhAnh(id);
                    anhDD.InnerHtml = "<img src='../../Upload/" + dataTable.Rows[0]["sDuongDan"] + "' alt=' 'class='alignleft img-responsive'>";

                    dataTable.Rows[0].Delete();
                        rpt1.DataSource = dataTable;
                        rpt1.DataBind();
                        rpt2.DataSource = dataTable;
                        rpt2.DataBind();

                        txtNoiDung.Text = rd["sMoTa"].ToString();
                       // System.Diagnostics.Debug.WriteLine(rd["sMoTa"].ToString());
                        txtTieuDe.Text = rd["sTieuDe"].ToString();
                        int giaTE = Convert.ToInt32(rd["igiate"]);//.ToString();
                    int giaTEgiam = Convert.ToInt32(rd["igiategiam"]);
                    int giaNL = Convert.ToInt32(rd["igianl"]);
                    int giaNLgiam = Convert.ToInt32(rd["igianlgiam"]);
                    
                    
                    string htmlGia = "<input type='hidden' id='giaNL' value ='";
                    if (giaNLgiam == 0)
                    {
                        htmlGia += giaNL;
                    }
                    else
                    {
                        htmlGia += giaNLgiam;
                    }

                    if (giaTEgiam == 0)
                    {
                        htmlGia += "' /><input type='hidden' id ='giaTE' value = '" + giaTE;
                    }
                    else
                    {
                        htmlGia += "' /><input type='hidden' id ='giaTE' value = '" + giaTEgiam;
                    }
                    gia.InnerHtml = htmlGia + "' /> ";
                    hiddenIdTour.InnerHtml = "<input type='hidden' id='idTour' name='idTour' value='" + rd["iMaTour"].ToString() + "' />";
                  

                }
            }
        }

        protected void binhLuan_Click(object sender, EventArgs e)
        {
        }
           
        [WebMethod]
        public static string anDanhGia(string id)
        {
            Debug.WriteLine("id " + id );
            //return id+idtour;
           if (!HttpContext.Current.Session["maNV"].ToString().Equals(""))
            {
                 DanhGiaController danhGiaController_ = new DanhGiaController();
                if (danhGiaController_.capNhatTrangThaiDanhGia(id))
                {
                    return JsonConvert.SerializeObject(danhGiaController_.layDanhGia_DanhGIa(Convert.ToInt32(id)));
                }
                return null;
            }
            else
            {
                return null;
            }
        }
        
         [WebMethod]
        public static string kiemTraSoChoCon(string idtour, string idthoigian)
        {
            TourController tourController = new TourController();
           string i = tourController.kiemTraSoChoCon(idtour, idthoigian);
            //.Debug.WriteLine("idso " + i);
            if ( i!= null)
                {
                return i;
                }
            
            else
            {
                return null;
            }
        }
       
      public string ktrasuaDanhGia(string maDanhGia, string maDonDatTour, string soSao)
        {
            if (danhGiaController.kiemTraDanhGiaKH(Session["maKH"].ToString(), maDonDatTour))
            {
                return " <label  class='label label-info' onclick='suaDanhGia(" + maDanhGia + "," + soSao +  ")'>Chỉnh Sửa</label>";
            }
            else
            {
                return "";
            }
        }
        [WebMethod]
        public static string suaDanhGia(string id, string noiDung, string soSao)
        {
            Debug.Write(id + "  " + noiDung + "  " + soSao + "  ");
            DanhGiaController danhGiaController = new DanhGiaController();

            string makh = HttpContext.Current.Session["maKH"].ToString();
            if(danhGiaController.suaDanhGia(id, noiDung, soSao))
            {
                DataTable dataTable = danhGiaController.layDanhGia_DanhGIa(Convert.ToInt32(id));
                dataTable.Columns.Add("check", typeof(System.Int32));
                foreach (DataRow row in dataTable.Rows)
                {
                    //need to set value to NewColumn column
                    if (row["iMaKhachHang"].ToString().Equals(makh))
                    {
                        row["check"] = 1;   // or set it to some other value
                    }
                    else
                    {
                        row["check"] = 0;
                    }
                }
                return JsonConvert.SerializeObject(dataTable);
            }
            else
            {
                return null;
            }

        }
    }
}