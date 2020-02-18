<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="DanhSachDonDatTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.DanhSachDonDatTour" %>
<asp:Content ID="conetnt" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <form method="POST" class="form-horizontal" runat="server" enctype="multipart/form-data">
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
                                            <th class="text-center">Thời Gian Đặt</th>
                                            <th class="text-center">Giá Trị Đơn</th>
                                            <th class="text-center">Đã Thanh Toán</th>
                                            <th class="text-center">Khách Hàng</th>
                                            <th class="text-center">Trạng Thái Tour</th>
                                            <th class="text-center">Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptDonDatTour" runat="server">
                                            <ItemTemplate>
                                                <tr>
										            <td class="text-center"><%# Container.ItemIndex+1 %></td>
										            <td class="left"><%# Eval("iMaDonDatTour") %></td>
                                                     <td class="left"><%# Eval("sTieuDe") %></td>
                                                    <td class="text-center"><%# Eval("dNgayDatTour", "{0:dd/MM/yyyy}") %></td>
                                                    <td class="text-center"><%# Eval("gia") %></td>
										            <td class="text-center"><%# Eval("tt") %></td>
                                                    <td class="left"><%# Eval("sTenKhachHang") %></td>   
										            <td class="text-center">
                                                        <%# Eval("iMaQuyen").ToString().Equals("2") ? "ADMIN" : "MEMBER" %>
										            </td>
											        <td class="text-center">
												        <asp:LinkButton ID="btnFix" CssClass="btn btn-xs btn-warning" ToolTip="Sửa" runat="server" CommandArgument='<%# Eval("iMaDonDatTour") %>'><i class="fa fa-pencil-square-o" aria-hidden="false"></i></asp:LinkButton>
                                                    
                                                        <asp:LinkButton ID="btnDelete" CssClass="btn btn-xs btn-danger" ToolTip="Xoá_" runat="server" OnClientClick="return confirm('Bạn có chắc chắn xoá ?')" CommandArgument='<%# Eval("iMaDonDatTour") %>'><i class="fa fa-times" aria-hidden="true"></i></asp:LinkButton>
											            
                                                        <asp:LinkButton ID="btnThanhToan" CssClass="btn btn-xs btn-info" ToolTip="Xoá" runat="server" OnClientClick="return confirm('Bạn có chắc chắn xoá ?')" CommandArgument='<%# Eval("iMaDonDatTour") %>'><i class="fa fa-credit-card" aria-hidden="true"></i></asp:LinkButton>
                                                    </td>

									            </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        
                                            
                                            
                                    </tbody>
                                </table>
                                <div class="text-center">
                                    
                                 </div>     
                            </div>
                        </div>
                    </div>
                </div>
            
                <!-- /.row -->

        </form>
</asp:Content>
