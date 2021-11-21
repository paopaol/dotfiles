# python
# import sys, os.path
# sys.path.insert(0, os.path.expanduser('~/.gdb'))
# sys.path.insert(1, '/home/jz/qtcreator-5.0.0/share/qtcreator/debugger')
# from gdbbridge import * 
# end

python
import sys, os.path
sys.path.insert(0, os.path.expanduser('/home/jz/workspace/code/gdb'))
import qt5printers
qt5printers.register_printers(gdb.current_objfile())

sys.path.insert(1, '/home/jz/qtcreator-5.0.0/share/qtcreator/debugger')
from gdbbridge import * 
end
