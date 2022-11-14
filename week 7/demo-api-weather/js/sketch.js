var weather;

function setup() {
    var canvas = createCanvas(600, 600);
    canvas.parent('canvasForHTML');
    loadJSON('http://api.openweathermap.org/data/2.5/weather?q=Rome&appid=1f6b9d2bbebdea058b6d72640ce86e31&units=metric', myData)
  }
  

function myData(data){
    weather = data;
    //print(air.list[0].components.co)

}

function draw() {
    background(0);
    if (weather){
        ellipse(100, 100, weather.main.temp, weather.main.temp);
        ellipse(300, 300, weather.main.humidity, weather.humidity);
    }
  }

