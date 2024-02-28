// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {ERC20TD} from "src/ERC20TD.sol";
import {Evaluator} from "src/Evaluator.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Loan} from "src/Loan.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // vm.startBroadcast(vm.envUint("anvil"));

        // ERC20TD erc20 = new ERC20TD("TD-AAVE-101", "TD-AAVE-101", 0);
        //ERC20TD erc20 = ERC20TD(0x482749F0578D0c8b067865a4eA49B5ef220c456B);

        address aDAIAddress = 0x31f30d9A5627eAfeC4433Ae2886Cf6cc3D25E772;
        address USDCAddress = 0x9FD21bE27A2B059a288229361E2fA632D8D2d074;
        address variableDebtUSDCAddress = 0xcfc2d9b9498cBd6F71E5E46d46082C76C4F6C695;
        address AAVE = 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9;
        address dai = 0x75Ab5AB1Eef154C0352Fc31D2428Cef80C7F8B33;
        //Evaluator evaluator =
           //new Evaluator(erc20, IERC20(aDAIAddress), IERC20(USDCAddress), IERC20(variableDebtUSDCAddress), AAVEPool);

        //erc20.setTeacher(address(evaluator), true);
        Loan loan = new Loan();
        vm.stopBroadcast();

        
    }

}

