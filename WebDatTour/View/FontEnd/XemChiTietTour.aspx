<%@ Page Language="C#" MasterPageFile="~/Layout/FontEnd.Master" AutoEventWireup="true" CodeBehind="XemChiTietTour.aspx.cs" Inherits="WebDatTour.View.FontEnd.XemChiTietTour" %>
<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" ID="content1" runat="server"> 
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-4" style="float:right;">
                   <!-- <div style="position:fixed; right:50px; margin-top:15px;"> -->
                    <div>
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
                        <input type="hidden" id="soChoToiDa"/>
                        <form class="form-group" method="get" action="DatTour.aspx"  id="formDatTour">
                            <div id="ngaydi" runat="server"></div>
                            <div id="hiddenIdTour" runat="server"></div>
                            <div class="form-inline"><span>Người Lớn:</span> &nbsp &nbsp<input class="form-controll" type="text" id="id1" name="inl" value = "1" style = "width: 40px; border-radius: 4px;">&nbsp &nbsp
 <button class="btnUpDow" type="button" onClick="up();" style="width: 35px; background-color: #ccc; border-radius: 4px;">+</button> <button type="button" class="btnUpDow" onclick="dow();"  style="width: 35px; background-color: #ccc; border-radius: 4px;">-</button></div>
 <br />
                            <div class="form-inline"><span>Trẻ Em:</span> &nbsp &nbsp &nbsp &nbsp &nbsp<input type="text" id="id2" name="ite" value = "0" style = "width: 40px; border-radius: 4px;" class="form-controll">&nbsp &nbsp
 <button type="button" class="btnUpDow" onClick="up2();" style="width: 35px; background-color: #ccc; border-radius: 4px;">+</button> <button class="btnUpDow" type="button" onclick="dow2();"  style="width: 35px; background-color: #ccc; border-radius: 4px;">-</button></div>
                            <div id="tongTien" style="color:red; font-size:25px; margin: 10px;"></div>
                            <div id="thongBaoSoCho" class="text-success"></div>
 <input type="button" onclick=" kiemTraDangNhap();" name="" value="Đặt Vé" style="">
                    
                        </form>
                        
                        </div>
                    </div>
                   
                 
                    
                </div>
                <div class="col-lg-8 col-md-8">
                    <div class="roww">
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
                                    <li data-target="#myCarousel2" data-slide-to="<%# Container.ItemIndex %>"></li>
                                
                                </ItemTemplate>
                                </asp:Repeater>
        </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
                                <asp:Repeater ID="rpt2" runat="server">
                                <ItemTemplate>
                                     <div class="post-img item <%# Container.ItemIndex == 0 ? "active" : "" %>">

                                         <img  style="width:100%; height: 400px;" src="../../Upload/<%# Eval("sDuongDan") %> " />
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
                                    <div class="post-header text-center">
                                        <h1>-----------------------------</h1>
                                       
                                    </div>
                                   
                                    <p> </p>
                                    <div id="anhDD" runat="server" class="text-center"></div>
                                    <div class="row">
                                        <div class="col-md-10">
                                            <label>Thông Tin Tour</label>
                                            <table class="table table-border" style="margin:15px;">
                                                <tr>
                                                    <td>Nơi Khởi Hành: </td>
                                                    <td runat="server" id="txtNKH"></td>
                                                    
                                                </tr>
                                                <tr>
                                                    <td>Tổng Thời Gian Của Tour: </td>
                                                    <td runat="server" id="txtTG"></td>
                                                    
                                                </tr>
                                                <tr>
                                                    <td>Ngày Khởi Hành: </td>
                                                    <td runat="server" id="txtNgay"><select></select></td>
                                                    
                                                </tr>
                                                <tr>
                                                    <td>Giá Người Lớn(từ 16T trở lên): </td>
                                                    <td runat="server" id="txtNL"></td>
                                                    
                                                </tr>
                                                 <tr>
                                                    <td>Giá Trẻ Em: (từ 16T trở xuống): </td>
                                                    <td runat="server" id="txtTE"></td>
                                                    
                                                </tr>
                                                 <tr>
                                                    <td>Đánh Giá: </td>
                                                    <td runat="server" id="txtDanhGia"></td>
                                                    
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
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
                                            <div class="col-md-12">
                                                <div class="carousel slide" data-ride="carousel" data-type="multi" data-interval="3000" id="myCarousel">
  <div class="carousel-inner">

      <asp:repeater  ID="rptTourLienQuan" runat="server">
          <ItemTemplate>

          
    <div class="item <%# Container.ItemIndex == 0 ? "active" : "" %> ">
  <div class="related-post col-md-5">
                                                    <!-- related post -->
                                                    <div class="related-post-img">
                                                        <a href="#"><img src="../../Upload/<%# Eval("surlanh") %>" alt="" style=" height: 163px;" class="img-responsive"></a>
                                                    </div>
                                                    <div class="related-post-content">
                                                        <h3 class="related-title"><a href="xemchitiettour.aspx?id=<%# Eval("imatour") %>" class="title"><%# Eval("stieude") %></a></h3>
                                                        
                                                    </div>
                                                </div>
    </div>
              </ItemTemplate>
      </asp:repeater>
    
 
   
  </div>
  <a class="left carousel-control" href="#myCarousel" data-slide="prev"><i class="glyphicon glyphicon-chevron-left"></i></a>
  <a class="right carousel-control" href="#myCarousel" data-slide="next"><i class="glyphicon glyphicon-chevron-right"></i></a>
