import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const Web3CXIModule = buildModule("Web3CXIModule", (m) => {

    const erc20 = m.contract("Web3CXI");

    return { erc20 };
});

export default Web3CXIModule;
//address: 0xd6b9D554a64Ae0238fD2db2B5124f649419c273f
//npx hardhat ignition deploy ignition/modules/Web3CXI.ts --network lisk-sepolia