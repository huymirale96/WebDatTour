<%@ Page Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="DanhSachNhomTour.aspx.cs" Inherits="WebDatTour.View.BackEnd.DanhSachNhomTour" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="MainContent">


    <br />
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Danh Sách Nhóm Tour
                        </div>
                        <div class="panel-body text-center">
                            <div class="text-center">
                                <span id="MainContent_lblNoti"></span>
                            </div>
                            <div class="col-md-6">
                                <table class="table table-bordered table-stripped">
                                    <thead>
                                        <tr>
                                            <th class="text-center">STT</th>
                                            <th class="text-center">Tên Nhóm Tour</th>
                                            <th class="text-center">Thao Tác</th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptds" runat="server">
                                            <ItemTemplate>                                  
                                                <tr>
                                                    <td class="text-center"><%# Container.ItemIndex+1 %></td>
                                                    <td class="left"><%# Eval("sTenNhomTour") %></td>
                                                   
                                                    
                                                    <td class="left">
                                                        <a id="MainContent_rptLyLich_btnFix_0" title="Sửa lý lịch" class="btn btn-xs btn-warning" href="javascript:__doPostBack('ctl00$MainContent$rptLyLich$ctl00$btnFix','')"><i class="fa fa-pencil-square-o" aria-hidden="false"></i></a>
                                                        <a onclick="return confirm('Bạn có chắc chắn xoá lý lịch?');" id="MainContent_rptLyLich_btnDelete_0" title="Xoá lý lịch" class="btn btn-xs btn-danger" href="javascript:__doPostBack('ctl00$MainContent$rptLyLich$ctl00$btnDelete','')"><i class="fa fa-times" aria-hidden="true"></i></a>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                              
                                            
                                    </tbody>
                                </table>
                                
                            </div>
                        </div>
                    </div>
                </div>
 
     <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Thêm Nhóm TOur</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Thêm Nhóm TOur</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
            <form method="post" action="DanhSachNhomTour.aspx">
            <div class="form-group">
                            <label>Nhóm Tour:</label>
                            <input type="text" id="stennhomtour" name="stennhomtour" class="form-control" value=""/>
                  <input type="hidden" name="chucNang" value="themNhom"/>
                            <button id="btnThemNT_" type="submit" class="btn btn-default">THÊM</button>
             
                        </div>
                </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
            
                <!-- /.row -->


</asp:Content>