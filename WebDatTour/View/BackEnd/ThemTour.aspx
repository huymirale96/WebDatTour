<%@ Page Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="ThemTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.ThemTour" %>
<%@ Register Namespace="CKEditor.NET" Assembly="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="cotent1" ContentPlaceHolderID="MainContent" runat="server">
<div class="row">
    <div class="col-md-12">
        <h1 class="page-header">Thêm Tour
                            <small>Add</small>
        </h1>
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
                        </div>
                        <div class="form-group">
                            <label>Số Ngày Đi:</label>
                            <asp:TextBox ID="txtSoNgayDi" runat="server" CssClass="form-control" placeholder="" ></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Số Chỗ</label>
                           <asp:TextBox ID="txtSoCho" runat="server" CssClass="form-control" placeholder="" TextMode="number"   value="0"></asp:TextBox>
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
                        </div>
                         <div class="form-group">
                            <label>Nhóm Tour</label>
                            <asp:DropDownList ID="ddlNhomTour" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        
                        
                        <div class="form-group" style="width: 180px; float: left">
                            <label>Giá vé Người Lớn</label>

                            <asp:TextBox ID="txtGIaNL" runat="server" CssClass="form-control" placeholder="" TextMode="Number"  value="0"></asp:TextBox>
                            <asp:rangevalidator ID="Rangevalidator1" errormessage="*" forecolor="Red" controltovalidate="txtGIaNL" minimumvalue="0" maximumvalue="99999999" runat="server">
            </asp:rangevalidator>
                        </div>
                        <div class="form-group"  style="width: 180px; float: right">
                            <label>Giá vé Giảm</label>
                            <asp:TextBox ID="txtGiaNLgiam" runat="server" CssClass="form-control" placeholder="" TextMode="Number"  value="0"></asp:TextBox>
                            <asp:rangevalidator ID="tGiaNLgidam" errormessage="*" forecolor="Red" controltovalidate="txtGIaNL" minimumvalue="0"  maximumvalue="99999999" runat="server" >
            </asp:rangevalidator>
                        </div>
                        <div class="form-group" style="width: 180px; float: left">
                            <label>Giá Vé Trẻ Em</label>

                            <asp:TextBox ID="txtGiaTE" runat="server" CssClass="form-control" placeholder="" TextMode="Number"  value="0"></asp:TextBox>
                            <asp:rangevalidator ID="txtGiaTsE" errormessage="*" forecolor="Red" controltovalidate="txtGiaTE" minimumvalue="0"  maximumvalue="99999999" runat="server" >
            </asp:rangevalidator>
                            <div class="form-group" style="width: 180px; float: right">
                            <label>Ngày Khởi Hành</label>
                            <asp:TextBox ID="txtNKH1" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>
                            <asp:TextBox ID="txtNKH2" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>
                                <asp:TextBox ID="txtNKH3" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>
                                <asp:TextBox ID="txtNKH4" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>
                                <asp:TextBox ID="txtNKH5" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>
                                <asp:TextBox ID="txtNKH6" runat="server" CssClass="form-control margin4px" placeholder="" TextMode="Date" ></asp:TextBox>  
                        </div>
                        </div>
                        <div class="form-group" style="width: 180px; float: right">
                            <label>Giá Vé Trẻ Em Giảm</label>
                            <asp:TextBox ID="txtGiaTEgiam" runat="server" CssClass="form-control" placeholder="" TextMode="Number"  value="0"></asp:TextBox>
                             <asp:rangevalidator ID="txssaatGiaTEgiams" errormessage="*" forecolor="Red" controltovalidate="txtGiaTEgiam" minimumvalue="0"  maximumvalue="99999999" runat="server">
            </asp:rangevalidator>
                            
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-offset-1 col-md-10">
                        <div class="form-group">
                            <label>Mô Tả Tour:</label>
                            <CKEditor:CKEditorControl ID="txtMoTaTour" runat="server" Height="400" CssClass="form-control"></CKEditor:CKEditorControl>
                        </div>
                        <asp:button ID="btnDangKi" runat="server" CssClass="btn btn-default btn-md" Text="Đăng Kí" OnClick="btnDangKi_Click"></asp:button>
                        <input type="reset" class="btn btn-default" value="RESET"/>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>
</asp:Content>