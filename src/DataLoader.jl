module DataLoader
    using CSV
    using DataFrames
    using XLSX
    using MLStyle
    using Revise
    export load_data, check_missing_value

    """
    Description:
    Check the data is exist or not, if not exist, then the path
    probably wrong
    """
    function check_file_exists(file_path::String)
        flag = false
            if isfile(file_path)
                println("File is exists")
                flag = true
            else
            println("File does not exist,check the file path")
        end
        return flag
    end

    function check_file_format(file_path::String)
        _, f_ends = split(file_path, '.')
    return f_ends
    end

    function load_data(file_path::String)
        flag = check_file_exists(file_path)
        if flag
            f_ends = check_file_format(file_path)
            f = @match f_ends begin
                "csv" => "CSV.read(\"$file_path\",DataFrame,normalizenames=true)"
                "txt" => "CSV.read(\"$file_path\",DataFrame,normalizenames=true)"
                "xlsx"=> "XLSX.read(\"$file_path\",DataFrame)"
                "dat"=> "CSV.read(\"$file_path\",DataFrame,normalizenames=true)"
                _ => "not supported yet"
            end
            df = eval(Meta.parse(f))
            return df
        end
    end


    """
    Description:
    Check the missing value of in each column of the dataframe,
    and also print the percentage of the missing value
    """
    function check_missing_value(df::DataFrame)
        l = nrow(df)
        for col in names(df)
            if any(ismissing, df[!, col])
                count_missing = count(ismissing, df[!, col])
                println("Column $col has $count_missing missing values, $(count_missing/l*100)% of the data is missing")
            else
                println("the $col has no missing values!")
            end
        end
    end

end # module DataLoader
