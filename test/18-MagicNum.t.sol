// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

import {BaseTest} from "./BaseTest.sol";
import {MagicNumFactory} from "../src/levels/18-MagicNumFactory.sol";
import {MagicNum} from "../src/levels/18-MagicNum.sol";

contract MagicNumSolution is BaseTest {

    function solution(address payable target_) internal override {
        MagicNum target = MagicNum(target_);

        address deployment = HuffDeployer.deploy("magicnum");
        target.setSolver(deployment);
        vm.startPrank(attacker, attacker);
    }

    function construction() internal override returns (address payable) {
        return payable(address(new MagicNumFactory()));
    }
}
