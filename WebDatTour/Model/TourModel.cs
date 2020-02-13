using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;

namespace WebDatTour.Model
{
    public class TourModel
    {
        Connector cn = new Connector();
        public DataTable layDanhSachTour()
        {
            System.Diagnostics.Debug.WriteLine("lay danh sahc tiuru");
            //String cnnString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
           // using (SqlConnection cnn = new SqlConnection(ck))
            {
                SqlCommand cmd = new SqlCommand("sp_dstour1", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
               // rptTour.DataSource = table;
               // rptTour.DataBind();
            }
        }
        
            public DataTable layTour(int id)
        {
         //   System.Diagnostics.Debug.WriteLine("lay danh sahc tiuru");
            //String cnnString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            // using (SqlConnection cnn = new SqlConnection(ck))
            {
                SqlCommand cmd = new SqlCommand("sp_dsnhomtourbyid", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
                // rptTour.DataSource = table;
                // rptTour.DataBind();
            }
        }
        
             public DataTable layTourTheoNhom(int id)
        {
            //   System.Diagnostics.Debug.WriteLine("lay danh sahc tiuru");
            //String cnnString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            // using (SqlConnection cnn = new SqlConnection(ck))
            {
                SqlCommand cmd = new SqlCommand("sp_tourTheoNhom", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
                // rptTour.DataSource = table;
                // rptTour.DataBind();
            }
        }
        public SqlDataReader xemTour(String id)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("sp_xemTourId", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idTour", id);
                SqlDataReader rd = cmd.ExecuteReader();
                return rd;
            }
            catch(Exception ex)
            {
                return null;
            }
        }
        public Boolean themTour(Object.Tour tour, int giaNL, int giaNLgiam, int giaTE, int GiaTEgiam)
        {
            Debug.WriteLine("them tour: ");
            try
            {
                SqlCommand cmd = new SqlCommand("sp_themtour", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@tieude", tour.TieuDe);
                cmd.Parameters.AddWithValue("@mota", tour.MoTa);
                cmd.Parameters.AddWithValue("@urlanh", tour.UrlAnh);
                cmd.Parameters.AddWithValue("@thoigian", tour.TongThoiGian);
                cmd.Parameters.AddWithValue("@ngaykhoihanh", tour.NgayKhoiHanh);
                cmd.Parameters.AddWithValue("@nhomtour", tour.MaNhomTour);
                cmd.Parameters.AddWithValue("@manv", tour.MaNV);
                cmd.Parameters.AddWithValue("@socho", tour.SoCho);
                cmd.Parameters.AddWithValue("@ngaytao", tour.NgayTao);
                cmd.Parameters.AddWithValue("@imatour", SqlDbType.Int).Direction = ParameterDirection.Output;
                //cnn.Open();
                cmd.ExecuteNonQuery();
                String idMaTour = cmd.Parameters["@imatour"].Value.ToString(); Debug.WriteLine("id tour: "+ idMaTour);
                SqlCommand cmd2 = new SqlCommand("sp_themGiave", cn.connect());
                cmd2.CommandType = CommandType.StoredProcedure;
                cmd2.Parameters.AddWithValue("@matour", idMaTour);
                cmd2.Parameters.AddWithValue("@gianl", giaNL);
                cmd2.Parameters.AddWithValue("@giagiamnl", giaNLgiam);
                cmd2.Parameters.AddWithValue("@giate", giaTE);
                cmd2.Parameters.AddWithValue("@giagiamte", GiaTEgiam);
                int k1 = cmd2.ExecuteNonQuery();

                for (int i = 0; i < tour.DsNgayKhoiHanh.Count(); i++)
                {
                    try
                    {
                        SqlCommand cmd3 = new SqlCommand("sp_themThoiGianKhoiHanh", cn.connect());
                        cmd3.CommandType = CommandType.StoredProcedure;
                        cmd3.Parameters.AddWithValue("@imatour", idMaTour);
                        cmd3.Parameters.AddWithValue("@ngay", tour.DsNgayKhoiHanh[i]);
                        cmd3.ExecuteNonQuery();
                    }
                    catch(Exception ex)
                    {
                        Debug.WriteLine("Error "+ex.Message);
                    }
                }
             //   int k = cmd3.ExecuteNonQuery();


                if (k1 > 0)
                {
                    //Response.Write("<script language=javascript>alert('OKK');</script>");
                   return true;
                }
                else
                {
                    //Response.Write("<script language=javascript>alert('Rrror');</script>");
                    return false;
                }


            }
            catch(Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("messeage: loi " + ex.Message);
                return false;
            }
        }
        public DataTable dsThoiGianKhoiHanh(int id)
        {
            SqlCommand cmd = new SqlCommand("sp_dsThoiGianKhoiHanh", cn.connect());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", id);
            //cnn.Open();
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dap.Fill(table);
            return table;
        }
        public Boolean upDateTrangThaiThoiGian(int id)
        {
            Debug.WriteLine("id: " + id);
              SqlCommand cmd = new SqlCommand("sp_trangThaiThoiGianKH", cn.connect());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", id);
           
            //cnn.Open();
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                
                Debug.WriteLine("id: ok");
                return true;

            }
            else
            {
                return false;
            }

        }
    }
}