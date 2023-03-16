+ "Однострочные примеры sed"
echo -e "\nСтроки:"
_ "- вставить пустые строки после каждой строки"  "sed G"
_ "- вставить пустые строки после каждой строки - если есть пустые строки, то заменить их одной"  sed '/^$/d;G'
_ "- вставить 2 пустые строки после каждой строки" "sed 'G;G'"
_ "- удалить каждую вторую строку" "sed 'n;d'"
_ "- вставить пустую строку перед каждой строкой с regex" "sed '/regex/{x;p;x;}'"
_ "- вставить пустую строку после каждой строки с regex" "sed '/regex/G'"
_ "- вставить пустую строку перед и после каждой строки с regex" "sed '/regex/{x;p;x;G;}'"

echo -e "\nНумерация:"
_ "- вывести файл с нумерацией строк - если строка пустая, номер опускается" "sed '/./=' filename | sed '/./N; s/\n/ /'"
_ "- число строк (аналог wc -l)" "sed -n '$='"

echo -e "\nЗамена и преобразование текста:"
_ "- замена CR/LF на LF (DOS -> Unix)" "sed 's/.$//'"
_ "- замена LF на CR/LF (Unix -> DOS)" "sed 's/$/\r/"
_ "- стереть все начальные отступы" "sed 's/^[ \t]*//'"
_ "- стереть все завершающие строку пробелы и табуляции" "sed 's/[ \t]*$//'"
_ "- стереть и начальные и конечные пробелы и табуляции" "sed 's/^[ \t]*//;s/[ \t]*$//'"
_ "- вставить в начало всех строк 5 пробелов" "sed 's/^/     /'"
_ "- выравнивание текста по правому краю на 79 столбце" "sed -e :a -e 's/^.\{1,78\}$/ &/;ta'"
_ "- выравнивание по центру (ширина 79 столбцов), в 1 варианте строки дополняются пробелами и сзади, во втором нет,
вариант 1:" "sed  -e :a -e 's/^.\{1,77\}$/ & /;ta'"
_ "вариант 2:" "sed  -e :a -e 's/^.\{1,77\}$/ &/;ta' -e 's/\( *\)\1/\1/'"

echo -e "\nЗамена foo на bar в каждой строке:"
_ "- замена только первого вхождения в строке" "sed 's/foo/bar/'"
_ "- замена 4 первых вхождений в каждой строке" "sed 's/foo/bar/4'" 
_ "- замена всех вхождений" "sed 's/foo/bar/g'" 
_ "- замена предпоследнего вхождения" "sed 's/\(.*\)foo\(.*foo\)/\1bar\2/'" 
_ "- замена только последнего вхождения" "sed 's/\(.*\)foo/\1bar/'"
+
_ "- замена foo на bar, только если строка содержит baz:" "sed '/baz/s/foo/bar/g'"
_ "- замена foo на bar, только если строка НЕ содержит baz" "sed '/baz/!s/foo/bar/g'"
_ "- замена scarlet или ruby или puce на red (только для GNU sed)"  "sed 's/scarlet\|ruby\|puce/red/g'"
_ "- вывести текст с последней по первую строку (эмуляция tac)" "sed '1!G;h;$!d'"               
_ "- вариант 2" "sed -n '1!G;h;$p'"
_ "- вывести текст справа налево (эмуляция rev)" "sed '/\n/!G;s/\(.\)\(.*\n\)/&\2\1/;//D;s/.//'"
_ "- слить четные и нечетные строки (как paste)" "sed '$!N;s/\n/ /'"
_ "- если строка оканчивается на \, добавить к ней следующую" "sed -e :a -e '/\\$/N; s/\\\n//; ta'"
_ "- если строка начинается на "=", добавить к ней предыдущую строку, '=' заменяется на пробел" "sed -e :a -e '$!N;s/\n=/ /;ta' -e 'P;D'"
_ "- добавить разделитель разрядов к числам ("1234567" -> "1,234,567")" "sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'"
_ "- добавить разделитель разрядов к числам с точкой и минусом (для GNU sed)" "sed ':a;s/\(^\|[^0-9.]\)\([0-9]\+\)\([0-9]\{3\}\)/\1\2,\3/g;ta'"
_ "- добавить пустую строку через каждые 5 строк (после 5,10,15,20 и т.д. строк)" "sed '0~5G'"

echo "\nВыборочный вывод строк:"
_ "- вывод первых 10 строк (эмуляция head)" "sed 10q"
_ "- вывод первой строки (head -1)" "sed q"
_ "- вывод последних 10 строк (эмуляция tail)" "sed -e :a -e '$q;N;11,$D;ba'"
_ "- вывод последних 2 строк (эмуляция tail -2)" "sed '$!N;$!D'"
_ "- вывод последней строки (эмуляция tail -1)" "sed '$!d'"
_ "- вариант 2" "sed -n '$p'"  

