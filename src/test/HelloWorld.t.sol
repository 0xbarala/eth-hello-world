// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "ds-test/test.sol";
import "../HelloWorld.sol";

interface CheatCodes {
    function prank(address) external;
    function expectRevert(bytes32) external;
    function expectEmit(bool, bool, bool, bool) external;
}

contract HelloWorldTest is DSTest {
    
    event NewMessage(string message);

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
        //expect event
        //first 3 args are used for indexed type events and last one is used for non index
        cheats.expectEmit(true, true, true, true);
        emit NewMessage('Hello World');
        helloWorldContract.addMessage('Hello World');

        cheats.prank(address(1));
        cheats.expectEmit(true, true, true, true);
        emit NewMessage('capturing event');
        helloWorldContract.addMessage('capturing event');

        //set false last argument and it wont compare the messages
        cheats.prank(address(1));
        cheats.expectEmit(true, true, true, false);
        emit NewMessage('i dont care');
        helloWorldContract.addMessage('gm');
    }

    function testOwnerCanAddAdmin() public {
        cheats.prank(address(0));
        helloWorldContract.addAdmin(address(10));
    }

    function testFailOtherThanOwnerCantAddAdmin() public {
        helloWorldContract.addAdmin(address(1));
    }
}