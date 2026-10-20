/*
Copyright © 2026 Fabian
*/
package main

import (
	"embed"
	"io/fs"
	"os"
	"path/filepath"
	"strings"

	"github.com/fabian/teko/cmd"
)

//go:embed scripts
var scripts embed.FS

func main() {
	tmpDir, err := extractScripts()
	if err != nil {
		panic(err)
	}
	defer os.RemoveAll(tmpDir)

	cmd.SetAssetsDir(tmpDir)
	cmd.Execute()
}

func extractScripts() (string, error) {
	tmpDir, err := os.MkdirTemp("", "teko-*")
	if err != nil {
		return "", err
	}

	err = fs.WalkDir(scripts, ".", func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}

		// Remove the scripts/ prefix from the extracted paths.
		relPath := strings.TrimPrefix(path, "scripts")
		relPath = strings.TrimPrefix(relPath, "/")
		if relPath == "" {
			return nil
		}

		target := filepath.Join(tmpDir, relPath)

		if d.IsDir() {
			return os.MkdirAll(target, 0755)
		}

		data, err := fs.ReadFile(scripts, path)
		if err != nil {
			return err
		}

		if err := os.MkdirAll(filepath.Dir(target), 0755); err != nil {
			return err
		}

		return os.WriteFile(target, data, 0644)
	})
	if err != nil {
		os.RemoveAll(tmpDir)
		return "", err
	}

	return tmpDir, nil
}
