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
using WebDatTour.Object;
using Newtonsoft.Json;

namespace WebDatTour.Model
{
    public class NhanVienModel
    {
        Connector cn = new Connector();
        XuLy xuLy = new XuLy();
        public DataTable layThongTinNhanVienM(string id)
        {
            try
            {
                string sqlStr = "select * from TBLNHANVIEN where imanhanvien = " +id;

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
                cmd.Parameters.AddWithValue("@pw", xuLy.GetMD5(pw));
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
                    HttpContext.Current.Session["quyen"] = quyen;
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
        
            public Boolean updateNhanVien(NhanVien nhanVien)
        {
            //Debug.WriteLine("dang nhap nhan vien " + JsonConvert.SerializeObject(nhanVien));
            try
            {
                SqlCommand cmd = new SqlCommand("updateNhanVien", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id",  HttpContext.Current.Session["maNV"].ToString());
                cmd.Parameters.AddWithValue("@dc", nhanVien.QueQuan);
                cmd.Parameters.AddWithValue("@ns",  nhanVien.NgaySinh);
                cmd.Parameters.AddWithValue("@dt",nhanVien.SoDienThoai);
                cmd.Parameters.AddWithValue("@ten", nhanVien.TenNhanVien);
                cmd.Parameters.AddWithValue("@gt", nhanVien.GioiTinh);
                //cnn.Open();
                int i = cmd.ExecuteNonQuery();
                cn.disconnect();
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
                Debug.WriteLine("Loi " + ex.Message);
                return false;
            }
        }

        public Boolean kiemTraDangNhap(NhanVien nhanVien)
        {
           // Debug.WriteLine("kiem tra nhan vien " + nhanVien.MatKhau );
            try
            {
                SqlCommand cmd = new SqlCommand("select * from tblnhanvien where imanhanvien = "+nhanVien.MaNV + " and spassword = "+ xuLy.GetMD5(nhanVien.MatKhau), cn.connect());
                cmd.CommandType = CommandType.Text;
                //cmd.Parameters.AddWithValue("@user", user);
               // cmd.Parameters.AddWithValue("@pw", pw);
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
            catch (Exception ex)
            {
                Debug.WriteLine("Loi " + ex.Message);
                return false;
            }
        }
        
              public Boolean kiemTraTenDangNhap(string tenDangNhap)
        {
            // Debug.WriteLine("kiem tra nhan vien " + nhanVien.MatKhau );
            try
            {
                SqlCommand cmd = new SqlCommand("kiemTraTenDangNhap", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ten", tenDangNhap);
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                cn.disconnect();
                if (table.Rows.Count > 0)
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
                Debug.WriteLine("Loi " + ex.Message);
                return false;
            }
        }

        public Boolean doiMatKhau(NhanVien nhanVien)
        {
            Debug.WriteLine("dang nhap nhan vien ");
            try
            {
                SqlCommand cmd = new SqlCommand("update tblnhanvien set spassword = " + xuLy.GetMD5(nhanVien.MatKhau) +" where imanhanvien = " + nhanVien.MaNV , cn.connect());
                cmd.CommandType = CommandType.Text;
                //cmd.Parameters.AddWithValue("@user", user);
                // cmd.Parameters.AddWithValue("@pw", pw);
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
            catch (Exception ex)
            {
                Debug.WriteLine("Loi " + ex.Message);
                return false;
            }
        }
        
             public DataTable thongKeTaiKhoan()
        {
            try
            {
              

                SqlCommand cmd = new SqlCommand("sp_ThongKeTaiKhoan", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
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

    }
}
