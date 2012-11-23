PYFILES = `find ./endless_pagination -name "*.py"`

all:
	@echo 'make develop - Set up development and testing environment'
	@echo 'make test - Run tests'
	@echo 'make pep8 - Run pep8'
	@echo 'make lint - Run linter'
	@echo 'make check - Run tests, pep8 and lint'
	@echo 'make testall - Run tests including integration ones'
	@echo 'make doc - Build Sphinx documentation'
	@echo 'make opendoc - Build Sphinx documentation and open it in browser'
	@echo 'make source - Create source package'
	@echo 'make install - Install on local system'
	@echo 'make shell - Enter Django interactive interpreter'
	@echo 'make server - Run Django development server'
	@echo 'make clean - Get rid of bytecode files, build dirs, dist files'
	@echo 'make cleanall - Clean and also get rid of the virtualenv'

doc:
	@./tests/with_venv.sh make -C doc html

clean:
	python setup.py clean
	rm -rfv .coverage build/ dist/ doc/_build MANIFEST
	find . -name '*.pyc' -delete

cleanall: clean
	rm -rfv .venv

check: test lint pep8

develop:
	@python ./tests/develop.py

install:
	python setup.py install

lint:
	@pocketlint $(PYFILES)

opendoc: doc
	@firefox ./doc/_build/html/index.html

pep8:
	@./tests/with_venv.sh pep8 --show-source $(PYFILES)

server:
	@./tests/with_venv.sh python ./tests/manage.py runserver 0.0.0.0:8000

shell:
	@./tests/with_venv.sh python ./tests/manage.py shell

source:
	python setup.py sdist

test:
	@./tests/with_venv.sh python ./tests/manage.py test

testall:
	@USE_SELENIUM=1 ./tests/with_venv.sh python ./tests/manage.py test

.PHONY: all doc clean cleanall check develop install lint opendoc pep8 server \
	shell source test testall
