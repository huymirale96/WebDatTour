<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/FontEnd.Master" AutoEventWireup="true" CodeBehind="DanhSachCacTourDaDat.aspx.cs" Inherits="WebDatTour.View.FontEnd.DanhSachCacTourDaDat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
     <div class="col-md-12">
        <h1 class="page-header">Danh Sách Đơn Đặt Tour
                            <small>---</small>
        </h1>
    </div>
    <br />
   <!-- <form method="POST" class="form-horizontal" runat="server" enctype="multipart/form-data"> -->
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
										            <td class="text-center"><%# Eval("stieude") %></td>
                                                    <td class="text-center"><%# Eval("dngaydattour", "{0:dd/MM/yyyy}") %></td>
                                                    <td class="text-center"><%# Eval("sTenKhachHang") %></td>
										            <td class="text-center"><%# toCurruncy(Convert.ToInt32(Eval("doanhthu").ToString())) %>&nbspVND</td>
										            <td class="text-center"><%# toCurruncy(Convert.ToInt32(Eval("thucthu"))) %>&nbspVND</td>
                                                    
										            <td class="text-center">
                                                        <%# trangThai(Eval("itrangthai").ToString()) %>
										            </td>
											        <td class="text-center">
                                                        <button class="btn btn-xs btn-success" <%# (Convert.ToInt32(Eval("doanhthu").ToString()) - Convert.ToInt32(Eval("thucthu"))) == 0 ? "style='display: none;'" : "" %> onclick ="thanhToan(<%# Eval("iMaDonDatTour") %>,<%# Convert.ToInt32(Eval("doanhthu").ToString()) - Convert.ToInt32(Eval("thucthu")) %>)">Thanh Toán Nốt<br /></button>
                                                         <br />
                                                        <button class="btn btn-xs btn-warning" onclick="huyTour(<%# Eval("iMaDonDatTour") %>)">Hủy Tour</button>
												        
											        </td>
									            </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        
                                            
                                            
                                    </tbody>
                                </table>
                                <div class="text-center">
                                   
                                     <asp:Label ID="url" runat="server" Text="Label"></asp:Label>
                                     <asp:Label ID="lblnoti" runat="server" Text=""></asp:Label>
                                 </div>     
                            </div>
                        </div>
                    </div>
                </div>
           
                <!-- Modal HUY TOUR-->
  <div class="modal fade" id="modalHuy" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Hủy Đặt Tour</h4>
        </div>
        <div class="modal-body">
            <form method="post" action="DanhSachCacTourDaDat.aspx">  
                <p>Nhập Mật Khẩu Để Hủy Tour</p>
                <input type="hidden" value="huy" name ="cn" />
                
             <div id="modalHuy_">
                 
                
             </div>
                <input type="submit" value="Hủy" class="btn btn-default"/>
                </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
          <!-- Modal HUY TOUR-->
        <!-- Modal Thanh Toan-->
  <div class="modal fade" id="modalThanhToan" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Hủy Đặt Tour</h4>
        </div>
        <div class="modal-body">
            <form method="post" action="DanhSachCacTourDaDat.aspx">  
                <p>CHỌN NGÂN HÀNG</p>
                <input type="hidden" value="tt" name ="cn" />
                 <select name="bank" id="bank" class="form-control">
	<option value="NCB">Ngan hang NCB</option>
	<option value="SACOMBANK">Ngan hang SacomBank</option>
	<option value="EXIMBANK">Ngan hang EximBank</option>
	<option value="MSBANK">Ngan hang MSBANK</option>
	<option value="NAMABANK">Ngan hang NamABank </option>
	<option value="VISA">The quoc te VISA/MASTER</option>
	<option value="VNMART">Vi dien tu VnMart</option>
	<option value="VIETINBANK">Ngan hang Vietinbank</option>
	<option value="VIETCOMBANK">Ngan hang VCB</option>
	<option value="HDBANK">Ngan hang HDBank</option>
	<option value="DONGABANK">Ngan hang Dong A</option>
	<option value="TPBANK">Ngân hàng TPBank</option>
	<option value="OJB">Ngân hàng OceanBank</option>
	<option value="BIDV">Ngân hàng BIDV</option>
	<option value="TECHCOMBANK">Ngân hàng Techcombank</option>
	<option value="VPBANK">Ngan hang VPBank</option>
	<option value="AGRIBANK">Ngan hang Agribank</option>
	<option value="ACB">Ngan hang ACB</option>
	<option value="OCB">Ngan hang Phuong Dong</option>
	<option value="SCB">Ngan hang SCB</option>

</select>
             <div id="modalTT">
                 
                
             </div>
                <input type="submit" value="Thanh Toán" class="btn btn-default"/>
                </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
          <!-- Modal Thanh Toan-->
            
                <!-- /.row  </form> -->

       
        </div>
</asp:Content>
