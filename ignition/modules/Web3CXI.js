const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const Web3CXIModule = buildModule("Web3CXIModule", (m) => {
    const erc20 = m.contract("Web3CXI");
    return { erc20 };
});

module.exports = Web3CXIModule;

//npx hardhat ignition deploy ignition/modules/Web3CXI.ts --network lisk-sepolia