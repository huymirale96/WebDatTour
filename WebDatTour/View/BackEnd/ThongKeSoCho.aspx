<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="ThongKeSoCho.aspx.cs" Inherits="WebDatTour.View.BackEnd.ThongKeSoCho" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <form method="POST" class="form-horizontal" runat="server" enctype="multipart/form-data">
    <div class="row">
     <div class="col-md-12">
        <h1 class="page-header">Danh Sách Tour - Số Chỗ
                            <small>---</small>
        </h1>
    </div>
    <br />
   
                <div class="col-md-12">
                    <
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Danh Sách 
                        </div>
                        <div class="panel-body">
                            <div class="text-center">
                                <span id="MainContent_lblNoti"></span>
                            </div>
                            <br />
                            <div class="col-md-4">
                        <asp:TextBox ID="txtTieuDe" runat="server" CssClass="form-control" Placeholder="Nhập tên tour muốn tìm."></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" id="reqName" controltovalidate="txtTieuDe" errormessage="****" />
                    </div>
                    <div class="col-md-4">
                        <asp:Button ID="timKiem" runat="server" Text="Tìm Kiếm" OnClick="timKiem_Click" CssClass="btn btn-default"></asp:Button>
                    </div>
                            <br />
                            <div class="col-md-12">
                                <table class="table table-bordered table-stripped">
                                    <thead>
                                        <tr> 
                                            <th class="text-center">STT</th>
                                             <th class="text-center">Tour</th>
                                            <th class="text-center">Ngày Đi</th>
                                            <th class="text-center">Tổng Số Chỗ</th>
                                            <th class="text-center">Chỗ Người Lớn Đã Đặt</th>
                                            <th class="text-center">Chỗ Trẻ Em Đã Đặt</th>
                                            <th class="text-center">Số Chỗ Còn Lại</th>                                         
                                            <th class="text-center">Trạng Thái</th>
                                            <th class="text-center">Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptTour" runat="server">
                                            <ItemTemplate>
                                                <tr>
										            <td class="text-center"><%# Container.ItemIndex+1 %></td>
                                                     <td class="text-center"><a href="../FontEnd/XemChiTietTour?id=<%# Eval("iMaTour") %>"><%# Eval("sTieuDe") %></a></td>									            
                                                    <td class="text-center"><%# Eval("dThoiGian", "{0:dd/MM/yyyy}") %></td>
                                                    <td class="text-center"><%# Eval("iSoCho") %></td>
                                                    <td class="text-center"><%# Eval("veNguoiLon") %></td>
										            <td class="text-center"><%# Eval("veTreEm") %></td>
										            <td class="text-center"><label class="label label-<%# (Convert.ToInt32(Eval("iSoCho")) -(Convert.ToInt32(Eval("veTreEm"))+Convert.ToInt32(Eval("veTreEm")))) <= 0 ? "warning" : "success" %>"><%# Convert.ToInt32(Eval("iSoCho")) -(Convert.ToInt32(Eval("veTreEm"))+Convert.ToInt32(Eval("veTreEm"))) %></label></td>
										            <td class="text-center">
                                                       
										            </td>
											        <td class="left">
												        <asp:LinkButton ID="btnFix" CssClass="btn btn-xs btn-warning" ToolTip="Sửa" runat="server"  CommandArgument=''><i class="fa fa-pencil-square-o" aria-hidden="false"></i></asp:LinkButton>
                                                        <asp:LinkButton ID="btnDelete" CssClass="btn btn-xs btn-danger" ToolTip="Xoá" runat="server"  OnClientClick="return confirm('Bạn có chắc chắn xoá ?')" CommandArgument=''><i class="fa fa-times" aria-hidden="true"></i></asp:LinkButton>
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

        </form>
        </div>
</asp:Content>
