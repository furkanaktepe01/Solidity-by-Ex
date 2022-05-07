pragma solidity ^0.8.13;

contract Gas {

    function testRequire(uint _i) public pure {
        require(_i > 10, "Input less than or equal to 10");
    }

    function testRevert(uint _i) public pure {

        if (_i <= 10) {
            revert("Input less than or equal to 10");
        }
    }

    uint public num;

    function testAssert() public view {
        assert(num == 0);
    }

    error InsufficientBalance(uint balance, uint withdrawAmount);

    function testCustomError(uint _withdrawAmount) public view {

        uint bal = address(this).balance;

        if (balance < _withdrawAmount) {
            revert InsufficientBalance({balance: bal, withdrawAmount: _withdrawAmount});
        }
    }

}

contract Account {

    uint public balance;
    uint public constant MAX_UINT = 2**256 - 1;

    function deposit(uint _amount) public {

        uint oldBalance = balance;
        uint newBalance = balance + _amount;

        require(newBalance >= oldBalance, "Overflow");

        balance = newBalance;

        assert(balance >= oldBalance);
    }

    function withdraw(uint _amount) public {

        uint oldBalance = balance;

        require(balance >= _amount, "Underflow");

        if (balance < _amount) {
            revert("Underflow");
        }

        balance -= _amount;

        assert(balance <= oldBalance);
    }

}
