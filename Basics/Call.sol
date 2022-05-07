pragma solidity ^0.8.13;

contract Receiver {
    
    event Received(address caller, uint amount, string message);

    fallback() external payable {
        emit Received(msg.sender, msg.value, "Fallback");
    }

    function foo(string memory _message, uint _x) public payable returns (uint) {

        emit Received(msg.sender, msg.value, _message);

        return _x + 1;
    }

}

contract Caller {

    event Response(bool success, bytes data);

    function testCallFoo(address payable _addr) public payable {

        (bool success, bytes memory data) = _addr.call{ value: msg.value, gas: 5000 }(abi.encodeWithSignature("foo(string,uint256)", "Calls Foo", 7));    

        emit Response(success, data);
    }

    function testCallDoesNotExist(address _addr) public {

        (bool success, bytes memory data) = _addr.call(abi.encodeWithSignature("doesNotExist()"));    

        emit Response(success, data);
    }

}
