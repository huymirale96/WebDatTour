<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="XemDonDatTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.XemDonDatTour" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="row">
     <div class="col-md-12">
        <h1 class="page-header"> Chi Tiết Đơn Đặt Tour
                            <small>---</small>
        </h1>
    </div>
    <br />
    <ul style="list-style-type: none;">
        <li style="font-size:25px" runat="server" id="txtMa">Mã Đơn Đặt Tour:</li>
         <li style="font-size:25px"  id="txtNgayD" runat="server">Ngày Đặt:</li>
        <li style="font-size:25px" runat="server"  id="txtTen">Khách Hàng</li>
         <li style="font-size:25px" runat="server"  id="txtsdt">Số Điện Thoại:</li>
         <li runat="server"  style="font-size:25px" id="txtEmail">Email:</li>
         <li style="font-size:25px" runat="server"   id="txtNL">Số Chỗ Người Lớn:</li>
         <li style="font-size:25px" runat="server"   id="txtTE">Số Chỗ Trẻ Em:</li>
         <li style="font-size:25px" runat="server"   id="txttientt">Tổng Tiền Đã Thanh Toán:</li>
         <li style="font-size:25px" runat="server"   id="txtTien">Tổng Đơn Đặt Tour:</li>
         <li style="font-size:25px" runat="server"   id="txtTieuDe">Tour:</li>
         <li style="font-size:25px" runat="server"   id="txtNgaykhoiHnah">Ngày Khởi Hành:</li>
         <li style="font-size:25px" runat="server"   id="txtNoiKhoiHanh">Nơi Khởi Hành:</li>
         <li style="font-size:25px" runat="server"   id="txttgtong">Tổng Thời Gian: </li>
         <li style="font-size:25px" runat="server"   id="txtGhiChu">Ghi chú</li>
       
    </ul>
</div>

</asp:Content>
