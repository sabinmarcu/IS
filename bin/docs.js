process.argv = ["node", "app", "--title", "'ISF Documentation'", "-o", "docs", "src"]
require("coffee-script")
require("../node_modules/codo/src/codo").run()