Feature: code-breaker submits a guess.

	As a code-breaker
	I want to submit a guess
	So that I can break the code

	The code-breaker submits a guess of four numbers. The game marks the guess with two numbers x:y, where
	x - count of numbers, that are included in the secret code and
	y - count of guessed numbers, that are located in the correct position

	Scenario Outline: submit guess
		Given the secret code is "<code>"
		When I guess "<guess>"
		Then the mark should be "<mark>"

	Scenarios: No matches
		| code | guess | mark |
		| 1234 | 5678  | 0:0  |

	Scenarios: 1 number correct
		| code | guess | mark |
		| 1234 | 5278  | 1:1  |
		| 1234 | 5728  | 1:0  |

	Scenarios: 2 numbers correct
		| code | guess | mark |
		| 1234 | 5238  | 2:2  |
		| 1234 | 2738  | 2:1  |		
		| 1234 | 5328  | 2:0  |

	Scenarios: 3 numbers correct
		| code | guess | mark |
		| 1234 | 1238  | 3:3  |
		| 1234 | 8134  | 3:2  |	
		| 1234 | 3184  | 3:1  |	
		| 1234 | 4318  | 3:0  |

	Scenarios: All numbers are correct
		| code | guess | mark |
		| 1234 | 1234  | 4:4  |
		| 1234 | 1243  | 4:2  |		
		| 1234 | 3241  | 4:1  |
		| 1234 | 4321  | 4:0  |

	Scenarios: matches with duplicates
		| code | guess | mark |
		| 1234 | 1122  | 2:1  |
		| 1234 | 1221  | 2:2  |		
		| 1234 | 2211  | 2:1  |
		| 1234 | 2112  | 2:0  |		
		| 1234 | 2111  | 2:0  |		
		| 1234 | 1112  | 2:1  |	
		| 1234 | 1111  | 1:1  |	