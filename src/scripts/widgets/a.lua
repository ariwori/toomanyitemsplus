function print_dump(data, showMetatable, lastCount)
  if type(data) ~= "table" then
      --Value
      if type(data) == "string" then
          print("\"", data, "\"")
      else
          print(tostring(data))
      end
  else
      --Format
      local count = lastCount or 0
      count = count + 1
      print("{\n")
      --Metatable
      if showMetatable then
          for i = 1,count do print("\t") end
          local mt = getmetatable(data)
          print("\"__metatable\" = ")
          print_dump(mt, showMetatable, count)    -- 如果不想看到元表的元表，可将showMetatable处填nil
          print(",\n")     --如果不想在元表后加逗号，可以删除这里的逗号
      end
      --Key
      for key,value in pairs(data) do
          for i = 1,count do print("\t") end
          if type(key) == "string" then
              print("\"", key, "\" = ")
          elseif type(key) == "number" then
              print("[", key, "] = ")
          else
              print(tostring(key))
          end
          print_dump(value, showMetatable, count) -- 如果不想看到子table的元表，可将showMetatable处填nil
          print(",\n")     --如果不想在table的每一个item后加逗号，可以删除这里的逗号
      end
      --Format
      for i = 1,lastCount or 0 do print("\t") end
      print("}")
  end
  --Format
  if not lastCount then
      print("\n")
  end
end
