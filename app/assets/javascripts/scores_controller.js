$(document).ready(ready);
$(document).on("page:load", ready);

function ready() {

  $("ul.scorecard-tabs li:first a:first").tab("show");

  $(".rating-slider").slider({
    tooltip: "hide",
    formatter: function(value) {
      return 'Flavor rating: ' + value;
    }
  });

  $(".rating-slider").on("slide", function(e) {
    var sliderElement = $(e.target)
    var sliderValueHolder = sliderElement.closest(".row").find("strong.rating-value-holder");
    sliderValueHolder.text(sliderElement.data("rating-attr") + " - " + e.value);
  })

}