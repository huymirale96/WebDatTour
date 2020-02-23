using System;
using System.Collections.Generic;
using System.Configuration;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using log4net;
//using VNPAY_CS_ASPX.Models;
using System.Diagnostics;
using WebDatTour.Model;
using WebDatTour.Object;
using WebDatTour.Controllers;

namespace WebDatTour.View.BackEnd
{
    public partial class vnpay_ipn : System.Web.UI.Page
    {
        //  private static readonly ILog log =
        //   LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        DonDatTourController donDatTourController = new DonDatTourController();
        protected void Page_Load(object sender, EventArgs e)
        {
            string returnContent = string.Empty;
            if (Request.QueryString.Count > 0)
            {
                string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; //Chuoi bi mat
                var vnpayData = Request.QueryString;
                VnPayLibrary vnpay = new VnPayLibrary();

                //if (vnpayData.Count > 0)
                //{
                foreach (string s in vnpayData)
                {
                    //get all querystring data
                    if (!string.IsNullOrEmpty(s) && s.StartsWith("vnp_"))
                    {
                        vnpay.AddResponseData(s, vnpayData[s]);
                    }
                }
                // }
                //Lay danh sach tham so tra ve tu VNPAY

                //vnp_TxnRef: Ma don hang merchant gui VNPAY tai command=pay    
                long orderId = Convert.ToInt64(vnpay.GetResponseData("vnp_TxnRef"));
                int orderID_ = Convert.ToInt32(vnpay.GetResponseData("vnp_TxnRef"));
                //vnp_TransactionNo: Ma GD tai he thong VNPAY
                long vnpayTranId = Convert.ToInt64(vnpay.GetResponseData("vnp_TransactionNo"));
                //vnp_ResponseCode:Response code from VNPAY: 00: Thanh cong, Khac 00: Xem tai lieu
                string vnp_ResponseCode = vnpay.GetResponseData("vnp_ResponseCode");
                //vnp_SecureHash: MD5 cua du lieu tra ve
                String vnp_SecureHash = Request.QueryString["vnp_SecureHash"];
                bool checkSignature = vnpay.ValidateSignature(vnp_SecureHash, vnp_HashSecret);
                if (checkSignature)
                {
                    //Cap nhat ket qua GD
                    //Yeu cau: Truy van vao CSDL cua  Merchant => lay ra duoc OrderInfo
                    //Giả sử OrderInfo lấy ra được như giả lập bên dưới
                    OrderInfo order = new OrderInfo();
                    order.OrderId = orderId;
                    order.vnp_TransactionNo = vnpayTranId;
                    order.Status = 0; //0: Cho thanh toan,1: da thanh toan,2: GD loi

                    //Kiem tra tinh trang Order
                    if (order != null)
                    {
                        if (order.Status == 0)
                        {
                            if (vnp_ResponseCode == "00")
                            {
                                //Thanh toan thanh cong
                                Debug.WriteLine("Thanh toan thanh cong, OrderId={0}, VNPAY TranId={1}", orderId, vnpayTranId);
                                //log.InfoFormat("Thanh toan thanh cong, OrderId={0}, VNPAY TranId={1}", orderId, vnpayTranId);
                                order.Status = 1;
                                donDatTourController.updateTrangThaiGiaoDich(vnpayTranId, orderID_, 1);
                                Response.Redirect("../fontend/toanthanhthanhtoan.aspx?id=1");
                            }
                            else
                            {
                                //Thanh toan khong thanh cong. Ma loi: vnp_ResponseCode
                                donDatTourController.updateTrangThaiGiaoDich(vnpayTranId, orderID_, 2);
                                //  displayMsg.InnerText = "Có lỗi xảy ra trong quá trình xử lý.Mã lỗi: " + vnp_ResponseCode;
                                Debug.WriteLine("Thanh toan loi, OrderId={0}, VNPAY TranId={1},ResponseCode={2}", orderId,
                                    vnpayTranId, vnp_ResponseCode);
                               // log.InfoFormat("Thanh toan loi, OrderId={0}, VNPAY TranId={1},ResponseCode={2}", orderId,
                                   // vnpayTranId, vnp_ResponseCode);
                                order.Status = 2;
                                Response.Redirect("../fontend/toanthanhthanhtoan.aspx?id=2");
                            }
                            returnContent = "{\"RspCode\":\"00\",\"Message\":\"Confirm Success\"}";
                            //Thêm code Thực hiện cập nhật vào Database 
                            //Update Database
                        }
                        else
                        {
                            returnContent = "{\"RspCode\":\"02\",\"Message\":\"Order already confirmed\"}";
                        }
                    }
                    else
                    {
                        returnContent = "{\"RspCode\":\"01\",\"Message\":\"Order not found\"}";
                    }
                }
                else
                {
                 //   log.InfoFormat("Invalid signature, InputData={0}", Request.RawUrl);
                    returnContent = "{\"RspCode\":\"97\",\"Message\":\"Invalid signature\"}";
                }
            }
            else
            {
                returnContent = "{\"RspCode\":\"99\",\"Message\":\"Input data required\"}";
            }

            Response.ClearContent();
            Response.Write(returnContent);
            Response.End();
        }
    }
}