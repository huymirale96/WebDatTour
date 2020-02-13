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
    public class Connector
    {
        String cnnString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
        SqlConnection cn = null;
        public Connector()
        {
            cn = new SqlConnection(cnnString);
        }
        public SqlConnection connect()
        {
            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                return cn;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        public SqlConnection disconnect()
        {
            try
            {
                if (cn.State == ConnectionState.Open)
                    cn.Close();
                return cn;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
    }
}