// Enable pusher logging - don't include this in production
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
  up.innerHTML = data.upvote;
  down.innerHTML = data.downvote;

});
