<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout/BackEnd.Master"  CodeBehind="ThongKeTaiKhoan.aspx.cs" Inherits="WebDatTour.View.BackEnd.ThongKeTaiKhoan" %>
<asp:Content ID="cotent1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-offset-2 col-md-6">
            <h2 style="margin: 20px;">THỐNG KÊ TÀI KHOẢN</h2>
            <table class="table table-hover">
                <tr>
                    <td>
                        Số Tài Khoản Quản Trị:
                    </td>
                    <td id="tkqt" runat="server">

                    </td>
                </tr>
                <tr>
                    <td>
                        Số Tài Khoản Admin:
                    </td>
                    <td id="tkad" runat="server">

                    </td>
                </tr>
                <tr>
                    <td>
                        Số Tài Khoản Nhân Viên:
                    </td>
                    <td id="tknv" runat="server">

                    </td>
                </tr>
                <tr>
                    <td>
                        Số Tài Khoản Khách Hàng
                    </td>
                    <td id="tkkh" runat="server">

                    </td>
                </tr>
            </table>
        </div>
    </div>
    </asp:Content>