
$(function() {
  //  $( "#datepicker" ).datepicker();

    $('#datepicker').datetimepicker({ dateFormat: "yy-mm-dd",
        minDateTime: (new Date()),useLocalTimezone:true});
});

