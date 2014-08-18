$(document).ready(function () {

  var sliderState = 0

  slide = function() {
    var sliderModulo = sliderState % 3;

    if (sliderModulo === 0) {
        $('#shouldI').hide()
        $('#optionInputForm').show()
    }
    else if (sliderModulo === 1) {
      $('#optionInputForm').hide()
      $('#proCon').show()
    }
    else {
        $('#proCon').hide()
        $('#shouldI').show()
    }

    sliderState++
  }

  $('.container').on('swipe', slide)
})
