<%@ Page Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="ThemNhanVien.aspx.cs" Inherits="WebDatTour.View.BackEnd.ThemNhanVien" %>
<asp:Content ID="cotent1" ContentPlaceHolderID="MainContent" runat="server">
<div class="row">
    <div class="col-md-12">
        <h1 class="page-header">Thêm Nhân Viên
                            <small>Add</small>
        </h1>
    </div>
    <!-- /.col-lg-12 -->
    <div class="col-md-12">
        <div class="container-fluid">
            <form action="" method="POST" runat="server">
                <div class="row">
                    <div class="col-md-5 col-md-offset-1">
                        <div class="form-group">
                            <label>Họ Và Tên</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="NguyenVanA"></asp:TextBox>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator1"  ControlToValidate="txtName" ErrorMessage="*" ForeColor="Red" runat="server" CssClass="valerror" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <label>Tên Đăng Nhập</label>
                            <asp:TextBox ID="txtTenDangNhap" runat="server" CssClass="form-control" placeholder="" ></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator52"  ControlToValidate="txtTenDangNhap" ErrorMessage="*" ForeColor="Red" runat="server" CssClass="valerror" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <label>Mật Khẩu</label>
                           <asp:TextBox ID="txtMK" runat="server" CssClass="form-control" placeholder="" TextMode="Password" ></asp:TextBox>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator4"  ControlToValidate="txtMK" ErrorMessage="*" ForeColor="Red" runat="server" CssClass="valerror" ></asp:RequiredFieldValidator>
                                 <asp:RegularExpressionValidator ID="regex" runat="server" ControlToValidate="txtMK" ErrorMessage="Mật Khẩu Ít Nhất 8 Ký Tự Bao Gồm 1 Chữ Và 1 Số." ForeColor="Red"  ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"></asp:RegularExpressionValidator>
                            </div>
                        <div class="form-group">
                            <label>Quê Quán</label>
                            <asp:TextBox ID="queQuan" runat="server" CssClass="form-control" placeholder="" ></asp:TextBox>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator2"  ControlToValidate="queQuan" ErrorMessage="*" ForeColor="Red" runat="server" CssClass="valerror" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <label>User Level</label>
                            <br>
                            <label class="radio-inline">
                                <asp:RadioButton ID="rdoAdmin" runat="server" GroupName="quyen" />Admin
                            </label>
                            <label class="radio-inline">
                                <asp:RadioButton ID="rdoMember" runat="server" GroupName="quyen" checked="true" /> Member
                            </label>
                        </div>
                        <asp:button ID="btnDangKi" runat="server" OnClick="btnDangKi_Click" CssClass="btn btn-default btn-md" Text="Đăng Kí"></asp:button>
                        <button type="reset" class="btn btn-default">Reset</button>
                        <br />
                        <asp:Label runat="server" ID="noti" CssClass="text-info" Text=""></asp:Label>
                    </div>
                    <div class="col-md-5 col-md-offset-0">
                        <div class="form-group">
                            <label>Số Điện Thoại</label>
                            <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control" placeholder="" ></asp:TextBox>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator3"  ControlToValidate="txtSDT" ErrorMessage="*" ForeColor="Red" runat="server" CssClass="valerror" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <label>Ngày Sinh</label>
                            <asp:TextBox ID="txtNgaySinh" runat="server" CssClass="form-control" placeholder="" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Giới Tính</label>
                            <br>
                            <label class="radio-inline">
                                <asp:RadioButton ID="rdoNam" runat="server" GroupName="quyen1" checked="true"/>Nam
                            </label>
                            <label class="radio-inline">
                                <asp:RadioButton ID="rdoNu" runat="server" GroupName="quyen1" /> Nữ
                            </label>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>
</asp:Content>