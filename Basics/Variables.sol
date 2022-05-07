pragma solidity ^0.8.13;

contract Variables {

    uint public num = 0; // state

    function pseudoFunction() public {

        uint public i = 1; // local

        // global
        address sender = msg.sender;
        uint timestamp = block.timestamp;
    }

}
