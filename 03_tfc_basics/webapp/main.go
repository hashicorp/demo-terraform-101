package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"

	"github.com/GeertJohan/go.rice"
	"github.com/gorilla/mux"
	"github.com/graarh/golang-socketio"
	"github.com/graarh/golang-socketio/transport"
)

// Message holds the values passed between clients when they connect.
type Message struct {
	ID      int    `json:"id"`
	Browser string `json:"browser"`
	Epochs  int    `json:"epochs"`
	IP      string `json:"ip"`
	Agent   string `json:"agent"`
	Value   int    `json:"value"`
}

var db = make([]Message, 0)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "80"
	}
	portWithColon := fmt.Sprintf(":%s", port)

	fmt.Println("Starting server on http://0.0.0.0:" + port)
	router := mux.NewRouter()
	router.PathPrefix("/socket.io/").Handler(startWebsocket())
	router.PathPrefix("/").Handler(http.FileServer(rice.MustFindBox("assets").HTTPBox()))

	log.Fatal(http.ListenAndServe(portWithColon, router))
}

func startWebsocket() *gosocketio.Server {
	server := gosocketio.NewServer(transport.GetDefaultWebsocketTransport())

	fmt.Println("Starting websocket server")
	server.On(gosocketio.OnConnection, handleConnection)
	server.On("send", handleSend)

	return server
}

func handleConnection(c *gosocketio.Channel) {
	fmt.Println("New client connected")
	c.Join("visits")
	// Send all messages in db
	for _, msg := range db {
		c.BroadcastTo("visits", "message", msg)
	}
	fmt.Println("Messages in db", len(db))
}

func handleSend(c *gosocketio.Channel, msg Message) string {
	switch {
	case strings.Contains(msg.Agent, "Edge"):
		msg.Browser = "edge"
	case strings.Contains(msg.Agent, "MSIE"):
		msg.Browser = "internet-explorer"
	case strings.Contains(msg.Agent, "Chrome"):
		msg.Browser = "chrome"
	case strings.Contains(msg.Agent, "Firefox"):
		msg.Browser = "firefox"
	case strings.Contains(msg.Agent, "Safari"):
		msg.Browser = "safari"
	default:
		msg.Browser = "netscape"
	}

	db = append(db, msg)
	maxLenOfDB := 20
	if len(db) > maxLenOfDB {
		fmt.Println("Pruning DB")
		db = db[(len(db) - maxLenOfDB):]
	}
	fmt.Println("Messages in db at Send", len(db))
	c.BroadcastTo("visits", "message", msg)
	fmt.Println(msg)
	return "OK"
}
