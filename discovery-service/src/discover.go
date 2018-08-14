package main

import (
    "fmt"
    "log"
    "os/exec"
)

func main() {
    log.Println("Cam Discovery Init")
    discovery("VIVOTEK");
    log.Println("Cam Discovery End")
}


func discovery(model string) {
    switch model {
    case "VIVOTEK":
        fmt.Println("Vivotek")
        vivotek_search()
    default:
        fmt.Printf("Don't know type %T\n", model)
    }
}


func vivotek_search() {
    cmd := exec.Command("/usr/bin/nmap", "-p", "554", "192.168.1.1/24") //not portable
    out, err := cmd.CombinedOutput()
    if err != nil {
        log.Fatalf("cmd.Run() failed with %s\n", err)
    }
    fmt.Printf("combined out:\n%s\n", string(out))
}
