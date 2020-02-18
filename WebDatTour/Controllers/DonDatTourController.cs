﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebDatTour.Model;
using WebDatTour.Object;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;

namespace WebDatTour.Controllers
{
   
    public class DonDatTourController
    {
        DonDatTourModel donDatTourModel = new DonDatTourModel();
        public int themDonDatTour(DonDatTour donDatTour, int tien)
        {
            return donDatTourModel.ThemDonDatTour(donDatTour, tien);
        }
        
             public Boolean updateTrangThaiGiaoDich(long idvnpay, int id, int tt)
        {
            return donDatTourModel.updateTrangThaiGiaoDich(idvnpay, id, tt);
        }
      public DataTable donDatTour()
        {
           return donDatTourModel.donDatTour();
        }
        
              public DataTable donHanh_khachHang(string id)
        {
            return donDatTourModel.donHanh_khachHang(id);
        }
        
              public Boolean khachHangHuyTour_(string id)
        {
            return donDatTourModel.khachHangHuyTour(id);
        }
        public Boolean khhuy(string id)
        {
            return donDatTourModel.khachHangHuyTour(id);
        }
        
            public int themGiaoDich(int id, int tien)
        {
            return donDatTourModel.themGiaoDich(id, tien);
        }
        public Boolean capNhatTrangThaiDatTour(string id, int tt, string nv)
        {
            return donDatTourModel.capNhatTrangThaiTour(id, tt,  nv);
        }
        public DataTable thongKeDoanhThu(string batdau, string ketthuc)
        {
            return donDatTourModel.thongKeDoanhThu(batdau,ketthuc);
        }
        
              public Boolean nhanVienthanhToan(string madon, string tien)
        {
            return donDatTourModel.nhanVienthanhToan(madon, tien);
        }

    }
}