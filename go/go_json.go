package main

import (
    "fmt"
    "encoding/json"
)

type EmailPayload struct {
    Recipients string `json:"to"`
    Sender     string `json:"from"`
    Subject    string `json:"subject"`
    Headers    string `json:"headers"`
    Text       string `json:"text"`
    Html       string `json:"html"`
}

func main() {
    var v EmailPayload
    str := `{"to": "to@example.com", "from": "from@from.com", "subject": "Go JSON",
    "headers": "headers body", "text": "text body", "html": "html body", "extra": "", "More": null}`
    if err := json.Unmarshal([]byte(str), &v); err != nil {
        fmt.Println(err)
    } else {
        fmt.Printf("%+v", v)
    }
}

// https://play.golang.org/p/N8IudAE_ym
