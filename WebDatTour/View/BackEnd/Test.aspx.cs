using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.Services;
using WebDatTour.Controllers;
using System.Diagnostics;
using WebDatTour.Object;

namespace WebDatTour.View.BackEnd
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String x = "00b0e98455c00a36507707ea638b2d7e.jpg/4d06fda30454472551758157b65dc6dd.jpg";
            string[] tokens = x.Split('/');
            //Label2.Text = "< button type = 'button' class='btn btn-primary'>Primary</button>"  ;//;;tokens[0] + tokens.Length.ToString();
            // Label2.Text = tokens[0];
            int dec = 4912323;
            string uk = dec.ToString("#,##0");//ToString("C", new System.Globalization.CultureInfo("vi-VN"));
                                              //Label2.Text = ToAlphaNumericOnly("a  Z./,+=$#**bc=+-123?/");
            DateTime now = DateTime.Now;
           //now.ToString()+"huy";  DateTime.Now.ToString("MM/dd/yyyy H:mm")   DateTime.Now.ToString()
            OrderInfo order = new OrderInfo();
            order.Amount = 8;
            Label2.Text = DateTime.Now.ToString("dd/MM/yyyy H:mm");



        }
        [WebMethod]
        public static String up(String x)
        {
            return x;
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFile file = Request.Files[i];
                if (file.ContentLength > 0)
                {
                    string fname = Path.GetFileName(file.FileName);
                    file.SaveAs(Server.MapPath(Path.Combine("~/Upload/", fname)));

                }
            }
            Label1.Text = Request.Files.Count + " Images Has Been Saved Successfully";
        }
        String hi()
        {
            return "< button type = 'button' class='btn btn-primary'>Primary</button>";
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Debug.WriteLine("okk1");
            TourController tourController = new TourController();
            tourController.upDateTrangThaiThoiGian(1);
            Debug.WriteLine("okk2");
        }
        public string ToAlphaNumericOnly(string str)

        {

            string[] chars = new string[] { ",", ".", "/", "!", "@", "#", "$", "%", "^", "&", "*", "'", "\"", ";", "_", "|", "[", "]", "?", "=", "+", "-" };
            //Iterate the number of times based on the String array length.
            for (int i = 0; i < chars.Length; i++)
            {
                if (str.Contains(chars[i]))
                {
                    str = str.Replace(chars[i], "");
                }
            }
            return str;
        }
    }
}