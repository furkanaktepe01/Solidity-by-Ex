pragma solidity ^0.8.13;

contract MultiDelegatecall {

    error DelegatecallFailed();

    function multiDelegatecall(address[] memory targets, bytes[] memory data) external payable returns (bytes[] memory) {

        require(targets.length == data.length);

        bytes[] memory results = new bytes[](data.length);

        for (uint i; i < data.length; i++) {

            (bool success, bytes memory result) = targets[i].delegatecall(data[i]);

            if (!success) {
                revert DelegatecallFailed();
            }

            results[i] = result;
        }

        return results;
    }

}
