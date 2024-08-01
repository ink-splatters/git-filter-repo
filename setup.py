from setuptools import setup, Extension
from Cython.Build import cythonize

extensions = [
    Extension(
        "git_filter_repo",
        ["git_filter_repo.pyx"],
        language="c++",
    )
]

setup(
    name="git-filter-repo",
    use_scm_version=True,
    ext_modules=cythonize(extensions),
    py_modules=["git_filter_repo"],
    entry_points={
        'console_scripts': [
            'git-filter-repo = git_filter_repo:main',
        ],
    },
    setup_requires=[
        'setuptools>=61',
        'setuptools_scm>=8.0',
        'wheel',
        'cython~=3.0.10'
    ],
)
