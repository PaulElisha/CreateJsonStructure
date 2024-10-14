// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/CreateJsonStruct.sol";

contract CreateJsonTest is Test {
    CreateJsonStruct createJsonStruct;

    function setUp() public {
        createJsonStruct = new CreateJsonStruct();
    }

    function testMainJsonObjectIsEmpty() public {
        createJsonStruct.startMainObject();
        createJsonStruct.closeMainObject();

        string memory jsonObject = createJsonStruct.getJson();
        console.log(jsonObject);
        assertEq(jsonObject, "{}");
    }

    function testCreateAStartObject() public {
        createJsonStruct.startMainObject();
        createJsonStruct.startObject("mainnet");
        createJsonStruct.addKeyValuePairWithUint("chainid", 1);
        createJsonStruct.closeObject();
        createJsonStruct.closeMainObject();

        string memory jsonObject = createJsonStruct.getJson();
        console.log(jsonObject);
        assertEq(jsonObject, '{"mainnet": {"chainid": 1}}');
    }
}
