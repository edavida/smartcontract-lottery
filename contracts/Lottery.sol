// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract Lottery {
    address payable[] public players;
    uint256 public usdEntryFee;
    AggregatorV3Interface internal ethUsdPriceFeed;

    constructor(address _priceFeedAddress) public {
        usdEntryFee = 50 * (10**18);
        ethUsdPriceFeed = AggregatorV3Interface(_priceFeedAddress);
    }

    function enter() public payable {
        // $50 minimum
        //require();
        players.push(msg.sender);
    }

    function getEntranceFee() public view returns (uint256) {
        (, int256 price, , , , ) = ethUsdPriceFeed.latestRoundData;
        uint256 adjustedPrice = uint256(price) * 10**10; // Price feed has 8 decimals, add 10 more
        uint256 costToEnter = (usdEntryFee * 10**18) / price;
        return costToEnter;
        //
    }

    function startLottery() public {}

    function endLottery() public {}
}
