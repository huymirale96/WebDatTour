function copyATM() {
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val("9704198526191432198").select();
    document.execCommand("copy");
    $temp.remove();
}
function huyTungVe(id) {
    $.ajax({
        type: 'post',
        url: 'danhsachcactourdadat.aspx/layVeTheoDon',
        data: "{ 'maDon' : '" + id +  "'}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
        },
        success: function (result) {
           // alert(result.d);
            var x = JSON.parse(result.d)[0];
            //alert(x.te);
            var html = "<input type='hidden' value='" + x.madon + "' name ='madon' /><label>Số Lượng Vé Người Lớn Hủy:</label><input type='number' class='form-control' name='sovenl' value='" + x.nl + "' min='0' max='" + x.nl + "'/><label>Số Lượng Vé Trẻ Em Hủy:</label><input type='number' class='form-control' name='sovete' value='" + x.te + "' min='0' max='" + x.te +"'/>"
            $("#modalHuyTungVe_").html(html);
            $("#modalHuyTungVe").modal();
        }
    });
}
function kiemTraDangNhap() {
    
    $.ajax({
        type: 'post',
        url: 'DatTour.aspx/kiemTraDangNhap',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
        },
        success: function (result) {
            //alert(result.d);
            if (result.d == true) {

                toastr.success("Da Dang Nhap");
                $('#formDatTour').submit();
            }
            else
            {
                toastr.warning("Chua Dang Nhap");
                $('#myModal1').modal('show');
            }
        }
    });
   return false;
   
   
}

function danhGiaTour(id) {
    $("#divbtndanhgia").html("<button id='btnDanhGia' onclick='danhGiaBTN(" + id + ")'>Đánh Giá</button>");
    $("#modalDanhGiaSao").modal();
 
}

function danhGiaBTN(id) {
    //alert($("#modalDanhGiaSao #txtDanhGiaTour").val() + "  id : " + id);
    var soSao = $("input[name='rating']:checked").val();
    var idDon = id;
    var noiDungDanhGia = $("#modalDanhGiaSao #txtDanhGiaTour").val();

    if (soSao != null && noiDungDanhGia != '' && idDon != null)
    {
       // alert(soSao + "  " +  noiDungDanhGia+"  " + id);
        $.ajax({
            type: 'post',
            url: 'DanhSachCacTourDaDat.aspx/danhgiatour',
            data: "{ 'maDon' : '" + id + "','soSao': '" + soSao + "','noiDung': '" + noiDungDanhGia +"'}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                // alert("We returned: " + result.d);
              //  alert("Ket Qua " + result.d);
                $("#modalDanhGiaSao").modal('hide');
                if (result.d == true) {
                    $("#btn-danhGiakh" + id).hide();
                    toastr.success('Bạn Đã Gửi Đánh Giá Thành Công.');
                }
                else {
                    toastr.warning('Đánh Giá Không Thành Công.');
                }


            }
        });
    }
    
}
function formatNumber(num) {
    return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
}
function hienThiSao(soSao)
{
    var sSaoVang = "<i class='fa fa-star' style='font - size: 18px; color: #ffca08;'></i>";
    var sSaoDen = "<i class='fa fa-star' style='font - size: 18px; '></i>"; 4
    var sSao = "";
    var isoSao = parseInt(soSao);
    for (var i = 0; i < isoSao; i++) {
        sSao += sSaoVang;
    }
    for (var i = 0; i < 5 - isoSao; i++) {
        sSao += sSaoDen;
    }
    return sSao;
}

