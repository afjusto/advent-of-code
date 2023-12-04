export const part1 = ({ input }) => {
  let result = 0;

  input.forEach((line) => {
    if (!line) return;

    const matchingNumbers = getMatchingNumbers(line);
    result += getPoints(matchingNumbers);
  });

  return result;
};

function getMatchingNumbers(line) {
  const { winning: winningString, numbers: numbersString } =
    /Card.*: (?<winning>.*) \| (?<numbers>.*)/g.exec(line).groups;

  const winning = winningString.split(" ").map((n) => parseInt(n.trim()));
  const numbers = numbersString.split(" ").map((n) => parseInt(n.trim()));

  return winning.filter((n) => numbers.includes(n)).filter(Boolean).length;
}

function getPoints(count) {
  if (count === 0) return 0;

  let points = 1;
  for (let i = 1; i < count; i++) {
    points *= 2;
  }

  return points;
}

export const part2 = ({ input }) => {
  let result = 0;
  const scratchCards = new Array(input.length).fill(0);

  input.forEach((line, index) => {
    if (!line) return;

    let cardIndex = index + 1;
    scratchCards[cardIndex]++;

    const matchingNumbers = getMatchingNumbers(line);

    for (let i = cardIndex + 1; i <= cardIndex + matchingNumbers; i++) {
      scratchCards[i] += scratchCards[cardIndex];
    }
  });

  result = scratchCards.reduce((acc, card) => acc + card, 0);

  return result;
};
