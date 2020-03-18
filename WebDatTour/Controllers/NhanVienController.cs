using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using WebDatTour.Object;
using System.Data.SqlClient;
using System.Data;
using WebDatTour.Model;

namespace WebDatTour.Controllers
{
    public class NhanVienController
    {
        string conn = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
        NhanVienModel nvModel = new NhanVienModel();
        XuLy xuLy = new XuLy();
        public void xoaNhanVienC(int ID)
        {
            nvModel.xoaNV(ID);
        }
        public Boolean ThemNhanVien(NhanVien nhanVien)
        {
            using (SqlConnection sqlConnection = new SqlConnection(conn))
            {
                sqlConnection.Open();
                SqlCommand cmd = new SqlCommand("themNhanVien1", sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@tendn", nhanVien.StenDangNhap);
                cmd.Parameters.AddWithValue("@tennv", nhanVien.TenNhanVien);
                cmd.Parameters.AddWithValue("@mk", xuLy.GetMD5(nhanVien.MatKhau));
                cmd.Parameters.AddWithValue("@gt", nhanVien.GioiTinh);
                cmd.Parameters.AddWithValue("@sdt", nhanVien.SoDienThoai);
                cmd.Parameters.AddWithValue("@ngaysinh", nhanVien.NgaySinh);
                cmd.Parameters.AddWithValue("@quyen", nhanVien.Quyen);
                cmd.Parameters.AddWithValue("@quequan", nhanVien.QueQuan);
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

        }
        public DataTable layDSNV()
        {
            return nvModel.layDSNV();
        }
        
               public DataTable thongKeTaiKhoan()
        {
            return nvModel.thongKeTaiKhoan();
        }

        public DataTable layThongTinNhanVienM(string id)
        {
            return nvModel.layThongTinNhanVienM(id);
        }
        public Boolean xoaNhanVien(String id)
        {
            return nvModel.xoaNhanVien(id);
        }
        public Boolean dangNhap(string tk, string mk)
        {
            return nvModel.dangNhap(tk, mk);
        }
        public Boolean kiemTraTen(string ten)
        {
            return nvModel.kiemTraTenDangNhap(ten);
        }

        public Boolean kiemTraDangNhap(NhanVien nhanVien)
        {
            return nvModel.kiemTraDangNhap(nhanVien);
        }

        public Boolean doiMatKhau(NhanVien nhanVien)
        {
            return nvModel.doiMatKhau(nhanVien);
        }
        
            public Boolean updateNhanVien(NhanVien nhanVien)
        {
            return nvModel.updateNhanVien(nhanVien);
        }
    }
}