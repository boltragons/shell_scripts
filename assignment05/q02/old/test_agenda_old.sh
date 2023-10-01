#!/bin/bash

if [ -f agenda.db ]
then
	rm agenda.db
fi

echo "Listar:"
./agenda.sh -l
sleep 1
echo ""

echo "Adicionar:"
./agenda.sh -a "Joao Marcelo" joao.marcelo@ufc.br
sleep 1
echo ""

echo "Adicionar:"
./agenda.sh -a "Jeandro Bezerra" jeandro@ufc.br
sleep 1
echo ""

echo "Adicionar:"
./agenda.sh -a "Michel Sales" michelsb@ufc.br
sleep 1
echo ""

echo "Listar:"
./agenda.sh -l
sleep 1
echo ""

echo "Remover:"
./agenda.sh -r joao.marcelo@ufc.br
sleep 1
echo ""

echo "Listar:"
./agenda.sh -l
sleep 1
echo ""
