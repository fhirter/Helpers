/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (

	"github.com/spf13/cobra"
)

// printCmd represents the print command
var printCmd = &cobra.Command{
	Use:   "print",
	Short: "Print all files called <filename> from all subdirectories",
	Long:  `Print all files called <filename> from all subdirectories by running print.sh`,
	Run: func(cmd *cobra.Command, args []string) {
		var option1 string
		if len(args) > 0 {
			option1 = args[0]
		}
		runScript("print.sh", option1)
	},
}

func init() {
	rootCmd.AddCommand(printCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// printCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// printCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
