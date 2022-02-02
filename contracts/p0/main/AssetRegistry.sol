// SPDX-License-Identifier: BlueOak-1.0.0
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "contracts/p0/interfaces/IAsset.sol";
import "contracts/p0/interfaces/IMain.sol";
import "contracts/p0/main/Mixin.sol";

contract AssetRegistryP0 is Ownable, Mixin, IAssetRegistry {
    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet internal _assets;

    function init(ConstructorArgs calldata args) public virtual override {
        super.init(args);
    }

    function addAsset(IAsset asset) external onlyOwner {
        _assets.add(address(asset));
        emit AssetAdded(asset);
    }

    function removeAsset(IAsset asset) external onlyOwner {
        _assets.remove(address(asset));
        emit AssetRemoved(asset);
    }

    function allAssets() external view override returns (IAsset[] memory assets) {
        assets = new IAsset[](_assets.length());
        for (uint256 i = 0; i < _assets.length(); i++) {
            assets[i] = IAsset(_assets.at(i));
        }
    }
}
