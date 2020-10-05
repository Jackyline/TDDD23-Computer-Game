static func transpose(arr):
	var newArr = []
	var w = arr[0].size()
	var h = arr.size()
	for i in w:
		newArr.append([])
		
	for i in h:
		for j in range(w):
			newArr[j].append(arr[i][j])
	
	return newArr
	
static func m_negate(arr):
	var res = []
	for e in arr:
		res.append(-e)
	return res
	
static func m_min(arr):
	var c_arr = arr.duplicate(true)
	c_arr.sort()
	return c_arr[0]
	
static func m_divide_row_by(var arr, var value):
	var res = arr.duplicate(true)
	
	for i in res.size():
		var div = float(res[i]) / float(value)
		res[i] = div
		
	return res
	
static func m_multiply_row(var arr, var val):
	var res = arr.duplicate(true)
	for i in res.size():
		res[i] = res[i] * val 
	return res
	
static func m_add_rows(var row1, var row2):
	var res = []
	for i in row1.size():
		res.append(float(row1[i]) + float(row2[i]))
	return res
	
static func m_splice(var arr, var from, var to):
	var res = []
	for i in arr.size():
		if i >= from && i <= to-1:
			res.append(arr[i])
	return res
	
static func m_sum(var arr):
	var res = 0
	for e in arr:
		res += e
	return res

static func m_abs(var n):
	if n < 0:
		return -n
	else:
		return n
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
