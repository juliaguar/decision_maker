$(document).ready(function () {
  slide = function() {
    $('#optionInputForm').toggle();
    $('#shouldI').toggle();
  }

  $('.container').on('swipe', slide)
})
