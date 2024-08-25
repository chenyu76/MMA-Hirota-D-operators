HirotaD[P_][ff_, gg_] :=
    Module[{x, len, df},
        x = Select[DeleteDuplicates[Cases[Evaluate[Expand[P]], _Symbol
             | _Symbol[_] | _Symbol[__], All]], Not[ValueQ[#]]&];
        len = Length[x];
        df[nx_, nf_] :=
            Function[fg,
                D[fg, nx[nf]]
            ];
        Apply[
                Plus
                ,
                (#[(ff /. Table[x[[i]] -> x[[i]][1], {i, len}]) (gg /.
                     Table[x[[i]] -> x[[i]][2], {i, len}])]&) /@
                    (Composition @@ #&) /@
                        (
                            Function[e,
                                        If[NumberQ[e],
                                            e #&
                                            ,
                                            e
                                        ]
                                    ] /@
                                    Flatten[
                                        If[Head[#] === Times,
                                                List @@ #
                                                ,
                                                {#}
                                            ] /. Power[xx_, nn_] :> Table[
                                                xx, {nn}]
                                    ]& /@ List @@ (If[Head[#] === Plus,
                                        
                                        #
                                        ,
                                        {#}
                                    ]&[P /. Table[x[[i]] -> df[x[[i]],
                                         1] - df[x[[i]], 2], {i, 1, len}] // Expand])
                        )
            ] /. Flatten[Table[x[[j]][i] -> x[[j]], {i, 1, 2}, {j, 1,
                 len}]]
    ];

HirotaDD[P_][ff_, gg_][x___] :=
    Module[{len = Length[{x}], df, dx},
        df[nx_, nf_] :=
            Function[fg,
                D[
                    fg
                    ,
                    If[nf == 1,
                        {x}[[nx]]
                        ,
                        dx[nx]
                    ]
                ]
            ];
        Apply[
                Plus
                ,
                (#[ff[x] gg @@ Table[dx[i], {i, len}]]&) /@
                    (Composition @@ #&) /@
                        (
                            Function[e,
                                        If[NumberQ[e],
                                            e #&
                                            ,
                                            e
                                        ]
                                    ] /@
                                    Flatten[
                                        If[Head[#] === Times,
                                                List @@ #
                                                ,
                                                {#}
                                            ] /. Power[xx_, nn_] :> Table[
                                                xx, {nn}]
                                    ]& /@ List @@ (P @@ Table[df[i, 1
                                        ] - df[i, 2], {i, len}] // Expand)
                        )
            ] /. dx[i_] :> {x}[[i]]
    ]

Dop[dx___][m___][ff_, gg_] :=
    D @@ Join[{(ff /. Table[{dx}[[i]] -> {dx}[[i]] + dy[i], {i, 1, Length[
        {dx}]}]) (gg /. Table[{dx}[[i]] -> {dx}[[i]] - dy[i], {i, 1, Length[{
        dx}]}])}, Transpose[{Table[dy[i], {i, 1, Length[{m}]}], {m}}]] /. dy[
        i_] :> 0;

HD[ff_, gg_, xx___] :=
    ((Dop @@ #[[1]]) @@ #[[2]]) @@ {ff, gg}&[
        Transpose[
            If[Head[#] === List,
                    #
                    ,
                    {#, 1}
                ]& /@ {xx}
        ]
    ];
