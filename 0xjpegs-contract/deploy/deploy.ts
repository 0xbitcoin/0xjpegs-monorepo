import { ethers } from 'ethers'
import { DeployFunction } from 'hardhat-deploy/dist/types'
import { HARDHAT_NETWORK_NAME } from 'hardhat/plugins'
import { deploy } from '../helpers/deploy-helpers'
  

const deployFn: DeployFunction = async (hre:any) => {

   
   
  let deployer_key =  process.env.PRIVATE_KEY!


  const jpegsNft = await deploy<any>({
    from: deployer_key,
    contract: 'JpegsNFT',
    args: [ ],
    
    skipIfAlreadyDeployed: false,
    hre,
  } )


  const tokenAddress = "0xab89a7742cb10e7bce98540fd05c7d731839cf9f";

  const auction = await deploy<any>({
    from:deployer_key,
    contract: 'MemesAuction',
    args: [ jpegsNft.address, tokenAddress ],
    
    skipIfAlreadyDeployed: false,
    hre, 
  })
 


}

// tags and deployment
deployFn.tags = ['auction']
deployFn.dependencies = [
  
]
export default deployFn
