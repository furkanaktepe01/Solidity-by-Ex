pragma solidity ^0.8.13;

interface IERC721 {

    function safeTransferFrom(address from, address to, uint tokenId) external;

    function transferFrom(address, address, uint) external;

}

contract EnglishAuction {

    event Start();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address winner, uint amount);

    IERC721 public nft;
    uint public nftId;

    address payable public seller;
    uint public endAt;
    bool public started;
    bool public ended;

    address public highestBidder;
    uint public highestBid;
    mapping(address => uint) public bids;

    constructor(address _nft, uint _nftId, uint _startingBid) {

        nft = IERC721(_nft);

        nftId = _nftId;

        seller = payable(msg.sender);

        highestBid = _startingBid;
    }

    function start() external {

        require(!started);
        
        require(msg.sender == seller);

        nft.transferFrom(msg.sender, address(this), nftId);

        started = true;

        endAt = block.timestamp + 7 days;

        emit Start();
    }

    function bid() external payable {

        require(started);

        require(block.timestamp < endAt);

        require(msg.value > highestBid);

        if (highestBidder != address(0x0)) {

            bids[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;

        highestBid = msg.value;

        emit Bid(msg.sender, msg.value);
    }

    function withdraw() external {

        uint bal = bids[msg.sender];

        bids[msg.sender] = 0;

        payable(msg.sender).transfer(bal);

        emit Withdraw(msg.sender, bal);
    }

    function end() external {

        require(started);

        require(block.timestamp >= endAt);

        require(!ended);

        ended = true;

        if (highestBidder != address(0x0)) {

            nft.safeTransferFrom(address(this), highestBidder, nftId);

            seller.transfer(highestBid);

        } else {

            nft.safeTransferFrom(address(this), seller, nftId);
        }

        emit End(highestBidder, highestBid);
    }

}
