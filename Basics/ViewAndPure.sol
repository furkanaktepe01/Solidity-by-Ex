pragma solidity ^0.8.13;

contract ViewAndPure {

    uint public x = 1;

    // view: does not modify the state
    function addToX(uint y) public view returns (uint) {
        return x + y;
    }  

    // pure: neither modify nor read the state
    function add(uint i, uint j) public pure returns (uint) {
        return i + j;
    }

}
