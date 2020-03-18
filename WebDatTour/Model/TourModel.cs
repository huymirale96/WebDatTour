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
            //System.Diagnostics.Debug.WriteLine("lay danh sahc tiuru");
            //String cnnString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            // using (SqlConnection cnn = new SqlConnection(ck))
            {
                SqlCommand cmd = new SqlCommand("sp_layDanhSachTOur", cn.connect());
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
        


            public DataTable timKiemTour_tieuDe(string tieuDe)
        {
        try
            {
                SqlCommand cmd = new SqlCommand("sp_timKiemTour_ds", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ten", tieuDe);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
              
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error " + ex.Message);
                
                return null;
            }
        }
        public DataTable layTourTheoNhom(int id)
        {

            {
                SqlCommand cmd = new SqlCommand("sp_tourTheoNhom", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
            }
        }
        public DataTable timKiemTour(string ten)
        {
            
            {
                SqlCommand cmd = new SqlCommand("sp_timKiemTour", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ten", ten);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
           
            }
        }

        public String layTenNhomTour(string id)
        {

            {
                SqlCommand cmd = new SqlCommand("layTenNhomTour", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table.Rows[0]["stennhomtour"].ToString();

            }
        }
        public Boolean kiemTraNgayKhoiHanh(string idtour, string ngay)
        {
           try
            { 
                Debug.WriteLine(idtour + "    "  + ngay );
                SqlCommand cmd = new SqlCommand("kiemTraNgayKhoiHanh", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ngay", ngay);
                cmd.Parameters.AddWithValue("@id", idtour);

                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                if(table.Rows.Count > 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }

            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return false;
            }
        }
        

        public DataTable timKiemTourTheoNgay(string ngaybd, string ngaykt)
        {
            
            {
                SqlCommand cmd = new SqlCommand("sp_timKiemTourTheoNgay", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@batdau", ngaybd);
                cmd.Parameters.AddWithValue("@ketthuc", ngaykt);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
              
            }
        }
        public SqlDataReader layDanhSachDonDatTour()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("layDanhSachDonDatTour", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                // cmd.Parameters.AddWithValue("@idTour", id);
                SqlDataReader rd = cmd.ExecuteReader();
                return rd;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public SqlDataReader xemTour(String id)
        {
            Debug.WriteLine("Xem tourr");
            try
            {
                SqlCommand cmd = new SqlCommand("sp_xemTourId", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idTour", id);
                SqlDataReader rd = cmd.ExecuteReader();
                /// cn.disconnect();
                return rd;

            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return null;
            }
        }
        public DataTable xemTour3(String id)
        {
            Debug.WriteLine("Xem tourr");
            try
            {
                SqlCommand cmd = new SqlCommand("sp_xemTourId", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idTour", id);
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;

            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
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
                cmd.Parameters.AddWithValue("@noikhoihanh", tour.NoiKhoiHanh);
                cmd.Parameters.AddWithValue("@thoigian", tour.TongThoiGian);
                //  cmd.Parameters.AddWithValue("@ngaykhoihanh", tour.NgayKhoiHanh);
                cmd.Parameters.AddWithValue("@nhomtour", tour.MaNhomTour);
                cmd.Parameters.AddWithValue("@manv", tour.MaNV);
                cmd.Parameters.AddWithValue("@socho", tour.SoCho);
                cmd.Parameters.AddWithValue("@ngaytao", tour.NgayTao);
                cmd.Parameters.AddWithValue("@imatour", SqlDbType.Int).Direction = ParameterDirection.Output;
                //cnn.Open();
                cmd.ExecuteNonQuery();
                String idMaTour = cmd.Parameters["@imatour"].Value.ToString(); Debug.WriteLine("id tour: " + idMaTour);
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
                    catch (Exception ex)
                    {
                        Debug.WriteLine("Error " + ex.Message);
                    }
                }
                string query = "insert into tblhinhanh(iMaTour,sDuongDan) values (";
                for (int i = 0; i < tour.DsAnh.Count(); i++)
                {
                    if((i+1) == tour.DsAnh.Count())
                    {
                        query += idMaTour + ",'" + tour.DsAnh[i] + "')";
                    }
                    else
                    {
                        query +=  idMaTour + ",'" + tour.DsAnh[i] + "'),(";
                    }
                   
                }
                Debug.WriteLine("Query : "+query);
                    try
                    {
                        SqlCommand cmdAnh = new SqlCommand(query, cn.connect());
                        cmdAnh.CommandType = CommandType.Text;
                        cmdAnh.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("Error " + ex.Message);
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
            catch (Exception ex)
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


                return true;

            }
            else
            {
                return false;
            }

        }

        public DataTable layNgayDiTour(int id)
        {
            Debug.WriteLine("lay ngay di tour");
            try
            {
                string sqlStr = "select * from tblThoiGianKhoiHanh where trangThai = 1 and dthoigian > getdate() and imatour = " + id + " order by dthoigian ASC ";

                SqlCommand cmd2 = new SqlCommand(sqlStr, cn.connect());
                SqlDataAdapter da = new SqlDataAdapter(cmd2);
                //SqlDataReader rd2 = cmd2.ExecuteReader();
                DataTable dataTable = new DataTable();
                da.Fill(dataTable);
                cn.disconnect();
                return dataTable;



            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.Message);
                return null;
            }
        }

        public string kiemTraSoChoCon(string idtour, string idtg)
        {
            Debug.WriteLine("lay ngay di tour");
            try
            {
                //string sqlStr = "select * from tblThoiGianKhoiHanh where imatour = " + id + " order by dthoigian ASC ";

                SqlCommand cmd2 = new SqlCommand("sp_layChoChoCon", cn.connect());
                cmd2.CommandType = CommandType.StoredProcedure;
                cmd2.Parameters.AddWithValue("@idtour", idtour);
                cmd2.Parameters.AddWithValue("@idtg", idtg);
                SqlDataAdapter da = new SqlDataAdapter(cmd2);
                //SqlDataReader rd2 = cmd2.ExecuteReader();
                DataTable dataTable = new DataTable();
                da.Fill(dataTable);
                cn.disconnect();
                // Debug.Write("return : " + dataTable.Rows[0]["sochocon"].ToString());
                return dataTable.Rows[0]["sochocon"].ToString();



            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.Message);
                return null;
            }
        }
        public Boolean themThoiGianKhoiHanh(int id, string date)
        {


            Debug.WriteLine("id: " + id);
            SqlCommand cmd = new SqlCommand("themThoiGianKhoiHanh", cn.connect());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@imatour", id);
            cmd.Parameters.AddWithValue("@thoigian", date);
           

            int i = cmd.ExecuteNonQuery();
            if(i > 0)
            //cnn.Open();timKiemTour            if (i > 0)
            {


                return true;

            }
            else
            {
                return false;
            }

        }
        public Boolean updatehinhanh(string id, string duongDan)
        {


           // Debug.WriteLine("id: " + id);
            SqlCommand cmd = new SqlCommand("updatehinhanh", cn.connect());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@duongDan", duongDan);
           

            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            //cnn.Open();timKiemTour            if (i > 0)
            {


                return true;

            }
            else
            {
                return false;
            }

        }


        public Boolean capNhatTrangThaiTour(string id)
        {


            //   Debug.WriteLine("id: " + id);
            SqlCommand cmd = new SqlCommand("sp_trangThaiTour", cn.connect());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", id);
            // cmd.Parameters.AddWithValue("@thoigian", date);

            //cnn.Open();
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {


                return true;

            }
            else
            {
                return false;
            }

        }
        public DataTable thongKeTour_soCho()
        {
            // Debug.WriteLine("lay ngay di tour");
            try
            {
                // string sqlStr = "select * from tblThoiGianKhoiHanh where imatour = " + id + " order by dthoigian ASC ";

                SqlCommand cmd2 = new SqlCommand("sp_soCho_Tour", cn.connect());
                SqlDataAdapter da = new SqlDataAdapter(cmd2);
                //SqlDataReader rd2 = cmd2.ExecuteReader();
                DataTable dataTable = new DataTable();
                da.Fill(dataTable);
                cn.disconnect();
                return dataTable;



            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.Message);
                return null;
            }
        }

        public DataTable timSoCHo_Tour(string tour)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("sp_timsoCho_Tour", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@tour", tour);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return null;

            }
        }

        public DataTable xemDonDatTour(string tour)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("xemDonDatTour", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", tour);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return null;

            }

        }

        public DataTable toutMoiNhat()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("toutMoiNhat", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                // cmd.Parameters.AddWithValue("@id", tour);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return null;

            }

        }
        
             public DataTable layHinhAnh(string id)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("sp_layHinhAnhCuaTour", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return null;

            }

        }
        public DataTable tourMoiNhat_()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("toutMoiNhat", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                // cmd.Parameters.AddWithValue("@id", tour);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return null;

            }

        }
        public DataTable layTourLienQuan(string tour)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("sp_layTourLienQuan", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", tour);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return null;

            }

        }
        
        public DataTable tourhotTuan()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("tourhotTuan", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                // cmd.Parameters.AddWithValue("@id", tour);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return null;

            }

        }

        public DataTable tourhotThang()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("tourhotThang", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                // cmd.Parameters.AddWithValue("@id", tour);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return null;

            }

        }


    }

}