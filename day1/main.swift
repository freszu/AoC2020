import Foundation

let path = FileManager.default.currentDirectoryPath + "/input.txt"

let input = try String(contentsOfFile: path)
        .split(separator: "\n")
        .map { string in
            Int(string)!
        }

let result1 = combinations(source: input, take: 2)
        .first { ints in
            ints.reduce(0, +) == 2020
        }?
        .reduce(1, *)

print("Result 1:\(result1)")

let result2 = combinations(source: input, take: 3)
        .first { ints in
            ints.reduce(0, +) == 2020
        }?
        .reduce(1, *)
print("Result 2:\(result2)")

func combinations<T>(source: [T], take: Int) -> [[T]] {
    guard source.count > take else {
        return [source]
    }
    guard !source.isEmpty || take != 0 else {
        return []
    }

    if (take == 1) {
        return source.map {
            [$0]
        }
    }

    var result: [[T]] = []

    let rest = Array(source.dropFirst())
    let subCombos = combinations(source: rest, take: take - 1)
    result += subCombos.map {
        [source.first!] + $0
    }
    result += combinations(source: rest, take: take)
    return result
}