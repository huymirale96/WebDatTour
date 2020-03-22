using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace WebDatTour.Model
{
    
    public class NhomTourModel
    {
        Connector cn = new Connector();
        XuLy xuLy = new XuLy();
        public DataTable danhSachNT()
        {
            try
            {
                string sqlStr = "select * from tblnhomtour";

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
        public Boolean themNhomTour(String tenNhomTour)
        {
            try
            {
                string sqlStr = "insert into tblnhomtour(stennhomtour) values (N'" + tenNhomTour + "')";

                SqlCommand cmd = new SqlCommand(sqlStr, cn.connect());
              //  SqlDataAdapter da = new SqlDataAdapter(cmd);
                if(cmd.ExecuteNonQuery() > 0 )
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
       

    }
}