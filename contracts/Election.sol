pragma solidity >=0.4.22 <0.8.0;

contract Election {
  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }

  // Store candidates.
  mapping(uint => Candidate) public candidates;

  // Store accounts that have voted.
  mapping(address => bool) public voters;

  uint public candidatesCount;

  constructor() public {
    addCandidate("Candidate 1");
    addCandidate("Candidate 2");
  }

  function addCandidate(string memory _name) private {
    candidatesCount++;
    candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
  }

  function vote(uint _candidateId) public {
    // Require that the voter hasn't voted before.
    require(!voters[msg.sender]);

    // Require a valid candidate.
    require(_candidateId > 0 && _candidateId <= candidatesCount);

    // Record that the voter has voted.
    voters[msg.sender] = true;

    // Update candidate vote count.
    candidates[_candidateId].voteCount++;
  }
}