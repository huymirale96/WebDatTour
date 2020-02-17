<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/FontEnd.Master" AutoEventWireup="true" CodeBehind="ThongTinKhachHang.aspx.cs" Inherits="WebDatTour.View.BackEnd.ThongTinKhachHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="row mb30"> <br /><h1 class="mt20" style="margin-left:126px;">THÔNG TIN KHÁCH HÀNG</h1><br />
                            <div class="col-md-offset-1 col-md-5">
                             <h3>TÊN KHÁCH HÀNG: Ngo Dang huy</h3>
                                <h3>SỐ ĐIỆN THOẠI: Ngo Dang huy</h3>
                                <h3>EMAIL: Ngo Dang huy  sdsadsa</h3>
                           </div>
                            <div class="col-md-5">
                                 <h3>TÊN ĐĂNG NHẬP: Ngo Dang huy</h3>
                                <h3> ĐỊA CHỈ: Ngo Dang huy</h3>
                                <h3>NGÀY SINH: Ngo Dang huy</h3>
                    
                        </div>
        </div>
    <br />
    <div class="row" style="margin-bottom: 100px;">
        <div class="col-md-offset-2 col-md-7">
            
<div class="col-lg-3 col-md-6 col-sm-6">
        <div class="card overflowhidden number-chart">
            <div class="body" style="text-align: center;">
                 <button type="button" id="addInventory"  class="btn btn-success" style="border-radius:3px; background-color:brown;">Cập Nhật Thông Tin</button>
            </div>
            
        </div>
    </div>
            <br />
<div class="row clearfix" id="contentAddInventory" style="display: none;">
    <div class="col-md-12">
        <div class="card">
            <br />
            <div class="header">
                <h2>THông Tin</h2>
            </div>
            <div class="body">
                <form id="basic-form" action="" method="post" novalidate="">
                  
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6 col-md-6">
                                <div class="form-group">
                        <label>Code</label>
                        <input type="text" name="codeproduct" class="form-control" required="">
                    </div>
                    <div class="form-group">
                        <label>Tên Sản Phẩm</label>
                        <input type="text" name="nameproduct" class="form-control" required="">
                    </div>
                    <div class="form-group">
                        <label>Quy Cách</label>
                        <input type="number" class="form-control" required="" name="caculationtype">
                    </div>
                    <div class="form-group">
                        <label>Kích hoạt</label>
                        <br>
                        <label class="fancy-radio">
                            <input type="radio" name="eable" value="eable" required="" checked data-parsley-errors-container="#error-radio" data-parsley-multiple="gender">
                            <span><i></i>Có</span>
                        </label>
                        <label class="fancy-radio">
                            <input type="radio" name="eable" value="uneable" data-parsley-multiple="gender">
                            <span><i></i>Không</span>
                        </label>
                        <p id="error-radio"></p>
                    </div>
                            </div>
                            <div class="col-md-6 col-md-6">
                                 <div class="form-group">
                        <label>Cân Nặng</label>
                        <input type="text" name="weight" class="form-control" required="">
                    </div>
                    <div class="form-group">
                        <label>Chiều Cao</label>
                        <input type="text" name="height" class="form-control" required="">
                    </div>
                    <div class="form-group">
                        <label>Độ Dài</label>
                        <input type="number" class="form-control" required="" name="length">
                    </div>
                    <div class="form-group">
                        <label>Độ Rộng</label>
                        <input type="number" class="form-control" required="" name="width">
                    </div>
                            </div>
                        </div>
                    </div>
                    <br>
                    <button type="Submit" class="btn btn-primary">Thêm</button>
                    <button  id="cannelAddInventory" type="button" class="btn btn-danger">Hủy</button>
                </form>
            </div>
        </div>
    </div>
</div>
        </div>
    </div>
</asp:Content>
