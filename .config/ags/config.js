const main = "/tmp/ags/hyprpanel/main.js";
const entry = `${App.configDir}/main`;

await Utils.execAsync(["bun", "build", entry, "--outfile", main]);

await import(`file://${main}`);

export {};
