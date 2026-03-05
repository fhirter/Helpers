/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (

	"github.com/spf13/cobra"
)

// dirCmd represents the dir command
var dirCmd = &cobra.Command{
	Use:   "dir",
	Short: "Create directories from notenblatt file",
	Long:  `Create directories from notenblatt file by running setup_directory.sh`,
	Run: func(cmd *cobra.Command, args []string) {
		runScript("setup_directory.sh")
	},
}

func init() {
	rootCmd.AddCommand(dirCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// dirCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// dirCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
