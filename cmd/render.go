package cmd

import (
	"os"
	"os/exec"
	"path/filepath"

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
		err := runRenderScript(option1)
		if err != nil {
			return
		}
	},
}

func init() {
	rootCmd.AddCommand(renderCmd)
}

func runRenderScript(option1 string) error {
	scriptPath := filepath.Join(assetsDir, "render.sh")

	cmd := exec.Command("sh", scriptPath, option1)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin

	return cmd.Run()
}
