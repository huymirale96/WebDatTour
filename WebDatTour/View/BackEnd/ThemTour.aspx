<%@ Page Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="ThemTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.ThemTour" %>
<%@ Register Namespace="CKEditor.NET" Assembly="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="cotent1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .marginL{ margin-left: 20px;}
    </style>
<div class="row">
    <div class="col-md-12">
        <h1 class="page-header">Thêm Tour
                            <small>Add</small>
        </h1>
         <div id="notification_" runat="server"></div>
    </div>
    <!-- /.col-lg-12 -->
    <div class="col-md-12">
        <div class="container-fluid">
            <form action="" enctype="multipart/form-data" method="POST" runat="server">
                <div class="row">
                    <div class="col-md-5 col-md-offset-1">
                        <div class="form-group">
                            <label>Tiêu Đề Tour:</label>
                            <asp:TextBox ID="txtTieuDe" runat="server" CssClass="form-control" placeholder="Tiêu Đề" TextMode="MultiLine" Rows="5"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="R1" runat="server"
         ErrorMessage="*" ValidationExpression="^.{0,99}$"
        ControlToValidate="txtTieuDe"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator id="req"  runat="server" ControlToValidate="txtTieuDe" ErrorMessage="*">
</asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <label>Số Ngày Đi:</label>
                            <asp:TextBox ID="txtSoNgayDi" runat="server" CssClass="form-control" placeholder="" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqsnd" runat="server" ControlToValidate="txtSoNgayDi"  ErrorMessage="*" ForeColor="#ff3300"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <label>Số Chỗ</label>
                           <asp:TextBox ID="txtSoCho" runat="server" CssClass="form-control isNumberic" placeholder="" TextMode="number"   value="0"></asp:TextBox>
                             <asp:rangevalidator Type="Integer" ID="Rangevalidator2" errormessage="*" forecolor="Red" controltovalidate="txtSoCho" minimumvalue="0" maximumvalue="99999999" runat="server">
            </asp:rangevalidator>
                           
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
                            <label>Nơi Khởi Hành</label>
                            <asp:TextBox ID="txtnoiKhoiHanh" runat="server" CssClass="form-control" placeholder="" ></asp:TextBox>
                              <asp:RequiredFieldValidator id="RequiredFieldValidator1"  runat="server" ControlToValidate="txtnoiKhoiHanh" ErrorMessage="*">
</asp:RequiredFieldValidator>
                        </div>
                         <div class="form-group">
                            <label>Nhóm Tour</label>
                            <asp:DropDownList ID="ddlNhomTour" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        
                        
                        <div class="form-group" style="width: 180px; float: left">
                            <label>Giá vé Người Lớn</label>

                            <asp:TextBox ID="txtGIaNL" runat="server" CssClass="form-control isNumberic" placeholder="" TextMode="Number" Type="Integer"  value="0"></asp:TextBox>
                          
                            
                        <div class="form-group"  style="width: 180px; float: right">
                            <label>Giá vé Người Lớn Giảm</label>
                            <asp:rangevalidator ID="tGiaNLgidam" errormessage="*" forecolor="Red" ControlToValidate="txtGIaNL" minimumvalue="0"  maximumvalue="99999999" runat="server" >
            </asp:rangevalidator>
                            <asp:TextBox ID="txtGiaNLgiam" runat="server" CssClass="form-control isNumberic" placeholder="" TextMode="Number" Type="Integer" value="0"></asp:TextBox>
                             <asp:CompareValidator  ID="CompareValidator1" runat="server" forecolor="Red"  ControlToValidate="txtGiaNLgiam" ControlToCompare="txtGIaNL" ErrorMessage="Giá GIảm Phải Nhở Hơn." Operator="LessThan" Type="Integer"></asp:CompareValidator>
                            
                            </div>
                        </div>
                        <div class="form-group" style="width: 180px; float: left">
                            <label>Giá Vé Trẻ Em</label>
                             <asp:rangevalidator ID="txtGiaTsE" errormessage="*" forecolor="Red" controltovalidate="txtGiaTE" minimumvalue="0"  maximumvalue="99999999" runat="server" >
            </asp:rangevalidator>
                            <asp:TextBox ID="txtGiaTE" runat="server" CssClass="form-control marginL isNumberic" placeholder="" TextMode="Number" Type="Integer" value="0"></asp:TextBox>
                           
                            <div class="form-group" style="width: 180px; float: right">
                            <label>Giá Vé Trẻ Em Giảm</label>
                                 <asp:rangevalidator ID="txssaatGiaTEgiams" errormessage="*" forecolor="Red" controltovalidate="txtGiaTEgiam" minimumvalue="0"  maximumvalue="99999999" runat="server">
            </asp:rangevalidator>
                            <asp:TextBox ID="txtGiaTEgiam" runat="server" CssClass="form-control marginL isNumberic" placeholder="" TextMode="Number" Type="Integer" value="0"></asp:TextBox>
                            <asp:CompareValidator  ID="re34" runat="server" forecolor="Red"  ControlToValidate="txtGiaTEgiam" ControlToCompare="txtGiaTE" ErrorMessage="Giá GIảm Phải Nhở Hơn." Operator="LessThan" Type="Integer"></asp:CompareValidator>
                                   </div>
                            <div class="form-group" style="width: 180px; float: right">
                            <label>Ngày Khởi Hành</label>
                            <asp:TextBox ID="txtNKH1" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="r3" runat="server" ControlToValidate="txtNKH1" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtNKH2" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>
                                <asp:TextBox ID="txtNKH3" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>
                                <asp:TextBox ID="txtNKH4" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>
                                <asp:TextBox ID="txtNKH5" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>
                                <asp:TextBox ID="txtNKH6" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>  
                        </div>
                        </div>
                        
                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-offset-1 col-md-10">
                        <div class="form-group">
                            <label>Mô Tả Tour:</label>
                            <CKEditor:CKEditorControl ID="txtMoTaTour" runat="server" Height="400" CssClass="form-control"></CKEditor:CKEditorControl>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMoTaTour" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>

                        <asp:button ID="btnDangKi" runat="server" CssClass="btn btn-default btn-md" Text="Thêm Tour" OnClick="btnDangKi_Click"></asp:button>
                      
                         <a href="themtour.aspx" class="btn btn-default">RESET</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>
</asp:Content>
<asp:Content ID="cnt2" ContentPlaceHolderID="script" runat="server" >
    <div id="notification" runat="server"></div>
</asp:Content>
