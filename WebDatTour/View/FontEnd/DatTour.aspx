<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DatTour.aspx.cs" Inherits="WebDatTour.View.FontEnd.DatTour" MasterPageFile="~/Layout/FontEnd.Master"%>
<asp:Content ID="content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="contendt">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="post-block">
                        <div class="row ">
                            <!-- post block -->
                            <div class="col-md-4">
                                <div class="post-img">
                                    <a href="#" id="linkAnh" runat="server"></a>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="post-content--">
                                   
                                    <form runat="server" method="post">
                                    <h2><a href="#" class="title" target="_blank" id="tieuDe" runat="server"></a></h2>
                                        
                                        <asp:HiddenField ID="iTE" runat="server"></asp:HiddenField>
                                        <asp:HiddenField ID="iNL" runat="server"></asp:HiddenField>
                                         <asp:HiddenField ID="tour" runat="server"></asp:HiddenField>
                                         <asp:HiddenField ID="tien_" runat="server" />
                                        <asp:HiddenField ID="tien_tt" runat="server" />
                                         <asp:HiddenField ID="maTG" runat="server" />
                                    <p id="txtTen" runat="server">Khach Hang: NGO DANG HUY</p>
                                    <p  id="txtSDT" runat="server">SDT: 0902656555</p>
                                    <p  id="txtEmail" runat="server">Email: huydx@xxx.com</p>
                                    <p  id="txtNL" runat="server">So cho Nguoi lon la: 2 cho x 10.000.000 vnd</p>
                                    <p  id="txtTE" runat="server">So cho tre em la: 2 cho x 10.000.000 vnd</p>
                                    <p  id="txtTong" runat="server">Tong cong la: 10.000.000 vnd</p>
                                        <h4 id="tienDC"></h4>

                                        <div class="col-md-6">
                                            <label ">Chọn Số Tiền: &nbsp </label>
                                             <div class="form-group">
                                        <asp:DropDownList ID="phanTramDat" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="none" Text="Không chọn"></asp:ListItem>
                                            <asp:ListItem value="0.1" Text="Đặt 10%" ></asp:ListItem>
                                            <asp:ListItem value="0.5" Text="Đặt 50%" ></asp:ListItem>
                                            <asp:ListItem value="1" Text="Trả 100%" ></asp:ListItem>
                                        </asp:DropDownList>
                                         <asp:CompareValidator ID="CompareValidator12" runat="server" ControlToValidate="phanTramDat" ErrorMessage="Tiền Thanh Toán Không Được Trống." Operator="NotEqual" ValueToCompare="none"  ForeColor="Red" SetFocusOnError="true" />

                                        </div>
                                        </div>
                                        <div class="col-md-6">
                        <div class="form-group">
                        <label onclick="copyATM()">Ngân hàng</label>
                        <asp:DropDownList ID="bank" runat="server" CssClass="form-control">
                            <asp:ListItem Value="none" Text="Không chọn"></asp:ListItem>
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
                            <asp:CompareValidator
    ID="val14" runat="server" ControlToValidate="bank"
    ErrorMessage="Ngân Hàng Thanh Toán Không Được Trống." Operator="NotEqual"
    ValueToCompare="none"
    ForeColor="Red" SetFocusOnError="true" />

                      
                                    </div>    
                                        </div>
                                        
                                  
                                    
                                  
                    </div>
                                        <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine" Rows="2" Placeholder="Ghi Chú" CssClass="form-control">
                                            
                                        </asp:TextBox>
                                  
                                    <asp:Button ID="btnDatVe" runat="server" Text="Đặt Vé" CssClass="btn btn-default" OnClick="btnDatVe_Click"/>
                               
                                </div>
                            </div>
                        </div>
                        </form>
                        <!-- /.post block -->
                    </div>
                </div>
                </div>
            </div>
</asp:Content>
