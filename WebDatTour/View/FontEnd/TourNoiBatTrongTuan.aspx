<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/FontEnd.Master" AutoEventWireup="true" CodeBehind="TourNoiBatTrongTuan.aspx.cs" Inherits="WebDatTour.View.FontEnd.TourNoiBatTrongTuan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="row">
        <div  style="margin: 10px;" class="col-lg-9 col-md-9 "> 
            <h2 style="margin:12px;">DANH SÁCH TOUR NỔI BẬT TRONG TUẦN</h2>
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
                                    <h3><a href="XemChiTietTour.aspx?id=<%# Eval("iMatour") %>" title="" rel=""><%# Eval("sTieuDe") %></a></h3>  
                                    <p style="margin-top: 0px; line-height: 1.7;"><strong>Địa Điểm Khởi Hành: </strong><%# Eval("sNoiKhoiHanh") %><br>
                                     <strong>Thời gian:&nbsp;</strong><%# Eval("sTongThoiGian") %><br>
                                     <strong>Giá Người Lớn:&nbsp;</strong><strike style="color:forestgreen;"><%# Convert.ToInt32(Eval("igianlgiam")) == 0 ? "" :  toCurruncy(Convert.ToInt32(Eval("igianl"))) %></strike>&nbsp;<strong><span style="color: #ff0000;"><strong><strong><%# toCurruncy(Convert.ToInt32(Eval("igianlgiam"))) %> &nbsp;VNĐ/khách</strong></strong></span><br>
                                     <strong>Giá Trẻ Em:&nbsp;</strong><strike style="color:forestgreen;"><%# Convert.ToInt32(Eval("igiategiam")) == 0 ? "" :  toCurruncy(Convert.ToInt32(Eval("igiate"))) %></strike>&nbsp;<strong><strong><strong><span style="color: #ff0000;"><%# toCurruncy(Convert.ToInt32(Eval("igiategiam"))) %> &nbsp;VNĐ/khách</strong></strong></span><br>
                                     <strong>Ngày Khởi hành: </strong><%# Eval("thoigiandi", "{0:dd/MM/yyyy}") %>
                                        </p>
                                
                                     
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

       <!--    <div class="col-lg-2 col-md-2"  style="">
                <br>
                    <h4 class="text-center">Tìm Kiếm Tour</h4>
                    
                   <div class="widgetd widget-searchd">
                        <!-- widget search 
                        <form method="get" action="TimKiemTour.aspx">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Tìm Kiếm" aria-describedby="basic-addon2" name="ten" id="ten">
                                <span class="input-group-addon" id="basic-addon2">
                                <button type="submit" class=""><i class="fa fa-search"></i></button></span>
                            </div>
                            <!-- /input-group
                        </form>

                       

                    </div>
                     
                        
                                    
               </div>
                         <div class="col-md-2">
            <nav class="nav-sidebar">
                <ul class="nav mt20 text-center" style="color:#18150d;">
                    <li class="active"><a href="javascript:;"><h2>Danh Mục</h2></a></li>
                    <li ><a style="color:#18150d;" href="tourmoinhat.aspx">Tour Mới Nhất</a></li>
                    <li ><a style="color:#18150d;" href="tournoibattrongtuan.aspx">Tour Nổi Bật</a></li>
                    <li ><a style="color:#18150d;" href="tournoibatthang.aspx">Tour Mua Nhiều Trong Tháng</a></li>
                    <li><a href="javascript:;">FAQ</a></li>
                    <li class="nav-divider"></li>
                    <li><a href="javascript:;"><i class="glyphicon glyphicon-off"></i> xxx</a></li>
                </ul>
            </nav>
        </div>-->
    </div>
</asp:Content>
