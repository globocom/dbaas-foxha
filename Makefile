.PHONY: clean-pyc clean-build docs clean

help:
	@echo "clean-build - remove build artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "lint - check style with flake8"
	@echo "test - run tests quickly with the default Python"
	@echo "test-all - run tests on every Python version with tox"
	@echo "coverage - check code coverage quickly with the default Python"
	@echo "docs - generate Sphinx HTML documentation, including API docs"
	@echo "release - package and upload a release"
	@echo "dist - package"

clean: clean-build clean-pyc
	rm -fr htmlcov/

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

lint:
	flake8 dbaas_fox tests

test:
	nosetests -v tests/test_dbaas_fox.py

test-all:
	tox

coverage:
	coverage run --source dbaas_fox setup.py test

docs:
	rm -f docs/dbaas-fox.rst
	rm -f docs/modules.rst
	sphinx-apidoc -o docs/ dbaas-fox
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	open docs/_build/html/index.html

release:
	python setup.py sdist upload

release_globo:
	python setup.py sdist upload -r ipypiglobo
	python setup.py sdist upload -r pypiglobo

fake_deploy:
	rm -f /Users/$(USER)/.virtualenvs/dbaas/lib/python2.7/site-packages/dbaas_fox/__init__.pyc
	rm -f /Users/$(USER)/.virtualenvs/dbaas/lib/python2.7/site-packages/dbaas_fox/database_providers.pyc
	rm -f /Users/$(USER)/.virtualenvs/dbaas/lib/python2.7/site-packages/dbaas_fox/dbaas_api.pyc
	rm -f /Users/$(USER)/.virtualenvs/dbaas/lib/python2.7/site-packages/dbaas_fox/provider.pyc
	rm -f /Users/$(USER)/.virtualenvs/dbaas/lib/python2.7/site-packages/dbaas_fox/provider_factory.pyc
	cp dbaas_fox/__init__.py /Users/$(USER)/.virtualenvs/dbaas/lib/python2.7/site-packages/dbaas_fox/
	cp dbaas_fox/database_providers.py /Users/$(USER)/.virtualenvs/dbaas/lib/python2.7/site-packages/dbaas_fox/
	cp dbaas_fox/dbaas_api.py /Users/$(USER)/.virtualenvs/dbaas/lib/python2.7/site-packages/dbaas_fox/
	cp dbaas_fox/provider.py /Users/$(USER)/.virtualenvs/dbaas/lib/python2.7/site-packages/dbaas_fox/
	cp dbaas_fox/provider_factory.py /Users/$(USER)/.virtualenvs/dbaas/lib/python2.7/site-packages/dbaas_fox/

dist: clean
	python setup.py sdist
	python setup.py bdist_wheel
	ls -l dist
