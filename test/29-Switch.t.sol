// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {SwitchFactory} from "../src/levels/29-SwitchFactory.sol";
import {Switch} from "../src/levels/29-Switch.sol";

contract SwitchSolution is BaseTest {

    function construction() internal override returns(address payable ) {
        return payable(address(new SwitchFactory()));
    }

    function solution(address payable target_) override internal {
      Switch target = Switch(target_);
    }
}
