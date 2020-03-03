using System;
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
         public DataTable layNgayDiTour(int id)
        {
            return tourModel.layNgayDiTour(id);
        }
        
            public Boolean themThoiGianKhoiHanh(int id, DateTime date, DateTime hanDat)
        {
            return tourModel.themThoiGianKhoiHanh(id, date,hanDat);
        }
        
            public Boolean capNhatTrangThaiTour(string id)
        {
            return tourModel.capNhatTrangThaiTour(id);
        }

        public DataTable thongKeTour_soCho()
        {
            return tourModel.thongKeTour_soCho();
        }
        
                 public DataTable timKiemTour(string ten)
        {
            return tourModel.timKiemTour(ten);
        }
        public string kiemTraSoChoCon(string idtour, string tdtg)
        {
            return tourModel.kiemTraSoChoCon(idtour, tdtg);
        }
        public DataTable timSoCHo_Tour(string tour)
        {
            return tourModel.timSoCHo_Tour(tour);
        }
        
            public DataTable xemDonDatTour(string tour)
        {
            return tourModel.xemDonDatTour(tour);
        }
        
                public DataTable toutMoiNhat()
        {
            return tourModel.toutMoiNhat();
        }
        
              public DataTable tourhotTuan()
        {
            return tourModel.tourhotTuan();
        }
        
            public DataTable tourhotThang()
        {
            return tourModel.tourhotThang();
        }
    }
}