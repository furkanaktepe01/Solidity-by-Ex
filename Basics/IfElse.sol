pragma solidity ^0.8.13;

contract IfElse {

    function foo(uint x) public pure returns (uint) {

        if (x < 10) {
            return 0;
        } else if (x < 20) {
            return 1;
        } else {
            return 2;
        }
    }

    function ternary(uint y) public pure returns (uint) {
        return y < 10 ? 1 : 2;
    }

}
