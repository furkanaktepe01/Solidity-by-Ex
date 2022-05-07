pragma solidity ^0.8.13;

contract Foo {

    address public owner;

    constructor(address _owner) {
        require(_owner != address(0x0), "Invalid Address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }    

    function pseudo(uint x) public pure returns (string memory) {
        require(x != 0, "Zero Input");
        return "Pseudo";
    }

}

contract Bar {
    
    event Log(string message);
    event LogBytes(bytes data);

    Foo public foo;

    constructor() {
        foo = new Foo(msg.sender);
    }

    function tryCatchExternalCall(uint _i) public {

        try foo.pseudo(_i) returns (string memory result) {
            emit Log(result);
        } catch {
            emit Log("External call to pseudo() failed.")
        }
    }

    function tryCatchNewContract(address _owner) public {

        try new Foo(_owner) returns (Foo foo) {
            emit Log("New foo created.");
        } catch Error(string memory reason) {
            // catch failing revert() and require()
            emit Log(reason);
        } catch (bytes memory reason) {
            // catch failing assert()
            emit LogBytes(reason);
        }
    }

}
