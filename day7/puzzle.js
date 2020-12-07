const fs = require("fs");

const data = fs.readFileSync('./input.txt')
    .toString()
    .split("\n")
    .slice(0, -1)
    .map(line => {
        const [bag, content] = line.split(" bags contain");
        const bags = content.slice(0, -1)
            .split(",")
            .map(countBagType => {
                const result = countBagType.match(/(\d+) (.+) bags?/)
                return result == null ? null : {color: result[2], count: result[1]}
            })
            .filter(x => x)
        return [bag, bags]
    })

const dataMap = new Map(data);

// part 1
function countOfBagsThatFits(color) {
    function hasBag(colorRec) {
        if (colorRec === color) return true;
        if (!dataMap.has(colorRec)) return false;
        for (const bag of dataMap.get(colorRec)) {
            if (hasBag(bag.color)) return true;
        }
        return false;
    }

    console.log(Array.from(dataMap.keys()))

    return Array.from(dataMap.keys())
        .map(keyColor => keyColor !== color ? hasBag(keyColor) : 0)
        .reduce((a, b) => a + b, 0)
}

console.log(countOfBagsThatFits("shiny gold"))

// part 2

function sumBagsInside(color) {
    function sumBagsRec(bag) {
        if (bag.count === 0) return 0;

        const bagsWithin = dataMap.get(bag.color);
        let sum = 1;
        for (const bag of bagsWithin) {
            sum += bag.count * sumBagsRec(bag);
        }
        return sum;
    }

    return sumBagsRec({color: color, count: 1}) - 1
}

console.log(sumBagsInside("shiny gold"))
