pragma solidity ^0.8.13;

contract Proxy {

    event Deploy(address);

    fallback() external payable { }

    function deploy(bytes memory _code) external payable returns (address addr) {

        assembly {

            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }

        require(addr != address(0x0));

        emit Deploy(addr);
    }

    function execute(address _target, bytes memory _data) external payable {

        (bool success, ) = _target.call{ value: msg.value }(_data);

        require(success);
    }

}

contract Helper {

    function getBytecode0() external pure returns (bytes memory) {
        
        bytes memory bytecode = type(Foo).creationCode;

        return bytecode;
    }

    function getBytecode1(uint _x, uint _y) external pure returns (bytes memory) {

        bytes memory bytecode = type(Foo).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_x, _y));
    }

    function getCalldata(address _owner) external pure returns (bytes memory) {
        
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }

}

contract Foo {

    address public owner = msg.sender;

    function setOwner(address _owner) public {

        require(msg.sender == owner);

        owner = _owner;
    }

}
