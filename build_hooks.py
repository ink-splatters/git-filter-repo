from hatchling.builders.hooks.plugin.interface import BuildHookInterface
import subprocess
import sys

class CustomBuildHook(BuildHookInterface):
    def initialize(self, version, build_data):
        # First stage: Generate type annotations using pytype
        subprocess.run([
            sys.executable, 
            "-m", 
            "pytype",
            "--keep-going",
            "--output-errors-csv=pytype_errors.csv",
            "--analyze-annotated",
            "--generate-config",
            "--python-version=3.6",
            "git_filter_repo.py"
        ], check=True)
        
        # The second stage (mypyc compilation) is handled automatically by the 
        # mypyc hook configured in pyproject.toml