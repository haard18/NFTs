//SPDX License-Identifier: MIT
pragma solidity ^0.8.18;   
import {console,Test} from 'forge-std/Test.sol';
import {DeployBasicNFT} from '../script/DeployBasicNFT.s.sol';
import {BasicNFT} from '../src/BasicNFT.sol';
contract BasicNFTtest is Test{

    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;
    address public USER=makeAddr("haard");
    string public constant BEAGLE="https://ipfs.io/ipfs/QmW6e735mMRaZBKP8eamQhkYQzNzD5npKpgbHRbV63Ya4k?filename=dog.json";
    function setUp() public{
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();

    }
    function testNameIsCorrect() public view{
        string memory actualName="Doggo";
        // console.log("actualName: ",actualName);

        string memory nftName=basicNFT.name();
        // console.log("nftName: ",nftName);
        //strings are byte arrays in solidity
        //how can we compare them?
        //we can convert them to bytes and compare
        //keccak256 hash of the two strings should be equal
        assert(keccak256(abi.encodePacked(actualName))==keccak256(abi.encodePacked(nftName)));        
    }   
    function testCanMintandHaveaBalance() public{
        vm.prank(USER);
        basicNFT.mintNFT(BEAGLE);
        assert(basicNFT.balanceOf(USER)==1);
        assert(keccak256(abi.encodePacked(basicNFT.tokenURI(0)))==keccak256(abi.encodePacked(BEAGLE)));
    }
}