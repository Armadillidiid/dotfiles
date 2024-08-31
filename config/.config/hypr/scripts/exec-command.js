import { execSync } from "child_process";

/**
 * Executes a shell command synchronously using child_process.execSync.
 * @param {string} command - The shell command to be executed.
 * @returns {string} The output of the executed command as a string.
 * @throws Error if the command encounters an error during execution.
 */
export function execCommand(command) {
  try {
    return execSync(command, { encoding: "utf8", shell: "/bin/bash" });
  } catch (error) {
    console.error(`Error executing command: ${command}`, error);
    throw error;
  }
}
