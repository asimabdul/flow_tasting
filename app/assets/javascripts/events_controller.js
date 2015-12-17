$(document).ready(ready);
$(document).on("page:load", ready);

function ready() {
  $("#datetimepicker_starts_at").datetimepicker({
    format: "YYYY-MM-DD HH:mm",
    minDate: moment()
  });

  $(".invite-emails-field").tokenfield();

}