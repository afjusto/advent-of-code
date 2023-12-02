import { readFile } from "fs/promises";

async function loadData({ day, file }) {
  const data = await readFile(`./${day}/${file}.txt`, "utf-8");
  return data.split("\n");
}

async function runner({ part, input }) {
  const result = await part({ input });
  return result;
}

const args = process.argv.slice(2);
const day = args[0];
const part = args[1];
const file = args[2];

const { part1, part2 } = await import(`./${day}/index.js`);
const data = await loadData({ day, file });

if (part === "part1") {
  console.log(await runner({ part: part1, input: data }));
} else if (part === "part2") {
  console.log(await runner({ part: part2, input: data }));
}
