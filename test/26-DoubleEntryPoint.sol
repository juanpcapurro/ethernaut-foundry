// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {BaseTest} from "./BaseTest.sol";
import {DoubleEntryPointFactory} from "../src/levels/26-DoubleEntryPointFactory.sol";
import {
  DoubleEntryPoint,
  Forta,
  IDetectionBot
} from "../src/levels/26-DoubleEntryPoint.sol";

contract Notifier is IDetectionBot{
  Forta private  forta;
  address private vault;

  constructor(Forta forta_, address vault_) {
    forta = forta_;
    vault = vault_;
  }

  function handleTransaction(address user, bytes calldata msgData) external{
    if(msgData.length < 4) return;
    bytes4 selector = bytes4(msgData[0:4]) ;
    if(selector == DoubleEntryPoint.delegateTransfer.selector){
      address from = address(bytes20(bytes32(msgData[68:100]) << 12*8));
      if(from == vault) {
        forta.raiseAlert(user);
      }
    }
  }
}

contract DoubleEntryPointSolution is BaseTest {

    function construction() internal override returns(address payable ) {
        return payable(address(new DoubleEntryPointFactory()));
    }

    function solution(address payable target_) override internal {
        DoubleEntryPoint target = DoubleEntryPoint(target_);
        Forta forta = Forta(target.forta());
        forta.setDetectionBot(address(new Notifier(forta, target.cryptoVault())));
    }
}
