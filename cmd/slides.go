package cmd

import (
	_ "embed"
	"os"
	"os/exec"

	"github.com/spf13/cobra"
)

//go:embed templates/slides/theme.css
var themeCSS []byte

var slidesCmd = &cobra.Command{
	Use:   "slides <file>",
	Short: "Create slides from a markdown file using marp.",
	Args:  cobra.ExactArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		runSlideRenderer(args[0])
	},
}

func runSlideRenderer(filepath string) {
	themeFile, _ := createEmbeddedTheme()
	defer os.Remove(themeFile)

	cmd := exec.Command(
		"marp",
		"--allow-local-files",
		"--pdf",
		filepath,
		"--theme",
		themeFile,
	)

	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin

	cmd.Run()
}

func createEmbeddedTheme() (string, error) {
	f, err := os.CreateTemp("", "teko-theme-*.css")
	if err != nil {
		return "", err
	}

	defer f.Close()

	if _, err := f.Write(themeCSS); err != nil {
		os.Remove(f.Name())
		return "", err
	}

	return f.Name(), nil
}

func init() {
	rootCmd.AddCommand(slidesCmd)
}
