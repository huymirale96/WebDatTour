using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebDatTour.Model;
using System.Data.SqlClient;
using System.Data;
using WebDatTour.Object;

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
            return khachHangModel.doiMatKhau(khachHang);
        }
        public DataTable layDSKH()
        {
            return khachHangModel.layDSKH();
        }
        public SqlDataReader xemKhachHangID(String id)
        {
            return khachHangModel.xemKhachHangID(id);
        }
        
            public String dangNhapKH(KhachHang khachHang)
        {
            return khachHangModel.dangNhapKH(khachHang);
        }
        
             public Boolean capNhapKhachHang(Object.KhachHang khachHang)
        {
            return khachHangModel.capNhapKhachHang(khachHang);
        }
        
            public DataTable xemKhachHangbyID(string id)
        {
            return khachHangModel.xemKhachHangbyID(id);
        }

        
                 public DataTable timKhachHang(string tuKhoa)
        {
            return khachHangModel.timKhachHang(tuKhoa);
        }
        
            public Boolean kiemTraTen(string ten)
        {
            return khachHangModel.kiemTraTen(ten);
        }
    }
}