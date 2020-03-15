<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="XemDonDatTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.XemDonDatTour" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="row">
     <div class="col-md-12">
        <h1 class="page-header"> Chi Tiết Đơn Đặt Tour
                            <small>---</small>
        </h1>
    </div>
    <br />
    
    <div class="col-md-12" style="padding: 37px;">
    <table class="table table-hover" >
        <thead>
            
        </thead>
        <tbody>
            <asp:Repeater ID="Repeater2" runat="server">
                                            <ItemTemplate>
            <tr>
            <th class="text-left">Mã Đơn Đặt Tour:</th>
                <th class="text-left"><%# Eval("imadontour") %></th>
                <th class="text-left">Ngày Đặt:</th>
                <th class="text-left"><%# Eval("dngaydattour", "{0:dd/MM/yyyy HH:mm}") %></th>
            </tr>
             <tr>
            <th class="text-left">Khách Hàng</th>
                <th class="text-left"><%# Eval("sTenKhachHang") %></th>
                <th class="text-left">Số Điện Thoại:</th>
                <th class="text-left"><%# Eval("sSDT") %></th>
            </tr>
 <tr>
            <th class="text-left">Email:</th>
                <th class="text-left"><%# Eval("sEmail") %></th>
                 <th class="text-left">Ngày Khởi Hành:</th>
                <th class="text-left"><%# Eval("dthoigian", "{0:dd/MM/yyyy HH:mm}") %></th>
            </tr>
 <tr>
     <th class="text-left">Số Chỗ Người Lớn:</th>
                <th class="text-left"><%# Eval("veNL") %></th>
            <th class="text-left">Số Chỗ Trẻ Em:</th>
                <th class="text-left"><%# Eval("veTE") %></th>
                
            </tr>
 <tr>
            <th class="text-left">Tổng Đơn Đặt Tour:</th>
                <th class="text-left"><%# toCurruncy(Convert.ToInt32(Eval("doanhthu")))  %></th>
     <th class="text-left">Tổng Tiền Đã Thanh Toán:</th>
                <th class="text-left"><%# toCurruncy(Convert.ToInt32(Eval("thucthu"))) %></th>
               
            </tr>
 <tr>
            <th class="text-left">Nơi Khởi Hành:</th>
                <th class="text-left"><%# Eval("snoikhoihanh") %></th>
                <th class="text-left">Tổng Thời Gian:</th>
                <th class="text-left"><%# Eval("stongthoigian") %></th>
            </tr>
 <tr>
       </ItemTemplate>
                                        </asp:Repeater>
           
        </tbody>

    </table>
        </div>
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
                                   
                                     <asp:Label ID="url" runat="server" Text=""></asp:Label>
                                    
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
                                   
                                     <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                    
                                 </div>     
                            </div>
                        </div>
                    </div>
                </div>

        </form>

</asp:Content>
