<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout/BackEnd.Master" CodeBehind="DanhSachTour.aspx.cs" Inherits="WebDatTour.View.FontEnd.DanhSachTour" %>
<asp:Content ID="content" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <form method="POST" class="form-horizontal" runat="server" enctype="multipart/form-data">
        <asp:HiddenField ID="page_" runat="server" Value="1"/>
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Danh sách Tour
                        </div>
                        <div class="panel-body">
                            <div class="text-center">
                                <span id="MainContent_lblNoti"></span>
                                <div class="col-md-offset-1 col-md-4"><asp:TextBox ID="txtTuKhoa" Text="." runat="server" CssClass="form-control" Placeholder="Tim Kiem"></asp:TextBox></div>
                                <asp:RequiredFieldValidator ID="reqyiretxt" runat="server" ControlToValidate="txtTuKhoa" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                <div class="col-md-2" style="margin-left:50px; margin-bottom:15px;"><asp:Button ID="btnTimKiem" runat="server" Text="Tìm Kiếm" CssClass="btn btn-default" onclick="btnTimKiem_Click"/></div>
                                <asp:Label ID="notification" runat="server" CssClass="text-info"></asp:Label>
                            </div>
                            <br />
                            <div class="col-md-12">
                                <table class="table table-bordered table-stripped">
                                    <thead>
                                        <tr>
                                            <th class="text-center">STT</th>
                                            <th class="text-center">Tiêu Đề</th>
                                            <th class="text-center">Ảnh Bìa</th>
                                            <th class="text-center">Tổng Thời Gian</th>
                                            <th class="text-center">Nơi Khởi Hành</th>
                                            <th class="text-center">Số Chỗ</th>
                                            
                                            <th class="text-center">Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <asp:Repeater ID="rptDanhSachTour" runat="server">
                                            <ItemTemplate>
                                                <tr>
										            <td class="text-center"><%# Container.ItemIndex+1 %></td>
										            <td class="left"><%# Eval("sTieuDe") %></td>
                                                    <td class="text-center"><img style="width: 200px;" src="../../Upload/<%#  Eval("sDuongDan")  %>" ></td>
                                                    <td class="left"><%# Eval("sTongThoiGian") %></td>
										            <td class="text-center"><%# Eval("snoikhoihanh") %></td>
										            <td class="text-center"><%# Eval("iSoCho") %></td>
                                                  
											        <td class="text-center">
                                                   <asp:LinkButton ID="btnTrangThai" CssClass="btn btn-xs btn-default" ToolTip="TrangThai" onClick="btnTrangThai_Click" runat="server" CommandArgument='<%# Eval("iMaTour") %>'><%# Eval("btrangthai").ToString().Equals("True") ? "Hiện" : "Ẩn"  %></asp:LinkButton>
												        <asp:LinkButton ID="btnFix" CssClass="btn btn-xs btn-info" ToolTip="Sửa" Visible="false" onClick="btnFix_Click" runat="server" CommandArgument='<%# Eval("iMaTour") %>'><i class="fa fa-pencil-square-o" aria-hidden="false"></i></asp:LinkButton>
                                                      <a Class="btn btn-xs btn-info" href="SuaTour.aspx?id=<%# Eval("iMaTour") %>"><i class="fa fa-pencil-square-o" aria-hidden="false"></i></a>
											        </td>
									            </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                            
                                    </tbody>
                                </table>
                                <div class="text-center" style="display: none">
                                    <asp:HyperLink ID="lnkPre" runat="server" CssClass="pre_next">Trang trước</asp:HyperLink>
                                    <asp:HyperLink ID="lnkStart" runat="server" CssClass="index">1</asp:HyperLink>
                                    <asp:Label ID="Labelnv" runat="server" Text="Label"></asp:Label>
                                   
                                    <asp:HyperLink ID="lnkEnd" runat="server" CssClass="index">11</asp:HyperLink>
                                    <asp:HyperLink ID="lnkNext" runat="server" CssClass="pre_next">Trang sau</asp:HyperLink>
                                     
                                 </div>  
                                <div class="text-center">
                                     <asp:Label ID="url" runat="server" Text="Label"></asp:Label>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
            
                <!-- /.row -->
        </form>

</asp:Content>
<asp:Content ID="conetnt2" runat="server" ContentPlaceHolderID="script">
    <div runat="server" id="script"></div>
</asp:Content>
