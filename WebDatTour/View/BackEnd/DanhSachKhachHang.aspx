<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout/BackEnd.Master" CodeBehind="DanhSachKhachHang.aspx.cs" Inherits="WebDatTour.View.BackEnd.DanhSachKhachHang" %>
<asp:Content ID="conetnt" ContentPlaceHolderID="MainContent" runat="server">
    <br />
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Danh Sách Khách Hàng
                        </div>
                        <div class="panel-body">
                            <div class="text-center" >
                                <span id="MainContent_lblNoti"></span>
                            </div>
                       
                            <form method ="get" runat="server">
                                <div class="col-md-offset-1 col-md-4"><asp:TextBox ID="txtTuKhoa" runat="server" CssClass="form-control" Placeholder="Tim Kiem"></asp:TextBox></div>
                                <div class="col-md-2" style="margin-left:50px; margin-bottom:15px;"><asp:Button ID="btnTimKiem" runat="server" Text="Tìm Kiếm" CssClass="btn btn-default" onclick="btnTimKiem_Click"/></div>
                            
                            </form>
                            <br />
                            <div class="col-md-12">
                                <table class="table table-bordered table-stripped">
                                    <thead>
                                        <tr>
                                            <th class="text-center">STT</th>
                                            <th class="text-center">Họ Tên</th>
                                            <th class="text-center">Ngày Sinh</th>
                                            <th class="text-center">Địa Chỉ</th>
                                            <th class="text-center">Số Điện Thoại</th>
                                            <th class="text-center">Email</th>
                                           <th class="text-center">Tên Đăng Nhập</th>
                                              <th class="text-center"></th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                                <asp:Repeater ID="rptdskh" runat="server">
                                                    <ItemTemplate>

                                                <tr>
                                                    <td class="text-center"><%# Container.ItemIndex+1 %></td>
                                                    <td class="left"><a href="xemdondatcuakhachhang.aspx?id= <%# Eval("imakhachhang") %>"><%# Eval("sTenKhachHang") %></a></td>
                                                    <td class="text-center"><%# Eval("dNgaySinh", "{0:dd/MM/yyyy}") %></td>
                                                    <td class="text-center"><%# Eval("sdiachi") %></td>
                                                    <td class="left"><%# Eval("sSDT") %></td>
                                                    <td class="text-center"><%# Eval("sEmail") %></td>
                                                    <td class="left"><%# Eval("susername") %></td>
                                                    <td class="text-center"><a class="btn btn-outline-primary" href="TaoDonDatTour.aspx?id=<%# Eval("imakhachhang") %>">Tạo Đơn Đặt Tour</a></td>
                                                    
                                                    
                                                    
                                                </tr>
                                            
                                              
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            
                                    </tbody>
                                </table>
                                 <div class="text-center">
                                    
                                     <asp:Label ID="url" runat="server" Text="Label"></asp:Label>
                                 </div>  
                            </div>
                        </div>
                    </div>
                </div>
            
                <!-- /.row -->


</asp:Content>
