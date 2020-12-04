use std::fs::File;
use std::ops::Rem;
use std::path::Path;
use std::io;
use std::io::BufRead;

const TREE: char = '#';

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>> where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}

fn main() {
    part1();
    part2();
}

fn part1() {
    let trees_count: u8 = read_lines("input.txt")
        .unwrap()
        .map(|y| y.unwrap())
        .enumerate()
        .map(|(y, l)| {
            let width = l.len();
            let x = (y * 3).rem(width);
            if l.chars().nth(x).unwrap() == TREE { 1 } else { 0 }
        })
        .sum();

    println!("{}", trees_count);
}

fn part2() {
    let slopes: Vec<(u8, u8)> = vec![(3, 1), (1, 1), (5, 1), (7, 1), (1, 2)];

    let track: Vec<String> = read_lines("input.txt")
        .unwrap()
        .map(|y| y.unwrap())
        .collect();


    fn trees_on_line(track: &Vec<String>, slope: &(u8, u8)) -> u16 {
        track.iter()
            .enumerate()
            .filter(|(y, _)| y.rem(slope.1 as usize) == 0)
            .map(|(y, l)| {
                let width = l.len();
                let x = (y * slope.0 as usize).rem(width);
                if l.chars().nth(x).unwrap() == TREE { 1 } else { 0 }
            })
            .sum()
    }

    let trees_count: usize = slopes.iter()
        .map(|slope| trees_on_line(&track, slope) as usize)
        .product();

    println!("{}", trees_count);
}
