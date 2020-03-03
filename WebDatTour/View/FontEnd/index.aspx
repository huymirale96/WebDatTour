<%@ Page Language="C#" MasterPageFile="~/Layout/FontEnd.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="WebDatTour.View.FontEnd.index" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <div>
    <div class="hero-sectdion">
        <div class="container">
          <!--  <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <h1 class="hero-title">hair salon website templates free download: <asp:Label ID="lb1" runat="server"></asp:Label></h1>
                    <p class="hero-text"><strong>Your Types. Your Style. Your Color.</strong> </p>
                    <a href="#" class="btn btn-default">Your slider buttons</a> </div>
            </div>
        </div> --->
    </div>
    
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
                        <div style="padding: 10px; background-color: #fff; border-radius:10px;" class="text-left" >
                           
                             <a href="../FontEnd/XemChiTietTour?id=<%# Eval("imatour") %>" class="">
                            <div class="zoom">                       
                                <img src="../../Upload/<%# anhDaiDien(Eval("sUrlAnh").ToString()) %>"  >
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
                    <li><a href="javascript:;">FAQ</a></li>
                    <li class="nav-divider"></li>
                    <li><a href="javascript:;"><i class="glyphicon glyphicon-off"></i> xxx</a></li>
                </ul>
            </nav>
        </div>
        
    <div class="space-medium">
        <div class="container">
            <div class="row">
                <div class="col-md-offset-2 col-md-8">
                    <div class="mb60 text-center section-title">
                        <!-- section title start-->
                        <h1>salon and barbar service</h1>
                        <h5 class="small-title ">we help you look great</h5>
                    </div>
                    <!-- /.section title start-->
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                    <div class="service-block">
                        <!-- service block -->
                        <div class="service-icon mb20">
                            <!-- service img -->
                            <img src="../../Content/images/service-icon-1.png" alt=""> </div>
                        <!-- service img -->
                        <div class="service-content">
                            <!-- service content -->
                            <h2><a href="# " class="title ">traditional cut</a></h2>
                            <p>Responsive website templates free download html5 with css3 for Hair Salon and Shop website template.</p>
                            <div class="price ">$45</div>
                        </div>
                        <!-- service content -->
                    </div>
                    <!-- /.service block -->
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                    <div class="service-block">
                        <!-- service block -->
                        <div class="service-icon mb20">
                            <!-- service img -->
                            <img src="../../Content/images/service-icon-2.png" alt=""> </div>
                        <!-- service img -->
                        <div class="service-content">
                            <!-- service content -->
                            <h2><a href="#" class="title ">MUSTACHE TRIM</a></h2>
                            <p>Free Responsive HTML5 CSS3 Website Template for hair salon and beauty salon.</p>
                            <div class="price">$45</div>
                        </div>
                        <!-- service content -->
                    </div>
                    <!-- /.service block -->
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                    <div class="service-block">
                        <!-- service block -->
                        <div class="service-icon mb20">
                            <!-- service img -->
                            <img src="../../Content/images/service-icon-3.png" alt=""> </div>
                        <!-- service img -->
                        <div class="service-content">
                            <!-- service content -->
                            <h2><a href="#" class="title ">BEARD TRIM</a></h2>
                            <p>Responsive website templates free download html with css.</p>
                            <div class="price ">$45</div>
                        </div>
                        <!-- service content -->
                    </div>
                    <!-- /.service block -->
                </div>
                <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12 text-center"> <a href="#" class="btn btn-default"> View All Service </a> </div>
            </div>
        </div>
    </div>
    <div class="space-medium bg-default">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12"><img src="../../Content/images/about-img.jpg" alt="" class="img-responsive"></div>
                <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12">
                    <div class="well-block">
                        <h1>Men’s salon website templates</h1>
                        <h5 class="small-title ">best experience ever</h5>
                        <p>Free Hair Salon Website Templates for your hair salon shop or business. <a href="https://easetemplate.com/">Free Website Template Download It now!</a></p>
                        <p>Bootstrap templates free download idcondi mentum utturpis one fuscenec justo idle libero pharetra posuere aliquam tempus is porttitor atfinibus sollicitudin namiam.</p>
                        <p>Best Free HTML CSS Website Templates for salon and hair cutting business. All features are clean designed</p>
                        <a href="# " class="btn btn-default">View More About us</a> </div>
                </div>
            </div>
        </div>
    </div>
    <div class="space-medium">
        <div class="container">
            <div class="row">
                <div class="col-lg-offset-2 col-lg-8 col-md-offset-2 col-md-8 col-sm-12 col-xs-12">
                    <div class="section-title mb60 text-center">
                        <!-- section title start-->
                        <h1>testimonials</h1>
                        <h5 class="small-title">What Happy Client Say</h5>
                    </div>
                    <!-- /.section title start-->
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                    <div class="testimonial-block">
                        <!-- testimonial block -->
                        <div class="testimonial-content">
                            <p class="testimonial-text">“Free Beauty Website Templates that help me a lot to build easy and fast my hair shop website in 2 days”</p>
                        </div>
                        <div class="testimonial-info">
                            <h4 class="testimonial-name">Reba Truong</h4>
                            <span class="testimonial-meta">34 Year</span> <span class="testimonial-meta">Customer</span> </div>
                    </div>
                    <!--/. testimonial block -->
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                    <div class="testimonial-block">
                        <!-- testimonial block -->
                        <div class="testimonial-content">
                            <p class="testimonial-text">“Free bootstrap responsive website templates 2017 its best ever i found for my hair salon”</p>
                        </div>
                        <div class="testimonial-info">
                            <h4 class="testimonial-name">Thomas Warren</h4>
                            <span class="testimonial-meta">34 Year</span> <span class="testimonial-meta ">Customer</span> </div>
                    </div>
                    <!--/. testimonial block -->
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                    <div class="testimonial-block">
                        <!-- testimonial block -->
                        <div class="testimonial-content">
                            <p class="testimonial-text">“Best Free HTML CSS Website Templates for salon and hair cutting business. All features are clean designed”</p>
                        </div>
                        <div class="testimonial-info">
                            <h4 class="testimonial-name">Carie Willis</h4>
                            <span class="testimonial-meta">34 Year</span> <span class="testimonial-meta">Customer</span> </div>
                    </div>
                    <!--/. testimonial block -->
                </div>
            </div>
        </div>
    </div>
    <div class="cta-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="cta-title">hair salon website templates</h1>
                    <p class="cta-text">You can download and use these FREE HTML templates for your salon and beauty shop and store. </p>
                    <a href="https://easetemplate.com/downloads/category/free-website-template/" class="btn btn-default" target="_blank">Call to action buttons</a> </div>
            </div>
        </div>
    </div>
    <div class="space-medium">
        <div class="container">
            <div class="row">
                <div class="col-lg-offset-2 col-lg-8 col-md-offset-2 col-md-8 col-sm-12 col-xs-12">
                    <div class="section-title mb40 text-center">
                        <!-- section title start-->
                        <h1>Latest News &amp; Article</h1>
                    </div>
                    <!-- /.section title start-->
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="post-block">
                        <div class="row ">
                            <!-- post block -->
                            <div class="col-md-6">
                                <div class="post-img">
                                    <a href="#"><img src="../../Content/images/post-img.jpg" alt="" class="img-responsive"></a>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="post-content">
                                    <h2><a href="https://easetemplate.com/" class="title" target="_blank"> cosmetics website templates free download</a></h2>
                                    <p class="meta"> <span class="meta-date"> 1 January 2018</span> <span class="meta-comment"><a href="# ">(12) Comments</a></span> <span class="meta-author">By <a href="#">Author</a></span></p>
                                    <p>Cras dolor arcu porttitor atfinibus idcondi mentum uttu rpis one fuscenec justo idle libero pharetra posuere aliq uam tempus is porttitor atfinibus.</p>
                                    <a href="#" class="btn btn-default">Read More</a> </div>
                            </div>
                        </div>
                        <!-- /.post block -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
                           </div>
</div>
</asp:Content>
