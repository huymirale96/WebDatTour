<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/FontEnd.Master" AutoEventWireup="true" CodeBehind="ThongTinKhachHang.aspx.cs" Inherits="WebDatTour.View.FontEnd.ThongTinKhachHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <form  method="post" runat="server">
        <div class="row mb30">
            <br />
            <h1 class="mt20" style="margin-left: 126px;">THÔNG TIN KHÁCH HÀNG</h1>
            <br />
            <div class="col-md-offset-1 col-md-5">
                <h3 runat="server" id="txtTen">TÊN KHÁCH HÀNG: Ngo Dang huy</h3>
                <h3 runat="server" id="txtSDT">SỐ ĐIỆN THOẠI: Ngo Dang huy</h3>
                <h3 runat="server" id="txtEMAIL">EMAIL: Ngo Dang huy  sdsadsa</h3>
            </div>
            <div class="col-md-5">
                <h3 runat="server" id="txtDN">TÊN ĐĂNG NHẬP: Ngo Dang huy</h3>
                <h3 runat="server" id="txtDC">ĐỊA CHỈ: Ngo Dang huy</h3>
                <h3 runat="server" id="txtNS">NGÀY SINH: Ngo Dang huy</h3>

            </div>
        </div>
        <br />
        <div class="row" style="margin-bottom: 100px;">
            <div class="col-md-offset-2 col-md-7">

                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card overflowhidden number-chart">
                        <div class="body" style="text-align: center;">
                            <button type="button" id="addInventory" class="btn btn-success" style="border-radius: 3px; background-color: brown; display: inline; margin-right: 30px;">Cập Nhật Thông Tin</button>                    <asp:Label ID="noti" runat="server" CssClass="text-info"></asp:Label>
                        </div>

                    </div>
                </div>
                </div>
            </div>
                <br />
                <div class="row clearfix" id="contentAddInventory" style="display: none;">
                   <div class="col-md-offset-1 col-md-11">
                            <br />
                            <div class="header">
                                <h2>THông Tin</h2>
                            </div>
                            <div class="body">

                                
                                        <div class="col-md-6 col-md-6">
                                            <div class="form-group">
                                                <label>Tên Khách Hàng</label>
                                                <asp:TextBox ID="txtTen_" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label>Số Điện Thoại</label>
                                                 <asp:TextBox ID="txtSDT_" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                 <asp:button ID="btnCapNhat" runat="server" Text="Cập Nhật" OnClick="btnCapNhat_Click"/>
                                                 <button id="cannelAddInventory" type="button" class="btn btn-danger">Hủy</button>
                                            </div>
                                            
                                        </div>
                                        <div class="col-md-6 col-md-6">
                                            <div class="form-group">
                                                <label>Email</label>
                                                 <asp:TextBox ID="txtEmail_" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label>Địa Chỉ</label>
                                                 <asp:TextBox ID="txtDC_" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label>Ngày Sinh</label>
                                                <asp:TextBox ID="txtNgaySinh_" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                            </div>
                                            
                                        </div>
                                    </div>
                                
                                   
                                
                                <br>

                               
   
 </div>
    </div>
       
       
     </form>
</asp:Content>
