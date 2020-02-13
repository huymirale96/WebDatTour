﻿<%@ Page Language="C#" MasterPageFile="~/Layout/FontEnd.Master" AutoEventWireup="true" CodeBehind="XemChiTietTour.aspx.cs" Inherits="WebDatTour.View.FontEnd.XemChiTietTour" %>
<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" ID="content1" runat="server"> 
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="post-holder">
                                <!-- post holder -->
                                 <div class="post-img">
                                </div>
         <h2><asp:label ID="txtTieuDe" runat="server"></asp:label></h2>  
  <div id="myCarousel2" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
                                <asp:Repeater ID="rpt1" runat="server">
                                <ItemTemplate>
                                    <li data-target="#myCarousel2" data-slide-to="<%# Eval("id")%>"></li>
                                
                                </ItemTemplate>
                                </asp:Repeater>
        </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
                                <asp:Repeater ID="rpt2" runat="server">
                                <ItemTemplate>
                                     <div class="post-img item <%# Container.ItemIndex == 0 ? "active" : "" %>">

                                         <img style="width:100%; height: 400px;" src="../../Upload/<%# Eval("url") %> " />
      </div>
                                </ItemTemplate>
                                </asp:Repeater>
        </div>
         <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel2" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel2" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
        </div>


                                <div class="post-content">
                                    <!-- post content -->
                                    <div class="post-header">
                                        <h1>-----------------------------</h1>
                                        <div class="meta">
                                            <!-- post meta -->
                                            <span class="meta-date">Ngay Thang </span>
                                            <span class="meta-comment"> <a href="#" class="meta-link">05 Comment </a></span>
                                            <span class="meta-user">by <a href="#"> Admin </a></span>
                                            <span class="meta-cat"> Danh Muc</span>
                                        </div>
                                    </div>
                                    <p>----- <a href="https://easetemplate.com/downloads/category/free-website-template/">website-</a> -</p>
                                    <p> </p>
                                    <img src="../../Content/images/ba-na-hill-ivivu.jpg" class="alignleft img-responsive" alt="">
                                    <p</p>
                                    <p></p>
                                    <p></p>
                                    <asp:Label ID="txtNoiDung" runat="server"></asp:Label>
                                    <br />
                                    <a href="#" class="btn btn-info text-center">ĐẶT TOUR NGAY</a>
                                    
                                    <div class="related-post-block">
                                        <!-- related post block -->
                                        <div class="row">
                                            <div class="col-lg-12 col-sm-12 col-md-12 col-sm-12">
                                                <h2 class="related-post-title">Tour Liên Quan</h2>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
                                                <div class="related-post">
                                                    <!-- related post -->
                                                    <div class="related-post-img">
                                                        <a href="#"><img src="../../Content/images/ngu-hanh-son-ivivu.jpg" alt="" class="img-responsive"></a>
                                                    </div>
                                                    <div class="related-post-content">
                                                        <h3 class="related-title"><a href="#" class="title">Tour Du Lịch 1</a></h3>
                                                        <div class="post-meta"><span class="meta-cat">in <a href="#" class="">abc</a> </span></div>
                                                    </div>
                                                </div>
                                                <!-- /.related post -->
                                            </div>
                                            <div class="col-lg-6 col-sm-6 col-md-6 col-xs-12">
                                                <div class="related-post">
                                                    <!-- related post -->
                                                    <div class="related-post-img">
                                                        <a href="#"><img src="../../Content/images/ngu-hanh-son-ivivu.jpg" alt="" class="img-responsive"></a>
                                                    </div>
                                                    <div class="related-post-content">
                                                        <h3 class="related-title"><a href="#" class="title">Tour Du Lịch 1</a></h3>
                                                        <div class="post-meta"><span class="meta-cat">in <a href="#" class="">abc</a> </span></div>
                                                    </div>
                                                </div>
                                                <!-- /.related post -->
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.related post block -->
                                    <div class="post-navigation">
                                        <!-- post navigation -->
                                        <div class="row">
                                            <div class="nav-links">
                                                <div class="col-md-6 col-sm-6">
                                                    <div class="nav-previous">
                                                        <!-- nav previous -->
                                                        <a href="#" class="prev-link">back</a>
                                                        <div class="prev-post">
                                                            <h3><a href="#" class="title">aaaa</a></h3>
                                                        </div>
                                                    </div>
                                                    <!-- /. nav previous -->
                                                </div>
                                                <div class="col-md-6 col-sm-6">
                                                    <div class="nav-next text-right">
                                                        <!-- nav next -->
                                                        <a href="#" class="next-link">next </a>
                                                        <div class="next-post">
                                                            <h3><a href="#" class="title">bbbbbbbbbbb</a></h3>
                                                        </div>
                                                    </div>
                                                    <!-- /.nav previous -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                   
                                    <!-- /.post author -->
                                    <div class="comments-area">
                                        <h2 class="comments-title"> Bình Luận_</h2>
                                        <ul class="comment-list">
                                            <li class="comment">
                                                <div class="comment-body">
                                                    <div class="comment-author"><img src="../../Content/images/user-pic-1.jpg" alt="" class="img-circle"> </div>
                                                    <div class="comment-info">
                                                        <div class="comment-header">
                                                            <div class="comment-meta"><span class="comment-meta-date pull-right">25  2020 </span></div>
                                                            <h4 class="user-title">Mr X/h4>
                                                        </div>
                                                        <div class="comment-content">
                                                            <p>Comment...</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <ul class="childern">
                                                    <li class="comment">
                                                        <div class="comment-body">
                                                            <div class="">
                                                                <div class="comment-author"><img src="../../Content/images/user-pic-2.jpg" alt="" class="img-circle"> </div>
                                                                <div class="comment-info">
                                                                    <div class="comment-header">
                                                                        <div class="comment-meta"><span class="comment-meta-date pull-right">25 2020 </span></div>
                                                                        <h4 class="user-title">XXYZ</h4>
                                                                    </div>
                                                                    <div class="comment-content">
                                                                        <p>Comment...</p>
                                                                    </div>
                                                                    <div class="reply"><a href="#" class="btn-link">Trả Lời</a></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                        
                                        <ul class="comment-list">
                                            <asp:Repeater ID="rptBinhLuan" runat="server">
                                                <ItemTemplate>
                                                   <li class="comment">
                                                    <div class="comment-body">
                                                    <div class="">
                                                        <div class="comment-author"><img src="../../Content/images/user-pic-3.jpg" alt="" class="img-circle"> </div>
                                                        <div class="comment-info">
                                                            <div class="comment-header">
                                                                <div class="comment-meta"><span class="comment-meta-date pull-right"><%# Eval("dThoiGian") %> </span></div>
                                                                <h4 class="user-title"><%# Eval("sTenKhachHang") %></h4>
                                                            </div>
                                                            <div class="comment-content">
                                                                <p><%# Eval("sNoiDung") %></p>
                                                            </div>
                                                            <div class="reply"><a href="#" class="btn-link">Trả Lời</a></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                        
                                    </div>
                                </div>
                                <div class="leave-comments">
                                    <h2 class="reply-title">Bình Luận</h2>
                                    <form class="reply-form" method="post" runat="server">
                                        <div class="row">
                                            <!-- Textarea -->
                                            <asp:HiddenField ID="maTour_" runat="server" />
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label" for="textarea">Comment</label>
                                                    <asp:TextBox ID="txtBinhLuan" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <!-- Button -->
                                                <div class="form-group">
                                                    <asp:Button ID="binhLuan" runat="server" Text="Bình Luận" OnClick="binhLuan_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div style="position:fixed; right:50px; margin-top:15px;">
                    <div class="widget widget-search">
                        <!-- widget search -->
                        <form>
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Search Here" aria-describedby="basic-addon2">
                                <span class="input-group-addon" id="basic-addon2">
                                <i class="fa fa-search"></i></span>
                            </div>
                            <!-- /input-group -->
                        </form>
                    </div>
                    <!-- /.widget search -->
                    <div class="widget widget-categories">
                       
                    </div>
                    <!-- /.widget categories -->
                    <!-- widget start -->
                    <div class="widget widget-recent-post">
                    <asp:Label ID="lableGia" runat="server"></asp:Label>
                        <div runat="server" name="gia" id="gia"></div>
                        <h3 class="widget-title">Đặt Tour </h3>
                        <form class="form-group" method="get" action="DatTour.aspx">
                            <div id="hiddenIdTour" runat="server"></div>
                            <div class="form-inline"><span>Người Lớn:</span> &nbsp &nbsp<input class="form-controll" type="text" id="id1" name="inl" value = "1" style = "width: 40px; border-radius: 4px;">&nbsp &nbsp
 <button type="button" onClick="up();" style="width: 35px; background-color: #ccc; border-radius: 4px;">+</button> <button type="button" onclick="dow();"  style="width: 35px; background-color: #ccc; border-radius: 4px;">-</button></div>
 <br />
                            <div class="form-inline"><span>Trẻ Em:</span> &nbsp &nbsp &nbsp &nbsp &nbsp<input type="text" id="id2" name="ite" value = "0" style = "width: 40px; border-radius: 4px;" class="form-controll">&nbsp &nbsp
 <button type="button" onClick="up2();" style="width: 35px; background-color: #ccc; border-radius: 4px;">+</button> <button type="button" onclick="dow2();"  style="width: 35px; background-color: #ccc; border-radius: 4px;">-</button></div>
                            <div id="tongTien" style="color:red; font-size:25px; margin: 10px;"></div>
 <input type="submit" name="" value="Đặt Vé" style="">
                    
                        </form>
                        
                        </div>
                    </div>
                   <!-- <div class="widget widget-recent-post">
                       
                        
                        <h3 class="widget-title">TOUR</h3>
                        <ul class="listnone widget-recent-post">
                            <li>
                                <div class="row">
                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                        <div class="recent-post-img">
                                            <a href="#"><img src="../../Content/images/ngu-hanh-son2-ivivu.jpg" alt=""></a>
                                        </div>
                                    </div>
                                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
                                        <div class="recent-post-content">
                                            <h3 class="recent-title"><a href="#" class="title">bootstrap responsive design templates free download</a></h3>
                                            <i class="fa fa-calendar-check-o" style="font-size: 20px;"></i>
                                            <div class="meta" style="display: inline-block;">
                                                <span class="meta-date" >22 Jan, 2020</span>
                                            </div>
                                            <br>
                                                 <i class="fa fa-cart-plus" style="font-size: 24px;"></i>
                                            <div class="meta" style="display: inline-block;">
                                                <span class="meta-date" style="display: inline-block;"><strike>449.000k</strike></span>
                                                <span class="meta-date"><p style="color: green;">449.000k</p></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>

                             <li> <!--
                                <div class="row">
                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                        <div class="recent-post-img">
                                            <a href="#"><img src="../../Content/images/ngau-hanh-son-ivivu.jpg" alt=""></a>
                                        </div>
                                    </div>
                                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
                                        <div class="recent-post-content">
                                            <h3 class="recent-title"><a href="#" class="title">bootstrap responsive design templates free download</a></h3>
                                            <i class="fa fa-calendar-check-o" style="font-size: 20px;"></i>
                                            <div class="meta" style="display: inline-block;">
                                                <span class="meta-date" >22 Jan, 2020</span>
                                            </div>
                                            <br>
                                                 <i class="fa fa-cart-plus" style="font-size: 24px;"></i>
                                            <div class="meta" style="display: inline-block;">
                                                <span class="meta-date" style="display: inline-block;"><strike>449.000k</strike></span>
                                                <span class="meta-date"><p style="color: green;">449.000k</p></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            
                        </ul>
                    </div> -->
                    <!-- /.widget recent post -->
                 
                    
                </div>
            </div>
        </div>
    
    </asp:Content>