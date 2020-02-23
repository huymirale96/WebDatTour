<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeFile="XemDonDatCuaKhachHang.aspx.cs" Inherits="WebDatTour.View.BackEnd.XemDonDatCuaKhachHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">\
     <div class="row">
     <div class="col-md-12">
        <h1 class="page-header">Danh Sách Đơn Đặt Tour
                            <small>---</small>
        </h1>
    </div>
    <br />
   
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Danh Sách Đơn Đặt Tour
                        </div>
                        <div class="panel-body">
                            <div class="text-center">
                                <span id="MainContent_lblNoti"></span>
                            </div>
                            <div class="col-md-12">
                                <table class="table table-bordered table-stripped">
                                    <thead>
                                        <tr> 
                                            <th class="text-center">STT</th>
                                             <th class="text-center">Mã Đơn</th>
                                            <th class="text-center">Tour</th>
                                            <th class="text-center">Ngày Đặt</th>
                                            <th class="text-center">Khách Hàng</th>
                                            <th class="text-center">Tổng Tiền</th>
                                            <th class="text-center">Đã Thanh Toán</th>
                                            
                                            <th class="text-center">Trạng Thái</th>
                                            <th class="text-center">Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptdondattour" runat="server">
                                            <ItemTemplate>
                                                <tr>
										            <td class="text-center"><%# Container.ItemIndex+1 %></td>
                                                     <td class="text-center"><a href="xemdondattour.aspx?id=<%# Eval("iMaDonDatTour") %>"><%# Eval("iMaDonDatTour") %></a></td>
										            <td class="text-center"><%# Eval("stieude") %></td>
                                                    <td class="text-center"><%# Eval("dngaydattour", "{0:dd/MM/yyyy}") %></td>
                                                    <td class="text-center"><%# Eval("sTenKhachHang") %></td>
										            <td class="text-center"><%# toCurruncy_(Convert.ToInt32(Eval("doanhthu").ToString())) %>&nbspVND</td>
										            <td class="text-center"><%# toCurruncy_(Convert.ToInt32(Eval("thucthu"))) %>&nbspVND</td>
                                                    
										            <td class="text-center">
                                                        <%# trangThai(Eval("itrangthai").ToString()) %>
										            </td>
											        <td class="text-center">
                                                       
											        </td>
									            </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        
                                            
                                            
                                    </tbody>
                                </table>
                                <div class="text-center">
                                   
                                     <asp:Label ID="url" runat="server" Text="Label"></asp:Label>
                                     <asp:Label ID="lblnoti" runat="server" Text=""></asp:Label>
                                 </div>     
                            </div>
                        </div>
                    </div>
                </div>
           
              
    

       
        </div>
</asp:Content>
