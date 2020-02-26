using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using WebDatTour.Model;
using WebDatTour.Object;

namespace WebDatTour.Controllers
{
    public class BinhLuanController
    {
        BinhLuanModel binhLuanModel = new BinhLuanModel();
        public DataTable layBinhLuan(int id)
        {
            return binhLuanModel.layBinhLuan(id);
        }
        public Boolean binhLuan(BinhLuan binhLuan)
        {
            return binhLuanModel.binhLuan(binhLuan);
        }
        
             public Boolean capNhatTrangThaiBinhLuan(string binhLuan)
        {
            return binhLuanModel.capNhatTrangThaiBinhLuan(binhLuan);
        }
        
                public Boolean kiemTraQuyenBinhLuan(string i1, string i2)  // kh  - tour
        {
            return binhLuanModel.kiemTraQuyenBinhLuan(i1,i2);
        }
    }
}