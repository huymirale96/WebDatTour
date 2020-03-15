<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="ThongKeDoanhSoTheoTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.ThongKeDoanhSoTheoTour" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <form method="POST" class="form-horizontal" runat="server" enctype="multipart/form-data">
    <div class="row">
     <div class="col-md-12">
        <h1 class="page-header">Thống Kê Doanh Số Theo Tour
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
                        
                    </div>
                    <div class="col-md-4">
                        <asp:Button ID="timKiem" runat="server" Text="Tìm Kiếm" OnClick="timKiem_Click" CssClass="btn btn-default"></asp:Button>
                    </div>
                            <br />
                            <div class="col-md-12" style="margin-top:30px;">
                                <table class="table table-bordered table-stripped">
                                    <thead>
                                        <tr> 
                                            <th class="text-center">STT</th>
                                             <th class="text-center">Tour</th>
                                            <th class="text-center">Ngày Đi</th>
                                            <th class="text-center">Doanh Thu</th>
                                            <th class="text-center">Thực Thu</th>
                                            <th class="text-center">Còn Lại</th>
                                            
                                          
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptTour" runat="server">
                                            <ItemTemplate>
                                                <tr>
										            <td class="text-center"><%# Container.ItemIndex+1 %></td>
                                                     <td class="text-center"><a href="../FontEnd/XemChiTietTour?id=<%# Eval("iMaTour") %>"><%# Eval("sTieuDe") %></a></td>									            
                                                    <td class="text-center"><%# Eval("thoigiandi", "{0:dd/MM/yyyy}") %></td>
                                                    <td class="text-center"><%# Eval("doanhthu") %></td>
                                                    <td class="text-center"><%# Eval("thucthu") %></td>
										            <td class="text-center"><%# Eval("conlai") %></td>

											        
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

