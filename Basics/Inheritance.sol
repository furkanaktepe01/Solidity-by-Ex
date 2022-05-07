pragma solidity ^0.8.13;

contract A {
    
    // virtual: can be overriden by sub-contracts
    function foo() public pure virtual returns (string memory) {
        return "A";
    }

}

contract B is A {

    function foo() public pure virtual override returns (string memory) {
        return "B";
    }

}

contract C is A {

    function foo() public pure virtual override returns (string memory) {
        return "C";
    }

}

contract D is B, C {

    function foo() public pure override(B, C) returns (string memory) {
        return super.foo(); // C
    }

}


contract E is C, B {

    function foo() public pure override(C, B) returns (string memory) {
        return super.foo(); // B
    }
    
}

contract F is A, B {

    // The order of the inheritance list: the most base-like -> the most derived

    function foo() public pure override(A, B) returns (string memory) {
        return super.foo();
    }

}
