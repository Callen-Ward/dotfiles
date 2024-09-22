import { globalMousePos } from "globals";
import Gdk from "types/@girs/gdk-3.0/gdk-3.0";

export const closeAllMenus = () => {
  const menuWindows = App.windows
    .filter((w) => {
      if (w.name) {
        return /.*menu/.test(w.name);
      }

      return false;
    })
    .map((w) => w.name);

  menuWindows.forEach((w) => {
    if (w) {
      App.closeWindow(w);
    }
  });
};

export const openMenu = (clicked: any, event: Gdk.Event, window: string) => {
  const middleOfButton = Math.floor(clicked.get_allocated_width() / 2);
  const xAxisOfButtonClick = clicked.get_pointer()[0];
  const middleOffset = middleOfButton - xAxisOfButtonClick;

  const clickPos = event.get_root_coords();
  const adjustedXCoord = clickPos[1] + middleOffset;
  const coords = [adjustedXCoord, clickPos[2]];

  globalMousePos.value = coords;

  closeAllMenus();
  App.toggleWindow(window);
};
