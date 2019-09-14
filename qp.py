import re
import string
import random

class Option:
	def __init__(self, choice, ans):
		self.choice = choice
		self.ans = ans

class Mcq:
	def __init__(self, text):
		reg = re.compile(r'(.*)\no\)(.*)\no\)(.*)\no\)(.*)\no\)(.*)\n(\d)')
		fragments = reg.search(text)
		self.question = fragments.group(1)
		self.options = []
		count =2
		while(count <= 5):
			myoption = Option(fragments.group(count), string.atoi(fragments.group(6)) == count-1)
			self.options.append(myoption)
			count+=1
			
		

class qp:
	def __init__(self, filename):
		f = open(filename)
		text = f.read()
		reg = re.compile(r'.*\no\).*\no\).*\no\).*\no\).*\n\d')
		fragments = reg.findall(text)
		self.fullset = []
		for elt in fragments:
			mymcq = Mcq(elt)
			self.fullset.append(mymcq)
	def olotpalot(self):
		random.shuffle(self.fullset)
		for elt in x.fullset:
			random.shuffle(elt.options)
				


x=qp('qp.dat')
x.olotpalot()
for elt in x.fullset:
	print elt.question
	for opt in elt.options:
		print opt.choice,
		print opt.ans
