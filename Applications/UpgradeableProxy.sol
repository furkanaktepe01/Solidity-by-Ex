pragma solidity ^0.8.13;

contract Proxy {

    address public implementation;

    function setImplementation(address _impl) external {
        implementation = _impl;
    }

    function _delegate(address _impl) internal virtual {

        assembly {

            calldatacopy(0, 0, calldatasize())

            let result := delegatecall(gas(), _impl, 0, calldatasize(), 0, 0)

            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    fallback() external payable {
        _delegate(implementation);
    }

}
