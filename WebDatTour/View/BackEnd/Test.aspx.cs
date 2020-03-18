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
using System.Net.Mail;
using System.Web.UI.HtmlControls;
using Newtonsoft.Json;

namespace WebDatTour.View.BackEnd
{
    public partial class Test : System.Web.UI.Page
    {
        string x1 = "dasd";
        NhanVienController nhanVienController = new NhanVienController();
        protected void Page_Load(object sender, EventArgs e)
        {
            test2();
            /*
            //// Label lab11 = (Label)FindControl("lab1") as Label;
            // lab11.Text = "1111";
            Label Label1 = FindControlRecursive(Page, "lab1") as Label;
            Label1.Text = "huydasd";
            FileUpload file = FindControlRecursive(Page, "FileAnh_") as FileUpload;
            if(file != null)
            {
                Debug.WriteLine("name: " + file.FileName);
            }
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
            FileUpload tb = new FileUpload();
            tb.ID = "name" + 2;
            // HtmlControl anhh = (HtmlControl)Page.FindControl("anh");
             Control anhh = (Control)FindControl("anh");
            ///Control anhh = Page.FindControl("anh");  Control myDiv = (Control)FindControl("myDiv");
            //anhh.Controls.Add(tb);
            if (anh != null)
            {
               

            }*/



        }

        private Control FindControlRecursive(Control root, string id)
        {
            if (root.ID == id) return root;
            foreach (Control c in root.Controls)
            {
                Control t = FindControlRecursive(c, id);
                if (t != null) return t;
            }
            return null;
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
            DateTime x = DateTime.Parse("2020-03-20");
            Debug.WriteLine("okk1 " + x);
           // TourController tourController = new TourController();
            //tourController.upDateTrangThaiThoiGian(1);
            //Debug.WriteLine("okk2");
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

        protected void mail_Click(object sender, EventArgs e)
        {
            MailMessage mail= new MailMessage();
            mail.To.Add("huymin96@gmail.com");

            mail.From = new MailAddress("ngohuyhnn@gmail.com");
            mail.Subject = "Khat Vong Viet - Gmail Auto";
            
            string Body = "Noi dung Email";
            mail.Body = Body;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com"; //Or Your SMTP Server Address
            smtp.Port = 587;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential
            ("ngohuyhnn@gmail.com", "huydepzai");

            //Or your Smtp Email ID and Password
            smtp.EnableSsl = true;
            smtp.Send(mail);
            Debug.WriteLine("GUi MAIL XONG");
        }
        public void test2()
        {
            ThongKeDoanhThu thongKe = new ThongKeDoanhThu();
            thongKe.Data = nhanVienController.layDSNV();
            thongKe.DoanhThu = "123";
            thongKe.ThucThu = "123";
            thongKe.SoDon = "123";
            Debug.WriteLine("josn: " + JsonConvert.SerializeObject(thongKe));
        }
    }
}