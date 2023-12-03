export const part1 = ({ input }) => {
  let result = 0;

  for (let i = 0; i < input.length; i++) {
    let digit = "";
    let foundAdjacentSymbol = false;
    for (let j = 0; j < input[i].length; j++) {
      const isNumber = /\d/.test(input[i][j]);

      if (isNumber) {
        digit += input[i][j];

        if (!foundAdjacentSymbol) {
          const adjacentSymbol = getAdjacentSymbol({
            input,
            row: i,
            column: j,
          });
          if (adjacentSymbol) {
            foundAdjacentSymbol = true;
          }
        }
      }

      if (!isNumber || j === input[i].length - 1) {
        if (digit && foundAdjacentSymbol) {
          result += parseInt(digit);
        }
        digit = "";
        foundAdjacentSymbol = false;
      }
    }
  }

  return result;
};

function getAdjacentSymbol({ input, row, column }) {
  for (let i = row - 1; i <= row + 1; i++) {
    if (i < 0 || i >= input.length) continue;

    for (let j = column - 1; j <= column + 1; j++) {
      if (j < 0 || j >= input[i].length) continue;
      if (i === row && j === column) continue;

      const isSymbol = /[^a-zA-Z0-9.]/.test(input[i][j]);
      if (isSymbol) return { row: i, column: j, symbol: input[i][j] };
    }
  }

  return null;
}

export const part2 = ({ input }) => {
  let possibleGears = {};

  for (let i = 0; i < input.length; i++) {
    let digit = "";
    let adjacentSymbol = null;
    for (let j = 0; j < input[i].length; j++) {
      const isNumber = /\d/.test(input[i][j]);

      if (isNumber) {
        digit += input[i][j];

        if (!adjacentSymbol) {
          adjacentSymbol = getAdjacentSymbol({
            input,
            row: i,
            column: j,
          });
        }
      }

      if (!isNumber || j === input[i].length - 1) {
        if (digit && adjacentSymbol?.symbol === "*") {
          const key = `${adjacentSymbol.row},${adjacentSymbol.column}`;
          if (possibleGears[key]) {
            possibleGears[key].push(parseInt(digit));
          } else {
            possibleGears[key] = [parseInt(digit)];
          }
        }
        digit = "";
        adjacentSymbol = null;
      }
    }
  }

  return Object.values(possibleGears).reduce((acc, gear) => {
    if (gear.length === 2) {
      return acc + gear[0] * gear[1];
    }
    return acc;
  }, 0);
};
