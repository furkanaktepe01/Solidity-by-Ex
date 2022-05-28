pragma solidity ^0.8.13;

contract ChainlinkPriceOracle {

    AggregatorV3Interface internal priceFeed;

    constructor() {

        priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    }

    function getLatestPrice() public view returns (int) {

        (uint80 roundId, int price, uint startedAt, uint timestamp, uint80 answeredInRound) = priceFeed.latestRoundData();

        return price;
    }

}

interface AggregatorV3Interface {

    function latestRoundData() external view returns (uint80 roundId, int answer, uint startedAt, uint updatedAt, uint80 answeredInRound);

}
