package slice_vs_map

import (
	"flag"
	"fmt"
	"log"
	"math/rand"
	"os"
	"strings"
	"testing"
)

func TestMapTo(t *testing.T) {
	func() {
		d := newSlice()
		ix := rand.Perm(testN)
		for _, v := range testVals {
			d.set(v)
		}
		for _, idx := range ix {
			d.delete(testVals[idx])
		}
		for _, idx := range ix {
			if d.exist(testVals[idx]) {
				t.Errorf("%s should have not existed!", testVals[idx])
			}
		}
	}()

	func() {
		d := newMap()
		ix := rand.Perm(testN)
		for _, v := range testVals {
			d.set(v)
		}
		for _, idx := range ix {
			d.delete(testVals[idx])
		}
		for _, idx := range ix {
			if d.exist(testVals[idx]) {
				t.Errorf("%s should have not existed!", testVals[idx])
			}
		}
	}()
}

var (
	opt      string
	testN    = 30000
	testVals = make([]string, testN)
)

func init() {
	flag.StringVar(&opt, "opt", "slice", "'slice' or 'map'.")
	flag.Parse()
	opt = strings.TrimSpace(strings.ToLower(opt))
	if opt != "slice" && opt != "map" {
		fmt.Fprintln(os.Stderr, fmt.Errorf("unknown option", opt))
		os.Exit(1)
	}
	log.Println("Running benchmarks with", opt)

	log.Println("Filling up the test data...")
	vs := multiRandBytes(15, testN)
	for i := 0; i < testN; i++ {
		testVals[i] = string(vs[i])
	}
	log.Println("Done! Test data is ready!")
}

func BenchmarkSet(b *testing.B) {
	var d Interface
	if opt == "slice" {
		d = newSlice()
	} else {
		d = newMap()
	}

	b.StartTimer()
	b.ReportAllocs()

	for _, v := range testVals {
		d.set(v)
	}
}

func BenchmarkExist(b *testing.B) {
	b.StopTimer()
	var d Interface
	if opt == "slice" {
		d = newSlice()
	} else {
		d = newMap()
	}
	for _, v := range testVals {
		d.set(v)
	}

	// to make it not biased towards data structures
	// with an order, such as slice.
	ix := rand.Perm(testN)

	b.StartTimer()
	b.ReportAllocs()

	for _, idx := range ix {
		if !d.exist(testVals[idx]) {
			b.Errorf("%s should have existed!", testVals[idx])
		}
	}
}

func BenchmarkDelete(b *testing.B) {
	b.StopTimer()
	var d Interface
	if opt == "slice" {
		d = newSlice()
	} else {
		d = newMap()
	}
	for _, v := range testVals {
		d.set(v)
	}

	// to make it not biased towards data structures
	// with an order, such as slice.
	ix := rand.Perm(testN)

	b.StartTimer()
	b.ReportAllocs()

	for _, idx := range ix {
		d.delete(testVals[idx])
	}
}
