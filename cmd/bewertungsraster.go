package cmd

import (
	"github.com/spf13/cobra"
)

var bewertungsrasterCmd = &cobra.Command{
	Use:   "bewertungsraster",
	Short: "Create bewertungsraster markdown file",
	Long:  `Create bewertungsraster markdown file by running create_bewertungsraster.sh`,
	Run: func(cmd *cobra.Command, args []string) {
		runScript("scripts/create_bewertungsraster.sh")
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
