set print pretty on
set print union on
set print array-indexes on
set print array on

python
import sys, os

sys.path.insert(0, os.environ['HOME'] + "/.gdb/qt5prettyprinters")

from qt import register_qt_printers
register_qt_printers (None)
end
