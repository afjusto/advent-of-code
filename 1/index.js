export const part1 = ({ input }) => {
  const result = input.reduce((acc, line) => {
    if (!line) return acc;

    const digits = line.match(/\d/g);
    return acc + parseInt(digits[0] + parseInt(digits[digits.length - 1]));
  }, 0);

  return result;
};

export const part2 = ({ input }) => {
  const regex = /(?:\d|one|two|three|four|five|six|seven|eight|nine)/g;
  const digits = {
    one: "1",
    two: "2",
    three: "3",
    four: "4",
    five: "5",
    six: "6",
    seven: "7",
    eight: "8",
    nine: "9",
  };

  const result = input.reduce((acc, line) => {
    if (!line) return acc;
    const matches = line.match(regex);

    const first = digits[matches[0]] || matches[0];

    let lastNumber = false;
    let count = -1;

    while (!lastNumber) {
      const testString = line.slice(count);
      if (testString.match(regex)) {
        lastNumber = testString.match(regex)[0];
      }
      count--;
    }
    const last = digits[lastNumber] || lastNumber;

    return acc + parseInt(first + last);
  }, 0);

  return result;
};
