import UIKit

import Foundation

//A twin prime is a prime number that differs from another prime number by two. Write a function called isTwinPrime which takes an integer and returns true if it is a twin prime, or false if it is not.

func isTwinPrime (_ num: Int) -> Bool {

    var counter = num

    for i in 2 ..< counter {
        if counter == 0 {
            return false

        } else if counter % i == 0 {
            return false

        } else {
            counter -= 1
            print("This is prime")
            
        }
        
    }
    return true
}

//Tests
isTwinPrime(5) //5 is a prime, and 5 + 2 = 7, which is also a prime, so returns true.
isTwinPrime(9) //9 is not a prime, and so does not need checking, so it returns false.
isTwinPrime(7) //7 is a prime, but 7 + 2 = 9, which is not a prime. However, 7 - 2 = 5, which is a prime, so it returns true.
isTwinPrime(23) //23 is a prime, but 23 + 2 is 25, which is not a prime. 23 - 2 is 21, which isn't a prime either, so 23 is not a twin prime.



