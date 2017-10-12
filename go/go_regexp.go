package main

import (
    "fmt"
    "regexp"
)

func main() {
    re := regexp.MustCompile("<(.*?)>")
    match := re.FindStringSubmatch("something<foo@example.com>more")
    if match != nil {
        fmt.Println(match[0])
        fmt.Println(match[1])
    } else {
        fmt.Println("No match")
    }
}

// https://play.golang.org/p/_yZxMOtU-U
