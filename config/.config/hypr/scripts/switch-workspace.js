import { execCommand } from "./exec-command";
// import { disableSpecialWorkspace } from "./disable-special-workspace.js";
import { argv } from "process";

const arg = argv[2];
try {
  execCommand(`hyprctl dispatch workspace ${arg}`)
  // disableSpecialWorkspace()
  await import("./disable-special-workspace.js")
} catch (error) {
  console.error(error)
}
