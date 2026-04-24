// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract AinuMusicalTraditionsRegistry {

    struct MusicalTradition {
        string traditionName;       // upopo, rimse, tonkori, mukkuri
        string instruments;         // tonkori, mukkuri, percussion
        string vocalStyle;          // group singing, call-and-response, throat techniques
        string techniques;          // plucking, breath vibration, rhythmic stamping
        string symbolism;           // spiritual meaning, social function
        string culturalContext;     // ceremonies, gatherings, seasonal rituals
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct MusicalInput {
        string traditionName;
        string instruments;
        string vocalStyle;
        string techniques;
        string symbolism;
        string culturalContext;
    }

    MusicalTradition[] public traditions;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event MusicalRecorded(uint256 indexed id, string traditionName, address indexed creator);
    event MusicalVoted(uint256 indexed id, bool like, uint256 likes, uint256 dislikes);

    constructor() {
        traditions.push(
            MusicalTradition({
                traditionName: "Example (replace manually)",
                instruments: "example",
                vocalStyle: "example",
                techniques: "example",
                symbolism: "example",
                culturalContext: "example",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordMusical(MusicalInput calldata m) external {
        traditions.push(
            MusicalTradition({
                traditionName: m.traditionName,
                instruments: m.instruments,
                vocalStyle: m.vocalStyle,
                techniques: m.techniques,
                symbolism: m.symbolism,
                culturalContext: m.culturalContext,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit MusicalRecorded(traditions.length - 1, m.traditionName, msg.sender);
    }

    function voteMusical(uint256 id, bool like) external {
        require(id < traditions.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;
        MusicalTradition storage m = traditions[id];

        if (like) m.likes++;
        else m.dislikes++;

        emit MusicalVoted(id, like, m.likes, m.dislikes);
    }

    function totalMusicals() external view returns (uint256) {
        return traditions.length;
    }
}
