# TODO: 
# representation of incoming and outgoing variables
# loop until non pivot can be found

var np = preload("res://m_numpy.gd") 

var primal_costs 		= [1,1,1,1]
var primal_constraints 	= [[1,1,0,1], [1,0,1,1]]
var primal_b_hat		= []
var primal_A			= []	
var primal_tab 			= []

var dual_costs 			= []
var dual_constraints 	= []
var dual_b_hat		 	= []
var dual_A				= []
var dual_tab			= []
#var base_vars			= []

# for testing assume that:
# primal_costs = [1,1,1,1]
# primal_constraints =  [[1,1,0,1], [1,0,1,1]]

func _init():		
	self._init_primal_A()
	self._init_primal_b_hat()
	
	self._init_dual_A()
	self._init_dual_b_hat()
	self._init_dual_costs()
	self._init_dual_tab()
	
	print(self._get_pivot())
	
	print("Primal A: ", self.primal_A)
	print("Dual tableau", self.dual_tab)
	
func _init_primal_A():
	for i in self.primal_constraints.size():
		self.primal_A.append(self.primal_constraints[i])
		
func _init_dual_A():
	self.dual_A = np.transpose(self.primal_A)

func _init_primal_b_hat():
	self.primal_b_hat.append(0)
	for i in self.primal_constraints:
		self.primal_b_hat.append(1)

func _init_dual_b_hat():
	self.dual_b_hat.append(0)
	for i in self.primal_costs:
		self.dual_b_hat.append(i)

func _init_dual_costs():
	for i in self.primal_b_hat.size():
		if i != 0:
			self.dual_costs.append(self.primal_b_hat[i])

func _init_dual_tab():
	for i in self.dual_b_hat.size():
		if i == 0:
			self.dual_tab.append([] + np.m_negate(self.dual_costs))
			self.dual_tab[i].append(0)
		else:
			self.dual_tab.append([] + self.dual_A[i-1])
			self.dual_tab[i].append(self.dual_b_hat[i])
			
	self._add_slack_to_dual()

func _add_slack_to_dual():
	for i in self.dual_b_hat.size():
		for j in self.dual_A.size():
			if i == 0:
				self.dual_tab[i].insert(self.dual_tab[i].size() - 1, 0)
			else:
				if i == j+1:
					self.dual_tab[i].insert(self.dual_tab[i].size() - 1, 1)
				else:
					self.dual_tab[i].insert(self.dual_tab[i].size() - 1, 0)

func _get_pivot():
	var pivot = [-1,-1]
	var min_cost = np.m_min(self.dual_tab[0])
	
	if min_cost >= 0:
		return pivot
	pivot[1] = self.dual_tab[0].find(min_cost)	
		
	var temp_arr = [] # contains all divisions b_hat/dual_tab[i][pivot[1]]
	for i in self.dual_b_hat.size():
		if i != 0:
			if self.dual_tab[i][pivot[1]] <= 0:
				temp_arr.append(INF)
			else: 
				temp_arr.append(self.dual_b_hat[i] / self.dual_tab[i][pivot[1]])
				
	pivot[0] = temp_arr.find(np.m_min(temp_arr)) + 1
	
	return pivot
	
