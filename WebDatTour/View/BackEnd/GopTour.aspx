<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout/BackEnd.Master" CodeBehind="GopTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.GopTour" %>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <form runat="server">
    <div class="row">
        <h3 style="margin: 10px;">Chuyển Đơn Đặt Tour</h3>
        <div class="col-md-12" style="margin: 20px;  width:70%;">
            <asp:Label ID="lblnoti" runat="server" CssClass="alert alert-warning" Visible="false" ></asp:Label>
            
                <label>Chọn Tour:</label>
                <br />
                <asp:DropDownList ID="ddlTour" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlTour_SelectedIndexChanged">
                    <asp:ListItem>2</asp:ListItem>
                </asp:DropDownList>
            <button>Chọn</button>
            </div>
      
        <div id="divThongTin" runat="server">
        <div class="col-md-12" style="margin: 20px; width:70%" >
            <div>
                <label>Chọn Ngày Đi:</label>
                <br />
                <asp:DropDownList ID="ddlNgayDi" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlNgayDi_SelectedIndexChanged">
                    <asp:ListItem>2</asp:ListItem>
                </asp:DropDownList>
                 <button>Chọn</button>
            </div>
        </div>
        <div>
            <div id="divDonDatTour" runat="server">
        <div class="col-md-12">
            <h2 style="margin:20px;">Danh Sách:</h2>
            <table class="table table-hover">
                <thead>
                   
                    <tr>
                        <th class="text-center">
                            -
                        </th>
                        <th class="text-center">
                            Mã Đơn
                        </th>
                           <th class="text-center">
                            Khách Hàng
                        </th>
                        <th class="text-center">
                            SĐT
                        </th>
                        <th class="text-center">
                            Email
                        </th>
                        <th class="text-center">
                            Thời Gian Đạt Tour
                        </th>
                        <th class="text-center">
                            Số Chỗ
                        </th>
                    </tr>
                </thead>
                <tbody>
                     <asp:Repeater OnItemDataBound="rptDondattour_ItemDataBound" ID="rptDondattour" runat="server">
                         <ItemTemplate>

                         
                    <tr>
                        <td class="text-center">
                            <asp:CheckBox runat="server" ID="ck_"/>
                            <asp:HiddenField runat="server" ID="iddondattour" Value='<%# Eval("iMaDonDatTour") %>' />
                        </td>
                        <td class="text-center">
                            <a href="xemdondattour.aspx?id=<%# Eval("iMaDonDatTour") %>"><%# Eval("iMaDonDatTour") %></a>
                        </td>
                        <td class="text-center">
                            <%# Eval("sTenKhachHang") %>
                        </td>
                        <td class="text-center">
                           <%# Eval("ssdt") %>
                        </td>
                        <td class="text-center">
                           <%# Eval("semail") %>
                        </td>
                        <td class="text-center">
                           <%# Eval("dNgayDatTour", "{0:dd/MM/yyyy HH:mm}") %>
                        </td>
                        <td class="text-center">
                            <%# Eval("soCho") %> &nbsp;Chỗ
                        </td>

                    </tr>
                    </ItemTemplate>
                     </asp:Repeater>
                </tbody>
            </table>
        </div>
        <div class="col-md-12" style="margin: 20px; width:50%" >
            <label>Chọn Tour Chuyển:</label>
                <br />
           
            <asp:DropDownList runat="server"  ID="ddlTourChuyen" CssClass="form-control"   ><asp:ListItem></asp:ListItem></asp:DropDownList>
             <button>Chọn</button>
        <br />
             <asp:Button runat="server" ID="btnGopTour" OnClick="btnGopTour_Click" Text="Chuyển Tour" CssClass="btn btn-success"/>
        </div>
            </div>
        </div>
            </div>
    </div>
        </form>
</asp:Content>
<asp:Content ID="scriptMain" runat="server" ContentPlaceHolderID="script">
    <div id="script_" runat="server"></div>
</asp:Content>