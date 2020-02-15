﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebDatTour.Model;
using System.Data;
using System.Data.SqlClient;

namespace WebDatTour.Controllers
{
    public class TourController
    {
        TourModel tourModel = new TourModel();
        public DataTable layDanhSachTour()
        {
            return tourModel.layDanhSachTour();
        }
        public SqlDataReader xemTour(String id)
        {
            return tourModel.xemTour(id);
        }
        public SqlDataReader xemTour2(String id)
        {
            return tourModel.xemTour(id);
        }
        
             public SqlDataReader layDanhSachDonDatTour(String id)
        {
            return tourModel.layDanhSachDonDatTour();
        }
        public Boolean themTour(Object.Tour tour, int giaNL, int giaNLgiam, int giaTE, int giaTEgiam)
        {
            return tourModel.themTour(tour, giaNL, giaNLgiam, giaTE, giaTEgiam);
        }
        public DataTable dsThoiGianKhoiHanh(int id)
        {
            return tourModel.dsThoiGianKhoiHanh(id);
        }
        public Boolean upDateTrangThaiThoiGian(int id)
        {
            return tourModel.upDateTrangThaiThoiGian(id);
        }
        public Boolean update(int id)
        {
            return tourModel.upDateTrangThaiThoiGian(id);
        }
        
            public DataTable layTour(int id)
        {
            return tourModel.layTour(id);
        }
        public DataTable layTourTheoNhom(int id)
        {
            return tourModel.layTourTheoNhom(id);
        }
    }
}