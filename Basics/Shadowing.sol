pragma solidity ^0.8.13;

contract A {
    
    string public name = "A";

}

contract B is A {

    // would not compile:
    // string public name = "B";

    constructor() {
        name = "B"
    }

}
