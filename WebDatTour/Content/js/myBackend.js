$(document).ready(function () {
    toastr.options = {
        'closeButton': true,
        'debug': false,
        'newestOnTop': true,
        'progressBar': true,
        'positionClass': 'toast-top-right',
        'preventDuplicates': true,
        'showDuration': '1000',
        'hideDuration': '1000',
        'timeOut': '3000',
        'extendedTimeOut': '1000',
        'showEasing': 'swing',
        'hideEasing': 'linear',
        'showMethod': 'fadeIn',
        'hideMethod': 'fadeOut',
    }

    $("#txtSoChoNL").attr('disabled', 'disabled');
    $("#txtSoChoTE").attr('disabled', 'disabled');
    $("#thanhToanDDT").attr('disabled', 'disabled');
    $("#tenKH").attr('disabled', 'disabled');
    
    


    //   alert("đas");
    var date = new Date();

    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();

    if (month < 10) month = "0" + month;
    if (day < 10) day = "0" + day;

    var today = year + "-" + month + "-" + day;
    $("#nbd").attr("value", today);
    $("#nkt").attr("value", today);

    ////////////rating bar
    $('.isNumberic').keypress(validateNumber);
    $('.isNumberic').change(function () {
        var nl = parseInt($("#txtSoChoNL").val());
        var te = parseInt($("#txtSoChoTE").val());
        var con_ = parseInt($('#soChoConh').val());
        //alert(con_)
        $('#thongBao').html();
        if (con_ < (te + nl)) {
            $('#thongBao').html("Số Chỗ Chỉ Còn " + $("#soChoConh").val() + " chỗ.");
            $("#thanhToanDDT").attr('disabled', 'disabled');
        }
        else {
            var tongTien = (parseInt($("#giaNLh").val()) * parseInt($("#txtSoChoNL").val()) + parseInt($("#giaTEh").val()) * parseInt($("#txtSoChoTE").val())) * parseFloat($("#txtPtThanhToan").val());     
            $('#thongBao').html("Tổng Tiền Là: " + tongTien.toLocaleString() + "VND");
            $('#tienTTh').val(tongTien);
            $("#thanhToanDDT").removeAttr('disabled');
            
        }
        
    });

    $(".btnrating").on('click', (function (e) {

        var previous_value = $("#selected_rating").val();

        var selected_value = $(this).attr("data-attr");
        $("#selected_rating").val(selected_value);
        alert(selected_value);

        $(".selected-rating").empty();
        $(".selected-rating").html(selected_value);

        for (i = 1; i <= selected_value; ++i) {
            $("#rating-star-" + i).toggleClass('btn-warning');
            $("#rating-star-" + i).toggleClass('btn-default');
        }

        for (ix = 1; ix <= previous_value; ++ix) {
            $("#rating-star-" + ix).toggleClass('btn-warning');
            $("#rating-star-" + ix).toggleClass('btn-default');
        }

    }));
/////////////rating bar
    $("#thongKe_").click(function () {
      var ngay = $("#nbd").val();
      //  alert(ngay + " ok  ");
        var d1 = Date.parse($("#nbd").val());
        var d2 = Date.parse($("#nkt").val());
        // console.log("ngay: " + ngay);
        if (d1 < d2) {
            $.ajax({
                type: 'post',
                url: 'thongkedoanhthutheongay.aspx/thongkedoanhthu',
                data: "{ 'ngayBatDau' : '" + $("#nbd").val() + "', 'ngayketthuc' : '" + $("#nkt").val() + "' }",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (data_) {
                    //alert(data_.d);
                    var x = JSON.parse(data_.d);
                    $("#txtDoanhSo").html("Tổng Doanh Số Là: " + x.DoanhThu);
                    $("#txtThucThu").html("Tổng Thực Thu là: " + x.ThucThu);
                    $("#txtSoDon").html("Tổng Số Đơn Là:     " + x.SoDon);
                    /*var xx = "";
                    var stt = 0;
                    var a = JSON.parse(data.d);
                    //  alert(a[0).dThoiGian + " leng th "+ a.length);


                        /*
                    $.each(a, function (index, item) {

                        xx += "<tr><td class='text-center'>" + (index + 1) + "</td><td class='text-center'>" + item.dThoiGian + "</td><td class='text-center'><a href='SuaTour.aspx/?chucNang=cn1&amp;tg=" + item.iMaThoiGian + "&amp;tour=" + item.iMaTour + "'></a><label onclick='anhienthoigian(" + item.iMaThoiGian + ")' ";

                        if (item.trangThai == false) {
                            xx += "class='label label-warning'>Ẩn </label></td></tr>";
                        }
                        else {
                            xx += "class='label label-success'>Hiện </label></td></tr>";
                        }
                    });
                    $('#bodyThoiGian').html(xx);*/
                    google.charts.load('current', { 'packages': ['line'] });
                    google.charts.setOnLoadCallback(drawChart);

                    function drawChart() {

                        var data = new google.visualization.DataTable();
                        data.addColumn('string', 'Ngày');
                        data.addColumn('number', 'Doanh Thu');
                        data.addColumn('number', 'Thực Thu');
                        //data.addColumn('number', 'Số Đơn');
                        // data.addColumn('number', 'Transformers: Age of Extinction');
                        // alert(JSON.stringify(JSON.parse(data_.d).Data));
                        $.each(JSON.parse(data_.d).Data, function (index, item) {
                            //    alert(item.ngay);
                            data.addRow([item.ngay, item.doanhthu, item.thucthu]);
                        });

                        var options = {
                            chart: {
                                title: 'Thống Kê Doanh Thu',
                                subtitle: '-----'
                            },
                            width: 900,
                            height: 500
                        };

                        var chart = new google.charts.Line(document.getElementById('chartStatistic'));

                        chart.draw(data, google.charts.Line.convertOptions(options));
                    }
                }
            });
        }
        else {
            $("#thongBaoNgay").html("Ngày Không Hợp Lệ");
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


    

    $("#thanhToanDDT").click(function () {
        var x = confirm('Bạn Muốn Đặt Tour?');
        if (x) {
            //alert("tien: " + $("#tienTTh").val() + "id tour " + $("#idtourh").val() + " nl " + $("#txtSoChoNL").val() + " te " + $("#txtSoChoTE").val() + " id ngay " + $("#txtThoiGian").val() + " id khach " + $("#idkhh").val()); 
            $.ajax({
                type: 'post',
                url: 'taodondattour.aspx/taodondattour',  // (string idTour, string idNgay, string idKH, string soTE, string soNL, string tien
                data: "{ 'idTour' : '" + $("#idtourh").val() + "', 'idNgay' : '" + $("#txtThoiGian").val() + "', 'idKH' : '" + $("#idkhh").val() + "', 'soTE' : '" + $("#txtSoChoTE").val() + "', 'soNL' : '" + $("#txtSoChoNL").val() + "', 'tien' : '" + $("#tienTTh").val() + "' }",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (data) {
                    if (data.d == "true") {
                        toastr.info("Tạo Đơn Đặt Tour Thành Công.", "Thông Báo.");
                        setTimeout(function () {
                            window.location.href = "DanhSachDatTour.aspx";
                        }, 2000);
                    }
                    else {
                        toastr.warning("Tạo Đơn Đặt Tour Không Thành Công.", "Thông Báo.");
                    }
                }





            });
        }
        //var ngay = $("#txtNgayDiThem").val();
        //  var hanDat = $("#txtHanDat").val(); 
       // alert($("#matour_").val() + "   " + $("#txtNgayDiThem").val());
       
        
           
        
        
    });

    $("#btnThemNgay").click(function () {
        var ngay = $("#txtNgayDiThem").val();
      //  var hanDat = $("#txtHanDat").val(); 
       //alert( $("#matour_").val() + "   " + $("#txtNgayDiThem").val());
        // console.log("ngay: " + ngay);
       // var d1 = Date.parse(ngay);
       // var d2 = Date.parse(hanDat);
        // console.log("ngay: " + ngay);  var d1 = Date.parse($("#nbd").val());
        var ngayThem = Date.parse(ngay);
        var ngayHienTai = Date.parse("2020-03-24");

        if (ngay != null && ngayThem > ngayHienTai) {
            $.ajax({
                type: 'post',
                url: 'suatour.aspx/themThoiGianKhoiHanh',
                data: "{ 'id' : '" + $("#matour_").val() + "', 'date' : '" + ngay + "' }",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (data) {
                    if (data.d != null) {
                        var xx = "";
                        var stt = 0;
                        var a = JSON.parse(data.d);
                        //  alert(a[0).dThoiGian + " leng th "+ a.length);



                        $.each(a, function (index, item) {

                            xx += "<tr><td class='text-center'>" + (index + 1) + "</td><td class='text-center'>" + moment(item.dThoiGian).format('DD-MM-YYYY') + "</td><td class='text-center'><a href='SuaTour.aspx/?chucNang=cn1&amp;tg=" + item.iMaThoiGian + "&amp;tour=" + item.iMaTour + "'></a><label onclick='anhienthoigian(" + item.iMaThoiGian + ")' ";

                            if (item.trangThai == false) {
                                xx += "class='label label-warning'>Ẩn </label></td></tr>";
                            }
                            else {
                                xx += "class='label label-success'>Hiện </label></td></tr>";
                            }
                            toastr.success("Thêm Ngày " + ngay + "Thành Công.", "Thông Báo.");
                        });


                        $('#bodyThoiGian').html(xx);
                    }
                    else {
                        toastr.info("Thêm Ngày " + ngay + "Không Thành Công.", "Thông Báo.");

                    }



                }





            });
        }
        else {
            $("#thongBaoNgay").html("Ngày Không Hợp Lệ");
        }
    });







    
});

$("#listTour").change(function () {
    //alert("Handler for .change() called." + $("#listTour").val());
    var id = $("#listTour").val();
    if (this.value != 'none') {

        $("#txtSoChoNL").attr('disabled', 'disabled');
        $("#txtSoChoTE").attr('disabled', 'disabled');
        $("#thanhToanDDT").attr('disabled', 'disabled');

        $.ajax({

            type: 'post',
            url: 'taodondattour.aspx/layThongTinTour',
            data: "{ 'id' : '" + id + "' }",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (data) {
                //  alert(data.d);
                var tour = JSON.parse(data.d).ThongTinTour[0];
                // alert("tour " + tour.sTieuDe);
                $('#txtTieuDe').html(tour.sTieuDe);
                $('#txtNoiKhoiHanh').html(tour.sNoiKhoiHanh);
                $('#txtTongThoiGian').html(tour.sTongThoiGian);
                $('#txtGiaNL').html(tour.igianlgiam);
                $('#txtGiaTE').html(tour.igiategiam);
                $('#txtSoCho').html(tour.iSoCho);

                $('#anhTour').html("<img src='../../Upload/" + tour.surlanh + "'>");
                $('#giaNL').val(tour.igianlgiam);

                $('#idtourh').val(tour.iMaTour);
                $('#giaNLh').val(tour.igianlgiam);
                $('#giaTEh').val(tour.igiategiam);
              //  alert(tour.iMaTour + "  " + $('#idtourh').val());
                var ngayKhoiHanh = "<option value='none'>Chọn Ngày</option>";
                $.each(JSON.parse(data.d).NgayDi, function (index, item) {
                    // alert(moment(item.dThoiGian).format('DD-MM-YYYY'));
                    ngayKhoiHanh += "<option value='" + item.iMaThoiGian + "'>" + moment(item.dThoiGian).format('DD-MM-YYYY') + "</option>";


                });
                //  alert("nkh: " + ngayKhoiHanh);
                $('#txtThoiGian').html(ngayKhoiHanh + "");
                $("#divThongTinTour").removeClass("classAn");
                /*$.each(JSON.parse(data.d.NgayDi), function (index, item) {
                    alert(item.dThoiGian);
    
                });*/
                //  $("#anhTour").html("<img src='"+tour.urlAnh+"' ");


                // $('#bodyThoiGian').html(xx);
            }
        });
}
});


$('#txtThoiGian').on('change', function () {
  //  alert(this.value + "ma tour " + $('#idtourh').val());
     $('#iMaTour').val();
    //$('#id2').val("0");

    if (this.value != "none") {

        $("#txtSoChoNL").attr('disabled', 'disabled');
        $("#txtSoChoTE").attr('disabled', 'disabled');
        $("#thanhToanDDT").attr('disabled', 'disabled');

        $.ajax({
            type: 'post',
            url: '../FontEnd/xemchitiettour.aspx/kiemTraSoChoCon',
            data: "{ 'idtour' : '" + $("#idtourh").val() + "', 'idthoigian' : '" + this.value + "' }",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
             //   alert("We returned: " + result.d);
                
                $("#txtSoChoCon").html(result.d);
                $("#soChoConh").val(result.d);
                if (parseInt(result.d) > 0) {
                    $("#txtSoChoNL").removeAttr('disabled');
                    $("#txtSoChoTE").removeAttr('disabled');
                }
                // alert("dnag nhap " + result.d);thongBaoSoCho
               // $("#thongBaoSoCho").html("Số Chỗ Còn Là: " + result.d);
              //  $("#soChoToiDa").val(result.d);
                // $("#btnUpDow").removeProp("disabled", true);


            }
        });
    }
});

function validateNumber(event) {
    var key = window.event ? event.keyCode : event.which;
    if (event.keyCode === 8 || event.keyCode === 46) {
        return true;
    } else if (key < 48 || key > 57) {
        return false;
    } else {
        return true;
    }
};

function anhienthoigian(id, idtour)
{
    $.ajax({
        
        type: 'post',
        url: 'suatour.aspx/cntttg',
        data: "{ 'id' : '" + id + "', 'idtour' : '" + idtour + "' }",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
        },
        success: function (data) {
          //  alert(data.d);
            var xx = "";
            var stt = 0;
            var a = JSON.parse(data.d);
            $.each(a, function (index, item) {

                xx += "<tr><td class='text-center'>" + (index + 1) + "</td><td class='text-center'>" + moment(item.dThoiGian).format('DD-MM-YYYY') + "</td><td class='text-center'>" + moment(item.dHanDatTour).format('DD-MM-YYYY') +  "</td><td class='text-center'><a href='SuaTour.aspx/?chucNang=cn1&amp;tg=" + item.iMaThoiGian + "&amp;tour=" + item.iMaTour + "'></a><label onclick='anhienthoigian(" + item.iMaThoiGian + "," + item.iMaTour + ")' ";

                if (item.trangThai === false) {
                    xx += "class='label label-warning'>Ẩn </label></td></tr>";
                }
                else {
                    xx += "class='label label-success'>Hiện </label></td></tr>";
                }
              //  toastr.success("Thay ĐÔ.", "Thông Báo.");
            });


            $('#bodyThoiGian').html(xx);
        }
    });
}