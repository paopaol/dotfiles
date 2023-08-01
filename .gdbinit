set print pretty on
set print union on
set print array-indexes on
set print array on

python
import sys, os

# print(f".gdbinit Python: current working directory is {os.getcwd()}")
# print(f".gdbinit Python: adding custom pretty-printers directory to the GDB path: {os.getcwd() + '/.gdb/qt5prettyprinters'}")

sys.path.insert(0, os.environ['HOME'] + "/.gdb/qt5prettyprinters")

from qt import register_qt_printers
register_qt_printers (None)
end
