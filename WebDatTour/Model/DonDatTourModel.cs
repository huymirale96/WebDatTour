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

namespace WebDatTour.Model
{
    public class DonDatTourModel
    {
        Connector cn = new Connector();
        public Boolean ThemDonDatTour(DonDatTour donDatTour)
        {

            try{
                SqlCommand cmd = new SqlCommand("taoDonHang", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idtour", donDatTour.MaTour);
                cmd.Parameters.AddWithValue("@ngay", donDatTour.NgayDat);
                cmd.Parameters.AddWithValue("@idkh", donDatTour.MaKH);
                cmd.Parameters.AddWithValue("@tien", donDatTour.TienDaThanhToan);
                cmd.Parameters.AddWithValue("@tt", donDatTour.TrangThai);
                cmd.Parameters.AddWithValue("@ghichu", donDatTour.GhiChu);

                cmd.Parameters.AddWithValue("@iMaDonDatTour", SqlDbType.Int).Direction = ParameterDirection.Output;
                //cnn.Open();
               int c =  cmd.ExecuteNonQuery();
               // Debug.WriteLine("cmd1 " + c);
                String maDonDatTour = cmd.Parameters["@iMaDonDatTour"].Value.ToString();
            //    Debug.WriteLine("id don dat tour: " + maDonDatTour);
                SqlCommand cmd2 = new SqlCommand("taoChiTietDonHang", cn.connect());
                cmd2.CommandType = CommandType.StoredProcedure;
                cmd2.Parameters.AddWithValue("@madon", maDonDatTour);
                cmd2.Parameters.AddWithValue("@nl", donDatTour.ChoNL);
                cmd2.Parameters.AddWithValue("@te", donDatTour.ChoTE);

                int k1 = cmd2.ExecuteNonQuery();


                //   int k = cmd3.ExecuteNonQuery();


                if (k1 > 0)
                {
                    //Response.Write("<script language=javascript>alert('OKK');</script>");
                    return true;
                }
                else
                {
                    //Response.Write("<script language=javascript>alert('Rrror');</script>");
                    return false;
                }


            }


            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("messeage: loi " + ex.Message);
                return false;
            }
        }
    }
}