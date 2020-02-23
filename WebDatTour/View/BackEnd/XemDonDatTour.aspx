<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="XemDonDatTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.XemDonDatTour" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="row">
     <div class="col-md-12">
        <h1 class="page-header"> Chi Tiết Đơn Đặt Tour
                            <small>---</small>
        </h1>
    </div>
    <br />
    <ul style="list-style-type: none; color:blue;">
        <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server" id="txtMa">Mã Đơn Đặt Tour:</li>
         <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;"  id="txtNgayD" runat="server">Ngày Đặt:</li>
        <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server"  id="txtTen">Khách Hàng</li>
         <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server"  id="txtsdt">Số Điện Thoại:</li>
         <li runat="server"  style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" id="txtEmail">Email:</li>
         <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server"   id="txtNL">Số Chỗ Người Lớn:</li>
         <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server"   id="txtTE">Số Chỗ Trẻ Em:</li>
         <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server"   id="txttientt">Tổng Tiền Đã Thanh Toán:</li>
         <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server"   id="txtTien">Tổng Đơn Đặt Tour:</li>
         <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server"   id="txtTieuDe">Tour:</li>
         <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server"   id="txtNgaykhoiHnah">Ngày Khởi Hành:</li>
         <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server"   id="txtNoiKhoiHanh">Nơi Khởi Hành:</li>
         <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server"   id="txttgtong">Tổng Thời Gian: </li>
         <li style="font-size:25px; font-family: Arial, Helvetica, sans-serif;" runat="server"   id="txtGhiChu">Ghi chú</li>
       
    </ul>
</div>
     <br />
    <form method="POST" class="form-horizontal" runat="server" enctype="multipart/form-data">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Danh Sách Giao Dịch
                        </div>
                        <div class="panel-body">
                            
                            <div class="col-md-12">
                                <table class="table table-bordered table-stripped">
                                    <thead>
                                        <tr> 
                                            <th class="text-center">STT</th>
                                             <th class="text-center">Mã Đơn</th>
                                            <th class="text-center">Số Tiền Thanh Toán</th>
                                            <th class="text-center">Ngày Thanh Toán</th>
                              
                                            <th class="text-center">Người Thanh Toán</th>
                                            <th class="text-center">Mã Giao Dịch VNPAY</th>
                                           
                                            
                                            <th class="text-center">Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptGiaoDich" runat="server">
                                            <ItemTemplate>
                                                <tr>
										            <td class="text-center"><%# Container.ItemIndex+1 %></td>
                                                      <td class="text-center"><%# Eval("imadontour") %></td>
                                                     <td class="text-center"><%# toCurruncy(Convert.ToInt32(Eval("tien").ToString())) %>&nbspVND</td>
                                                    <td class="text-center"><%# Eval("thoigian", "{0:dd/MM/yyyy HH:mm}") %></td>
                                                     <td class="text-center"><%# Eval("stennhanvien") %></td>
                                                    <td class="text-center"><%# Eval("idgiaodichvnpay") %></td>
										            
										          
											        <td class="text-center">
												        <td>
                                                      
                                                        </td>
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
        <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Danh Sách Trạng Thái Đơn Đặt Tour
                        </div>
                        <div class="panel-body">
                            
                            <div class="col-md-12">
                                <table class="table table-bordered table-stripped">
                                    <thead>
                                        <tr> 
                                            <th class="text-center">STT</th>
                                             <th class="text-center">Mã Đơn</th>
                                            <th class="text-center">Trạng Thái</th>
                                            <th class="text-center">Thời Gian</th>
                              
                                            <th class="text-center">Ghi Chú</th>
                                            <th class="text-center">Người Thực Hiện</th>
                                           
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptTrangThai" runat="server">
                                            <ItemTemplate>
                                                <tr>
										            <td class="text-center"><%# Container.ItemIndex+1 %></td>
                                                      <td class="text-center"><%# Eval("imadon") %></td>
                                                     <td class="text-center"><%# trangThai(Eval("iTrangThai").ToString()) %></td>
                                                    <td class="text-center"><%# Eval("dthoigian", "{0:dd/MM/yyyy HH:mm}") %></td>
                                                     <td class="text-center"><%# Eval("sghiChu") %></td>
                                                    <td class="text-center"><%# Eval("stenNhanvien") %></td>
										            
										          
											      
									            </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        
                                            
                                            
                                    </tbody>
                                </table>
                                <div class="text-center">
                                   
                                     <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                    
                                 </div>     
                            </div>
                        </div>
                    </div>
                </div>

        </form>

</asp:Content>
