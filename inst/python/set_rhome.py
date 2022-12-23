import os
import sys
from rpy2.situation import (r_home_from_subprocess,
                            r_home_from_registry,
                            get_r_home, 
                            assert_python_version) 
# os.environ.get("R_HOME") 
os.environ['R_HOME'] = sys.argv[1]
os.environ['LD_LIBRARY_PATH'] = sys.argv[1]
R_HOME = get_r_home()
print(R_HOME)


