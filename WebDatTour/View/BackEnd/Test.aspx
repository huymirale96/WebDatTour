<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="WebDatTour.View.BackEnd.Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- row  -->
    <script>
     /*   $(document).ready(function () {
            $("#File1").change(function () {
              
                                              var previewimages = $("#showimage");
                                              previewimages.html("");
                                              $($(this)[0].files).each(function () {
                                                                                     var file = $(this);
                                                                                     var reader = new FileReader();
                                                                                     reader.onload = function (e) {
                                                                                                      var img = $("<img />");
                                                                                                      img.attr("style", "height:150px;width: 150px;");
                                                                                                      img.attr("src", e.target.result);
                                                                                                      previewimages.append(img);
                                                                                                                  }
                                                                                       reader.readAsDataURL(file[0]);
                                                                                    });
            
                                           });
                                      });*/
    </script>
               <div>
        <h1>Hariti Study Hub</h1>
        <h4>How to Preview and Upload Multiple Images in Asp.Net with Jquery</h4>
        <hr />
    </div>
    <form method="post" enctype="multipart/form-data" runat="server">                
    Upload Images
    <input type="file" multiple="multiple" name="File1" id="File1" accept="image/*" />
    <br /><br />
    <div id="showimage">
    </div>
    <hr />  
    <asp:Button ID="Button1" runat="server" Text="Upload and Save" OnClick="Button1_Click" />
        <asp:Button ID="Button2" runat="server" Text="BTN" OnClick="Button2_Click" />
        

</form>
    
   
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
    <button id="btn123">BTN TEST</button>
 

   
            
</asp:Content>
