// Loaded via config-dir file discovery (`<configdir>/plugin/*.ts`), which resolves
// file targets directly. This sidesteps an opencode-on-Bun bug where an absolute
// directory entry in the global `plugins` array resolves to the directory itself
// (import.meta.resolve("/abs/dir") returns the dir, not package.json's entry), so
// the entry is dropped silently. See the repo README / the filed issue for detail.
export { default } from "/home/emmanuel/ghq/github.com/Armadillidiid/opencode-kiro/src/plugin.ts"
