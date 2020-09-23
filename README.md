# Sudoku

## Uzdevums

1. Izlasīt https://guides.rubygems.org/make-your-own-gem/ un izveidot `sudoku.gemspec` failu, kā arī iestatīt `rspec` šajā direktorijā(vairāk info - http://rspec.info/).

    Katrai no uzdevuma ietvaros izveidojamām klasēm jāizveido testa fails, kurā notestē katru publisko klases metodi(Pirms sākt, vajadzētu iepazīties ar testēšanu [šeit](https://semaphoreci.com/community/tutorials/getting-started-with-rspec))
2. Izveidot klasi `Board`, kas satur sekojošas metodes
    * `columns` - atgriež sudoku laukuma kolonnu masīvu
    * `filled?` - atgriež `true` vai `false`, atkarībā no tā, vai viss laukums ir piepildīts(nav svarīgi, vai tas darīts pareizi)
    * `valid?` - Izmantojot pārveidotu `Validator` klasi(par to vairāk `2.`), atgriež `true` vai `false`, atkarībā no tā vai laukums ir pareizi aizpildīts(nav svarīgi, vai tas ir pilnīgi, vai nepilnīgi aizpildīts)
    * `subgroups` - atgriež masīvu ar sudoku laukuma apakšgrupām(mazie 3x3 kvadrātiņi)
    * `to_s` - atgriež string, kas noformatēts tieši tāpat kā `.sudoku` ievades faili
    * Instancei jāļauj piekļūt rindām un kolonnām, kā to varētu darīt ar masīvu -
        ```rb
          grid = Grid.new(...)
          grid[0][1]
        ```
    * Divas `Board` instances jāspēj salīdzināt ar `==`
    * `insert` - Ļauj norādīt rindas un kolonnas koordinātu, kā arī vērtību, kuru ievietot. Metode atgriež divdimensiju masīvu ar laukuma saturu(kā laukums izskatās pēc ievietošanas). Izmaiņas netiek pieglabātas klases instances datos. Ja lietotājs ievadījis ko citu kā ciparu, atgriezt kļūdas ziņojumu un neizvadīt izmainīto masīvu.
    * `insert!` - Ļauj norādīt rindas un kolonnas koordinātu, kā arī vērtību, kuru ievietot. Metode veic izmaiņas ar instances datiem. Ja lietotājs ievadījis ko citu kā ciparu, atgriezt kļūdas ziņojumu un izmaiņas neveikt.
3. Izveidot klasi `Validator`, kas saņem klases `Board` instanci un, izmantojot tai pieejamās metodes, pārbauda, vai sudoku laukums ir pareizs.
4. Izveidot klasi `Parser`, kas saņem `.sudoku` formāta stringu. Klasei jāatgriež gatava `Board` klases instance

****

## Parauga ievades faila formāts

*Nulles apzīmē tukšās sudoku mīklas vietas*
```
8 5 0 |0 0 2 |4 0 0
7 2 0 |0 0 0 |0 0 9
0 0 4 |0 0 0 |0 0 0
------+------+------
0 0 0 |1 0 7 |0 0 2
3 0 5 |0 0 0 |9 0 0
0 4 0 |0 0 0 |0 0 0
------+------+------
0 0 0 |0 8 0 |0 7 0
0 1 7 |0 0 0 |0 0 0
0 0 0 |0 3 6 |0 4 0
```
