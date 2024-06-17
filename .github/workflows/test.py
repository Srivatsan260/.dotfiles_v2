import os


exit_code = 1
_ = os.system(f"echo 'EXIT_CODE={exit_code}' >> $GITHUB_ENV")
