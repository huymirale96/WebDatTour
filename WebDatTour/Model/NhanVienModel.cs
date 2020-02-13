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
    public class NhanVienModel
    {
        Connector cn = new Connector();

        public DataSet layDanhSachNhanVienM()
        {
            try
            {
                string sqlStr = "select * from TBLNHANVIEN";

                SqlCommand cmd = new SqlCommand(sqlStr, cn.connect());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                da.Fill(ds);
                cn.disconnect();
                return ds;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        public void xoaNV(int ID)
        {
            try
            {
                string sqlStr = "DELETE TBLNHANVIEN WHERE ID = " + ID;

                SqlCommand cmd = new SqlCommand(sqlStr, cn.connect());
                cmd.ExecuteNonQuery();

                cn.disconnect();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public DataTable layDSNV()
            {
            SqlCommand cmd = new SqlCommand("sp_danhSachNhanVien",cn.connect());
        cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
        DataTable table = new DataTable();
        dap.Fill(table);
                return table;
            }
        public Boolean xoaNhanVien(String id)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("sp_xoaNhanVien", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                int i = cmd.ExecuteNonQuery();
                if(i  > 0)
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
                return false;
            }
        }
        public Boolean dangNhap(string user, string pw)
        {
            Debug.WriteLine("dang nhap nhan vien " + user+pw);
            try
            {
                SqlCommand cmd = new SqlCommand("sp_login_nv", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@user", user);
                cmd.Parameters.AddWithValue("@pw", pw);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                cn.disconnect();
                if (table.Rows.Count > 0)
                {
                    string iMaKH = table.Rows[0]["imanhanvien"].ToString();
                    string sTenKH = table.Rows[0]["sTenNhanVien"].ToString();
                    string quyen = table.Rows[0]["imaquyen"].ToString();
                    //System.Diagnostics.Debug.WriteLine("id: "+x);
                    HttpContext.Current.Session["maNV"] = iMaKH;
                    HttpContext.Current.Session["tenNV"] = sTenKH;
                    // Debug.WriteLine("ten: " + sTenKH + "    "+HttpContext.Current.Session["tenKH"]);

                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch(Exception ex)
            {
                Debug.WriteLine("Loi " + ex.Message);
                return false;
            }
        }
       

    }
}
