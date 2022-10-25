
$(document).ready(function() {

    let html = "";

    /* 
    * Read weather data from Open Weather API
    */


    $.getJSON('http://api.openweathermap.org/data/2.5/weather?q=Rome&appid=1f6b9d2bbebdea058b6d72640ce86e31&units=metric', function(data) {

      console.log(data);
        let currentTemp = data["main"]["temp"];
        let feelsTemp = data["main"]["feels_like"];

        console.log(currentTemp)
        console.log(feelsTemp)

        let wind = data["wind"]["speed"];
        $('#temp').text(currentTemp);
        $('#feels').text(feelsTemp); 
    });

    console.log("Hello world!!!")

});