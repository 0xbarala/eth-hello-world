// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "ds-test/test.sol";
import "../HelloWorld.sol";

interface CheatCodes {
    function prank(address) external;
    function expectRevert(bytes32) external;
}

contract HelloWorldTest is DSTest {
    
    HelloWorld private helloWorldContract;
    address immutable private owner = address(0);
    CheatCodes constant cheats = CheatCodes(HEVM_ADDRESS);

    function setUp() public {
        helloWorldContract = new HelloWorld(owner);
    }

    function testFailOnlyOwnerCanAddAdmin() public {
        helloWorldContract.addAdmin(address(1));
    }

    function testAdminCanUpdateMessage() public {
        cheats.prank(address(0));
        //owner adds admin 1
        helloWorldContract.addAdmin(address(1));

        //admin will try to add message
        cheats.prank(address(1));
        helloWorldContract.addMessage('Hello World');
    }

    function testOwnerCanAddAdmin() public {
        cheats.prank(address(0));
        helloWorldContract.addAdmin(address(10));
    }

    function testFailOtherThanAdminCantUpdateMessage() public {
        helloWorldContract.addAdmin(address(1));
    }

    function testEventIsEmittedOnUpdateMessage() public {
        //TODO cover event test case
    }
}