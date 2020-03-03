<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostBack="true" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="SuaTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.SuaTour" %>
<%@ Register Namespace="CKEditor.NET" Assembly="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="cotent1" ContentPlaceHolderID="MainContent" runat="server">
<div class="row">
    <div class="col-md-12">
        <h1 class="page-header">Sửa Tour
                            <small>EDIT</small>
        </h1>
    </div>
    <!-- /.col-lg-12 -->
    <div class="col-md-12">
        <div class="container-fluid">
            <form method="POST" runat="server">
                <asp:HiddenField ID="txtMaTour" runat="server" />
                <div class="row">
                    <div class="col-md-5 col-md-offset-1">
                        <div class="form-group">
                            <label>Tiêu Đề Tour:</label>
                            <asp:TextBox ID="txtTieuDe" runat="server" CssClass="form-control" placeholder="Tiêu Đề"></asp:TextBox>
                            
                        </div>
                        <div class="form-group">
                            <label>Số Ngày Đi:</label>
                            <asp:TextBox ID="txtSoNgayDi" runat="server" CssClass="form-control" placeholder="" ></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1"  ControlToValidate="txtSoNgayDi" ErrorMessage="*" ForeColor="Red" runat="server" CssClass="valerror" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <label>Số Chỗ</label>
                           <asp:TextBox ID="txtSoCho" runat="server" CssClass="form-control" placeholder="" TextMode="number" ></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2"  ControlToValidate="txtSoCho" ErrorMessage="*" ForeColor="Red" runat="server" CssClass="valerror" ></asp:RequiredFieldValidator>
                       <asp:RangeValidator ID="da" runat="server" MaximumValue="999999999"  MinimumValue="1"  Type="Integer" ControlToValidate="txtSoCho" ErrorMessage="*"></asp:RangeValidator>
                            </div>
                        <div class="form-group">
                            <label>Hình Ảnh Bìa</label>
                            <asp:FileUpload ID="fAnhBia" runat="server" ></asp:FileUpload>
                        </div>
                        <div class="form-group">
                            <label>Hình Ảnh Mô Tả</label>
                            <input type="file" multiple="multiple" name="File1" id="File1" accept="image/*" />
                        </div>
         
                    </div>
                    <div class="col-md-5 col-md-offset-0">
                        <div class="form-group">
                            <label>Nơi Khởi Hành: </label>
                          <asp:TextBox ID="txtNoiKhoiHanh" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                            </div>
                        <div class="form-group">
                            <label>Nhóm Tour: </label>
                           <asp:DropDownList ID="ddlNhomtour" runat="server" CssClass="form-control"></asp:DropDownList>

                            </div>
                        
                        
                        <div class="form-group" style="width: 180px; float: left">
                            <label>Giá vé Người Lớn</label>
                            <asp:TextBox ID="txtGIaNL" runat="server" CssClass="form-control" placeholder="" TextMode="Number"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3"  ControlToValidate="txtGIaNL" ErrorMessage="*" ForeColor="Red" runat="server" CssClass="valerror" ></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" MaximumValue="999999999"  MinimumValue="2"  Type="Integer" ControlToValidate="txtGIaNL" ErrorMessage="*"></asp:RangeValidator>            
                            </div>
                        <div class="form-group"  style="width: 180px; float: right">
                            <label>Giá vé Giảm</label>
                            <asp:TextBox ID="txtGiaNLgiam" runat="server" CssClass="form-control" placeholder="" TextMode="Number"></asp:TextBox>
                        <asp:RangeValidator ID="RangeValidator2" runat="server" MaximumValue="999999999"  MinimumValue="2"  Type="Integer" ControlToValidate="txtGiaNLgiam" ErrorMessage="*"></asp:RangeValidator>
                            </div>
                        <div class="form-group" style="width: 180px; float: left">
                            <label>Giá Vé Trẻ Em</label>
                            <asp:TextBox ID="txtGiaTE" runat="server" CssClass="form-control" placeholder="" TextMode="Number"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4"  ControlToValidate="txtGiaTE" ErrorMessage="*" ForeColor="Red" runat="server" CssClass="valerror" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group" style="width: 180px; float: right">
                            <label>Giá Vé Trẻ Em Giảm</label>
                            <asp:TextBox ID="txtGiaTEgiam" runat="server" CssClass="form-control" placeholder="" TextMode="Number"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator5"  ControlToValidate="txtGiaTEgiam" ErrorMessage="*" ForeColor="Red" runat="server" CssClass="valerror" ></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="row">
                     
                    <asp:HiddenField ID="anhtour" runat="server" />
                    <asp:Repeater ID="rptDSanh" runat="server" OnItemDataBound="rptDSanh_ItemDataBound" OnItemCommand="rptDSanh_ItemCommand">
                        <ItemTemplate> 
                            <div class="col-md-2" style="padding: 10px;">
                                <div style="width: 100%; height: 200px;">
                        <image src="../../Upload/<%# Eval("url") %>" class="img-responsive" ></image>
                                    </div>
                             <div class="text-center" style="margin-bottom:15px; margin-top: 15px;">
                                  <asp:FileUpload ID="FileAnh" runat="server" CssClass="MakeButtonHidden" />
                             </div>
                            </div>   
                            
                           
                        </ItemTemplate>
                    </asp:Repeater>
                    
                    
                   
                    
                </div>
                <div class="row">
                    <div class="col-md-offset-1 col-md-10">
                        <div class="form-group">
                            <label>Mô Tả Tour:</label>
                            <CKEditor:CKEditorControl ID="txtMoTaTour" runat="server" Height="400" CssClass="form-control"></CKEditor:CKEditorControl>
                        </div>
                        <asp:button ID="btnSuaTour" runat="server" CssClass="btn btn-default btn-md" Text="Sửa" OnClick="btnSuaTour_Click"></asp:button>
                        <input type="reset" class="btn btn-default" value="RESET"/>
                    </div>
                    <asp:HiddenField ID="matour" runat="server" />
                     </form>
                    <div class="col-md-offset-1 col-md-10">
                        <h3 style="margin: 20px;">Thêm Ngày Khởi Hành</h3>
                         <div class="col-md-3">
                     <!---->
                             <div id="idt_" runat="server"></div>
                             <label for="txtNgayDiThem">Ngày Khởi Hành: </label>
                             <input type="date" class="form-control" id="txtNgayDiThem" style="display: inline; margin-right:20px;" value="2020-03-04"/>
                             
                           
                            
                             </div>
                        <div class="col-md-3">
                            <label for="txtNgayDiThem">Hạn Đặt Vé: </label>
                             <input type="date" class="form-control" id="txtHanDat" style="display: inline; margin-right:20px;"  value="2020-03-04"/>
                        </div>
                        <div class="col-md-3">
                            <br />
                              <label class="label label-default" id="btnThemNgay">Thêm Ngày </label>
                        </div>
                        
                        <table class="table table-hover" style="margin-top:25px">
                            <thead>
                                <tr>
                                    <th>STT</th><th>Thời Gian Khởi Hành</th><th>Hạn Đặt Tour</th><th>Trạng Thái</th>
                                </tr>
                            </thead>
                            <tbody id="bodyThoiGian">
                                <asp:Repeater ID="rpt1" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            
                                            <td class="text-center"><%# Container.ItemIndex+1 %></td>
                                            <td class="text-center"><%# Eval("dThoiGian","{0:dd-MM-yyyy}") %></td>
                                            <td class="text-center"><%# Eval("dHanDatTour","{0:dd-MM-yyyy}") %></td>
                                            <td class="text-center"><a href="SuaTour.aspx/?chucNang=cn1&tg=<%# Eval("iMaThoiGian") %>&tour=<%# Eval("iMaTour") %>"></a><label onclick="anhienthoigian(<%# Eval("iMaThoiGian") %>,<%# Eval("iMaTour") %>)" class="label label-<%# Eval("trangThai").ToString().Equals("True") ? "success" : "warning" %>"><%# anHien(Eval("trangThai").ToString())%></label></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                         
                    </div>
               </div>
         
        </div>
    </div>


</asp:Content>
