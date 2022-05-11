pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {

    IERC20 public token0;
    address public owner0;
    uint public amount0;

    IERC20 public token1;
    address public owner1;
    uint public amount1;

    constructor(address _token0, address _owner0, uint _amount0, address _token1, address _owner1, uint _amount1) {
        token0 = IERC20(_token0);
        owner0 = _owner0;
        amount0 = _amount0;
        token1 = IERC20(_token1);
        owner1 = _owner1;
        amount1 = _amount1;
    }

    function swap() public {

        require(msg.sender == owner0 || msg.sender == owner1);

        require(token0.allowance(owner0, address(this)) >= amount0);

        require(token1.allowance(owner1, address(this)) >= amount1);

        _safeTransferFrom(token0, owner0, owner1, amount0);

        _safeTransferFrom(token1, owner1, owner0, amount1);
    }

    function _safeTransferFrom(IERC20 token, address sender, address recipient, uint amount) private {

        bool sent = token.transferFrom(sender, recipient, amount);

        require(sent);
    }

}
