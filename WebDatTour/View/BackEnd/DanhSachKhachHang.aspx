<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout/BackEnd.Master" CodeBehind="DanhSachKhachHang.aspx.cs" Inherits="WebDatTour.View.BackEnd.DanhSachKhachHang" %>
<asp:Content ID="conetnt" ContentPlaceHolderID="MainContent" runat="server">
    <br />
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Danh Sách Khách Hàng
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
                                            <th class="text-center">Họ Tên</th>
                                            <th class="text-center">Ngày Sinh</th>
                                            <th class="text-center">Địa Chỉ</th>
                                            <th class="text-center">Số Điện Thoại</th>
                                            <th class="text-center">Email</th>
                                           <th class="text-center">Tên Đăng Nhập</th>
                                            <th class="text-center">Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                                <asp:Repeater ID="rptdskh" runat="server">
                                                    <ItemTemplate>

                                                <tr>
                                                    <td class="text-center"><%# Container.ItemIndex+1 %></td>
                                                    <td class="left"><%# Eval("sTenKhachHang") %></td>
                                                    <td class="text-center"><%# Eval("dNgaySinh", "{0:dd/MM/yyyy}") %></td>
                                                    <td class="text-center"><%# Eval("sdiachi") %></td>
                                                    <td class="left"><%# Eval("sSDT") %></td>
                                                    <td class="text-center"><%# Eval("sEmail") %></td>
                                                    <td class="left"><%# Eval("susername") %></td>
                                                    
                                                    
                                                    <td class="left">
                                                        <a id="MainContent_rptLyLich_btnFix_0" title="Sửa lý lịch" class="btn btn-xs btn-warning" href="javascript:__doPostBack('ctl00$MainContent$rptLyLich$ctl00$btnFix','')"><i class="fa fa-pencil-square-o" aria-hidden="false"></i></a>
                                                        <a onclick="return confirm('Bạn có chắc chắn xoá lý lịch?');" id="MainContent_rptLyLich_btnDelete_0" title="Xoá lý lịch" class="btn btn-xs btn-danger" href="javascript:__doPostBack('ctl00$MainContent$rptLyLich$ctl00$btnDelete','')"><i class="fa fa-times" aria-hidden="true"></i></a>
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


</asp:Content>
