pragma solidity ^0.8.13;

contract Immutable {

    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    constructor(uint _uint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _uint;
    }

}
