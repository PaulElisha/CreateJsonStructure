// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/StdJson.sol";
import "../src/CreateJsonStruct.sol";

contract CreateJsonStructScript is Script {
    CreateJsonStruct createJsonStruct = new CreateJsonStruct();
    string private constant INPUT_PATH = "script/target/input.json";

    function run() public {
        string memory jsonObject = getJson();
        vm.writeFile(INPUT_PATH, jsonObject);
    }

    function getJson() public returns (string memory jsonObject) {
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

        jsonObject = createJsonStruct.getJson();

        console.log("file has been written to script/target/input.json");
        // assertEq(jsonObject, "{}");
    }
}
