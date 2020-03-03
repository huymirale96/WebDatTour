$(document).ready(function () {
    //   alert("đas");


    ////////////rating bar
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
        alert(ngay + " ok  ");
        // console.log("ngay: " + ngay);
        if (ngay != '') {
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
                    $("#txtDoanhSo").html("Tổng Doanh Số Là: " + x.DoanhThu );
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
  
    $("#btnThemNgay").click(function () {
        var ngay = $("#txtNgayDiThem").val();
        var hanDat = $("#txtHanDat").val(); 
       // alert(ngay + "   " + $("#matour_").val());
       // console.log("ngay: " + ngay);
        if (ngay != '') {
            $.ajax({
                type: 'post',
                url: 'suatour.aspx/themThoiGianKhoiHanh',
                data: "{ 'id' : '" + $("#matour_").val() + "', 'date' : '" + ngay + "', 'hanDat' : '" + hanDat + "' }",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (data) {
                 //   alert(data.d);
                    var xx = "";
                    var stt = 0;
                    var a = JSON.parse(data.d);
                    //  alert(a[0).dThoiGian + " leng th "+ a.length);

                   

                    $.each(a, function (index, item) {

                        xx += "<tr><td class='text-center'>" + (index + 1) + "</td><td class='text-center'>" + moment(item.dThoiGian).format('DD-MM-YYYY') + "</td><td class='text-center'>" + moment(item.dHanDatTour).format('DD-MM-YYYY')  + "</td><td class='text-center'><a href='SuaTour.aspx/?chucNang=cn1&amp;tg=" + item.iMaThoiGian + "&amp;tour=" + item.iMaTour + "'></a><label onclick='anhienthoigian(" + item.iMaThoiGian +")' ";

                        if (item.trangThai == false) {
                            xx += "class='label label-warning'>Ẩn </label></td></tr>";
                        }
                        else {
                            xx += "class='label label-success'>Hiện </label></td></tr>";
                        }
                    });
                    

                    $('#bodyThoiGian').html(xx);



                }





            });
        }
    });







    
});




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
            });


            $('#bodyThoiGian').html(xx);
        }
    });
}