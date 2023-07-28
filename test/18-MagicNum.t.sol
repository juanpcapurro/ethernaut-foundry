// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {MagicNumFactory} from "../src/levels/18-MagicNumFactory.sol";
import {MagicNum} from "../src/levels/18-MagicNum.sol";

contract MagicNumSolution is BaseTest {
    bytes19 constant private creationCode = 0x6009600a5f3960095ff3602a601f5360205ff3;

    function solution(address payable target_) internal override{
        MagicNum target = MagicNum(target_);
        address deployment;
        assembly {
            // from the yul docs
            function allocate(size) -> ptr {
                ptr := mload(0x40)
                if iszero(ptr) { ptr := 0x60 }
                mstore(0x40, add(ptr, size))
            }
            let offset := allocate(19)
            mstore(offset, creationCode)
            deployment := create(0, offset, 19)
        }
        target.setSolver(deployment);
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new MagicNumFactory()));
    }
}
