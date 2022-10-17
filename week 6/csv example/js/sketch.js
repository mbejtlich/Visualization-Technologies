/*
PIE CHART
Jeff Thompson | 2021 | jeffreythompson.org


Here, we graph US occupations in creative industries, pulled
from the Bureau of Labor Statistics.

SEE ALSO
+ https://www.chartjs.org/docs/latest/charts/doughnut.html

DATA SOURCE
+ https://leanin.org/research/state-of-black-women-in-corporate-america/section-3-everyday-discrimination


*/

d3.csv('data/WomenFeelingIncluded.csv').then(function(loadedData) {
    let data =   []; // percentages (column 2)
    let labels = []; // labels (column 1)
    
    console.log(loadedData.length)
    for (let i=0; i<loadedData.length; i++) {
      let race = loadedData[i].race;
      labels.push(race);  // add new element to array
      
      let percent = loadedData[i].percentage_included;
      data.push(percent);
      //console.log(i)
      //console.log(race)
      //console.log(percent)
    }

    console.log(data)
    //console.log(labels)
    
    // optionally, add colors based on our data
    // (uses a function at the bottom, check it out 
    // if you're interested in how this is accomplished)
    let colors = generateColors(
      data,         // the data
      [150, 75, 0],   // rgb values for the first color
      [92,70,50]   // and for the other
    );
    
    let options = {
      
      // pie chart, please!
      type: 'pie',
      
      // everything else is pretty much
      // like we've used before
      data: {
        labels: labels,
        datasets: [{
          data: data,
          
          // the colors we generated above
          // (otherwise will be gray)
          backgroundColor: colors,
          hoverBackgroundColor: 'rgb(0,150,100)'
        }]
      },
      options: {
        title: {
          display: true,
        },
        
        // we have a lot of data here, so the
        // legend is in the way and doesn't provide
        // us with any helpful info
        legend: {
          display: false
        }
      }
    };
    
    let chart = new Chart(document.getElementById('canvas2'), options);
  });
  
  
  // an extra bit of code that generates a list
  // of colors based on the data – the values
  // will be between two colors specified above
  function generateColors(data, c1, c2) {
    
    // get the min/max values from the data
    let minVal = Math.min(...data);
    let maxVal = Math.max(...data);
    
    // convert those to color values
    let c = [];
    for (let d of data) {
      let r = scale(d, minVal,maxVal, c1[0],c2[0]);
      let g = scale(d, minVal,maxVal, c1[1],c2[1]);
      let b = scale(d, minVal,maxVal, c1[2],c2[2]);
      c.push('rgb(' + r + ',' + g + ',' + b + ')');
    }
    return c;
  }
  
  // helpful function: scales numbers from one range
  // to another (in this case our data to RGB)
  function scale(num, inMin, inMax, outMin, outMax) {
    return (num-inMin) * (outMax-outMin) / (inMax-inMin)+outMin;
  }
  
  