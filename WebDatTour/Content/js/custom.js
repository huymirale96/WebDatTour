function copyATM() {
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val("9704198526191432198").select();
    document.execCommand("copy");
    $temp.remove();
}
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

function anbinhluan(idc, idt) {
  //  alert("id : " + idc + idt);
    $.ajax({
                type: 'post',
                url: 'xemchitiettour.aspx/anBinhLuan',
                 data: "{ 'id' : '" + idc + "', 'idtour' : '" + idt + "' }",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (result) {
                    // alert("We returned: " + result.d);
                    if (result.d != null) {
                        //alert("dnag nhap " + result.d);
                        var cmt = "";
                        $.each(JSON.parse(result.d), function (index, item) {
                            cmt += "<li class='comment'><div class='comment-body'><div class=''><div class='comment-author'><img src='../../Content/images/user-pic-3.jpg' alt='' class='img-circle'></div><div class='comment-info'><div class='comment-header'><div class='comment-meta'><span class='comment-meta-date pull-right'>" + item.dThoiGian + "</span></div><h4 style='display:inline;' class='user-title'>" + item.sTenKhachHang + "</h4><label onclick='anbinhluan(" + item.iMaBinhLuan + "," + item.iMaTour + ")' style='display: ' class='label label-";
                            if (item.itrangthai == false) {
                                cmt +=  "success '>Hiện</label></div><div class='comment-content'><p>" + item.sNoiDung + "</p></div><!--<div class='reply'><a href='#' class='btn-link'>TrảLời</a></div>--></div></div></div></li>";
                            }
                            else {
                                cmt +=  "warning '>Ẩn</label></div><div class='comment-content'><p>" + item.sNoiDung + "</p></div><!--<div class='reply'><a href='#' class='btn-link'>TrảLời</a></div>--></div></div></div></li>";
                            }
                        });
                      //  alert(cmt);

                        $("#listCommnent_").html(cmt);
                        $("#txtBinhLuan_").val("");
                    }
                    // var string = "<a href='#' id='tendn' title='Features'>" + result.d + "</a><ul id='dangNhap' > <li><a href='taikhoan.aspx'>Tài Khoản</a></li> <li><a href='thongtinkhachhang.aspx'>Thông Tin</a></li><li> <a href = 'DanhSachCacTourDaDat.aspx' > Các Đơn Đặt Tour</a ></li > <li><a href='doimatkhau.aspx'>Đổi Mật Khẩu</a></li><li><a href='index.aspx?chucNang=dangxuat'>Đăng Xuất</a></li></ul >";
                    //$('#daDangNhap').html(string);
                    //$('#myModal1').modal('hide');
                    
                }
            });
}

$("#formdk").submit(function (e) {
    e.preventDefault();
    var hoTen = $('#txtHTDK').val();
    var tendk = $('#txtTenDK').val();
    var mail = $('#txtEmalDK').val();
    if ($.trim(hoTen) == '') {
        alert('Bạn chưa nhập họ tên.');
        return true;
    }

    if ($.trim(tendk) == '') {
        alert('Bạn chưa nhập tên đăng kí.');
        return false;
    }
    
    if ($.trim(txtEmalDK) == '') {
        alert('Bạn chưa nhập email.');
        return false;
    }
    var self = this;
        var id = $("#txtTenDK").val();
        alert("Ten: " + id);
        if (id != '') {
            alert("khach ''");
            $.ajax({
                type: 'post',
                url: 'index.aspx/kiemTraTen',
                data: "{ 'ten' : '" + id + "' }",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    return false;
                },
                success: function (result) {
                    alert("We returned: " + result.d);
                    if (result.d == true) {
                        alert("We true: ");
                        $("#noTi").html("Tên Đăng Nhập đúng.");
                        self.submit();
                        //return true;
                    }
                    else {
                        alert("We fasle: ");
                        $("#noTi").html("Tên Đăng Nhập Đã Trùng.");
                        return false;
                    }
                }

            });     
        }
        return false;
 });

    
$(document).ready(function () {
   // alert(kiemTraTen("aada"));
    $('.carousel[data-type="multi"] .item').each(function () {
        var next = $(this).next();
        if (!next.length) {
            next = $(this).siblings(':first');
        }
        next.children(':first-child').clone().appendTo($(this));

        for (var i = 0; i < 0; i++) {
            next = next.next();
            if (!next.length) {
                next = $(this).siblings(':first');
            }

            next.children(':first-child').clone().appendTo($(this));
        }
    });


    $('#btnBinhLuan_').click(function () {
        // alert("btndangnhap");
        //alert("btn binh luan " + $("#txtMaTour_").val() + $("#txtBinhLuan_").val());
        if (!$("#txtBinhLuan_").val() == "") {
            $.ajax({
                type: 'post',
                url: 'xemchitiettour.aspx/taoBinhLuan',
                data: "{ 'idtour' : '" + $("#txtMaTour_").val() + "', 'binhluan' : '" + $("#txtBinhLuan_").val() + "' }",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (result) {
                    // alert("We returned: " + result.d);
                    //alert("dnag nhap " + result.d);
                    var cmt = "";
                    $.each(JSON.parse(result.d), function (index, item) {
                        cmt += "<li class='comment'><div class='comment-body'><divclass=''><div class='comment-author'><img src='../../Content/images/user-pic-3.jpg' alt='' class='img-circle'></div><div class='comment-info'><div class='comment-header'><div class='comment-meta'><span class='comment-meta-date pull-right'>" + item.dThoiGian + "</span></div><h4 class='user-title'>" + item.sTenKhachHang + "</h4></div><div class='comment-content'><p>" + item.sNoiDung + "</p></div><!--<div class='reply'><a href='#' class='btn-link'>TrảLời</a></div>--></div></div></div></li>";
                    });
                    // alert(cmt);

                    $("#listCommnent_").html(cmt);
                    $("#txtBinhLuan_").val("");
                    // var string = "<a href='#' id='tendn' title='Features'>" + result.d + "</a><ul id='dangNhap' > <li><a href='taikhoan.aspx'>Tài Khoản</a></li> <li><a href='thongtinkhachhang.aspx'>Thông Tin</a></li><li> <a href = 'DanhSachCacTourDaDat.aspx' > Các Đơn Đặt Tour</a ></li > <li><a href='doimatkhau.aspx'>Đổi Mật Khẩu</a></li><li><a href='index.aspx?chucNang=dangxuat'>Đăng Xuất</a></li></ul >";
                    //$('#daDangNhap').html(string);
                    //$('#myModal1').modal('hide');

                }
            });
        }
        else {
            $("#notiCmt").html("<p class='text-warning'>Nội dung bình luận không được trống.</p>");
        }
    });

    $("#formdk").validate({
        rules: {
            txtHTDK: "required",
            txtTenDK: "required",
            txtSDTDK: {
                required: true,
                minlength: 2
            }
        },
        messages: {
            txtHTDK: "Vui lòng nhập họ tên. ",
            txtTenDK: "Vui lòng nhập tên đăng kí",
            txtSDTDK: {
                required: "Vui lòng nhập sdt",
                minlength: "Ngắn vậy, chém gió ah?"
            }
        }
    });



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


 
  