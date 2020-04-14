using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace WebDatTour
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Application.Lock();
            Session["login"] = false;
            Session["tenTK"] = "";
            Session["maKH"] = "";
            Session["tenKH"] = "";
            Session["maNV"] = "28";
            Session["tenNV"] = "Ngo Dang Huy";
            Session["quyen"] = "2";
            Session["type"] = "";
            Session["mess"] = "";
            Session["sessId"] = Session.SessionID;
           // Session.Timeout = 100;
            Application.UnLock();
        }
    }
}