import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const tokenAddress = "0xd6b9D554a64Ae0238fD2db2B5124f649419c273f";

const StakeERC20Module = buildModule("StakeERC20Module", (m) => {

    const save = m.contract("StakeERC20", [tokenAddress]);

    return { save };
});

export default StakeERC20Module;

// Deployed SaveERC20: 
// Web3CXIModule#Web3CXI - 0xd6b9D554a64Ae0238fD2db2B5124f649419c273f
// StakeERC20Module#StakeERC20 - 0x492a86EdEEa01158FcD3C8f2348A4c0431b8A24d