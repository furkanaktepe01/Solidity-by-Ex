pragma solidity ^0.8.13;

contract FunctionModifier {
    
    address public owner;
    uint public x = 10;
    bool public locked;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner");
        _;
    }

    modifier validAddress(address _addr) {
        require(_addr != address(0x0), "Invalid Address");
    }

    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }

    modifier noReentrancy() {

        require(!locked);

        locked = true;
        _;
        locked = false,
    }

    function decrement(uint i) public noReentrancy {

        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }

}
