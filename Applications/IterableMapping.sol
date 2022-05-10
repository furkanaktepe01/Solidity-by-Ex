pragma solidity ^0.8.13;

library IterableMapping {

    struct Map {
        address[] keys;
        mapping(address => uint) values;
        mapping(address => uint) indexOf;
        mapping(address => bool) inserted; 
    }

    function get(Map storage map, address key) public view returns (uint) {
        return map.values[key];
    }

    function getKeyAtIndex(Map storage map, uint index) public view returns (address) {
        return map.keys[index];
    }

    function size(Map storage map) public view returns (uint) {
        return map.keys.length;
    }

    function set(Map storage map, address key, uint value) public {

        if (map.inserted[key]) {

            map.values[key] = value;
        
        } else {
         
            map.inserted[key] = true;
         
            map.values[key] = value;
         
            map.indexOf[key] = map.keys.length;
         
            map.keys.push(key);
        }
    }

    function remove(Map storage map, address key) public {

        if (!map.inserted[key]) {
            return;
        }

        delete map.inserted[key];
        
        delete map.values[key];

        uint index = map.indexOf[key];

        address lastKey = map.keys[map.keys.length - 1];

        map.indexOf[lastKey] = index;

        delete map.indexOf[key];

        map.keys[index] = lastKey;

        map.keys.pop();
    }

}

contract ExperimentIterableMap {

    using IterableMapping for IterableMapping.Map;

    IterableMapping.Map private map;

    function experimentIterableMap() public {

        map.set(address(0x0), 0);
        map.set(address(0x1), 10);
        map.set(address(0x2), 4);
        map.set(address(0x2), 20);
        map.set(address(0x3), 30);

        for (uint i = 0; i < map.size(); i++) {

            address key = map.getKeyAtIndex(i);

            assert(map.get(key) == i * 10);
        }

        map.remove(address(0x1));

        assert(map.size() == 3);
        assert(map.getKeyAtIndex(0) == address(0x0));
        assert(map.getKeyAtIndex(1) == address(0x3));
        assert(map.getKeyAtIndex(2) == address(0x2));
    }

}
