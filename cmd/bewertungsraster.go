/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (
	"log"
	"os"
	"os/exec"
	"path/filepath"

	"github.com/spf13/cobra"
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

// bewertungsrasterCmd represents the bewertungsraster command
var bewertungsrasterCmd = &cobra.Command{
	Use:   "bewertungsraster",
	Short: "Create bewertungsraster markdown file",
	Long:  `Create bewertungsraster markdown file by running create_bewertungsraster.sh`,
	Run: func(cmd *cobra.Command, args []string) {
		runScript("create_bewertungsraster.sh")
	},
}

func init() {
	rootCmd.AddCommand(bewertungsrasterCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// bewertungsrasterCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// bewertungsrasterCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
