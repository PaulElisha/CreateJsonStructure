// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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

    function testCreateArray() public {
        createJsonStruct.startMainObject();

        createJsonStruct.startObject("kaia");

        createJsonStruct.addKeyValuePairWithString("network", "testnet");
        createJsonStruct.addKeyValuePairWithString("chainid", "1001");

        createJsonStruct.startArray("developers");
        createJsonStruct.addArrayElementWithString("xx");
        createJsonStruct.addArrayElementWithString("oo");
        createJsonStruct.addArrayElementWithString("ppp");
        createJsonStruct.closeArray();

        createJsonStruct.closeObject();

        createJsonStruct.startObject("base");
        createJsonStruct.addKeyValuePairWithString("network", "testnet");
        createJsonStruct.addKeyValuePairWithString("chainid", "8354");
        createJsonStruct.closeObject();
        createJsonStruct.closeMainObject();

        string memory jsonObject = createJsonStruct.getJson();
        console.log(jsonObject);
    }
}
