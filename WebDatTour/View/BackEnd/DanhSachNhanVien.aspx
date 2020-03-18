<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout/BackEnd.Master" CodeBehind="DanhSachNhanVien.aspx.cs" Inherits="WebDatTour.View.BackEnd.DanhSachNhanVien" %>
<asp:Content ID="conetnt" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <form method="POST" class="form-horizontal" runat="server" enctype="multipart/form-data">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Danh Sách Nhân Viên
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
                                            <th class="text-center">Giới Tính</th>
                                            <th class="text-center">Địa Chỉ</th>
                                            <th class="text-center">Số Điện Thoại</th>
                                            <th class="text-center">Tên Đăng Nhập</th>
                                            <th class="text-center">Quyền</th>
                                          <!--  <th class="text-center">Thao Tác</th> -->
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptNhanVien" runat="server">
                                            <ItemTemplate>
                                                <tr>
										            <td class="text-center"><%# Container.ItemIndex+1 %></td>
										            <td class="left"><%# Eval("sTenNhanVien") %></td>
                                                    <td class="text-center"><%# Eval("dNgaySinh", "{0:dd/MM/yyyy}") %></td>
                                                    <td class="left"><%# Eval("bGioiTinh").ToString().Equals("1") ? "Nam" : "Nữ" %></td>
										            <td class="text-center"><%# Eval("sDiaChi") %></td>
										            <td class="text-center"><%# Eval("sSdt") %></td>
                                                     <td class="left"><%# Eval("sUserName") %></td>
										            <td class="text-center">
                                                        <%# Eval("iMaQuyen").ToString().Equals("2") ? "ADMIN" : "MEMBER" %>
										            </td>
											     <!--   <td class="text-center">
                                                       
												       <input type="checkbox" hidden="hidden" id="trangThaiNV" data-id="" checked="checked">
                                                        <label class="switch_btn" for="trangThaiNV"></label>  -->
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
                                 </div>     
                            </div>
                        </div>
                    </div>
                </div>
            
                <!-- /.row -->

        </form>
</asp:Content>
