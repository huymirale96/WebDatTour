<%@ Page Language="C#" MasterPageFile="~/Layout/FontEnd.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="WebDatTour.View.FontEnd.index" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    
        <style>

.zoom {
    overflow: hidden;
   // padding: 0;
    //width: 300px;
///height: 300px;
   // border:1px solid #000;
   // float:left;
   // margin:10px;
}
.zoom img {
    transition-duration: 2s;
    margin: 0 auto;
    display: block;
}
.zoom img:hover {
     transform: scale(1.2);
    -webkit-transform: scale(1.2);
    -moz-transform: scale(1.2);
    z-index: 0;
}
        </style>
                    <div class="container-fluid">
                    <div class="row" >
                    <div class="col-lg-10 col-md-10" style="margin-top: 24px;">

                    <div class="row">
                        <div class="col-md-12">
                    <div class="panel panel-default" style="background-color: #e0e7ee; margin:5px;">
                    <div class="panel-heading" style="height:50px;">
                        <div class="panel-title pull-left">
                             <h4>MIỀN BẮC</h4>
                        </div>
                    <div class="panel-title pull-right"><a href="xemTourTheoNhom.aspx?id=18">Xem Thêm</a></div>

                    </div>
                    <div class="panel-body">
                    <div class="container-fluid">
                    <div class="row" style="padding: 10px;">
                       <asp:Repeater ID="rpt1" runat="server">
                        <ItemTemplate>
                        <div class="col-md-4 col-lg-4 border border-warning" style=" padding: 5px;">
                            <%# hienSoSao(Eval("soSao").ToString()) %>
                        <div style="padding: 10px; background-color: #fff; border-radius:10px;" class="text-left" >
                           
                             <a href="../FontEnd/XemChiTietTour?id=<%# Eval("imatour") %>" class="">
                            <div class="zoom">                       
                                <img src="../../Upload/<%# anhDaiDien(Eval("sUrlAnh").ToString()) %>" width="320px" height="200px" >
                                </div>
                                  <div style="height:45px; margin-top: 5px;">
                        <p class="text-left" style="font-family: 'Roboto', sans-serif; line-height:20px; color: #18150d"><b><%# Eval("sTieuDe").ToString() %></b></p>
                            </a>
                                </div>
                        <div class="text-left" style="line-height:0px;"> 
                        <i class="fa fa-cart-plus" style="font-size: 20px;"></i> 
                        <strike style="color: orangered; display:inline-block;"><%# giave(Convert.ToInt32(Eval("igianlgiam"))) %></strike>
                        <p style="color: green; display:inline-block; font-size: 26px;"><b><%# toCurruncy(Convert.ToInt32(Eval("igianl"))) %>đ</b></p>
                        <br>
                        <i class="fa fa-clock-o" style="font-size:20px; color: black;"></i>
                        <p style=" color: black; display: inline-block;"><%# Eval("stongthoigian") %></p>
                        <br>
                        <i class="fa fa-calendar-check-o" style="font-size: 20px;"></i>
                        <p style=" color: black; display: inline-block;">Ngày đi:<%# Eval("dngaykhoihanh", "{0:dd/MM/yyyy}") %></p>
                     
                        
                        </div>
                        </div>
                        </div>
                        </ItemTemplate>
                        </asp:Repeater>

                        </div>
                        </div>
               </div>
                </div>
               </div>
                    </div>

                        <!--nhom 1-->
                        
                    <div class="row">
                        <div class="col-md-12">
                    <div class="panel panel-default" style="background-color: #e0e7ee; margin:5px;">
                    <div class="panel-heading" style="height:50px;"><div class="panel-title pull-left">
                            <h4>MIỀN TRUNG</h4>
                        </div>
                    <div class="panel-title pull-right"><a href="xemTourTheoNhom.aspx?id=19">Xem Thêm</a></div></div>
                    <div class="panel-body">
                    <div class="container-fluid">
                    <div class="row" style="padding: 10px;">
                       <asp:Repeater ID="rpt2" runat="server">
                        <ItemTemplate>
                        <div class="col-md-4 col-lg-4 border border-warning" style=" padding: 5px;">
                              <%# hienSoSao(Eval("soSao").ToString()) %>
                        <div style="padding: 10px; background-color: #fff; border-radius:10px;" class="text-left" >
                           
                             <a href="../FontEnd/XemChiTietTour?id=<%# Eval("imatour") %>" class="">
                            <div class="zoom">                       
                                <img src="../../Upload/<%# anhDaiDien(Eval("sUrlAnh").ToString()) %>"   width="320px" height="200px">
                                </div>
                                  <div style="height:45px; margin-top: 5x;">
                        <p class="text-left" style="font-family: 'Roboto', sans-serif; line-height:20px; color: #18150d"><b><%# Eval("sTieuDe").ToString() %></b></p>
                            </a>
                                </div>
                        <div class="text-left" style="line-height:0px;"> 
                        <i class="fa fa-cart-plus" style="font-size: 20px;"></i> 
                        <strike style="color: orangered; display:inline-block;"><%# giave(Convert.ToInt32(Eval("igianlgiam"))) %></strike>
                        <p style="color: green; display:inline-block; font-size: 26px;"><b><%# toCurruncy(Convert.ToInt32(Eval("igianl"))) %>đ</b></p>
                        <br>
                        <i class="fa fa-clock-o" style="font-size:20px; color: black;"></i>
                        <p style=" color: black; display: inline-block;"><%# Eval("stongthoigian") %></p>
                        <br>
                        <i class="fa fa-calendar-check-o" style="font-size: 20px;"></i>
                        <p style=" color: black; display: inline-block;">Ngày đi:<%# Eval("dngaykhoihanh", "{0:dd/MM/yyyy}") %></p>
                        
                        </div>
                        </div>
                        </div>
                        </ItemTemplate>
                        </asp:Repeater>

                        </div>
                        </div>
               </div>
                </div>
               </div>
                    </div>
                        <!--nhom 2-->
                        
                    <div class="row">
                        <div class="col-md-12">
                    <div class="panel panel-default" style="background-color: #e0e7ee; margin:5px;">
                    <div class="panel-heading" style="height:50px;"><div class="panel-title pull-left">
                            <h4>MIỀN NAM</h4>
                        </div>
                    <div class="panel-title pull-right"><a href="xemTourTheoNhom.aspx?id=20">Xem Thêm</a></div></div>
                    <div class="panel-body">
                    <div class="container-fluid">
                    <div class="row" style="padding: 10px;">
                       <asp:Repeater ID="rpt3" runat="server">
                        <ItemTemplate>
                        <div class="col-md-4 col-lg-4 border border-warning" style=" padding: 5px;">
                              <%# hienSoSao(Eval("soSao").ToString()) %>
                        <div style="padding: 10px; background-color: #fff; border-radius:10px;" class="text-left" >
                           
                             <a href="../FontEnd/XemChiTietTour?id=<%# Eval("imatour") %>" class="">
                            <div class="zoom">                       
                                <img src="../../Upload/<%# anhDaiDien(Eval("sUrlAnh").ToString()) %>" width="320px" height="200px" >
                                </div>
                                  <div style="height:45px; margin-top: 5x;">
                        <p class="text-left" style="font-family: 'Roboto', sans-serif; line-height:20px; color: #18150d"><b><%# Eval("sTieuDe").ToString() %></b></p>
                            </a>
                                </div>
                        <div class="text-left" style="line-height:0px;"> 
                        <i class="fa fa-cart-plus" style="font-size: 20px;"></i> 
                        <strike style="color: orangered; display:inline-block;"><%# giave(Convert.ToInt32(Eval("igianlgiam"))) %></strike>
                        <p style="color: green; display:inline-block; font-size: 26px;"><b><%# toCurruncy(Convert.ToInt32(Eval("igianl"))) %>đ</b></p>
                        <br>
                        <i class="fa fa-clock-o" style="font-size:20px; color: black;"></i>
                        <p style=" color: black; display: inline-block;"><%# Eval("stongthoigian") %></p>
                        <br>
                        <i class="fa fa-calendar-check-o" style="font-size: 20px;"></i>
                        <p style=" color: black; display: inline-block;">Ngày đi:<%# Eval("dngaykhoihanh", "{0:dd/MM/yyyy}") %></p>
                        
                        </div>
                        </div>
                        </div>
                        </ItemTemplate>
                        </asp:Repeater>

                        </div>
                        </div>
               </div>
                </div>
               </div>
                    </div>
                        <!--nhom 3-->
                    </div>
               
              
                        
                       

                         


                  
               <div class="col-lg-2 col-md-2"  style="">
                <br>
                    <h4 class="text-center">Tìm Kiếm Tour</h4>
                    
                   <div class="widgetd widget-searchd">
                        <!-- widget search -->
                        <form method="get" action="TimKiemTour.aspx">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Tìm Kiếm" aria-describedby="basic-addon2" name="ten" id="ten">
                                <span class="input-group-addon" id="basic-addon2">
                                <button type="submit" class=""><i class="fa fa-search"></i></button></span>
                            </div>
                            <!-- /input-group -->
                        </form>
                       <p  class="nav-divider"></p>

                       

                    </div>
                          <!--  <div class="row" style="border-bottom: 1px solid #f4f1ec; margin: 10px;">
                            <div class="col-md-10 col-lg-10 col-md-offset-1">
                                <img src="../../Content/images/related-post.jpg" class="img-responsive" style="border-radius: 5px;">
                                <a href="#"><p>Title  Title  Title  Title  Title  Title  Title  Title  Title  Title  Title  Title  </p></a> 
                                  <i class="fa fa-calendar-check-o" style="font-size: 20px;"></i>
                                            <div class="meta" style="display: inline-block;">
                                                <span class="meta-date" >22 Jan, 2020</span>
                                            </div>
                                            <br>
                                                 <i class="fa fa-cart-plus" style="font-size: 20px; display: inline-block;"></i>
                                            <div class="meta" style="display: inline-block;">
                                                <span class="meta-date" style="display: inline-block;"><strike>449.000k</strike></span>
                                                <span class="meta-date"><p style="color: green;">449.000k</p></span>
                                      </div>
                                  </div>
                              </div>
                     <div class="row" style="border-bottom: 1px solid #aa9144; margin: 10px;">
                            <div class="col-md-10 col-lg-10">
                                <img src="../../Content/images/related-post.jpg" class="img-responsive" style="border-radius: 5px;">
                                <a href="#"><p>Title  Title  Title  Title  Title  Title  Title  Title  Title  Title  Title  Title  </p></a> 
                                  <i class="fa fa-calendar-check-o" style="font-size: 10px;"></i>
                                            <div class="meta" style="display: inline-block;">
                                                <span class="meta-date" >22 Jan, 2020</span>
                                            </div>
                                            <br>
                                                 <i class="fa fa-cart-plus" style="font-size: 10px; display: inline-block;"></i>
                                            <div class="meta" style="display: inline-block;">
                                                <span class="meta-date" style="display: inline-block;"><strike>449.000k</strike></span>
                                                <span class="meta-date"><p style="color: green;">449.000k</p></span>
                                      </div>
                                  </div>
                                  </div>-->



                        
                                    
               </div>
                         <div class="col-md-2">
            <nav class="nav-sidebar">
                <ul class="nav mt20 text-center" style="color:#18150d;">
                    <li class="active"><a href="javascript:;"><h2>Danh Mục</h2></a></li>
                    <li ><a style="color:#18150d;" href="tourmoinhat.aspx">Tour Mới Nhất</a></li>
                    <li ><a style="color:#18150d;" href="tournoibattrongtuan.aspx">Tour Nổi Bật</a></li>
                    <li ><a style="color:#18150d;" href="tournoibatthang.aspx">Tour Mua Nhiều Trong Tháng</a></li>
                    
                    <li class="nav-divider"></li>
                    
                </ul>
            </nav>
        </div>
                        <div class="col-md-2">
                         <div class="widgetd widget-searchd">
                             <form method="get" action="timkiemtour.aspx">
                                 <h3>TÌM THEO NGÀY ĐI</h3>
                                 <input type="hidden" name="chucNang" value="timtheongay"/>
                                 <label>Ngày Bắt Đầu: </label><input type="date" id="ngaybd" name="ngaybd" class="form-control" value="2020-03-03"/>
                                 <label>Ngày Kết Thúc: </label><input type="date" id="ngaykt" name="ngaykt" class="form-control" value="2020-04-03"/>
                                 <input type="submit" value="Tìm Kiếm"/>
                             </form>
                         </div>
                              </div>

        
   
    
    
</div>
                           </div>
</asp:Content>
