<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Layout/BackEnd.Master"  CodeBehind="TaoDonDatTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.TaoDonDatTour" %>
<asp:Content ID="cnt" runat="server" ContentPlaceHolderID="MainContent">
    <div class="row">
        <div class="col-md-12">
            <style>
                .classAn
                {
                    display: none;
                }
            </style>
            <div id="idkhhidden" runat="server">

            </div>
                    	<input type="hidden" id="giaNLh">
                    	<input type="hidden" id="giaTEh">
                    	<input type="hidden" id="idtourh">
                    	<input type="hidden" id="soChoConh">
                       
                    	<input type="hidden" id="tienTTh">
                    	

                    	
                    	<br>
                    	<h2>Tạo Đơn Đặt Tour</h2>
                    	<div class="form-group" style="width: 40%;">
                                <label>Tên Khách Hàng</label>
                                <h3 id="tenKhachHAng" runat="server"></h3>
                         </div>
                         <div class="form-group" style="width: 70%;">
                                <label>CHỌN TOUR:</label>
                                <select id="listTour" class="form-control">
                                    <option value="none">Chọn Tour:</option>
                                    <asp:Repeater runat="server" ID="rptour">
                                        <ItemTemplate>
                                            <option value="<%# Eval("iMaTour") %>"><%# Eval("sTieuDe") %></option>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </select>
                         </div>
                         <div class="classAn" id="divThongTinTour">
                         <div class="col-md-4" id="anhTour">
                         	
                         </div>
                         <div class="col-md-offset-1 col-md-7 tourTable">
                         	<table class="table table-hover">
                         		<tr>
                         			<td>Tour:</td>
                         			<td id="txtTieuDe">TOur abc</td>
                         		</tr>
                         		<tr>
                         			<td>Nơi Khởi Hành: </td>
                         			<td id="txtNoiKhoiHanh">ABC</td>
                         		</tr>
                         		<tr>
                         			<td>Tổng Thời Gian: </td>
                         			<td id="txtTongThoiGian"></td>
                         		</tr>
                         		<tr>
                         			<td>Giá Người Lớn: </td>
                         			<td id="txtGiaNL">ABC</td>
                         		</tr>
                         		<tr>
                         			<td>Giá Trẻ Em: </td>
                         			<td id="txtGiaTE">ABC</td>
                         		</tr>
                         		<tr>
                         			<td>Ngày Khởi Hành Khởi Hành: </td>
                         			<td>
                         				<select id="txtThoiGian">
                         					<option>1</option>
                         					<option>1</option>
                         				</select>
                         			</td>
                         		</tr>
                                 <tr>
                         			<td>Số Chỗ : </td>
                         			<td id="txtSoCho">ABC</td>
                         		</tr>
                                 <tr>
                         			<td>Số Chỗ Còn : </td>
                         			<td id="txtSoChoCon">ABC</td>
                         		</tr>
                                 <tr>
                         			<td>Số % Thanh Toán: </td>
                         			 <td>
                         				<select id="txtPtThanhToan">
                                             <option value="1">Chọn Số Tiền Thanh Toán</option>
                         					<option value="0.5">50%</option>
                         					<option value="1">100%</option>
                         				</select>
                         			</td>
                         		</tr>
                         	</table>
                         	<div class="form-group" style="width: 40%;">
                                <label>Số Chỗ Người Lớn:</label>
                                <input class="form-control isNumberic" id="txtSoChoNL" type="number" min="0" value="0" />
                            </div>
                            <div class="form-group" style="width: 40%;">
                                <label>Số Chỗ Trẻ Em:</label>
                                <input class="form-control isNumberic" id="txtSoChoTE" type="number" min="0"  value="0"/>
                                <span style="color: crimson" id="thongBao"></span>
                            </div>
                            
                            <button class="btn btn-success" id="thanhToanDDT" >Đặt Tour</button>
                         </div>
                             </div>
                    </div>
    </div>
</asp:Content>