using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using WebDatTour.Model;
using WebDatTour.Object;

namespace WebDatTour.Controllers
{
    public class DanhGiaController
    {
        DanhGiaModel danhGiaModel = new DanhGiaModel();
        public DataTable layDanhGia(int id)
        {
            return danhGiaModel.layDanhGia(id);
        }
        
             public DataTable layDanhGia_DanhGIa(int id)
        {
            return danhGiaModel.layDanhGia_DanhGIa(id);
        }
        public Boolean danhGia(DanhGia danhGia)
        {
            return danhGiaModel.danhGia(danhGia);
        }
        
            public Boolean kiemTraDonCoDanhGia(string id)
        {
            return danhGiaModel.kiemTraDonCoDanhGia(id);
        }
        public Boolean capNhatTrangThaiDanhGia(string binhLuan)
        {
            return danhGiaModel.capNhatTrangThaiDanhGia(binhLuan);
        }
        public Boolean suaDanhGia(string id, string nd, string sosao)
        {
            return danhGiaModel.suaDanhGia(id, nd, sosao);
        }
        
        public Boolean kiemTraQuyenDanhGia(string id)
        {
            return danhGiaModel.kiemTraQuyenDanhGia(id);
        }
        
             public Boolean kiemTraDanhGiaKH(string makh, string idDond)
        {
            return danhGiaModel.kiemTraDanhGiaKH(makh, idDond);
        }
        /*   public Boolean kiemTraQuyenBinhLuan(string i1, string i2)  // kh  - tour
           {
               return danhGiaModel.kiemTraQuyenBinhLuan(i1, i2);
           }*/
    }
}