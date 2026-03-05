/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (

	"github.com/spf13/cobra"
)

// publishCmd represents the publish command
var publishCmd = &cobra.Command{
	Use:   "publish",
	Short: "Render markdown to html",
	Long:  `Render markdown to html by running publish.sh`,
	Run: func(cmd *cobra.Command, args []string) {
		var option1, option2 string
		if len(args) > 0 {
			option1 = args[0]
		}
		if len(args) > 1 {
			option2 = args[1]
		}
		runScript("publish.sh", option1, option2)
	},
}

func init() {
	rootCmd.AddCommand(publishCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// publishCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// publishCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
