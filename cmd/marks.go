/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (

	"github.com/spf13/cobra"
)

// marksCmd represents the marks command
var marksCmd = &cobra.Command{
	Use:   "marks",
	Short: "Calculate marks and point from notenblatt file",
	Long:  `Calculate marks and point from notenblatt file by running marks.py`,
	Run: func(cmd *cobra.Command, args []string) {
		var option1 string
		if len(args) > 0 {
			option1 = args[0]
		}
		runPython("marks.py", option1)
	},
}

func init() {
	rootCmd.AddCommand(marksCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// marksCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// marksCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
