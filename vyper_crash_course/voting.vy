#needed variables
voting_started: public(bool)
voting_closed: public(bool)

has_voted: public(HashMap[address, bool]) # { 0x1: true}
candidates_count: public(uint256)
owner: public(address)

MAX_CANDIDATES: constant(uint256) = 10

# Apply Partylist, 20
struct Candidate:
    name: String[64]
    vote_count: uint256

candidates: public(HashMap[uint256, Candidate]) # {1: # Apple Partylist, 20}

# initialize the candidates
@deploy
def __init__():
    self.owner = msg.sender
    self.voting_started = False
    self.voting_closed = False
    self.candidates_count = 0

    # Homogenous Data of Strings, LIMIT
    default_candidates: DynArray[String[64], MAX_CANDIDATES] = [
        "Apple Partylist", "Grapes Partylist", "Orange Partylist", "Mango Partylist"
    ]

    # initialize candidate
    for name: String[64] in default_candidates:
        self.candidates_count += 1
        self.candidates[self.candidates_count] = Candidate({
            name: name,
            vote_count : 0
        })


# open the voting
@external 
def open_vote():
    assert msg.sender == self.owner
    assert self.candidates_count > 0

    self.voting_started = True
    self.voting_closed = False


# close the voting
@external 
def close_vote():
    assert msg.sender == self.owner
    assert not self.voting_closed, "The voting is already closed"
    self.voting_closed = True

# vote canditate
@external 
def vote_candidate(candidate_id: uint256):
    assert self.voting_started and not self.voting_closed, "Voting is not active"
    assert not self.has_voted[msg.sender] # {address1: false}, if false will proceed, if true , voter casted vote already

    # Here, we accessed the candidate struct from our candidates hashmap <-- Candidate {name, vote_count}
    self.candidates[candidate_id].vote_count += 1
    self.has_voted[msg.sender] = True




# view results
@external 
@view 
def view_election_result() -> DynArray[Candidate, MAX_CANDIDATES]:
    results: DynArray[Candidate, MAX_CANDIDATES] = []

    for i: uint256 in range(MAX_CANDIDATES):
        if i + 1 > self.candidates_count:
            break
        results.append(self.candidates[i + 1])


    return results

