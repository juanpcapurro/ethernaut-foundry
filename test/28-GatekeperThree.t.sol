// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {GatekeeperThreeFactory} from "../src/levels/28-GatekeeperThreeFactory.sol";
import {GatekeeperThree} from "../src/levels/28-GatekeeperThree.sol";

contract GatekeeperThreeSolution is BaseTest {

    function construction() internal override returns(address payable ) {
        return payable(address(new GatekeeperThreeFactory()));
    }

    function solution(address payable target_) override internal {
      GatekeeperThree target = GatekeeperThree(target_);
    }
}
