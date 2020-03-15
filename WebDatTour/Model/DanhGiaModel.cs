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
using Microsoft.Ajax.Utilities;

namespace WebDatTour.Model
{
    public class DanhGiaModel
    {
        Connector cn = new Connector();
        public DataTable layDanhGia(int id)
        {

            try
            {
                SqlCommand cmd = new SqlCommand("laydanhgia", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
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
        
             public DataTable layDanhGia_DanhGIa(int id)
        {

            try
            {
                SqlCommand cmd = new SqlCommand("laydanhgia_danhGia", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
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
        public Boolean danhGia(Object.DanhGia danhGia)
        {
            Debug.WriteLine("ma toyrur "  );
            try
            {
                SqlCommand cmd = new SqlCommand("danhGia", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@iddontour", danhGia.MaDonDatTour);
                cmd.Parameters.AddWithValue("@isosao", danhGia.SoSao);
                cmd.Parameters.AddWithValue("@thoigian", danhGia.ThoiGian);
                cmd.Parameters.AddWithValue("@noidung", danhGia.NoiDung);

                //cnn.Open();
                int i = cmd.ExecuteNonQuery();
                //Debug.WriteLine("i dang nhap" + i);
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
                Debug.WriteLine("Error: " + ex.Message);
                return false;
            }
        }

        public Boolean capNhatTrangThaiDanhGia(string id)
        {
            // Debug.WriteLine("ma toyrur " + binhLuan.MaTour);
            try
            {
                SqlCommand cmd = new SqlCommand("capNhatTrangThaiDanhGia", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);


                //cnn.Open();
                int i = cmd.ExecuteNonQuery();
                //Debug.WriteLine("i dang nhap" + i);
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
                Debug.WriteLine("Error: " + ex.Message);
                return false;
            }
        }
        public Boolean kiemTraQuyenDanhGia(string id)
        {
            // Debug.WriteLine("ma toyrur " + binhLuan.MaTour);
            try
            {
                SqlCommand cmd = new SqlCommand("sp_kiemTraQuyenDanhGia", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);
                //Debug.WriteLine("i dang nhap" + i);
                if (dataTable.Rows.Count > 0)
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
                Debug.WriteLine("Error: " + ex.Message);
                return false;
            }
        }
        
        public Boolean kiemTraDanhGiaKH(string makh, string idDon)
        {
            // Debug.WriteLine("ma toyrur " + binhLuan.MaTour);
            try
            {
                SqlCommand cmd = new SqlCommand("select * from tbldondattour, tbldanhgia where tbldondattour.imadondattour = " + idDon + " and tbldanhgia.imadondattour = tbldondattour.imadondattour and tbldondattour.imakhachhang = " + makh, cn.connect());
                cmd.CommandType = CommandType.Text;
                //cmd.Parameters.AddWithValue("@idtour", idtour);
                //cmd.Parameters.AddWithValue("@makh", makh);
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable dataTable = new DataTable();
                dap.Fill(dataTable);

                //cnn.Open();

                if (dataTable.Rows.Count > 0)
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
                Debug.WriteLine("Error: " + ex.Message);
                return false;
            }
        }

        public Boolean kiemTraBinhLuanKH(string makh, string id)
        {
            // Debug.WriteLine("ma toyrur " + binhLuan.MaTour);
            try
            {
                SqlCommand cmd = new SqlCommand("select * from tblbinhluan where imakhachhang = " + makh + " and imabinhluan = " + id, cn.connect());
                cmd.CommandType = CommandType.Text;

                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable dataTable = new DataTable();
                dap.Fill(dataTable);

                //cnn.Open();

                if (dataTable.Rows.Count > 0)
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
                Debug.WriteLine("Error: " + ex.Message);
                return false;
            }
        }
        public Boolean kiemTraDonCoDanhGia(string id)
        {
            try
            {
                //  Debug.WriteLine("kachh hant : " + JsonConvert.SerializeObject(khach));
                using (SqlCommand cmd = new SqlCommand("select * from tbldanhGia where imadondattour = " + id, cn.connect()))
                {

                    cmd.CommandType = CommandType.Text;
                    //cmd.Parameters.AddWithValue("@idTour", id);
                    SqlDataAdapter dap = new SqlDataAdapter(cmd);
                    DataTable table = new DataTable();
                    dap.Fill(table);

                    if (table.Rows.Count > 0)
                    {


                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return false;
            }
        }
        public Boolean suaDanhGia(string id, string nd, string sosao)
        {
            // Debug.WriteLine("ma toyrur " + binhLuan.MaTour);
            try
            {
                SqlCommand cmd = new SqlCommand("suaDanhGia", cn.connect());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@nd", nd);
                cmd.Parameters.AddWithValue("@sosao", sosao);
                int i = cmd.ExecuteNonQuery();

                //cnn.Open();

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
                Debug.WriteLine("Error: " + ex.Message);
                return false;
            }
        }
    }
}