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
        public int ThemDonDatTour(DonDatTour donDatTour, int tien)
        {
            Debug.WriteLine("ma ngay di ___ " + donDatTour.MaNgaydi);
            try
            {
                SqlCommand cmd = new SqlCommand("taoDonHang", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idtour", donDatTour.MaTour);
                cmd.Parameters.AddWithValue("@ngay", donDatTour.NgayDat);
                cmd.Parameters.AddWithValue("@idkh", donDatTour.MaKH);
                cmd.Parameters.AddWithValue("@tien", donDatTour.TienDaThanhToan);
                cmd.Parameters.AddWithValue("@tt", donDatTour.TrangThai);
                cmd.Parameters.AddWithValue("@ghichu", donDatTour.GhiChu);
                cmd.Parameters.AddWithValue("@maThoiGian", donDatTour.MaNgaydi);
                
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

                SqlCommand cmd3= new SqlCommand("themGiaoDich", cn.connect());
                cmd3.CommandType = CommandType.StoredProcedure;
                cmd3.Parameters.AddWithValue("@iMaDonTOur", maDonDatTour);
                cmd3.Parameters.AddWithValue("@trangThai", 0);
                cmd3.Parameters.AddWithValue("@thoigian", donDatTour.NgayDat);
                cmd3.Parameters.AddWithValue("@tien", tien);
                cmd3.Parameters.AddWithValue("@iMaGiaoDich", SqlDbType.Int).Direction = ParameterDirection.Output;
                //   int k = cmd3.ExecuteNonQuery();
               int x3 =  cmd3.ExecuteNonQuery();
                Debug.WriteLine("cmd3 " + x3);
                int maGiaoDich = Convert.ToInt32(cmd3.Parameters["@iMaGiaoDich"].Value.ToString());
                 Debug.WriteLine("Ma Giao Dich " + maGiaoDich);
                return maGiaoDich;


            }


            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("messeage: loi xxx " + ex.Message);
                return 0 ;
            }
        }


        public int themGiaoDich(int id, int tien)
        {
            //Debug.WriteLine("ma ngay di ___ " + donDatTour.MaNgaydi);
            try
            {
                

                SqlCommand cmd3 = new SqlCommand("themGiaoDich", cn.connect());
                cmd3.CommandType = CommandType.StoredProcedure;
                cmd3.Parameters.AddWithValue("@iMaDonTOur", id);
                cmd3.Parameters.AddWithValue("@trangThai", 0);
                cmd3.Parameters.AddWithValue("@thoigian", DateTime.Now);
                cmd3.Parameters.AddWithValue("@tien", tien);
                cmd3.Parameters.AddWithValue("@iMaGiaoDich", SqlDbType.Int).Direction = ParameterDirection.Output;
                //   int k = cmd3.ExecuteNonQuery();
                int x3 = cmd3.ExecuteNonQuery();
               // Debug.WriteLine("cmd3 " + x3);
                int maGiaoDich = Convert.ToInt32(cmd3.Parameters["@iMaGiaoDich"].Value.ToString());
                Debug.WriteLine("Ma Giao Dich them :  " + maGiaoDich);
                return maGiaoDich;


            }


            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("messeage: loi xxx " + ex.Message);
                return 0;
            }
        }
        public Boolean updateTrangThaiGiaoDich(long idvnpay, int id, int tt)
        {
            Debug.WriteLine("vnpay " + idvnpay + "  id" +  id + "  tt" +tt );
            try
            {
                SqlCommand cmd = new SqlCommand("updateTrangThaiGiaoDich", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@trangthai", tt);
                cmd.Parameters.AddWithValue("@idvnpay", idvnpay);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                cn.disconnect();
                if (table.Rows.Count > 0)
                {

                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Loi " + ex.Message);
                return false;
            }
        }

        public DataTable donDatTour()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("donDatTour", cn.connect());
                cmd.CommandType = CommandType.Text;
                // cmd.Parameters.AddWithValue("@idTour", id);
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                    dap.Fill(table);
                return table;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return null;
            }
        }
        public DataTable donHanh_khachHang(string id)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("layDanhSachDonDatTourByIDkh", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                //cnn.Open();
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                dap.Fill(table);
                return table;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return null;

            }

        }
        
            public Boolean khachHangHuyTour(string id)
        {
          //  Debug.WriteLine("vnpay " + idvnpay + "  id" + id + "  tt" + tt);
            try
            {
                SqlCommand cmd = new SqlCommand("khachHangHuyTour", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);

                //cnn.Open();
                int  i = cmd.ExecuteNonQuery();
                cn.disconnect();
                if (i > 0)
                {

                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Loi " + ex.Message);
                return false;
            }
        }
        
               public Boolean capNhatTrangThaiTour(string id, int trangThai)
        {
            //  Debug.WriteLine("vnpay " + idvnpay + "  id" + id + "  tt" + tt);
            try
            {
                SqlCommand cmd = new SqlCommand("capNhatTrangThaiTour", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@tt", trangThai);

                //cnn.Open();
                int i = cmd.ExecuteNonQuery();
                cn.disconnect();
                if (i > 0)
                {

                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Loi " + ex.Message);
                return false;
            }
        }
    }
}