pragma solidity ^0.8.13;

contract GasGolf {

    uint public total;

    // Replace memory with calldata
    function sumIfEvenAndLessThan99(uint[] calldata nums) external {

        // Load state variables to memory
        uint _total = total;

        // Cach array length
        uint len = nums.length;

        // Replace i++ with ++i
        for (uint i = 0; i < len; ++i) {

            // Cach array elements
            uint num = nums[i];

            // Short circuit: without pre-declaring bools, 
            // exits if first condition is false, second one is skipped
            if (num % 2 == 0 && num < 99) {
                _total += num;
            }
        }

        total = _total;
    }

}
