pragma solidity ^0.8.13;

contract Loop {

    function loop() public {

        uint j;

        while (j < 10) {
            j++;
        }

        for (uint i = 0; i < 10; i++) {
            
            if (i == 3) {
                continue;
            }

            if (i == 5) {
                break;
            }
        }
    }

}
