pragma solidity ^0.8.13;

library SafeMath {
    
    function add(uint x, uint y) internal pure returns (uint) {

        uint z = x + y;

        require(z >= x, "Overflow");

        return z;
    }

}

contract TestSafeMath {

    using SafeMath for uint;

    uint public MAX_UINT = 2**256 - 1;

    function pseudo_0(uint x, uint y) public pure returns (uint) {
        return x.add(y);
    }

    function pseuod_1(uint x, uint y) public pure returns (uint) {
        return SafeMath.add(x, y);
    }

}
