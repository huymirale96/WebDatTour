<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ThanhToan.aspx.cs" Inherits="WebDatTour.View.FontEnd.ThanhToan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>VNPAY DEMO</title>
       <link href="../../Content/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <div class="header clearfix">
                 
                <h3 class="text-muted">VNPAY DEMO</h3>
            </div>
            <div class="table-responsive">
                <form id="form1" runat="server">
                    <h3>Tạo yêu cầu thanh toán </h3>
   
                    <div class="form-group">
                        <label >Loại hàng hóa (*) </label>
                        <asp:DropDownList ID="orderCategory" runat="server" CssClass="form-control">
                            <asp:ListItem Value="topup" Text="Nạp tiền điện thoại"></asp:ListItem>
                            <asp:ListItem Value="billpayment" Text="Thanh toán hóa đơn"></asp:ListItem>
                            <asp:ListItem Value="fashion" Text="Thời trang"></asp:ListItem>
                            <asp:ListItem Value="other" Text="Thanh toán trực tuyến"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
        
                    <div class="form-group">
                        <label >Số tiền (*)</label>
                        <asp:TextBox ID="Amount" runat="server" CssClass="form-control"></asp:TextBox>
             
                    </div>
                    <div class="form-group">
                        <label >Nội dung thanh toán (*)</label>
                        <asp:TextBox ID="OrderDescription" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Ngân hàng</label>
                        <asp:DropDownList ID="bank" runat="server" CssClass="form-control">
                            <asp:ListItem Value="" Text="Không chọn"></asp:ListItem>
                            <asp:ListItem Value="NCB" Text="Ngan hang NCB"></asp:ListItem>
                            <asp:ListItem Value="SACOMBANK" Text="Ngan hang SacomBank"></asp:ListItem>
                            <asp:ListItem Value="EXIMBANK" Text="Ngan hang EximBank"></asp:ListItem>
                            <asp:ListItem Value="MSBANK" Text="Ngan hang MSBANK"></asp:ListItem>
                            <asp:ListItem Value="NAMABANK" Text="Ngan hang NamABank "></asp:ListItem>
                            <asp:ListItem Value="VISA" Text="The quoc te VISA/MASTER"></asp:ListItem>
                            <asp:ListItem Value="VNMART" Text="Vi dien tu VnMart"></asp:ListItem>
                            <asp:ListItem Value="VIETINBANK" Text="Ngan hang Vietinbank"></asp:ListItem>
                            <asp:ListItem Value="VIETCOMBANK" Text="Ngan hang VCB"></asp:ListItem>
                            <asp:ListItem Value="HDBANK" Text="Ngan hang HDBank"></asp:ListItem>
                            <asp:ListItem Value="DONGABANK" Text="Ngan hang Dong A"></asp:ListItem>
                            <asp:ListItem Value="TPBANK" Text="Ngân hàng TPBank"></asp:ListItem>
                            <asp:ListItem Value="OJB" Text="Ngân hàng OceanBank"></asp:ListItem>
                            <asp:ListItem Value="BIDV" Text="Ngân hàng BIDV"></asp:ListItem>
                            <asp:ListItem Value="TECHCOMBANK" Text="Ngân hàng Techcombank"></asp:ListItem>
                            <asp:ListItem Value="VPBANK" Text="Ngan hang VPBank"></asp:ListItem>
                            <asp:ListItem Value="AGRIBANK" Text="Ngan hang Agribank"></asp:ListItem>
                            <asp:ListItem Value="ACB" Text="Ngan hang ACB"></asp:ListItem>
                            <asp:ListItem Value="OCB" Text="Ngan hang Phuong Dong"></asp:ListItem>
                            <asp:ListItem Value="SCB" Text="Ngan hang SCB"></asp:ListItem>
                        </asp:DropDownList>
         
                    </div>
                    <div class="form-group">
                        <label >Ngôn ngữ  (*)</label>
                          <asp:DropDownList ID="language" CssClass="form-control" runat="server">
                              <asp:ListItem Value="vn" Text="Tiếng Việt"></asp:ListItem>
                                  <asp:ListItem Value="en" Text="English"></asp:ListItem>
                        </asp:DropDownList>
                         
                    </div>
                    <asp:Button ID="btnPay" runat="server" Text="Thanh toán" CssClass="btn btn-default" OnClick="btnPay_Click" />
                    &nbsp;&nbsp;
                    <button type="submit" class="btn btn-default" runat="server" id="btnPayPopup">Thanh toán (Popup)</button>
                </form>
            </div> </div>

          <script src="../../Content/js/jquery.min.js"></script>
        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script type="text/javascript" src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <script type="text/javascript">

            $("#btnPayPopup").click(function () {
                var postData = $("#form1").serialize();
                var submitUrl = "<%=ResolveUrl("../../View/BackEnd/GetUrl.aspx") %>";
                $.ajax({
                    type: "GET",
                    url: submitUrl,
                    data: postData,
                    dataType: 'JSON',
                    success: function (x) {
                        if (x.code === '00') {
                            if (window.vnpay) {
                                vnpay.open({ width: 480, height: 600, url: x.data });
                            } else {
                                location.href = x.data;
                            }
                            return false;
                        } else {
                            alert(x.Message);
                        }
                    }
                });
                return false;
            });

        </script>
    </body>
</html>