export const part1 = ({ input }) => {
  let ids = 0;

  const red = 12;
  const green = 13;
  const blue = 14;

  input.forEach((line) => {
    if (!line) return;

    const { game, sets } = parseInput(line);
    let success = true;
    sets.forEach((set) => {
      const { r, g, b } = set;
      if (r > red || g > green || b > blue) {
        success = false;
      }
    });
    if (success) {
      ids += game;
    }
    success = true;
  });
  return ids;
};

export const part2 = ({ input }) => {
  let sumOfPowers = 0;

  input.forEach((line) => {
    if (!line) return;

    const { sets } = parseInput(line);

    let red = 0;
    let green = 0;
    let blue = 0;

    sets.forEach((set) => {
      red = Math.max(red, set.r);
      green = Math.max(green, set.g);
      blue = Math.max(blue, set.b);
    });
    sumOfPowers += red * green * blue;
  });

  return sumOfPowers;
};

function parseInput(input) {
  const { game, sets } = /Game (?<game>\d+): (?<sets>.*)/.exec(input).groups;
  const parsedSets = sets.split(";").map((set) => {
    let red = 0;
    let green = 0;
    let blue = 0;

    set
      .trim()
      .split(",")
      .forEach((entry) => {
        const { color, value } = /(?<value>\d+) (?<color>\w+)/.exec(
          entry.trim(),
        ).groups;

        switch (color) {
          case "red":
            red += parseInt(value);
            break;
          case "green":
            green += parseInt(value);
            break;
          case "blue":
            blue += parseInt(value);
            break;
        }
      });

    return { r: red, g: green, b: blue };
  });

  return { game: parseInt(game), sets: parsedSets };
}
