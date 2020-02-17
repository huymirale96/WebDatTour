
    function up()
{
        var x = $('#id1').val();
        x++; 
        $('#id1').val(x);
        var giaNL = $('#giaNL').val();
        var giaTE = $('#giaTE').val();
        var y = $('#id2').val();
        var tong = x * giaNL + y * giaTE;
        $('#tongTien').html( tong.toLocaleString() + " &nbspVNĐ");
    //alert(x);
    }
    function dow()
{
var x = $('#id1').val();
    if(x != 1)
{
        x--;
        $('#id1').val(x);
      //  $('#id1').val(x);
        var giaNL = $('#giaNL').val();
        var giaTE = $('#giaTE').val();
        var y = $('#id2').val();
        var tong = x * giaNL + y * giaTE;
        $('#tongTien').html( tong.toLocaleString() + " &nbspVNĐ");
    }
    }
    
    function up2()
{
var y = $('#id2').val();
    //alert(x);
    y++;
       // $('#id2').val(x);
        $('#id2').val(y);
        var giaNL = $('#giaNL').val();
        var giaTE = $('#giaTE').val();
        var x = $('#id1').val();
        var tong = x * giaNL + y * giaTE;
        $('#tongTien').html( tong.toLocaleString() + " &nbspVNĐ");
    }
    function dow2()
{
var y = $('#id2').val();
    if(y != 0)
{
        y--;
        $('#id2').val(y);
        var giaNL = $('#giaNL').val();
        var giaTE = $('#giaTE').val();
        var x = $('#id1').val();
        var tong = x * giaNL + y * giaTE;
        $('#tongTien').html( tong.toLocaleString() + " &nbspVNĐ");
   // $('#id2').val(x);
    }
}

function huyTour(id) {
    var x = "<input type='hidden' value='" + id + "' name='id' /> <input type='password' name='pw' class='form-control' />";
    $("#modalHuy_").html(x);
    $("#modalHuy").modal("show");

}

function thanhToan(id, tien) {
    var x = "<p>Số Tiền Thanh Toán Là: " + tien+ " VND</p><br><input type='hidden' value='" + id + "' name='idtt' /> <input type='hidden' name='tientt' value="+ tien +"  />";
    $("#modalTT").html(x);
    $("#modalThanhToan").modal("show");
}


    
$(document).ready(function () {
    $("#dkk").click(function () {
        $('#myModal2').modal('show');
    });

    $("#dnn").click(function () {
        $('#myModal1').modal('show');
    });
    $("#ContentPlaceHolder1_phanTramDat").change(function () {
        //alert("change");
        var tien = $("#ContentPlaceHolder1_tien_tt").val();
        var phanTram = $("#ContentPlaceHolder1_phanTramDat").val();
        if (phanTram != "none")
        {
            $("#tienDC").text("Số TIền Sẽ Thanh Toán ONLINE: "+tien * phanTram + "VND");
        }
    });

    $('#btndangnhap').click(function () {
       // alert("btndangnhap");
        console.log("btn dnag nhap");
        $.ajax({
            type: 'post',
            url: 'index.aspx/dangnhapkh',
            data: "{ 'ten' : '" + $("#txtTenDN").val() + "', 'mk' : '" + $("#txtMKDN").val() + "' }", 
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                // alert("We returned: " + result.d);
                console.log(  "dnag nhap " + result.d);
                // $("#bodyThoiGian").html(x);
                var string = "<a href='#' id='tendn' title='Features'>" + result.d + "</a><ul id='dangNhap' > <li><a href='taikhoan.aspx'>Tài Khoản</a></li> <li><a href='thongtinkhachhang.aspx'>Thông Tin</a></li><li> <a href = 'DanhSachCacTourDaDat.aspx' > Các Đơn Đặt Tour</a ></li > <li><a href='doimatkhau.aspx'>Đổi Mật Khẩu</a></li><li><a href='index.aspx?chucNang=dangxuat'>Đăng Xuất</a></li></ul >";
                $('#daDangNhap').html(string);
                $('#myModal1').modal('hide');

            }
        });
    });



    $("#addInventory").click(function () {
        //alert("1");
        $("#contentAddInventory").slideToggle();
        $("#contentAddCategory").hide();
        $("HTML, BODY").animate({ scrollTop: $("#contentAddInventory").offset().top - 100 }, 1000);
    });

    $("#cannelAddInventory").click(function () {
        $("#contentAddInventory").hide();
        // $("HTML, BODY").animate({scrollTop: $("#contentAddInventory").offset().top - 100}, 1000);
    });
});


 
  