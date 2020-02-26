<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="ThongTinNhanVien.aspx.cs" Inherits="WebDatTour.View.BackEnd.ThongTinNhanVien" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <form  method="post" runat="server">
        <div class="row mb30">
            <br />
            <h1 class="mt20" style="margin-left: 126px;">THÔNG TIN NHÂN VIÊN</h1>
            <br />
            <div class="col-md-offset-1 col-md-5">
                <h3 runat="server" id="txtTen">TÊN KHÁCH HÀNG: Ngo Dang huy</h3>
                <h3 runat="server" id="txtSDT">SỐ ĐIỆN THOẠI: Ngo Dang huy</h3>
                <h3 runat="server" id="txtGT">EMAIL: Ngo Dang huy  sdsadsa</h3>
                <h3 runat="server" id="txtQuyen">EMAIL: Ngo Dang huy  sdsadsa</h3>
            </div>
            <div class="col-md-5">
                <h3 runat="server" id="txtDN">TÊN ĐĂNG NHẬP: Ngo Dang huy</h3>
                <h3 runat="server" id="txtDC">ĐỊA CHỈ: Ngo Dang huy</h3>
                <h3 runat="server" id="txtNS">NGÀY SINH: Ngo Dang huy</h3>

            </div>
        </div>
        <br />
        <div class="row" style="margin-bottom: 100px;">
            <div class="col-md-offset-2 col-md-7">

                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card overflowhidden number-chart">
                        <div class="body" style="text-align: center;">
                            <button type="button" id="addInventory" class="btn btn-success" style="border-radius: 3px; background-color: brown; display: inline; margin-right: 30px;">Cập Nhật Thông Tin</button>                    <asp:Label ID="noti" runat="server" CssClass="text-info"></asp:Label>
                        <asp:Label ID="notil" runat="server" CssClass="text-info"></asp:Label>
                        </div>

                    </div>
                </div>
                </div>
            </div>
                <br />
                <div class="row clearfix" id="contentAddInventory" style="display: none;">
                   <div class="col-md-offset-1 col-md-11">
                            <br />
                            <div class="header">
                                <h2>THông Tin</h2>
                            </div>
                            <div class="body">

                               <div class="row">
                    <div class="col-md-5 col-md-offset-1">
                        <div class="form-group">
                            <label>Họ Và Tên</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="NguyenVanA"></asp:TextBox>
                        </div>
                     
                        <div class="form-group">
                            <label>Địa Chỉ</label>
                            <asp:TextBox ID="queQuan" runat="server" CssClass="form-control" placeholder="" ></asp:TextBox>
                        </div>
                     
                        <asp:button ID="btnDangKi" runat="server" onclick="btnDangKi_Click" CssClass="btn btn-default btn-md" Text="Cập Nhật Thông Tin"></asp:button>
                        <button type="reset" class="btn btn-default">Reset</button>
                       
                    </div>
                    <div class="col-md-5 col-md-offset-0">
                        <div class="form-group">
                            <label>Số Điện Thoại</label>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="" ></asp:TextBox>
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
                                    </div>
                                
                                   
                                
                                <br>

                               
   
 </div>
    </div>
       
       
     </form>
</asp:Content>
