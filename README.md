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

- Create a target file in your script folder. In this case, I used this path: "script/target/input.json"
- Assign the target file to a variable like this: `string private constant INPUT_PATH = "script/target/input.json"`;
- Copy the fs_permissions configuration in the foundry.toml file and paste in your foundry config file

- Example: 

```solidity
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

    }
}


```
## Output

```shell
{
    "kaia": {
        "network": "testnet",
        "chainid": "1001",
        "developers": [
            "xx",
            "oo",
            "ppp"
        ]
    },
    "base": {
        "network": "testnet",
        "chainid": "8354"
    }
}
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