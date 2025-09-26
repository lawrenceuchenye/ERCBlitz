// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

interface IMyInterface {
    function foo() external;
    function bar(uint256) external view returns (uint256);
}

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

contract ERC165 is IERC165 {
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor() {
        _registerInterface(type(IERC165).interfaceId);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    function _registerInterface(bytes4 interfaceId) internal virtual {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

contract MyContract is ERC165, IMyInterface {
    constructor() {
        // register the custom interface
        _registerInterface(type(IMyInterface).interfaceId);
    }

    function foo() external override {
        // ...
    }

    function bar(uint256 x) external view override returns (uint256) {
        return x + 1;
    }
}
