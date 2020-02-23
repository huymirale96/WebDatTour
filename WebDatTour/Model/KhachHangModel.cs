using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.SessionState;
using System.Diagnostics;
using Newtonsoft.Json;

namespace WebDatTour.Model
{
    public class KhachHangModel
    {
        Connector cn = new Connector();
        XuLy xuLy = new XuLy();
        public Boolean dangNhap(Object.KhachHang khach)
        {
            SqlCommand cmd = new SqlCommand("sp_login_kh", cn.connect());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@user", khach.TenDangNhap);
            cmd.Parameters.AddWithValue("@pw", xuLy.GetMD5(khach.MatKhau));
            //cnn.Open();
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dap.Fill(table);
            cn.disconnect();
            if (table.Rows.Count > 0)
            {
                string iMaKH = table.Rows[0]["iMaKhachHang"].ToString();
                string sTenKH = table.Rows[0]["sTenKhachHang"].ToString();
                //System.Diagnostics.Debug.WriteLine("id: "+x);
                HttpContext.Current.Session["maKH"] = iMaKH;
                HttpContext.Current.Session["tenKH"] = sTenKH;
               // Debug.WriteLine("ten: " + sTenKH + "    "+HttpContext.Current.Session["tenKH"]);
           
                return true;
            }
            else
            {
                return false;
            }
        }
        public String dangNhapKH(Object.KhachHang khach)
        {
            SqlCommand cmd = new SqlCommand("sp_login_kh", cn.connect());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@user", khach.TenDangNhap);
            cmd.Parameters.AddWithValue("@pw", xuLy.GetMD5(khach.MatKhau));
            //cnn.Open();
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dap.Fill(table);
            cn.disconnect();
           // Debug.WriteLine(khach.TenDangNhap + "ten -  so cot kh: " + table.Rows.Count);
            if (table.Rows.Count > 0)
            {
                string iMaKH = table.Rows[0]["iMaKhachHang"].ToString();
                string sTenKH = table.Rows[0]["sTenKhachHang"].ToString();
                //System.Diagnostics.Debug.WriteLine("id: "+x);
                HttpContext.Current.Session["maKH"] = iMaKH;
                HttpContext.Current.Session["tenKH"] = sTenKH;
                // Debug.WriteLine("ten: " + sTenKH + "    "+HttpContext.Current.Session["tenKH"]);

                return sTenKH;
            }
            else
            {
                return "";
            }
        }
        public Boolean kiemTraDangNhap(Object.KhachHang khach)
        {
         //   Debug.WriteLine("ktra dang nahp "+khach.MaKH+khach.MatKhau);
            SqlCommand cmd = new SqlCommand("sp_login_kh_id", cn.connect());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", khach.MaKH);
            cmd.Parameters.AddWithValue("@pw", xuLy.GetMD5(khach.MatKhau));
            //cnn.Open();
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dap.Fill(table);
            cn.disconnect();
            if (table.Rows.Count > 0)
            {
               

                return true;
            }
            else
            {
                return false;
            }
        }
        public Boolean dangKy(Object.KhachHang khachHang)
        {
            SqlCommand cmd = new SqlCommand("sp_dangki", cn.connect());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@tenkh", khachHang.TenKhachHang);
            cmd.Parameters.AddWithValue("@ns", khachHang.NgaySinh);
            cmd.Parameters.AddWithValue("@diachi", khachHang.DiaChi);
            cmd.Parameters.AddWithValue("@sdt", khachHang.SoDienThoai);
            cmd.Parameters.AddWithValue("@email", khachHang.Email);
            cmd.Parameters.AddWithValue("@user", khachHang.TenDangNhap);
            cmd.Parameters.AddWithValue("@pw", xuLy.GetMD5(khachHang.MatKhau));
            //cnn.Open();
            int i = cmd.ExecuteNonQuery();
            Debug.WriteLine("i dang nhap" + i);
            if(i > 0)
            {

                return true;
            }
            else
            {
                return false;
            }
        }

        
            public Boolean doiMatKhau(Object.KhachHang khach)
        {
            SqlCommand cmd = new SqlCommand("sp_doiMatKhauKH", cn.connect());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", khach.MaKH);
            cmd.Parameters.AddWithValue("@pw", xuLy.GetMD5(khach.MatKhau));
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

        public DataTable layDSKH()
        {
            try
            {
                string sqlStr = "select * from tblkhachhang";

                SqlCommand cmd = new SqlCommand(sqlStr, cn.connect());
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


        public DataTable timKhachHang(string tuKhoa)
        {
            try
            {
                string sqlStr = "select * from tblkhachhang where stenkhachhang like '%" + tuKhoa + "%' or semail like '%" + tuKhoa + "%'";

                SqlCommand cmd = new SqlCommand(sqlStr, cn.connect());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable ds = new DataTable();

                da.Fill(ds);
                cn.disconnect();
                return ds;
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.Message);
                return null;
            }
        }
        /* public DataTable xemKhachHangID(string id)
   {
       try
       {
           string sqlStr = "select * from tblkhachhang where imakhachhang = "+id;

           SqlCommand cmd = new SqlCommand(sqlStr, cn.connect());
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
   }*/


        public SqlDataReader xemKhachHangID(String id)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("select * from tblkhachhang where imakhachhang = " + id, cn.connect());
                cmd.CommandType = CommandType.Text;
                //cmd.Parameters.AddWithValue("@idTour", id);
                SqlDataReader rd = cmd.ExecuteReader();
                return rd;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return null;
            }
        }

        public DataTable xemKhachHangbyID(String id)
        {
          //  Debug.Write(id + "id1  khach hang : ");
            try
            {
                SqlCommand cmd = new SqlCommand("select * from tblkhachhang where imakhachhang = " + id, cn.connect());
                cmd.CommandType = CommandType.Text;
                //cmd.Parameters.AddWithValue("@idTour", id);
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
               // Debug.Write(id + "id  khach hang : " + table.Rows.Count);
                return table;

            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return null;
            }
        }

        public Boolean capNhapKhachHang(Object.KhachHang khach)
        {
            Debug.WriteLine("kachh hant : " + JsonConvert.SerializeObject(khach));
            using (SqlCommand cmd = new SqlCommand("capNhapKhachHang", cn.connect()))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", khach.MaKH);
                cmd.Parameters.AddWithValue("@ten", khach.TenKhachHang);
                cmd.Parameters.AddWithValue("@ngay", khach.NgaySinh);
                cmd.Parameters.AddWithValue("@dicchi", khach.DiaChi);
                cmd.Parameters.AddWithValue("@sdt", khach.SoDienThoai);
                cmd.Parameters.AddWithValue("@mail", khach.Email);
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
        }
        public Boolean kiemTraTen(string ten)
        {
            try
            {
                //  Debug.WriteLine("kachh hant : " + JsonConvert.SerializeObject(khach));
                using (SqlCommand cmd = new SqlCommand("select * from tblkhachhang where susername = '" + ten + "'", cn.connect()))
                {

                    cmd.CommandType = CommandType.Text;
                    //cmd.Parameters.AddWithValue("@idTour", id);
                    SqlDataAdapter dap = new SqlDataAdapter(cmd);
                    DataTable table = new DataTable();
                    dap.Fill(table);

                    if (table.Rows.Count > 0)
                    {


                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }
            }
            catch(Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return false;
            }
        }


    }
}