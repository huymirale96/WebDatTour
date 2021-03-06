﻿using System;
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
            cmd.Parameters.AddWithValue("@user", xuLy.locKiTu(khach.TenDangNhap));
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
            cmd.Parameters.AddWithValue("@tenkh", xuLy.locKiTu(khachHang.TenKhachHang));
            cmd.Parameters.AddWithValue("@ns", khachHang.NgaySinh);
            cmd.Parameters.AddWithValue("@diachi", xuLy.locKiTu(khachHang.DiaChi));
            cmd.Parameters.AddWithValue("@sdt", xuLy.locKiTu(khachHang.SoDienThoai));
            cmd.Parameters.AddWithValue("@email", xuLy.locKiTu(khachHang.Email));
            cmd.Parameters.AddWithValue("@user", xuLy.locKiTu(khachHang.TenDangNhap));
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
          //  Debug.WriteLine("doi mat khau idkh mk : " + khach.MatKhau);
            SqlCommand cmd = new SqlCommand("sp_doiMatKhauKH", cn.connect());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", khach.MaKH);
            cmd.Parameters.AddWithValue("@pw", xuLy.GetMD5(khach.MatKhau));
            //cnn.Open();
            int i = cmd.ExecuteNonQuery();
          ///  Debug.WriteLine("doi mat khau i : " + i);
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

        public string layTenKhachHang(string id)
        {
            try
            {
                string sqlStr = "select stenkhachhang from tblkhachhang where iMaKhachHang = "+id;

                SqlCommand cmd = new SqlCommand(sqlStr, cn.connect());
                cmd.CommandType = CommandType.Text;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable ds = new DataTable();

                da.Fill(ds);
                return ds.Rows[0]["stenkhachhang"].ToString();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        public Boolean capNhapHoSoKhachHang(string id, List<string> ds_)
        {
            try
            {
                string script = "insert into tblTepThongTinKhachHang (imakhachhang, sduongdan) values ";
                for (int ii = 0; ii < ds_.Count; ii++)
                {
                    if (ii != (ds_.Count - 1))
                    {
                        script += "(" + id + ",'" + ds_[ii]+"'),";
                    }
                    else
                    {
                        script += "(" + id + ",'" + ds_[ii] + "')";
                    }
                }
                Debug.WriteLine("script: " + script);
               // string sqlStr = "select stenkhachhang from tblkhachhang where iMaKhachHang = " + id;

               SqlCommand cmd = new SqlCommand(script, cn.connect());
                cmd.CommandType = CommandType.Text;
                int i = cmd.ExecuteNonQuery();
                if(i > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }

               
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
                cmd.Parameters.AddWithValue("@ten", xuLy.locKiTu(khach.TenKhachHang));
                cmd.Parameters.AddWithValue("@ngay", khach.NgaySinh);
                cmd.Parameters.AddWithValue("@dicchi", xuLy.locKiTu(khach.DiaChi));
                cmd.Parameters.AddWithValue("@sdt", xuLy.locKiTu(khach.SoDienThoai));
                cmd.Parameters.AddWithValue("@mail", xuLy.locKiTu(khach.Email));
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