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
using Microsoft.Ajax.Utilities;

namespace WebDatTour.Model
{
    public class BinhLuanModel
    {
        Connector cn = new Connector();
        public DataTable layBinhLuan(int id)
        {
           
            try
            {
                SqlCommand cmd = new SqlCommand("layBinhLuan", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable ds = new DataTable();
                da.Fill(ds);
                cn.disconnect();
                return ds;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public Boolean binhLuan(Object.BinhLuan binhLuan)
        {
            Debug.WriteLine("ma toyrur "+binhLuan.MaTour);
            try
            {
                SqlCommand cmd = new SqlCommand("binhLuan", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idtour", binhLuan.MaTour);
                cmd.Parameters.AddWithValue("@idkhachhang", binhLuan.MaKH);
                cmd.Parameters.AddWithValue("@thoigian", binhLuan.ThoiGian);
                cmd.Parameters.AddWithValue("@noidung", binhLuan.NoiDung);

                //cnn.Open();
                int i = cmd.ExecuteNonQuery();
                //Debug.WriteLine("i dang nhap" + i);
                if (i > 0)
                {

                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch(Exception ex)
            {
                Debug.WriteLine("Error: "+ ex.Message);
                return false;
            }
        }
        
             public Boolean capNhatTrangThaiBinhLuan(string id)
        {
           // Debug.WriteLine("ma toyrur " + binhLuan.MaTour);
            try
            {
                SqlCommand cmd = new SqlCommand("capNhatTrangThaiBinhLuan", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id",id);
            

                //cnn.Open();
                int i = cmd.ExecuteNonQuery();
                //Debug.WriteLine("i dang nhap" + i);
                if (i > 0)
                {

                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error: " + ex.Message);
                return false;
            }
        }
    }
}