<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="ThongKeDoanhThuTheoNgay.aspx.cs" Inherits="WebDatTour.View.BackEnd.ThongKeDoanhThuTheoNgay" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />

    <div class="row">
        <h2 style="margin-left:150px;">Thống Kê Doanh Thu</h2><br />
        <div class="col-md-offset-1 col-md-10">
            <form runat="server" method="get">
                <div class="row">
                     <div class="col-md-3">
                         <label>NGÀY BẮT ĐẦU</label>
                       <input type="date" class="form-control" runat="server" id="batDau_" name="batDau_" />
                    </div>
                     <div class="col-md-3">
                         <label>NGÀY Kế Thuc</label>
                   <input type="date" class="form-control" runat="server" id="ketThuc_" name="ketThuc_" />
                    </div>
                     <div class="col-md-3">
                          <br>
                        <asp:Button ID="tim_" runat="server" CssClass="btn -btn-primary" Text="Thống Kê" OnClick="tim__Click"></asp:Button>
                    </div>
                    <br />  
                   <div class="col-md-9">
                       <asp:label ID="noti" runat="server" CssClass="text-info"></asp:label>
                    </div>
                    <div class="col-md-9">
                        <h3 runat="server" id="txtDoanhSo"> </h3>
                    </div>
                    <div class="col-md-9">
                        <h3 runat="server" id="txtThucThu"></h3>
                    </div>
                    <div class="col-md-9">
                        <h3 runat="server" id="txtSoDon"></h3>
                    </div>

                </div>

            </form>
        </div>
    </div>
</asp:Content>
