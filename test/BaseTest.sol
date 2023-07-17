// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Level} from "../src/core/BaseLevel.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

abstract contract BaseTest is Test {
    Ethernaut internal ethernaut;
    address payable internal levelFactory;
    address internal attacker = address(1337);
    address payable internal level;

    function solution(address payable target) virtual internal ;
    function construction() virtual internal returns (address payable);

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        levelFactory = construction();
        ethernaut.registerLevel(Level(address(levelFactory)));
        vm.startPrank(attacker);
        level = payable(ethernaut.createLevelInstance{value: 0.001 ether}(Level(levelFactory)));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        solution(level);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(level);
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
