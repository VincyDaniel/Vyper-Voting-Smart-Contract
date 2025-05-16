# version ^0.4.0

# Data Types: global storage, there is cost
# var_name: access(type_annotation) or data type
bool_type: public(bool)
int_type: public(uint256)
my_message: public(String[100]) # For Strings, Arrays, Dynamic Arrays, we need to specify the lengths
number_list: public(uint256[10])
my_address: public(address)
num: public(uint256)
vote_mapping: HashMap[String[100], uint256]  # Map<String[100], uint256> vote_mapping = new HashMap<>(); in java



# initialize data
@deploy
def __init__():
    self.bool_type = False
    self.my_message = "testing my message"
    self.int_type = 20
    self.number_list = [1,2,3,4,5,6,7,8,9,10]
    self.my_address = msg.sender #msg.sender is your blockchain address
    self.num = 0
    self.vote_mapping["Apple Partylist"] = 0


# Control Flow
@external # sample function works like external
def sample_function():
    # Assert Statements
    assert msg.sender == self.my_address # checks if msg.sender has the correct account based on when my_address is clicked

    # Conditional Statements
    if(self.bool_type):
        self.num = 10
    elif(self.my_message == "testing my message"): # else if(self.my_message == "testing my message") self.num = 20;
        self.num = 20
    else:
        self.num = 30

    # Loops
    for i: uint256 in self.number_list: # for(int i: self.number_list) self.num += i;
        self.num = self.num + i


#-----------------------------------------------------------

@external
def add(num1: uint256, num2: uint256):
    self.num = self._operate("add", num1, num2)

@external
def subtract(num1: uint256, num2: uint256):
    self.num = self._operate("subtract", num1, num2)

@external
def multiply(num1: uint256, num2: uint256):
    self.num = self._operate("multiply", num1, num2)

#view
@view
@external 
def get_num() -> uint256:
    return self.num

# Functions
def _operate(oper_type: String[100], num1: uint256, num2: uint256) -> uint256:
    result: uint256 = 0
    if(oper_type == "add"):
        result = num1 + num2
    elif(oper_type == "subtract"):
        result = num1 - num2
    else:
        result = num1 * num2
    return result