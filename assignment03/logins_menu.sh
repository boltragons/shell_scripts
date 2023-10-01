#!/bin/sh
case $1 in
1)
echo '01) ---------- MENSAGENS QUE NÃO SÃO DO SSHD ----------'
grep -v -E '.*sshd.*' auth.log
;;
2)
echo '02) ---------- LOGINS ATRAVÉS DO SSHD COM USUÁRIO J... ----------'
grep -E '.*sshd.*session opened for user j.*' auth.log
;;
3)
echo '03) LOGINS VIA ROOT ATRAVÉS DO SSHD'
grep -E '.*sshd.*Disconnect.*root.*' auth.log
;;
4)
echo '04) LOGINS EM 11 E 12 DE OUTUBRO'
grep -E '^Oct 1[1 | 2].*sshd.*session opened.*' auth.log
;;
*) echo 'Opção inválida!'
;;
esac
