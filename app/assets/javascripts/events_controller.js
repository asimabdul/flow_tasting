$(document).ready(ready);
$(document).on("page:load", ready);

function ready() {
  $("#event_date_picker").datepicker();

  $("#event_time_picker").timepicker();

  $(".invite-emails-field").tokenfield();

}

$(document).off("click", ".event-date-icon").on("click", ".event-date-icon", function(e) {
  $("#event_date_picker").focus();
})

$(document).off("click", ".event-time-icon").on("click", ".event-time-icon", function(e) {
  $("#event_time_picker").focus();
})