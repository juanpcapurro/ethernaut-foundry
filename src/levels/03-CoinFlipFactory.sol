// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "../core/BaseLevel.sol";
import "./03-CoinFlip.sol";

contract CoinFlipFactory is Level {
    function createInstance(address _player) public payable override returns (address) {
        _player;
        return address(new CoinFlip());
    }

    function validateInstance(address payable _instance, address) public view override returns (bool) {
        CoinFlip instance = CoinFlip(_instance);
        return instance.consecutiveWins() >= 10;
    }
}
