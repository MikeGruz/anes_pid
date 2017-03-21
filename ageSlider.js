$(document).ready(function() {

  function ageLabel(num) {
    var age = [
      "17-20",
      "21-24",
      "25-29",
      "30-34",
      "35-39",
      "40-44",
      "45-49",
      "50-54",
      "55-59",
      "60-64",
      "65-69",
      "70-74",
      "75+"
    ];
    
    // return val of input - 1 
    return age[num-1];
  }
  
  /**
  Tweak ionRangeSlider options
  prettify tells the ionRangeSlider to 
  use our createLabel function to
  render the slider labels
  */
  var slider = $("#age").ionRangeSlider({
    prettify: ageLabel,
  });
})