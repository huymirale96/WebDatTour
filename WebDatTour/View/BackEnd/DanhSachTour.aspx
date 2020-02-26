<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout/BackEnd.Master" CodeBehind="DanhSachTour.aspx.cs" Inherits="WebDatTour.View.FontEnd.DanhSachTour" %>
<asp:Content ID="content" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <form method="POST" class="form-horizontal" runat="server" enctype="multipart/form-data">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Danh sách Tour
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
                                            <th class="text-center">Tiêu Đề</th>
                                            <th class="text-center">Ảnh Bìa</th>
                                            <th class="text-center">Tổng Thời Gian</th>
                                            <th class="text-center">Ngày Khởi Hành</th>
                                            <th class="text-center">Số Chỗ</th>
                                            <th class="text-center">Giá Vé Người Lớn</th>
                                            <th class="text-center">Giá Vé Trẻ Em</th>
                                            <th class="text-center">Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <asp:Repeater ID="rptDanhSachTour" runat="server">
                                            <ItemTemplate>
                                                <tr>
										            <td class="text-center"><%# Container.ItemIndex+1 %></td>
										            <td class="left"><%# Eval("sTieuDe") %></td>
                                                    <td class="text-center"><img style="width: 200px;" src="../../Upload/<%# urlAnhh( Eval("sUrlAnh").ToString() ) %>" ></td>
                                                    <td class="left"><%# Eval("sTongThoiGian") %></td>
										            <td class="text-center"><%# Eval("dNgayKhoiHanh", "{0:dd/MM/yyyy}") %></td>
										            <td class="text-center"><%# Eval("iSoCho") %></td>
                                                       
                                                   <td class="text-center">
                                                       gia 2
										            </td>
										            <td class="text-center">
                                                       gia 1
										            </td>
											        <td class="left">
                                                       
												        <asp:LinkButton ID="btnFix" CssClass="btn btn-xs btn-info" ToolTip="Sửa" onClick="btnFix_Click" runat="server" CommandArgument='<%# Eval("iMaTour") %>'><i class="fa fa-pencil-square-o" aria-hidden="false"></i></asp:LinkButton>
                                                        <asp:LinkButton ID="btnDelete" CssClass="btn btn-xs btn-danger" ToolTip="Xóa" runat="server" OnClick="btnDelete_Click" OnClientClick="return confirm('Bạn có chắc chắn xoá tour?')" CommandArgument='<%# Eval("iMaTour") %>'><i class="fa fa-times" aria-hidden="true"></i></asp:LinkButton>
											        </td>
									            </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                            
                                    </tbody>
                                </table>
                                <div class="text-center">
                                    <asp:HyperLink ID="lnkPre" runat="server" CssClass="pre_next">Trang trước</asp:HyperLink>
                                    <asp:HyperLink ID="lnkStart" runat="server" CssClass="index">1</asp:HyperLink>
                                    <asp:Label ID="Labelnv" runat="server" Text="Label"></asp:Label>
                                   
                                    <asp:HyperLink ID="lnkEnd" runat="server" CssClass="index">11</asp:HyperLink>
                                    <asp:HyperLink ID="lnkNext" runat="server" CssClass="pre_next">Trang sau</asp:HyperLink>
                                     <asp:Label ID="url" runat="server" Text="Label"></asp:Label>
                                 </div>  
                            </div>
                        </div>
                    </div>
                </div>
            
                <!-- /.row -->
        </form>

</asp:Content>
