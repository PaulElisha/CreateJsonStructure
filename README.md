## CreateJsonStructure

This is a tool useful for creating JSON structure for data gathering. It is useful when trying to read off-chain data in solidity, or when building data for merkle trees, it is very useful when trying to efficiently handle data. 

## Requirements

- Solidity v0.8.0^

## Installation

```shell
forge install PaulElisha/CreateJsonStructure
```

## Functions

- startMainObject - Entry point to creating a Json data.
- startObject - Entry point to creating an object.
- addKeyValuePairWithString - Used for add key-value pair.
- startNestedObjectInArray - Used for creating nested object in an array.
- addArrayElementWithString - Used to add array element.
- StartArray - Used to start an array.

To every 'start' method, ensure you close them with the required functions.

## Usage

```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    import "../src/CreateJsonStruct.sol";

    contract CreateJsonTest  {
        CreateJsonStruct createJsonStruct = new CreateJsonStruct();

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
            createJsonStruct.addArrayElementWithString("pp");
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

```
## Test Output

```shell
    Ran 3 tests for test/CreateJson.t.sol:CreateJsonTest
[PASS] testCreateAStartObject() (gas: 53109)
Logs:
  {"mainnet": {"chainid": 1}}

[PASS] testCreateArray() (gas: 226954)
Logs:
  {"kaia": {"network": "testnet","chainid": "1001","developers": ["xx","oo","pp"]}, "base": {"network": "testnet","chainid": "8354"}}

[PASS] testMainJsonObjectIsEmpty() (gas: 60915)
Logs:
  {}
```
## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```