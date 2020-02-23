<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="DanhSachDatTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.DanhSachDatTour" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
     <div class="col-md-12">
        <h1 class="page-header">Danh Sách Đơn Đặt Tour
                            <small>---</small>
        </h1>
    </div>
    <br />
    <form method="POST" class="form-horizontal" runat="server" enctype="multipart/form-data">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Danh Sách 
                        </div>
                        <div class="panel-body">
                            <div class="text-center">
                                <span id="MainContent_lblNoti"></span>
                            </div>
                            <div class="col-md-offset-1 col-md-4"><asp:TextBox ID="txtTuKhoa" runat="server" CssClass="form-control" Placeholder="Tim Kiem"></asp:TextBox></div>
                                <div class="col-md-2" style="margin-left:50px; margin-bottom:15px;"><asp:Button ID="btnTimKiem" runat="server" Text="Tìm Kiếm" CssClass="btn btn-default" onclick="btnTimKiem_Click"/></div>
                             <label class="radio-inline"><asp:RadioButton ID="rdDon" runat="server"  Checked="true" GroupName="kieu" Text="Mã Đơn"/></label>
                             <label class="radio-inline">  <asp:RadioButton ID="rdKH" runat="server"  Checked="false" GroupName="kieu" Text="Tên Khách Hàng"/> </label>
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
										            <td class="text-center"><a href="../FontEnd/XemChiTietTour.aspx?id=<%# Eval("iMaTour") %>"><%# Eval("stieude") %></a></td>
                                                    <td class="text-center"><%# Eval("dngaydattour", "{0:dd/MM/yyyy HH:mm}") %></td>
                                                    <td class="text-center"><%# Eval("sTenKhachHang") %></td>
										            <td class="text-center"><%# toCurruncy(Convert.ToInt32(Eval("doanhthu").ToString())) %>&nbspVND</td>
										            <td class="text-center"><%# toCurruncy(Convert.ToInt32(Eval("thucthu"))) %>&nbspVND</td>
                                                
										            <td class="text-center">
                                                        <%# trangThaiDon(Convert.ToInt32(Eval("itrangthai").ToString())) %>
										            </td>
											        <td class="left">
												        <asp:LinkButton ID="btnXacNhan" CssClass="btn btn-xs btn-success" Onclick="btnXacNhan_Click" ToolTip="Xác Nhận" runat="server" OnClientClick="return confirm('Bạn có chắc chắn Xác Nhận Đơn Đặt Tour?')" CommandArgument='<%# Eval("iMaDonDatTour") %>'><i class="fa fa-pencil-square-o" aria-hidden="false"></i></asp:LinkButton>
                                                        <asp:LinkButton ID="btnHuy" CssClass="btn btn-xs btn-danger" ToolTip="Hủy" runat="server" Onclick="btnHuy_Click" OnClientClick="return confirm('Bạn có chắc chắn hủy đơn đặt tour?')" CommandArgument='<%# Eval("iMaDonDatTour") %>'><i class="fa fa-times" aria-hidden="true"></i></asp:LinkButton>
											            <%# Convert.ToInt32(Eval("conLai")) == 0 ? "<div style='display: none;'>" : ""%> <asp:LinkButton ID="btnThanhToan"  CssClass="btn btn-xs btn-info" Onclick="btnThanhToan_Click" ToolTip="Thanh Toán Tiền Còn Lại" runat="server" OnClientClick='<%# Eval("conLai", "return confirm(\"Bạn Có Muốn Thanh Toán Nốt {0} VND?\");") %>'   CommandArgument='<%# Eval("iMaDonDatTour")  + ";" + Eval("conLai")   %>'><i class="fa fa-credit-card" aria-hidden="true"></i></asp:LinkButton> <%# Convert.ToInt32(Eval("conLai")) == 0 ? "</div>" : ""%>
                                                      
                                                        </td>
									            </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        
                                            
                                            
                                    </tbody>
                                </table>
                                <div class="text-center">
                                   
                                     <asp:Label ID="url" runat="server" Text="Label"></asp:Label>
                                    <asp:Label ID="lblnoti" runat="server" Text=""></asp:Label>
                                    <asp:HiddenField ID="pageid" runat="server" value="1"/>
                                 </div>     
                            </div>
                        </div>
                    </div>
                </div>
            
                <!-- /.row -->

        </form>
        </div>
</asp:Content>
