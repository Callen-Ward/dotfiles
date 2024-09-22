import { icons, makeIcon } from "icons";

export const Menu = () =>
  Widget.Button({
    classNames: ["bar-widget", "menu"],
    child: makeIcon(icons.menu),
    onClicked: async () =>
      Utils.execAsync(
        await Utils.execAsync(
          "tofi-run --font='Fira Code Nerd Font Semibold' --font-size=12 --background-color=16161e --outline-width=0 --border-width=2 --border-color=565f89 --text-color=c0caf5 --selection-color=7dcfff --width=30% --height=20% --corner-radius=10",
        ),
      ),
  });
