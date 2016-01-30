use std::io;
use std::io::prelude::*;
use std::io::BufReader;
use std::fs::File;

fn get_lines() -> Result<Vec<String>, io::Error> {
    let mut rtn = vec![];
    let f = try!(File::open("roman.txt"));
    let reader = BufReader::new(f);

    for line in reader.lines() {
        let line = try!(line);
        rtn.push(line);
    }
    Ok((rtn))
}

fn get_value(c: char) -> u64 {
    match c {
        'I' => 1,
        'V' => 5,
        'X' => 10,
        'L' => 50,
        'C' => 100,
        'D' => 500,
        'M' => 1000,
        _ => 0,
    }
}

fn best_forms() -> Vec<(u64,u64,String)> {
    vec![ ( 1000, 1, "M" ),
            ( 900, 2, "CM" ),                        
            ( 500, 1, "D" ),
            ( 500 - 100, 2, "CD" ),                       
            ( 100, 1, "C" ),
            ( 100 -  10, 2, "XC" ),
            ( 50, 1, "L" ),
            ( 50 -  10, 2, "XL" ),
            ( 10, 1, "X" ),
            ( 10 -   1, 2, "IX" ),            
            ( 5, 1, "V" ),
            ( 5 -   1, 2, "IV" ),                        
            ( 1, 1, "I" )].iter().map(|a| (a.0,a.1,a.2.to_string())).collect()
            
}

fn roman_cost(_val: &u64) -> u64 {
    let forms = best_forms();
    let mut cost = 0;
    let mut val = _val + 0;
    for form in forms {
        while form.0 <= val {
            val -= form.0;
            cost += form.1;
        }
    }
    cost
}

fn parse_roman(roman: &String) -> u64 {
    let numbers : Vec<u64> = roman.chars().map(get_value).collect();
    let mut rtn = 0;
    for i in 0..numbers.len() {
        let num = numbers[i];
        let isFirst = i == 0;
        let isLast  = i == numbers.len()-1;
        
        let nextIsBigger = !isLast  && num < numbers[i+1];
        let prevIsSmaller = !isFirst && num > numbers[i-1];

        if prevIsSmaller {
            rtn += num - numbers[i-1];
        } else if !nextIsBigger {
            rtn += num
        }
    }
    rtn
}



fn prob89(nums: Vec<String>) -> u64 {
    let numbers : Vec<u64> = nums.iter().map(parse_roman).collect();
    let costs   : Vec<u64> = numbers.iter().map(roman_cost).collect();
    let lengths : Vec<u64>= nums.iter().map(|s| s.len() as u64 ).collect();
    lengths.iter().zip(costs).map(|a|a.0 - a.1).fold(0,|a,b| a+b)
}

fn main() {
    best_forms();
    match get_lines() {
        Ok(v) => println!("{}", prob89(v)),
        Err(e) => println!("Couldn't find file {:?}", e),
    }
}
