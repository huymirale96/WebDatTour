<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="WebDatTour.View.BackEnd.DangNhap" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Đăng nhập</title>

        <!-- Bootstrap Core CSS -->
        <link href="../../Content/css/bootstrap.min.css" rel="stylesheet">

        <!-- MetisMenu CSS -->
        <link href="../Content/css/metisMenu.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="../Content/css/startmin.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="../Content/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!--[if lt IE 9]>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
    <div class="container">
            <div class="row" style="margin-top:180px;">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-panel panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title text-center">Đăng nhập hệ thống</h3>
                        </div>
                        <div class="panel-body">
                            <form method="POST" runat="server">
                                <fieldset>
                                    <div class="form-group">
                                        <asp:TextBox ID="txtTaiKhoan" CssClass="form-control" runat="server" placeholder="Tài khoản"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <asp:TextBox ID="txtMatKhau" TextMode="Password" CssClass="form-control" runat="server" placeholder="Mật khẩu"></asp:TextBox>
                                    </div>
                                    <div class="col-md-12 text-center">
                                        <asp:Label ID="lblNoti" runat="server" Text="" CssClass="text-danger"></asp:Label>
                                    </div>
                                    <!-- Change this to a button or input when using this as a form -->
                                    <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" OnClick="btnLogin_Click" CssClass="btn btn-lg btn-success btn-block" />
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- jQuery -->
        <script src="../Scripts/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="../../Content/js/Scripts/bootstrap.min.js"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="../../Content/js/Scripts/metisMenu.min.js"></script>

        <!-- Custom Theme JavaScript -->
        <script src="../../Content/js/Scripts/startmin.js"></script>
</body>
</html>

