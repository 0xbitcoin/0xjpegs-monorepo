

const fs = require("fs");
const { parse } = require("csv-parse");

const inputPath = 'tasks/data/input.csv'
  

fs.createReadStream(inputPath)
  .pipe(parse({ delimiter: ",", from_line: 2 }))
  .on("data", function (row:any) {
    

    handleRow( row )



  })


function handleRow( row :any  ){

    let name = row[1]
    let tokenId = parseInt(row[2])
    let imageUrl = row[9]

    if(isNaN(tokenId)) {
      console.log('skipping row without token id: ', name)
      return
    }
    if(!name) throw Error("missing image url")
 
    if(!imageUrl) throw Error("missing image url")

    let output = {


        name,
        description:`0xJPEGs are a celebration of the lasting legacy of decentralized ERC20 tokens on Ethereum Mainnet.  0xBTC is the faithful implementation of the bitcoin protocol as a trustless, immutable Ethereum smart contract. It has credible neutrality due to proof-of-work issuance and a 21 million coin cap within the Ethereum EVM. This enables dapp composability and decentralized-exchange trading.\n\n\n0xBitcoin is an open community project with decentralized development. No person or organization has special authority or control over 0xbtc. The 0xJPEGs artworks honor the decentralized, composable, and permissionless nature of the technology as non-upgradeable non-fungible tokens built in a custom smart contract.\n\n\nFind more at https://0xbitcoin.org\n\n\nImage: ${imageUrl}`,
        external_url:"https://0xjpegs.com",
        image:imageUrl,

        properties:[
          [
          {
          "key":"decimals",
          "value":8,
          "type":"integer"
          },
          {
          "key":"mining_algorithm",
          "value":"Keccak256",
          "type":"string"
          }
          ]
          ],

          attributes:[
            {
            "trait_type":"token_number",
            "value": `${tokenId}`
            },
            {
            "trait_type":"0xbtc_birthday",
            "value":"Feb-06-2018"
            },
            {
            "display_type":"boost_percentage",
            "trait_type":"decentralized",
            "value":100
            },
            {
            "display_type":"boost_percentage",
            "trait_type":"mined",
            "value":100
            },
            {
            "display_type":"boost_percentage",
            "trait_type":"airdropped",
            "value":0
            },
            {
            "display_type":"boost_percentage",
            "trait_type":"ICO",
            "value":0
            },
            {
            "display_type":"number",
            "trait_type":"0xbtc_max_supply",
            "value":21000000
            }
            ]
        

    }


    let outputPath = `./tasks/out/${name}.json`

    fs.writeFileSync(outputPath, JSON.stringify(output))
    

}