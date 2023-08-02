// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {Level} from "../core/BaseLevel.sol";
import {IAlienCodex} from "./19-IAlienCodex.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract AlienCodexFactory is Level, StdCheats {
    function createInstance(address _player) public payable override returns (address) {
        _player;
        return deployCode("19-AlienCodex-05.sol:AlienCodex");
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool) {
        // _player;
        IAlienCodex instance = IAlienCodex(_instance);
        return instance.owner() == _player;
    }
}
