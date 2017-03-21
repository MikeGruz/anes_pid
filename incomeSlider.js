$(document).ready(function() {

  function incomeLabel(num) {
    var income = [
      "0-2,500",
      "2,501-7,499",
      "7,500-11,249",
      "22,250-13,749",
      "13,750-16,249",
      "16,250-18,749",
      "18,750-21,249",
      "21,250-23,749",
      "23,750-26,249",
      "26,250-28,749",
      "28,750-32,499",
      "32,500-37,499",
      "37,500-42,499",
      "42,500-47,499",
      "47,500-52,499",
      "52,500-57,499",
      "57,500-62,499",
      "62,500-67,499",
      "67,500-72,499",
      "72,500-77,499",
      "77,500-84,999",
      "85,000-94,999",
      "95,000-104,999",
      "105,000-117,499",
      "117,500-137,499",
      "137,500-162,499",
      "162,500-212,499",
      "212,500+"
    ];
    
    // return val of input - 1 
    return income[num-1];
  }
  
  /**
  Tweak ionRangeSlider options
  prettify tells the ionRangeSlider to 
  use our createLabel function to
  render the slider labels
  */
  var slider = $("#income").ionRangeSlider({
    prettify: incomeLabel,
  });
})