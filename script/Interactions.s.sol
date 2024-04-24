//SPDX License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
// lib/foundry-devops/src/DevOpsTools.sol
contract MintBasicNFT is Script {
    string public constant BEAGLE="https://ipfs.io/ipfs/Qmb5iDsmkybqZ3hsh1DYCpMgTJNvMPzYQeTiHUVvPCpVkK?filename=dog.json";
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNFTonContract(mostRecentlyDeployed);
    }
    function mintNFTonContract(address contractAddress) public{
        vm.startBroadcast();
        BasicNFT(contractAddress).mintNFT(BEAGLE);
        vm.stopBroadcast();
    }
}
