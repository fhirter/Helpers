/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (

	"github.com/spf13/cobra"
)

// notenblattCmd represents the notenblatt command
var notenblattCmd = &cobra.Command{
	Use:   "notenblatt",
	Short: "Create notenblatt using marks from Bewertungsraster.md",
	Long:  `Create notenblatt using marks from Bewertungsraster.md by running create_notenblatt.sh`,
	Run: func(cmd *cobra.Command, args []string) {
		var option1, option2 string
		if len(args) > 0 {
			option1 = args[0]
		}
		if len(args) > 1 {
			option2 = args[1]
		}
		runScript("create_notenblatt.sh", option1, option2)
	},
}

func init() {
	rootCmd.AddCommand(notenblattCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// notenblattCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// notenblattCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
