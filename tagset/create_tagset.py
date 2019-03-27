import re

###
# extracts variable numbers from variables.txt and creates a tagset
###

# specify tagset directory, which should must variables.txt
OS = 'windows'

if OS == 'linux':
	tagset_dir = "/home/brian/Dropbox/BrianLivingstonRA/Height/NLSY/tagset/"
elif OS == 'windows':
	tagset_dir = "C://Users/Brian/Dropbox/BrianLivingstonRA/Height/NLSY/tagset/"
elif OS == 'mac':
	tagset_dir = "/Users/brianlivingston/Dropbox/BrianLivingstonRA/Height/NLSY/tagset/"
	
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------

fobj = open(tagset_dir+"variables.txt",'r')
tagset = open(tagset_dir+"default.NLSY97",'w')

pattern = re.compile("[A-Z][0-9]{7}")
for line in fobj:
	words = line.split()
	
	if len(words) != 1:
		continue
		
	code = words[0]
	if pattern.match(code):
		tagset.write(code+'\n')
		print(code)
	
fobj.close()
tagset.close()
