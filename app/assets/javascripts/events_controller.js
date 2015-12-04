$(document).ready(ready);
$(document).on("page:load", ready);

function ready() {
  console.log("debugging assets");
  $("#datetimepicker_starts_at").datetimepicker({
    format: "YYYY-MM-DD HH:mm"
  });

  $("#datetimepicker_ends_at").datetimepicker({
    useCurrent: false,
    format: "YYYY-MM-DD HH:mm"
  })

  $("#datetimepicker_starts_at").on("dp.change", function(e) {
    $("#datetimepicker_ends_at").data("DateTimePicker").minDate(e.date);
  })

  $("#datetimepicker_ends_at").on("dp.change", function(e) {
    $("#datetimepicker_starts_at").data("DateTimePicker").maxDate(e.date);
  })

  $(".invite-emails-field").tokenfield();


}