</div>
</div>

                                        </div>
                                    </div>
                                   
                                   
                                    <!-- /.post author -->
                                    <div class="comments-area">
                                        <h2 class="comments-title"> Đánh Giá</h2>
                                     
  <div class="modal fade" id="modalSuaBinhLuan" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" style="margin-top: 30px;">Sửa Bình Luận</h4>
        </div>
        <div class="modal-body" id="suablDiv">
          <div class="container">
                <div class="row">
                    <div class="col-md-11">

        <div class="starrating risingstar d-flex justify-content-center flex-row-reverse" style="display:inline; margin-right: 50px;">
            <input type="radio" id="star5" name="rating" value="5" /><label for="star5" title="5 star">5</label>
            <input type="radio" id="star4" name="rating" value="4" /><label for="star4" title="4 star">4</label>
            <input type="radio" id="star3" name="rating" value="3" /><label for="star3" title="3 star">3</label>
            <input type="radio" id="star2" name="rating" value="2" /><label for="star2" title="2 star">2</label>
            <input type="radio" id="star1" name="rating" value="1" /><label for="star1" title="1 star">1</label>
          
        </div>
                        <textarea  placeholder="Đánh Giá Về Tour" id="txtDanhGiaTour" rows="3" class="form-control" style="width: auto;" cols="50"></textarea>
                          <div id="divbtndanhgia"></div>
  </div>

        </div>
          
                    </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
                                        <ul class="comment-list" id="listCommnent_">
                                            <asp:Repeater ID="rptBinhLuan" runat="server">
                                                <ItemTemplate>
                                                   <li class="comment">
                                                    <div class="comment-body">
                                                    <div class="">
                                                        <div class="comment-author"><img src="../../Content/images/user-pic-3.jpg" alt="" class="img-circle"> </div>
                                                        <div class="comment-info">
                                                            <div class="comment-header">
                                                                <div class="comment-meta"><span class="comment-meta-date pull-right"><%# Eval("dThoiGian", "{0:dd/MM/yyyy HH:mm:ss}") %> </span></div>
                                                                <h4 class="user-title" style="display: inline;"><%# Eval("sTenKhachHang") %></h4><label onclick="anDanhGia(<%# Eval("iMaDanhGia") %>)" style="display: <%# HttpContext.Current.Session["maNV"].ToString().Equals("") ? "none" : ""%>" class="label label-<%# Eval("btrangthai").ToString().Equals("True") ? "success" : "warning" %> "><%# Eval("btrangthai").ToString().Equals("False") ? "Ẩn" : "Hiện" %></label> 
                                                            </div>
                                                            <div class="comment-content">
                                                                <%# hienSao(Eval("isosao").ToString()) %>
                                                                <br />
                                                                <p id="bl_<%# Eval("iMaDanhGia") %>"><%# Eval("sNoiDung") %></p>
                                                            </div>
                                                            <div style="margin: 20px;"><%# ktrasuaDanhGia(Eval("iMaDanhGia").ToString(),Eval("imadondattour").ToString(),Eval("isosao").ToString()) %></div>
                                                            <!--<div class="reply"><a href="#" class="btn-link">Trả Lời</a></div> -->
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                        
                                    </div>
                                </div>
                              <!--  <-% if(!HttpContext.Current.Session["maKH"].ToString().Equals("")) { %->    -->
                                <% if(1 ==2 ) { %>
                                <div id="matourhidden" runat="server"></div>
                                <div class="leave-comments">
                                    <h2 class="reply-title">Bình Luận</h2>
                                    <form class="reply-form" method="post" runat="server">
                                        <div class="row">
                                            <!-- Textarea -->
                                            <asp:HiddenField ID="maTour_" runat="server" />
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="control-label" for="textarea">Comment</label>
                                                    <textarea class="form-control" id="txtBinhLuan_" name="textarea" rows="3"></textarea>
                                                   <!-- <asp:TextBox ID="txtBinhLuan" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>-->
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <!-- Button -->
                                                <div class="form-group">
                                                   <!-- <asp:Button ID="binhLuan" runat="server" Text="Bình Luận" OnClick="binhLuan_Click" />-->
                                                <label id="btnBinhLuan_" class="label label-default">Đánh Giá</label>
                                                    <div id="notiCmt"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    
    </asp:Content>