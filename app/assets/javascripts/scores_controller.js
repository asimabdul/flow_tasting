$(document).ready(ready);
$(document).on("page:load", ready);

var bodyScoreMap = { 1: "Light", 2: "Medium", 3: "Full" }
var sweetnessScoreMap = { 1: "Dry", 2: "Medium", 3: "Sweet" }
var acidityScoreMap = { 1: "Low", 2: "Medium", 3: "High" }
var finishScoreMap = { 1: "Short", 2: "Medium", 3: "Long" }

function ready() {

  $('[data-toggle="popover"]').popover();

  $("ul.scorecard-tabs li:first a:first").tab("show");

  $(".rating-slider").slider({
    tooltip: "hide",
    formatter: function(value) {
      return 'Flavor rating: ' + value;
    }
  });

  $(".rating-slider").on("slide", function(e) {
    var sliderElement = $(e.target)
    var sliderValueHolder = sliderElement.closest(".row").find("span.rating-value-holder");
    sliderValueHolder.text(" - " + translateSliderValue(sliderElement.data("rating-attr"), e.value || sliderElement.data("slider-value")));
  })

  $(".rating-slider").trigger("slide");

}

function translateSliderValue(attr, val) {
  switch (attr) {
    case "body":
      return bodyScoreMap[val];
    case "sweetness":
      return sweetnessScoreMap[val];
    case "acidity":
      return acidityScoreMap[val];
    case "finish":
      return finishScoreMap[val];
    case "rank":
      return val;
    default:
      console.log("Unkown slider attr!");
      return false;
  }
}
