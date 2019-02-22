package main

import (
	"fmt"
	"log"
	"net/http"
	_ "net/http/pprof"
	"time"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

func spinsleep(n uint64) uint64 {
	// defer timeTrack(time.Now(), "spinsleep")
	var i uint64
	for i = 0; i <= n; i++ {
	}
	return i
}

// func timeTrack(start time.Time, name string) {
//     elapsed := time.Since(start)
//     log.Printf("%s took %s", name, elapsed)
// }

func measureSpinsleep(n uint64) time.Duration {
	start := time.Now()
	spinsleep(n)
	return time.Since(start)
}

func calibrateSpinsleepN(target time.Duration) uint64 {
	var n uint64 = 1000
	duration := measureSpinsleep(n)
	// log.Printf("n is %d and duration is %s", n, duration)
	for (duration - target) < 0 {
		if (target / duration) > 5 {
			n *= 5
		} else {
			n *= 2
		}
		duration = measureSpinsleep(n)
		// log.Printf("n is %d and duration is %s", n, duration)
	}
	for (target - duration) < 0 {
		n = n - (n / 10)
		duration = measureSpinsleep(n)
		// log.Printf("n is %d and duration is %s", n, duration)
	}
	var round int
	for round = 0; round < 25; round++ {
		duration = measureSpinsleep(n)
		if (duration - target) > 0 {
			round = 0
			n = n - (n / 100)
		}
		// log.Printf("n is %d and duration is %s (round %d)", n, duration, round)
	}
	log.Printf("n is %d and duration is %s", n, duration)
	return n
}

func debugServer() {
	log.Println(http.ListenAndServe(":6060", nil))
}

func main() {
	n := calibrateSpinsleepN(time.Duration(50) * time.Millisecond)
	handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		go spinsleep(n)
		fmt.Fprint(w, "Hello world")
	})
	h2s := &http2.Server{
	}
	h1s := &http.Server{
		Addr:    ":8080",
		Handler: h2c.NewHandler(handler, h2s),
	}
	go debugServer()
	log.Fatal(h1s.ListenAndServe())
}
