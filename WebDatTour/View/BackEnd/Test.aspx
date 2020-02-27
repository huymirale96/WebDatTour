<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/BackEnd.Master" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="WebDatTour.View.BackEnd.Test" %>
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
    <form method="post" enctype="multipart/form-data" runat="server" id="form1">   
        <div id="anh" runat="server"></div>
        -------------------------------------
        <div>
<asp:PlaceHolder ID="anh1" runat="server" />
</div>
    Upload Images
        <asp:FileUpload ID="FileAnh_" runat="server" />
        <asp:label ID="lab1" runat="server" Text ="change"></asp:label>
    <input type="file" multiple="multiple" name="File1" id="File1" accept="image/*" />
    <br /><br />
    <div id="showimage">
    </div>
    <hr />  
    <asp:Button ID="Button1" runat="server" Text="Upload and Save" OnClick="Button1_Click" />
        <asp:Button ID="Button2" runat="server" Text="BTN" OnClick="Button2_Click" />
        <asp:Button ID="mail" runat="server" Text="Mail" OnClick="mail_Click" />
         <input type="file" name="File2" id="File2" runat="server" />

</form>
    
   
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
    <button id="btn123">BTN TEST</button>
 

   <div class="form-group" id="rating-ability-wrapper">
	    <label class="control-label" for="rating">
	    <span class="field-label-header">How would you rate your ability to use the computer and access internet?*</span><br>
	    <span class="field-label-info"></span>
	    <input type="hidden" id="selected_rating" name="selected_rating" value="" required="required">
	    </label>
	    <h2 class="bold rating-header" style="">
	    <span class="selected-rating">0</span><small> / 5</small>
	    </h2>
	    <button type="button" class="btnrating btn btn-default btn-lg" data-attr="1" id="rating-star-1">
	        <i class="fa fa-star" aria-hidden="true"></i>
	    </button>
	    <button type="button" class="btnrating btn btn-default btn-lg" data-attr="2" id="rating-star-2">
	        <i class="fa fa-star" aria-hidden="true"></i>
	    </button>
	    <button type="button" class="btnrating btn btn-default btn-lg" data-attr="3" id="rating-star-3">
	        <i class="fa fa-star" aria-hidden="true"></i>
	    </button>
	    <button type="button" class="btnrating btn btn-default btn-lg" data-attr="4" id="rating-star-4">
	        <i class="fa fa-star" aria-hidden="true"></i>
	    </button>
	    <button type="button" class="btnrating btn btn-default btn-lg" data-attr="5" id="rating-star-5">
	        <i class="fa fa-star" aria-hidden="true"></i>
	    </button>
	</div>
            
</asp:Content>
