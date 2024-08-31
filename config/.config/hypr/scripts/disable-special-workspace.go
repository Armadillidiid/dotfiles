package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
)

const filePath = "/home/emmanuel/.cache/last_special_workspace"

// Monitor represents a monitor in the hyprctl output
type Monitor struct {
	ID int `json:"id"`
	SpecialWorkspace struct {
		Name string `json:"name"`
	} `json:"specialWorkspace"`
}

// HyprctlWorkspace represents the active workspace output from hyprctl
type HyprctlWorkspace struct {
	MonitorID int `json:"monitorID"`
}

// disableWorkspace disables a special workspace
func disableWorkspace(workspace string) {
	fmt.Printf("Disabling special workspace: %s\n", workspace)
	cmd := exec.Command("hyprctl", "dispatch", "togglespecialworkspace", workspace)
	if err := cmd.Run(); err != nil {
		log.Fatalf("Failed to disable workspace: %v", err)
	}
}

// runCommand executes a shell command and returns the output
func runCommand(name string, args ...string) ([]byte, error) {
	cmd := exec.Command(name, args...)
	var out bytes.Buffer
	cmd.Stdout = &out
	err := cmd.Run()
	return out.Bytes(), err
}

func main() {
	// Get monitors JSON
	monitorsJSON, err := runCommand("hyprctl", "monitors", "-j")
	if err != nil {
		log.Fatalf("Failed to get monitors: %v", err)
	}

	// Unmarshal monitors JSON
	var monitors []Monitor
	if err := json.Unmarshal(monitorsJSON, &monitors); err != nil {
		log.Fatalf("Failed to unmarshal monitors JSON: %v", err)
	}

	// Get current workspace ID
	activeWorkspaceJSON, err := runCommand("hyprctl", "activeworkspace", "-j")
	if err != nil {
		log.Fatalf("Failed to get active workspace: %v", err)
	}

	// Unmarshal active workspace JSON
	var currentWorkspace HyprctlWorkspace
	if err := json.Unmarshal(activeWorkspaceJSON, &currentWorkspace); err != nil {
		log.Fatalf("Failed to unmarshal active workspace JSON: %v", err)
	}

	// Find index for current workspace ID
	var index int
	found := false
	for i, monitor := range monitors {
		if monitor.ID == currentWorkspace.MonitorID {
			index = i
			found = true
			break
		}
	}

	if !found {
		log.Fatalf("Error: Could not find index for current workspace ID: %d", currentWorkspace.MonitorID)
	}

	// Get current workspace name
	currentWorkspaceName := monitors[index].SpecialWorkspace.Name

	if currentWorkspaceName == "" {
		log.Fatalf("Error: Could not find special workspace")
	}

	if !strings.HasPrefix(currentWorkspaceName, "special:") {
		log.Fatalf("Error: Not a special workspace")
	}

	workspaceName := strings.TrimPrefix(currentWorkspaceName, "special:")
	if err := os.WriteFile(filePath, []byte(workspaceName), 0644); err != nil {
		log.Fatalf("Failed to write to file: %v", err)
	}
	disableWorkspace(workspaceName)
}
