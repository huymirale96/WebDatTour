
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
    
$(document).ready(function () {
    $("#dkk").click(function () {
        $('#myModal2').modal('show');
    });

    $("#dnn").click(function () {
        $('#myModal1').modal('show');
    });
});