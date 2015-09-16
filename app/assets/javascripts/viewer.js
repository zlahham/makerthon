// Enable pusher logging - don't include this in production
// Pusher.log = function(message) {
//   if (window.console && window.console.log) {
//     window.console.log(message);
//   }
// };

// var pusher = new Pusher('da575b9edde9ebf3a600', {
//   encrypted: true
// });

// var channel = pusher.subscribe('voting');
// channel.bind('my_event', function(data) {
//   // alert(data.upvote);
//   var up = document.getElementById("upvote");
//   var down = document.getElementById("downvote");
//   up.innerHTML = data.upvote;
//   down.innerHTML = data.downvote;

// });

// dev key for pusher
// da575b9edde9ebf3a600
// production 9a2f3193a0af5c40e9c0


  Pusher.log = function(message) {
    if (window.console && window.console.log) {
      window.console.log(message);
    }
  };

  var pusher = new Pusher('da575b9edde9ebf3a600', {
    encrypted: true
  });

  var channel = pusher.subscribe('voting');
  channel.bind('my_event', function(data) {
    // alert(data.upvote);
    var up = document.getElementById("upvote");
    var down = document.getElementById("downvote");
    // up.innerHTML = data.upvote;
    // down.innerHTML = data.downvote;

    var upCount = data.upvote;
    var downCount = data.downvote;
    var neutralCount = data.neutral;


    chartCreate(upCount, downCount, neutralCount);
});


function chartCreate(upCount, downCount, neutralCount) {
      d3.select("svg").remove();
      //Width and height
      var w = 300;
      var h = 300;


      var dataset = [ upCount, downCount, neutralCount];
      var totalVoters = upCount + downCount + neutralCount;

      var outerRadius = w / 2;
      var innerRadius = w / 3;
      var arc = d3.svg.arc()
              .innerRadius(innerRadius)
              .outerRadius(outerRadius);

      var pie = d3.layout.pie();

      //Easy colors accessible via a 10-step ordinal scale
      // var color = d3.scale.category10();
      var color = d3.scale.ordinal().range(['#7ED321','#FF001F','#F8E71C']);

      //Create SVG element

      var svg = d3.select("div#chart")
            .append("svg")
            .attr("width", w)
            .attr("height", h);

      //Set up groups
      var arcs = svg.selectAll("g.arc")
              .data(pie(dataset))
              .enter()
              .append("g")
              .attr("class", "arc")
              .attr("transform", "translate(" + outerRadius + "," + outerRadius + ")");

      //Draw arc paths
      arcs.append("path")
          .attr("fill", function(d, i) {
            return color(i);
          })
          .attr("d", arc);

      //Labels
      arcs.append("text")
          .attr("transform", function(d) {
            return "translate(" + arc.centroid(d) + ")";
          })
          .attr("text-anchor", "middle")
          .text(function(d) {
            return d.value;
            // return totalVoters;
          });

}
