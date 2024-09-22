const clockText = Variable("", {
  poll: [1000, "date '+%a %d/%m %H:%M'"],
});

export const Clock = () =>
  Widget.Label({
    classNames: ["bar-widget", "clock"],
    label: clockText.bind(),
  });
