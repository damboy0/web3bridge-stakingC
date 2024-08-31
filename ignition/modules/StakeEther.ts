import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const StakeEtherModule = buildModule("StakeEtherModule", (m) => {

    const save = m.contract("StakeEther");

    return { save };
});

export default StakeEtherModule;

// Deployed SaveERC20: 0x90b9E1C8645bC731be19537A4932B26Fc218e464
