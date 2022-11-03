module InsectBook
    export LogisticMap


    include("logisticmap.jl")

   

    export myblue, mygreen, myyellow, myorange, myred, myblack, mycolors

    begin
        myblue = "#304da5"
        mygreen = "#2a9d8f"
        myyellow = "#e9c46a"
        myorange = "#f4a261"
        myred = "#e76f51"
        myblack = "#50514F"
    
        mycolors = [myblue, myred, mygreen, myorange, myyellow]
    end;
end