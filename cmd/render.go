/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (

	"github.com/spf13/cobra"
)

// renderCmd represents the render command
var renderCmd = &cobra.Command{
	Use:   "render",
	Short: "Render markdown to pdf",
	Long:  `Render markdown to pdf by running render.sh`,
	Run: func(cmd *cobra.Command, args []string) {
		var option1 string
		if len(args) > 0 {
			option1 = args[0]
		}
		runScript("render.sh", option1)
	},
}

func init() {
	rootCmd.AddCommand(renderCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// renderCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// renderCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
