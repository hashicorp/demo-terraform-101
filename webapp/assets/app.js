var data = [{ date: new Date(), value: 1 }];
var ids = {};

const windowWidth = $(window).width();
function renderChart(data) {
  MG.data_graphic({
    title: "Visits",
    description: "This graphic shows a time series of page views.",
    data: data,
    width: windowWidth < 800 ? windowWidth - 40 : 700,
    height: windowWidth < 800 ? 150 : 250,
    chart_type: "histogram",
    bins: 30,
    bar_margin: 0,
    target: "#chart",
    x_accessor: "date",
    y_accessor: "value"
  });
}

renderChart(data);

function addTableRow(record) {
  // {browser:"firefox", epochs:39929283829, ip:"10.0.0.1", agent:"Chrome 238.23"}
  $("#visits tbody").prepend(
    '<tr><td><img src="images/128/' +
      record.browser +
      '_128x128.png"></td><td>' +
      '<div class="metadata"><span class="time">' +
      moment(record.epochs).format("LT") +
      "</span></div>" +
      '<div class="agent">' +
      record.agent +
      "</div>" +
      "</td></tr>"
  );
}

function logVisit(record) {
  if (ids[record.id] === undefined) {
    record.date = new Date(record.epochs);
    data.push(record);
    renderChart(data);
    addTableRow(record);
    ids[record.id] = 1;
  }
}

var socket = io({ transports: ["websocket"] });

// Listen for messages
socket.on("message", function(message) {
  logVisit(message);
});

socket.on("connect", function() {
  // Broadcast a message
  var message = {};
  const epochs = new Date().getTime();

  function broadcastMessage() {
    message.epochs = new Date().getTime();
    message.id = message.epochs;
    socket.emit("send", message, function(result) {
      // Silent success
    });
  }

  message = {
    id: epochs,
    browser: navigator.appName.toLowerCase(),
    epochs: epochs,
    agent: navigator.userAgent,
    value: 1
  };
  broadcastMessage();

  setInterval(broadcastMessage, 30 * 1000);
});