function suaDanhGia(danhGia, soSao) {
    //alert("id : " + id + "  " + $("#bl_" + id).text());

    $("#modalSuaBinhLuan #txtDanhGiaTour").val($("#bl_" + danhGia).text());
    $("#modalSuaBinhLuan #txtMaDanhGia").val(danhGia);
    $('#modalSuaBinhLuan #star' + soSao).prop('checked', true);
    $("#divbtndanhgia").html("<button onclick='hoanThanhSuaBL(" + danhGia+")'>SỬA</button>");
    $("#modalSuaBinhLuan").modal();
}
function hoanThanhSuaBL(id)
{
   // alert("id : " + id + "  " + $("#txtDanhGiaTour").val());
    $.ajax({
        type: 'post',
        url: 'xemchitiettour.aspx/suaDanhGia',
        data: "{ 'id' : '" + id + "', 'noiDung' : '" + $("#modalSuaBinhLuan #txtDanhGiaTour").val() + "', 'soSao' : '" + $("#modalSuaBinhLuan input[name = 'rating']:checked").val()  +  "' }",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
        },
        success: function (result) {
            // alert("We returned: " + result.d);
           // alert("dnag nhap " + result.d);
            var cmt = "";
            $.each(JSON.parse(result.d), function (index, item) {
                if (item.check == 1) {
                    cmt += "<li class='comment'><div class='comment-body'><divclass=''><div class='comment-author'><img src='../../Content/images/user-pic-3.jpg' alt='' class='img-circle'></div><div class='comment-info'><div class='comment-header'><div class='comment-meta'><span class='comment-meta-date pull-right'>" + item.dThoiGian + "</span></div><h4 class='user-title'>" + item.sTenKhachHang + "</h4></div><div class='comment-content'>" + hienThiSao(item.iSoSao) + "<br><p id='bl_" + item.iMaDanhGia + "'>" + item.sNoiDung + "</p>" + "<label  class='label label-info' onclick = 'suaDanhGia(" + item.iMaDanhGia + "," + item.iSoSao + ")' > Chỉnh Sửa</label>" + "</div></div></div></div></li>";
                }
                else {
                    cmt += "<li class='comment'><div class='comment-body'><divclass=''><div class='comment-author'><img src='../../Content/images/user-pic-3.jpg' alt='' class='img-circle'></div><div class='comment-info'><div class='comment-header'><div class='comment-meta'><span class='comment-meta-date pull-right'>" + item.dThoiGian + "</span></div><h4 class='user-title'>" + item.sTenKhachHang + "</h4></div><div class='comment-content'>" + hienThiSao(item.iSoSao) + "<p id='bl_" + item.iMaBinhLuan + "'s>" + item.sNoiDung + "</p>" + "" + "</div></div></div></div></li>";
                }
                });
            // alert(cmt);

            $("#listCommnent_").html(cmt);
            $("#txtBinhLuan_").val("");
            $("#modalSuaBinhLuan").modal('hide');
            // var string = "<a href='#' id='tendn' title='Features'>" + result.d + "</a><ul id='dangNhap' > <li><a href='taikhoan.aspx'>Tài Khoản</a></li> <li><a href='thongtinkhachhang.aspx'>Thông Tin</a></li><li> <a href = 'DanhSachCacTourDaDat.aspx' > Các Đơn Đặt Tour</a ></li > <li><a href='doimatkhau.aspx'>Đổi Mật Khẩu</a></li><li><a href='index.aspx?chucNang=dangxuat'>Đăng Xuất</a></li></ul >";
            //$('#daDangNhap').html(string);
            //$('#myModal1').modal('hide');

        }
    });
    
}
    function up()
    {
       // alert($('#id1').val() + "  " +  $('#id2').val() + "  " + $('#soChoToiDa').val());
        var soCho1 = parseInt($('#id1').val());
        var soCho2 = parseInt($('#id2').val());
        var tongcho = soCho1 + soCho2;
        var toida = parseInt($('#soChoToiDa').val());
       // alert(toida + "  " + tongcho);
        if (tongcho < toida)
        {
            var x = $('#id1').val();
            x++;
            $('#id1').val(x);
            var giaNL = $('#giaNL').val();
            var giaTE = $('#giaTE').val();
            var y = $('#id2').val();
        var tong = x * giaNL + y * giaTE;
       // alert(tong);
            $('#tongTien').html("Tổng Tiền: " + tong.toLocaleString() + " &nbspVNĐ");
       }
    //alert(x);
    }
    function dow()
{
var x = $('#id1').val();
    if(x != 1 && x !=0 )
{
        x--;
        $('#id1').val(x);
      //  $('#id1').val(x);
        var giaNL = $('#giaNL').val();
        var giaTE = $('#giaTE').val();
        var y = $('#id2').val();
        var tong = x * giaNL + y * giaTE;
        $('#tongTien').html("Tổng Tiền: " +  tong.toLocaleString() + " &nbspVNĐ");
    }
    }
    
    function up2()
    {
        var soCho1 = parseInt($('#id1').val());
        var soCho2 = parseInt($('#id2').val());
        var tongcho = soCho1 + soCho2;
        var toida = parseInt($('#soChoToiDa').val());
        // alert(toida + "  " + tongcho);
        if (tongcho < toida) {
            var y = $('#id2').val();
            //alert(x);
            y++;
            // $('#id2').val(x);
            $('#id2').val(y);
            var giaNL = $('#giaNL').val();
            var giaTE = $('#giaTE').val();
            var x = $('#id1').val();
            var tong = x * giaNL + y * giaTE;
            $('#tongTien').html("Tổng Tiền: " + tong.toLocaleString() + " &nbspVNĐ");
        }
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
        $('#tongTien').html("Tổng Tiền: " +  tong.toLocaleString() + " &nbspVNĐ");
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

function anDanhGia(id) {
  //  alert("id : " + idc + idt);
    $.ajax({
                type: 'post',
                url: 'xemchitiettour.aspx/anDanhGia',
                data: "{ 'id' : '" + id + "' }",
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
                            cmt += "<li class='comment'><div class='comment-body'><div class=''><div class='comment-author'><img src='../../Content/images/user-pic-3.jpg' alt='' class='img-circle'></div><div class='comment-info'><div class='comment-header'><div class='comment-meta'><span class='comment-meta-date pull-right'>" + item.dThoiGian + "</span></div><h4 style='display:inline;' class='user-title'>" + item.sTenKhachHang + "</h4><label onclick='anDanhGia(" + item.iMaDanhGia + ")' style='display: ' class='label label-";
                            if (item.btrangthai == true) {
                                cmt += "success '>Hiện</label></div><div class='comment-content'>" + hienThiSao(item.iSoSao) + "<br><p>" + item.sNoiDung + "</p></div><!--<div class='reply'><a href='#' class='btn-link'>TrảLời</a></div>--></div></div></div></li>";
                            }
                            else {
                                cmt += "warning '>Ẩn</label></div><div class='comment-content'>" + hienThiSao(item.iSoSao) + "<br><p>" + item.sNoiDung + "</p></div><!--<div class='reply'><a href='#' class='btn-link'>TrảLời</a></div>--></div></div></div></li>";
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
    var mk = $('#txtMKDK').val();
   // var txtSDTDK = $('#txtSDTDK').val();
    if ($.trim(hoTen) == '') {
        alert('Bạn chưa nhập họ tên.');
        return true;
    }

    if ($('#txtSDTDK').val().length < 10 && $('#txtSDTDK').val().length > 14) {
        alert('Số Điện Thoại Không Đúng');
        return false;
    } 

    if (/^[\w&.\-]+$/i.test(mk)) {
        //  alert(mk+'Mật Khẩu Phải Từ 8 Kí Tự Bao Gồm Ít Nhất 1 Chữ Và 1 Số 1');
        //return false;
    }
    else {
        alert('Số Điện Thoại Không Được Chứa Ký Tự Đặc Biệt');
        return false;
    }

    if ($.trim(tendk) == '') {
        alert('Bạn chưa nhập tên đăng kí.');
        return false;
    }
    if ($.trim(tendk).length > 30) {
        alert('Tên Đăng Ký Không Quá 30 Ký Tự.');
        return false;
    }
    
    if ($.trim(txtEmalDK) == '') {
        alert('Bạn chưa nhập email.');
        return false;
    }
   
    if (/^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/i.test(mail))
    {
      //  alert('Bạn nhập đunhgs email.');
    }
    else {
        alert('Bạn nhập sai email.');
        return false;
    }
  
    if (/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/i.test(mk)) {
      //  alert(mk+'Mật Khẩu Phải Từ 8 Kí Tự Bao Gồm Ít Nhất 1 Chữ Và 1 Số 1');
        //return false;
    }
    else {
        alert(' Mật Khẩu Phải Từ 8 Kí Tự Bao Gồm Ít Nhất 1 Chữ Và 1 Số.');
        return false;
    }
    var self = this;
        var id = $("#txtTenDK").val();
       // alert("Ten: " + id);
        if (id != '') {
           // alert("khach ''");
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
                  //  alert("We returned: " + result.d);
                    if (result.d == true) {
                       // alert("We true: ");
                        $("#noTi").html("Tên Đăng Nhập đúng.");
                        self.submit();
                        //return true;
                    }
                    else {
                       // alert("We fasle: ");
                        $("#noTi").html("Tên Đăng Nhập Đã Trùng.");
                        return false;
                    }
                }

            });     
        }
        return false;
 });

    
