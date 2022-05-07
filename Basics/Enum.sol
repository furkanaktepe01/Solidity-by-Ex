pragma solidity ^0.8.13;

contract Enum {

    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    Status public status; // default: Pending

    function get() public view returns (Status) {
        return status; // returns uint    
    }

    function set(Status _status) public {
        status = _status;
    }

    function cancel() public {
        status = Status.Canceled;
    }

    function reset() public {
        delete status;  // default: Pending
    }

}
