pragma solidity ^0.8.13;

import "./TryCatch.sol";
import { Todo } from "./Structs.sol";
import "https://github.com/.../X.sol";

contract Import {

    Foo public foo = new Foo();
    
    function foosPseudo(uint _x) public view returns (string memory) {
        return foo.pseudo(_x);
    }

}
