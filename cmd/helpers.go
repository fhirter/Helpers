package cmd

import (
	"log"
	"os"
	"os/exec"
	"path/filepath"
)

// runScript executes a script in the same directory as the executable
func runScript(scriptName string, args ...string) {
	exePath, err := os.Executable()
	if err != nil {
		log.Fatalf("Error getting executable path: %v", err)
	}
	scriptDir := filepath.Dir(exePath)
	scriptPath := filepath.Join(scriptDir, scriptName)

	cmd := exec.Command(scriptPath, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin
	if err := cmd.Run(); err != nil {
		log.Fatalf("Error running script %s: %v", scriptName, err)
	}
}

// runPython executes a python script in the same directory as the executable
func runPython(scriptName string, args ...string) {
	exePath, err := os.Executable()
	if err != nil {
		log.Fatalf("Error getting executable path: %v", err)
	}
	scriptDir := filepath.Dir(exePath)
	scriptPath := filepath.Join(scriptDir, scriptName)

	pythonArgs := append([]string{scriptPath}, args...)
	cmd := exec.Command("python3", pythonArgs...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin
	if err := cmd.Run(); err != nil {
		log.Fatalf("Error running python script %s: %v", scriptName, err)
	}
}
