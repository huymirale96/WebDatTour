<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/FontEnd.Master" AutoEventWireup="true" CodeBehind="xemTourTheoNhom.aspx.cs" Inherits="WebDatTour.View.FontEnd.xemNhomTour" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div  style="margin: 10px;" class="col-lg-9 col-md-9 col-sm-12 col-xs-12">  
        <asp:Repeater ID="rptTour" runat="server">
            <ItemTemplate>
            
                 <div class="post-block" >
                        <div class="row ">
                            <!-- post block -->
                            <div class="col-md-4">
                                <div class="post-img">
                                    <a href="#"><img src="../../Upload/<%# anhDaiDien(Eval("sUrlAnh").ToString()) %>" alt="" class="img-responsives" style=" max-height: 180px;"></a>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="post-content--">
                                    <h3><a href="XemChiTietTour.aspx?id=<%# Eval("iMatour") %>" title="Permalink to Du lịch Hà Nội – Ninh Bình – Tam Cốc – Hạ Long – Yên Tử" rel="bookmark"><%# Eval("sTieuDe") %></a></h3>
                                    <p style="margin-top: 0px; line-height: 1.7;"><strong>Địa Điểm Khởi Hành: </strong>Tour riêng<br>
                                     <strong>Thời gian:&nbsp;</strong><%# Eval("sTongThoiGian") %><br>
                                     <strong>Giá:&nbsp;</strong><strong><span style="color: #ff0000;"><strong><strong><%# toCurruncy(Convert.ToInt32(Eval("igianl"))) %> VNĐ/khách</strong></strong></span><br>
                                     </strong><strong>Phương tiện: </strong>Ôtô, tàu<br>
                                     <strong>Ngày Khởi hành: </strong><%# Eval("dngaykhoihanh", "{0:dd/MM/yyyy}") %></p>
                                
                                     
                                </div>
                            </div>
                        </div>
                    </div>
                
                 </ItemTemplate>
        </asp:Repeater>
        <div class="text-center">
            <asp:Label ID="url" runat="server" Text="Label"></asp:Label>
        </div>
        </div>
    </div>

</asp:Content>
