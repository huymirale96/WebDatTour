<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/FontEnd.Master" AutoEventWireup="true" CodeFile="TourMoiNhat.aspx.cs" Inherits="WebDatTour.View.FontEnd.TourMoiNhat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="container-fluid">
    <div class="row">
        <div  style="margin: 0px;" class="col-lg-9 col-md-9"> 
            <h2 style="margin:12px;">DANH SÁCH TOUR MUA NHIỀU TRONG THÁNG</h2>
         <asp:Repeater ID="rptTour" runat="server">
            <ItemTemplate>
            
                 <div class="post-blocks"  style="margin: 20px 0 20px 40px;">
                        <div class="row ">
                            <!-- post block -->
                            <div class="col-md-4">
                                <div class="post-img">
                                    <a href="#"><img src="../../Upload/<%# anhDaiDien(Eval("sUrlAnh").ToString()) %>" alt="" class="img-responsives" style=" height: 225px; width: 330px;"></a>
                                </div>
                            </div>
                            <div class="col-md-7"  style="margin-left: 30px;">
                                <div class="post-content--">
                                    <h3><a href="XemChiTietTour.aspx?id=<%# Eval("iMatour") %>" title="" rel=""><%# Eval("sTieuDe") %></a></h3>  
                                    <p style="margin-top: 0px; line-height: 1.7;"><strong>Địa Điểm Khởi Hành: </strong><%# Eval("sNoiKhoiHanh") %><br>
                                     <strong>Thời gian:&nbsp;</strong><%# Eval("sTongThoiGian") %><br>
                                     <strong>Giá Người Lớn:&nbsp;</strong><strike style="color:forestgreen;"><%# Convert.ToInt32(Eval("igianlgiam")) == 0 ? "" :  toCurruncy(Convert.ToInt32(Eval("igianl"))) %></strike>&nbsp;<strong><span style="color: #ff0000;"><strong><strong><%# toCurruncy(Convert.ToInt32(Eval("igianlgiam"))) %> &nbsp;VNĐ/khách</strong></strong></span><br>
                                     <strong>Giá Trẻ Em:&nbsp;</strong><strike style="color:forestgreen;"><%# Convert.ToInt32(Eval("igiategiam")) == 0 ? "" :  toCurruncy(Convert.ToInt32(Eval("igiate"))) %></strike>&nbsp;<strong><strong><strong><span style="color: #ff0000;"><%# toCurruncy(Convert.ToInt32(Eval("igiategiam"))) %> &nbsp;VNĐ/khách</strong></strong></span><br>
                                     <strong>Ngày Khởi hành: </strong><%# Eval("thoigiandi", "{0:dd/MM/yyyy}") %>
                                           <br />  <%# hienSoSao(Eval("soSao").ToString()) %></p>
                                
                                     
                                </div>
                            </div>
                        </div>
                    </div>
                
                 </ItemTemplate>
        </asp:Repeater>
        <div class="text-center col-md-8">
            <asp:Label ID="url" runat="server" Text="Label"></asp:Label>
        </div>
        </div>
    </div>
      </div>
</asp:Content>