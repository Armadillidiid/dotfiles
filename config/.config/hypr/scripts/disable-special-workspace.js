// Disable current special workspace and save its name to a file

import { execCommand } from "./exec-command.js";
import { writeFileSync } from "fs";
import { join } from "path";

const FILE_PATH = join(process.env.HOME, ".cache", "last_special_workspace");

export function disableSpecialWorkspace() {
  try {
    const monitorsJson = JSON.parse(execCommand("hyprctl monitors -j"));
    const currentWorkspaceId = parseInt(
      execCommand("hyprctl activeworkspace -j | jq -r '.monitorID'"),
    );
    const index = monitorsJson.findIndex(
      (monitor) => monitor.id === currentWorkspaceId,
    );

    if (index === -1)
      throw new Error(
        `Error: Could not find index for current workspace ID: ${currentWorkspaceId}`
      );

    const currentWorkspace = execCommand(
      `echo '${JSON.stringify(monitorsJson)}' | jq -r '.[${index}].specialWorkspace.name'`
    ).trim();

    if (!currentWorkspace)
      throw new Error("Error: Could not find special workspace");
    if (!currentWorkspace.startsWith("special:"))
      throw new Error("Error: Not a special workspace");

    const workspaceName = currentWorkspace.replace("special:", "");
    writeFileSync(FILE_PATH, workspaceName, "utf8");
    disableWorkspace(workspaceName);
  } catch (error) {
    console.error("Error:", error);
  }
}
disableSpecialWorkspace()

/**
 * Disables a special workspace.
 * @param {string} workspace - The name of the workspace to be disabled.
 */
function disableWorkspace(workspace) {
  console.log(`Disabling special workspace: ${workspace}`);
  execCommand(`hyprctl dispatch togglespecialworkspace ${workspace}`);
}
