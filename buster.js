var config = module.exports;

config["My tests"] = {
    rootPath: "./",
    environment: "browser", // or "node"
    sources: [
        "dist/steroids.js"
    ],
    tests: [
        "test/*.coffee"
    ],
    extensions: [require("buster-coffee")]
}