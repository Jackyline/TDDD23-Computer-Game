# TODO: 
# loop until non pivot can be found

var outgoing = [1,2,3,4,5,6] # row vars
var incoming = [3,4,5,6] # base/col vars

var np = preload("res://scripts/m_numpy.gd") 

var primal_costs 		= []
var primal_constraints 	= []
var primal_b_hat		= []
var primal_A			= []	
var primal_tab 			= []

var dual_costs 			= []
var dual_constraints 	= []
var dual_b_hat		 	= []
var dual_A				= []
var dual_tab : 			= []

func _init(var p_costs, var p_constraints):	
	self.primal_costs = p_costs
	self.primal_constraints = p_constraints
	
	self._solve()
	print(self.get_solution())
	print("Dual: ", self.dual_tab)
	
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
				temp_arr.append(float(self.dual_b_hat[i]) / float(self.dual_tab[i][pivot[1]]))
				
	pivot[0] = temp_arr.find(np.m_min(temp_arr)) + 1
	
	return pivot
	
func _update_in_out_vars(var p):
	var t_incoming = self.outgoing[p[1]]
	self.incoming[p[0]-1] = t_incoming
	
func _is_pivot_one(var p):
	return self.dual_tab[p[0]][p[1]] == 1
	
func _transform_dual_tab(var p):
	# divide pivot row by pivot value p_val
	var p_val = self.dual_tab[p[0]][p[1]]
	if !self._is_pivot_one(p):
		self.dual_tab[p[0]] = np.m_divide_row_by(self.dual_tab[p[0]], p_val)
	
	# make a pivot column a 0-column
	for i in self.dual_tab.size():
		if i != p[0] && self.dual_tab[i][p[1]] != 0:
			var row_to_add = np.m_multiply_row(self.dual_tab[p[0]], -self.dual_tab[i][p[1]])
			self.dual_tab[i] = np.m_add_rows(row_to_add, self.dual_tab[i])
			
	#self._update_in_out_vars(p)

func _solve():
	self._init_primal_A()
	self._init_primal_b_hat()
	self._init_dual_A()
	self._init_dual_b_hat()
	self._init_dual_costs()
	self._init_dual_tab()
	
	var pivot = self._get_pivot()
	while pivot != [-1,-1]:
		self._transform_dual_tab(pivot)
		pivot = self._get_pivot()

func get_solution():
	var from = self.dual_costs.size()
	var to = from + self.primal_costs.size()
	return np.m_splice(self.dual_tab[0], from, to)

func get_opt_cost():
	return self.dual_tab[0][-1]
