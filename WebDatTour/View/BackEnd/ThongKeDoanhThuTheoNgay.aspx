<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="ThongKeDoanhThuTheoNgay.aspx.cs" Inherits="WebDatTour.View.BackEnd.ThongKeDoanhThuTheoNgay" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />

    <div class="row">
        <h2 style="margin-left:150px;">Thống Kê Doanh Thu</h2><br />
        <div class="col-md-offset-1 col-md-10">
            <form runat="server" method="get">            </form>
                <div class="row">
                     <div class="col-md-3">
                         <label>NGÀY BẮT ĐẦU</label>
                      
                         <input type="date" class="form-control" id="nbd" />
                    </div>
                     <div class="col-md-3">
                         <label>NGÀY Kế Thuc</label>
                  
                         <input type="date" class="form-control" id="nkt" />
                    </div>
                     <div class="col-md-3">
                          <br>
                       
                    <!--<label class="label label-primary" id="">Thống Kê</label> -->
                         <button id="thongKe_" class="btn btn-info">Thống Kê</button>
                     </div>
                    <br />  
                   <div class="col-md-9">
                       <asp:label ID="noti" runat="server" CssClass="text-info"></asp:label>
                       
                    </div>
                    <div class="col-md-9">
                        <h3 id="txtDoanhSo"> </h3>
                    </div>
                    <div class="col-md-9">
                        <h3  id="txtThucThu"></h3>
                    </div>
                    <div class="col-md-9">
                        <h3  id="txtSoDon"></h3>
                    </div>
                   
                </div>


             <div id="chartStatistic"></div>
        </div>
    </div>
</asp:Content>
