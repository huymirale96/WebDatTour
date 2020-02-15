using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebDatTour.Model;
using System.Data.SqlClient;
using System.Data;

namespace WebDatTour.Controllers
{
    public class KhachHangController
    {
        KhachHangModel khachHangModel = new KhachHangModel();
        public Boolean dangKy(Object.KhachHang khachHang)
        {
            return khachHangModel.dangKy(khachHang);
        }
        public Boolean dangNhap(Object.KhachHang khachHang)
        {
            return khachHangModel.dangNhap(khachHang);
        }
        public Boolean kiemTraDangNhap(Object.KhachHang khachHang)
        {
            return khachHangModel.kiemTraDangNhap(khachHang);
        }
        

          public Boolean doiMatKhau(Object.KhachHang khachHang)
        {
            return khachHangModel.dangNhap(khachHang);
        }
        public DataTable layDSKH()
        {
            return khachHangModel.layDSKH();
        }
        public SqlDataReader xemKhachHangID(String id)
        {
            return khachHangModel.xemKhachHangID(id);
        }


    }
}