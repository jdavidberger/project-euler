extern crate primes;

use primes::*;
use std::collections::HashSet;

fn totient_base(fac: &Vec<u64>) -> f64 {
    fac.iter().map(|f| 1. - (1. / ( (f+0) as f64)))
        .fold(1., |acc, p| acc * p)
}

fn prob243() -> u64 {    
    let target = 15499./94744.;

    // The key to this problem is that r is basically eulers totient.
    // we can quickly find a lower bound by going along the primorials
    let mut ps = primes::PrimeSet::new();
    let mut fact = 1.;
    let mut factors = vec![];
    for i in ps.iter() {
        factors.push(i);
        fact = fact * (i as f64);
        let base = totient_base(&factors); // We don't multiply in the base since we'd just cancel it out. 
        if base < target {
            break
        }
    }

    // This all works out so that the totient base remains constant. Since that base
    // is only dependent on unique prime factors of a number, so long as you aren't
    // multiplying by a new prime you aren't changing the totient base at all.
    // Since we know the totient_base for this group of factors is the _first_
    // time it's lower than our target, we can now focus on the n / (n-1) portion.
    // n / (n-1) approaches 1 as n->inf. So we can just take our product from above,
    // and start multiplying in numbers, looking for the smallest n where n/(n-1)
    // tips us over the edge of being smaller than our target.
    //
    // We could probably straight up solve for the value of i that will work, but
    // guess and check works just fine too. 
    let base = totient_base(&factors);
    let mut rtn = 0;
    for i in 2.. {
        let m = i as f64;
        if (fact * m * base) / (fact * m - 1.) < target {
            rtn = (fact * m) as u64;
            break;
        }
    }    
    rtn
}

fn main() {
    println!("{}", prob243());
}

