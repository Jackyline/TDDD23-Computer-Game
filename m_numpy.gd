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
	var c_arr = [] + arr
	c_arr.sort()
	return c_arr[0]
