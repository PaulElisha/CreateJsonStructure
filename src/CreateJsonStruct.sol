// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/StdJson.sol";
import "./LibJsonUtils.sol";

contract CreateJsonStruct {
    using stdJson for string;

    string internal json;
    bool internal isObjectOpen = false;
    bool internal isArrayOpen = false;

    // Entry point to creating a json object
    function startMainObject() public {
        json = "{";
        isObjectOpen = true;
    }

    // Close the main JSON object
    function closeMainObject() public {
        json = string(abi.encodePacked(json, "}"));
    }

    // Start the JSON object
    function startObject(string memory key) public {
        _checkJson();
        json = string(abi.encodePacked(json, '"', key, '": {'));
        isObjectOpen = true;
    }

    // Close the current JSON object
    function closeObject() public {
        json = string(abi.encodePacked(json, "}"));
        isObjectOpen = false;
    }

    // Add key-value pair to the object (for simple values)
    function addKeyValuePairWithString(
        string memory key,
        string memory value
    ) public {
        _checkJson();
        json = string(abi.encodePacked(json, '"', key, '": "', value, '"'));
    }

    // Add a key-value pair to the current object (for uint values)
    function addKeyValuePairWithUint(string memory key, uint value) public {
        _checkJson();
        json = string(
            abi.encodePacked(
                json,
                '"',
                key,
                '": ',
                LibJsonUtils.uint2str(value)
            )
        );
    }

    // Add key-value pairs for int values
    function addKeyValuePairWithInt(string memory key, int value) public {
        _checkJson();
        json = string(
            abi.encodePacked(json, '"', key, '": ', LibJsonUtils.int2str(value))
        );
    }

    // Add key-value pairs for boolean values
    function addKeyValuePairWithBool(string memory key, bool value) public {
        _checkJson();
        json = string(
            abi.encodePacked(json, '"', key, '": ', value ? "true" : "false")
        );
    }

    // Add key-value pairs for address values
    function addKeyValuePairWithAddress(
        string memory key,
        address value
    ) public {
        _checkJson();
        json = string(
            abi.encodePacked(
                json,
                '"',
                key,
                '": "',
                LibJsonUtils.addressToString(value),
                '"'
            )
        );
    }

    // Add key-value pairs for bytes values
    function addKeyValuePairWithBytes(
        string memory key,
        bytes memory value
    ) public {
        _checkJson();
        json = string(
            abi.encodePacked(
                json,
                '"',
                key,
                '": "',
                LibJsonUtils.bytesToHex(value),
                '"'
            )
        );
    }

    // Start an object without a key (for nested structures)
    function startNestedObject() public {
        _checkJson();
        json = string(abi.encodePacked(json, "{"));
        isObjectOpen = true;
    }

    // Add nested object
    function addNestedObject(
        string memory parentKey,
        string memory nestedKey,
        string memory nestedValue
    ) public {
        startObject(parentKey);
        addKeyValuePairWithString(nestedKey, nestedValue);
        closeObject();
    }

    // Nested object with uint value
    function addNestedObjectWithUint(
        string memory parentKey,
        string memory nestedKey,
        uint value
    ) public {
        startObject(parentKey);
        addKeyValuePairWithUint(nestedKey, value);
        closeObject();
    }

    // Nested object with int value
    function addNestedObjectWithInt(
        string memory parentKey,
        string memory nestedKey,
        int value
    ) public {
        startObject(parentKey);
        addKeyValuePairWithInt(nestedKey, value);
        closeObject();
    }

    // Nested object with boolean value
    function addNestedObjectWithBool(
        string memory parentKey,
        string memory nestedKey,
        bool value
    ) public {
        startObject(parentKey);
        addKeyValuePairWithBool(nestedKey, value);
        closeObject();
    }

    // Nested object with address value
    function addNestedObjectWithAddress(
        string memory parentKey,
        string memory nestedKey,
        address value
    ) public {
        startObject(parentKey);
        addKeyValuePairWithAddress(nestedKey, value);
        closeObject();
    }

    // Nested object with bytes value
    function addNestedObjectWithBytes(
        string memory parentKey,
        string memory nestedKey,
        bytes memory value
    ) public {
        startObject(parentKey);
        addKeyValuePairWithBytes(nestedKey, value);
        closeObject();
    }

    // Nested array of objects example
    function addNestedObjectInArray(string memory arrayKey) public {
        startArray(arrayKey);
        startNestedObject();
        closeObject();
        closeArray();
    }

    // Start an array
    function startArray(string memory key) public {
        _checkJson();
        json = string(abi.encodePacked(json, '"', key, '": ['));
        isArrayOpen = true;
    }

    // Close an array
    function closeArray() public {
        json = string(abi.encodePacked(json, "]"));
        isArrayOpen = false;
    }

    // Add an element to an array (for string values)
    function addArrayElement(string memory value) public {
        _checkJson();
        json = string(abi.encodePacked(json, '"', value, '"'));
    }

    function addArrayElement(uint value) public {
        _checkJson();
        json = string(abi.encodePacked(json, LibJsonUtils.uint2str(value)));
    }

    function addArrayElement(int value) public {
        _checkJson();
        json = string(abi.encodePacked(json, LibJsonUtils.int2str(value)));
    }

    function addArrayElement(bool value) public {
        _checkJson();
        json = string(abi.encodePacked(json, value ? "true" : "false"));
    }

    function addArrayElement(address value) public {
        _checkJson();
        json = string(
            abi.encodePacked(
                json,
                '"',
                LibJsonUtils.addressToString(value),
                '"'
            )
        );
    }

    function addArrayElement(bytes memory value) public {
        _checkJson();
        json = string(
            abi.encodePacked(json, '"', LibJsonUtils.bytesToHex(value), '"')
        );
    }

    function getJson() public view returns (string memory) {
        return json;
    }

    // // Internal comma handling for objects
    // function _checkJson() internal {
    //     _isCommaNeeded();
    // }

    // // Internal comma handling for arrays
    // function _checkJson() internal {
    //     _isCommaNeeded();
    // }

    function _checkJson() internal {
        bytes memory jsonBytes = bytes(json);
        if (jsonBytes.length > 0) {
            bytes1 lastChar = jsonBytes[jsonBytes.length - 1];

            if (lastChar != "{" || lastChar != "[") {
                json = string(abi.encodePacked(json));
            }
        }
    }
}
