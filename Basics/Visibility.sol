pragma solidity ^0.8.13;

contract Base {
    
    // private: only within contract
    function privateFunc() private pure returns (string memory) {
        return "Private";
    }

    // internal: only within contract and sub-contracts
    function internalFunc() internal pure returns (string memory) {
        return "Internal";
    }

    function pseudo() public {
        string memory text_0 = privateFunc();
        string memory text_1 = internalFunc();
        string memory text_2 = publicFunc();
        // ...
    }

    // public: by other contracts and accounts, also within contract and sub-contracts
    function publicFunc() public pure returns (string memory) {
        return "Public";
    }

    // external: only by other contracts and accounts
    function externalFunc() public pure returns (string memory) {
        return "External";
    }

    string private privateState = "Private State";
    string internal internalState = "Internal State";
    string public publicState = "Public State";
    // state cannot be external 

}

contract Derived is Base {

    function childFunc() public pure returns (string memory) {
        return internalFunc();
    } 

}
