function Table(tbl)
  -- Set custom widths: 20%, 50%, 30%
  tbl.colspecs = {
    {pandoc.AlignLeft, 0.2},
    {pandoc.AlignLeft, 0.1},
    {pandoc.AlignLeft, 0.7}
  }
  return tbl
end