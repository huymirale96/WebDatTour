$(document).ready(function () {
    //   alert("đas");
  
    $("#btnThemNgay").click(function () {
        var ngay = $("#txtNgayDiThem").val();
       // alert(ngay + "   " + $("#matour_").val());
       // console.log("ngay: " + ngay);
        if (ngay != '') {
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
                 //   alert(data.d);
                    var xx = "";
                    var stt = 0;
                    var a = JSON.parse(data.d);
                    //  alert(a[0).dThoiGian + " leng th "+ a.length);

                   

                    $.each(a, function (index, item) {

                        xx += "<tr><td class='text-center'>" + (index + 1) + "</td><td class='text-center'>" + item.dThoiGian + "</td><td class='text-center'><a href='SuaTour.aspx/?chucNang=cn1&amp;tg=" + item.iMaThoiGian + "&amp;tour=" + item.iMaTour + "'></a><label onclick='anhienthoigian(" + item.iMaThoiGian +")' ";

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

                xx += "<tr><td class='text-center'>" + (index + 1) + "</td><td class='text-center'>" + item.dThoiGian + "</td><td class='text-center'><a href='SuaTour.aspx/?chucNang=cn1&amp;tg=" + item.iMaThoiGian + "&amp;tour=" + item.iMaTour + "'></a><label onclick='anhienthoigian(" + item.iMaThoiGian + "," + item.iMaTour + ")' ";

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