_ "- вывод строк, совпадающих с регулярным выражением (эмуляция grep)" "sed -n '/regexp/p'"
_ "- вариант 2" "sed '/regexp/!d'"
_ "- вывод строк, НЕ совпадающих с регулярным выражением (эмуляция grep -v)" "sed -n '/regexp/!p'"
_ "- вариант 2" "sed '/regexp/d'"
+
_ "- вывести строки, которые стоят ПЕРЕД строками с регулярным выражением regexp" "sed -n '/regexp/{g;1!p;};h'"
_ "- вывести строки, которые стоят ПОСЛЕ строк с регулярным выражением regexp" "sed -n '/regexp/{n;p;}'"
_ "- вывод двух строк, окружающих строку с регулярным выражением, самой строки, а также номера строки (похоже на grep -A1 -B1)" \
"sed -n -e '/regexp/{=;x;1!p;g;$!N;p;D;}' -e h"
+
_ "- вывод строк, которые содержат и AAA, и BBB, и CCC (в любом порядке)" "sed '/AAA/!d; /BBB/!d; /CCC/!d'"
_ "- вывод строк, которые содержат и AAA, и BBB, и CCC (именно в таком порядке)" "sed '/AAA.*BBB.*CCC/!d'"
_ "- вывод строк, которые содержат или AAA, или BBB, или CCC (эмуляция egrep)" "sed '/AAA\|BBB\|CCC/!d'"
+
_ "- вывод абзаца, если он содержит AAA (абзацы должны быть разделены пустыми линиями)" "sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;'"
_ "- вывод абзаца, если он содержит и AAA, и BBB, и CCC" "sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;/BBB/!d;/CCC/!d'"
_ "- вывод абзаца, если он содержит или AAA, или BBB, или CCC" "sed '/./{H;$!d;};x;/AAA\|BBB\|CCC/b;d'"
_ "- вывод только строк, которые длиннее 65 символов" "sed -n '/^.\{65\}/p'"
_ "- вывод только строк, которые короче 65 символов" "sed -n '/^.\{65\}/!p'"
_ "- вариант 2:" "sed '/^.\{65\}/d'"
_ "- вывод части файла от regexp до конца" "sed -n '/regexp/,$p'"
_ "- вывод с 8-й по 12-ю строку" "sed -n '8,12p'"
_ "- вариант 2:" "sed '8,12!d'"
_ "- вывод 52-й строки" "sed -n '52p'"
_ "- вариант 2:" "sed '52!d'"
_ "- вариант 3:" "sed '52q;d'"
_ "- вывод каждой 7-й строки, начиная с 3-й" "sed -n '3~7p'"
_ "- вывод файла со строки, содержащей Iowa, по строку, содержащую Montana" "sed -n '/Iowa/,/Montana/p'"

echo -e "\nВыборочное удаление строк:"

_ "- вывод файла, кроме части со строки, содержащей Iowa, по строку, содержащую Montana" "sed '/Iowa/,/Montana/d'"
_ "- удаление повторяющихся строк, идущих друг за другом (аналог uniq)" "sed '$!N; /^\(.*\)\n\1$/!P; D'"
_ "- удаление повторяющихся строк, НЕ идущих друг за другом (возможно переполнение буфера, используйте GNU sed)" \
"sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P'"

_ "- удаление всех строк, кроме повторяющихся (аналог uniq -d)" "sed '$!N; s/^\(.*\)\n\1$/\1/; t; D'"
_ "- удаление первых 10 строк файла" "sed '1,10d'"
_ "- удаление последней строки файла" "sed '$d'"
_ "- удаление последних 2 строк файла" "sed 'N;$!P;$!D;$d'"
_ "- удаление последних 10 строк файла" "sed -e :a -e '$d;N;2,10ba' -e 'P;D'"
_ "- вариант 2:" "sed -n -e :a -e '1,10!{P;N;D;};N;ba'"
_ "- удаление каждой 8-й строки" "sed '0~8d'"
_ "- удаление всех пустых строк (похоже на grep '.' )" "sed '/^$/d'"
_ "- вариант 2:" "sed '/./!d'"
_ "- замена всех повторяющихся пустых строк из файла на одну,
также удаление всех пустых строк в начале и конце файла (аналог cat -s)" "sed '/./,/^$/!d'"
_ "- замена всех повторяющихся пустых строк из файла на две" "sed '/^$/N;/\n$/N;//D'"
_ "- удаление пустых строк в начале файла" "sed '/./,$!d'"
_ "- удаление пустых строк в конце файла" "sed -e :a -e '/^\n*$/{$d;N;ba' -e '}'"
_ "- удаление последней строки каждого абзаца" "sed -n '/^$/{p;h;};/./{x;/./p;}'"

echo "ИСПОЛЬЗОВАНИЕ: Sed применяет команду(ы) к каждой строке на своем входе,
а затем выводит результат на стандартный вывод"

_ "- использование ввода через пайп" "cat filename | sed '10q'" 
_ "- то же, но без cat" "sed '10q' filename"
_ "- вывод -> в файл newfile" "sed '10q' filename > newfile"  
_ "- с ключом -i результат записывается в тот же файл, из которого производится ввод" "sed -i '10q' filename"

echo "
КАВЫЧКИ: Приведенные примеры используют одинарные кавычки \'...\'
вместо двойных \"...\" для экранирования команд, так sed
используется на Unix платформах. Одинарные кавычки не дают оболочке shell
интерпретировать символ доллара \$ и обратных кавычек \`...\`,
для использования переменных shell с sed можно использовать 
комбинацию одинарных и двойных кавычек.
"

_ "- пример:"   "sed 's/'\"\$var\"'/bar/g' filename"
echo "
ОПТИМИЗАЦИЯ СКОРОСТИ: Если скорость выполнения неудовлетворительна, то
выражения могут быть выполнены гораздо быстрее, если до "s/.../.../"
сделать поиск по файлу
"
_ "- cтандартная команда замены"   "sed 's/foo/bar/g' filename" 
_ "- выполняется гораздо быстрее"   "sed '/foo/ s/foo/bar/g' filename"  
_ "- сокращенное выражение"   "sed '/foo/ s//bar/g' filename" 

echo "Если выбор или удаление производится только в части файла, 
то команда выход (q) ускорит выполнение на больших файлах"

_ "- вывод строк 45-50 файла" "sed -n '45,50p' filename"
_ "- то же, но быстрее"   "sed -n '51q;45,50p' filename"
