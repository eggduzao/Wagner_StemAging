#!/bin/bash

base=$PWD

# a variance threshold higher than this might be too brutal (ie,
# it would cut out cpg that actually correlate well with age)
# hannum_variance=0.00001
hannum_variance=0.0

# corrs="0.3 0.4 0.45"
corrs="0.4"

# vars="0 0.01 0.05"
vars="0"

iterations=0

################################### keeping the three models separated

# # correlations, abs
# for cor in $corrs
# do
#     for var in $vars
#     do
#         dir="agecancer_imputed_cor${cor}abs_var${var}_3-model"
#         mkdir $dir
#         cd $dir && echo $PWD && echo "#######" && Rscript  ../../code/script.R --iterations $iterations --variance-threshold-hannum $hannum_variance --variance-threshold-laml $var --use-correlation --top-n `echo "$cor * 100" | bc` --take-abs > ../${dir}.log 2>&1
#         cd $base
#     done
# done

# correlations, pos
# for cor in $corrs
# do
#     for var in $vars
#     do
#         dir="agecancer_imputed_cor${cor}pos_var${var}_3-model"
#         mkdir $dir
#         cd $dir && echo $PWD && echo "#######" && Rscript  ../../code/script.R --iterations $iterations --variance-threshold-hannum $hannum_variance --variance-threshold-laml $var --use-correlation --top-n `echo "$cor * 100" | bc` > ../${dir}.log 2>&1
#         cd $base
#     done
# done

# # top or bottom
# for n in 100
# do
#     for top in neg pos abs
#     do
#         if [ $top == "abs" ]; then
#             take_abs="--take-abs --top-n $n"
#         elif [ $top == "pos" ]; then
#             take_abs="--top-n $n"
#         elif [ $top == "neg" ]; then
#             take_abs="--bottom-n $n"
#         fi

#         for var in 0 0.01 0.05
#         do
#             dir="agecancer_imputed_top${n}${top}_var${var}_3-model"
#             mkdir $dir
#             cd $dir && echo $PWD && echo "#######" && Rscript  ../../code/script.R --iterations $iterations --variance-threshold-hannum $hannum_variance --variance-threshold-laml $var ${take_abs} > ../${dir}.log 2>&1
#             cd $base
#         done
#     done
# done

# # top and bottom
# for n in 50
# do
#     for var in 0 0.01 0.05
#     do
#         dir="agecancer_imputed_top${n}pos${n}neg_var${var}_3-model"
#         mkdir $dir
#         cd $dir && echo $PWD && echo "#######" && Rscript  ../../code/script.R --iterations $iterations --variance-threshold-hannum $hannum_variance --variance-threshold-laml $var --top-n $n --bottom-n $n > ../${dir}.log 2>&1
#         cd $base
#     done
# done

################################### taking intersection, therefore only 1 model

# # correlations, abs
# for cor in $corrs
# do
#     for var in $vars
#     do
#         dir="agecancer_imputed_cor${cor}abs_var${var}_1-model"
#         mkdir $dir
#         cd $dir && echo $PWD && echo "#######" && Rscript  ../../code/script.R --iterations $iterations --variance-threshold-hannum $hannum_variance --variance-threshold-laml $var --take-intersection --use-correlation --top-n `echo "$cor * 100" | bc` --take-abs > ../${dir}.log 2>&1
#         cd $base
#     done
# done

# correlations, pos
for cor in $corrs
do
    for var in $vars
    do
        dir="agecancer_imputed_cor${cor}pos_var${var}_1-model"
        mkdir $dir
        cd $dir && echo $PWD && echo "#######" && Rscript ../../code/script.R --iterations $iterations --variance-threshold-hannum $hannum_variance --variance-threshold-laml $var --take-intersection --use-correlation --top-n `echo "$cor * 100" | bc` > ../${dir}.log 2>&1
        cd $base
    done
done

# # top or bottom
# for n in 100
# do
#     for top in neg pos abs
#     do
#         if [ $top == "abs" ]; then
#             take_abs="--take-abs --top-n $n"
#         elif [ $top == "pos" ]; then
#             take_abs="--top-n $n"
#         elif [ $top == "neg" ]; then
#             take_abs="--bottom-n $n"
#         fi

#         for var in 0 0.01 0.05
#         do
#             dir="agecancer_imputed_top${n}${top}_var${var}_1-model"
#             mkdir $dir
#             cd $dir && echo $PWD && echo "#######" && Rscript  ../../code/script.R --iterations $iterations --variance-threshold-hannum $hannum_variance --variance-threshold-laml $var ${take_abs} --take-intersection > ../${dir}.log 2>&1
#             cd $base
#         done
#     done
# done

# # top and bottom
# for n in 50
# do
#     for var in 0 0.01 0.05
#     do
#         dir="agecancer_imputed_top${n}pos${n}neg_var${var}_1-model"
#         mkdir $dir
#         cd $dir && echo $PWD && echo "#######" && Rscript  ../../code/script.R --iterations $iterations --variance-threshold-hannum $hannum_variance --variance-threshold-laml $var --top-n $n --bottom-n $n --take-intersection > ../${dir}.log 2>&1
#         cd $base
#     done
# done
