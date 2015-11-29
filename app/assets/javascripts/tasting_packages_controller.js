// $(document).ready(ready);
// $(document).on("page:load", ready);


$(document).on("click", ".package-wine-add-btn", function(e) {
  console.log("clicking add")
  e.preventDefault();
  
  var wineContainer = $("#package-wine-fields .wine-controls")
  var currentEntry = $(this).parents(".wine-entry:first")
  var newEntry = $(currentEntry.clone()).appendTo(wineContainer)
  newEntry.find("input").val("")

  wineContainer.find(".wine-entry:not(:last) .btn")
  .addClass("btn-danger")
  .addClass("package-wine-remove-btn")
  .removeClass("package-wine-add-btn")
  .html("<i class='fa fa-minus'></i>")

  return false;
})

$(document).on("click", ".package-wine-remove-btn", function(e) {
  console.log("clicking remove")
  e.preventDefault();
  $(this).parents(".wine-entry:first").remove();
  return false;
})