$(document).ready(function () {

  /*  $.validator.addMethod("txtMKDN", function (value, element) {
        return this.optional(element) || /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/i.test(value);
    }, "Mật Khẩu Nhất 8 kí tự bao gồm cả số và chữ.");*/

   // alert(kiemTraTen("aada"));

    toastr.options = {
        'closeButton': true,
        'debug': false,
        'newestOnTop': false,
        'progressBar': true,
        'positionClass': 'toast-top-right',
        'preventDuplicates': false,
        'showDuration': '1000',
        'hideDuration': '1000',
        'timeOut': '3000',
        'extendedTimeOut': '1000',
        'showEasing': 'swing',
        'hideEasing': 'linear',
        'showMethod': 'fadeIn',
        'hideMethod': 'fadeOut',
    }
   // toastr.success('Bạn Đã Gửi Đánh Giá Thành Công.');
    $(".btn-danhGia").click(function () {
      //  alert("ma don: " + $(this).data('imadon'));
        $("#divbtndanhgia").html("<button id='btnDanhGia' onclick='danhGiaBTN(" + $(this).data('imadon') + ")'>Đánh Giá</button>");
        $("#modalDanhGiaSao").modal();
       /// alert("ok");

    });
    $("#btnDanhGia_").click(function () {
        
        var danhGia = $("input[name='rating']:checked").val();
    if (danhGia != null) {
        alert(danhGia);
    }
    });
    
    $('#mangaydi').on('change', function () {
      // alert(this.value);
        $('#id1').val("0");
        $('#id2').val("0");
        
        if (this.value != "none") {
            $.ajax({
                type: 'post',
                url: 'xemchitiettour.aspx/kiemTraSoChoCon',
                data: "{ 'idtour' : '" + $("#idTour").val() + "', 'idthoigian' : '" + this.value + "' }",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (result) {
                   // alert("We returned: " + result.d);
                    // alert("dnag nhap " + result.d);thongBaoSoCho
                    $("#thongBaoSoCho").html("Số Chỗ Còn Là: "+result.d);
                    $("#soChoToiDa").val(result.d);
                   // $("#btnUpDow").removeProp("disabled", true);


                }
            });
        }
    });


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
                minlength: 11
            },
            txtMKDK: "required",
               // : "required",
            txtSDTDK: "required",
            txtDCDK: "required",
            txtEmalDK: {
                required: true,
                regex: '/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/'
            }

        },
        messages: {
            txtHTDK: "Vui lòng nhập họ tên. ",
            txtTenDK: "Vui lòng nhập tên đăng kí",
            txtSDTDK: {
                required: "Vui lòng nhập sdt",
                minlength: "Ngắn vậy, chém gió ah?"
            },
            txtMKDK: "Vui lòng nhập mật khẩu. ",
            txtDCDK: "Vui lòng địa chỉ. ",
            txtSDTDK: "Vui lòng nhập sdt",
            txtEmalDK: {
                required: "Vui lòng nhập email. ",
                regex: "Vui lòng nhập đúng email. "
            },

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
            $("#tienDC").text("Số TIền Sẽ Thanh Toán ONLINE: " +  formatNumber(tien * phanTram) + " VND");
        }
    });

    $('#btndangnhap').click(function () {
       // alert("btndangnhap");
        console.log("btn dnag nhap" + $("#txtMKDN").val());
        var mk = $("#txtMKDN").val();
        //alert('ok1s' + mk);
        if (/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/i.test(mk))  //huyhuy123
        {
            
           // alert('ok');
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
                    console.log("dnag nhap " + result.d);
                    // $("#bodyThoiGian").html(x);
                    if (result.d != "") {
                        var string = "<a href='#' id='tendn' title='Features'>" + result.d + "</a><ul id='dangNhap' > <li><a href='#'>Tài Khoản</a></li> <li><a href='thongtinkhachhang.aspx'>Thông Tin</a></li><li> <a href = 'DanhSachCacTourDaDat.aspx' > Các Đơn Đặt Tour</a ></li > <li><a href='doimatkhau.aspx'>Đổi Mật Khẩu</a></li><li><a href='index.aspx?chucNang=dangxuat'>Đăng Xuất</a></li></ul >";
                        $('#daDangNhap').html(string);
                        $('#myModal1').modal('hide');
                        toastr.success("Đăng Nhập Thành Công.");
                    }
                    else {
                        $("#thongBaoDangNhap").html("Đăng Nhập Sai.");
                    }

                }
            });
        }
        else {
            $("#thongBaoDangNhap").html("Mật Khẩu Không Đúng");
        }
        
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


 
  