$(document).ready(ready);
$(document).on("page:load", ready);

function ready() {
  $("#event_date_picker").datepicker();

  $("#event_time_picker").timepicker();

  $(".invite-emails-field").tokenfield();

}