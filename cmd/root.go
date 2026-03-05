/*
Copyright © 2026 Fabian

*/
package cmd

import (
	"os"

	"github.com/spf13/cobra"
)



// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "teko",
	Short: "Teko is a collection of tools for managing school-related markdown files and scripts.",
	Long: `Teko is a tool that dispatches various commands to underlying scripts for creating 
bewertungsraster, rendering markdown to pdf/html, calculating marks, etc.`,
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
}


