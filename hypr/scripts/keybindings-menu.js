let input = ""
process.stdin.setEncoding("utf8")
process.stdin.on("data", chunk => input += chunk)
process.stdin.on("end", () => {
  const binds = JSON.parse(input)
  const modifiers = [
    [64, "Super"],
    [1, "Shift"],
    [4, "Ctrl"],
    [8, "Alt"],
  ]

  const rows = binds
    .filter(bind => bind.has_description && bind.description && !bind.submap)
    .map(bind => {
      const keys = modifiers
        .filter(([mask]) => (bind.modmask & mask) !== 0)
        .map(([, name]) => name)
      keys.push(bind.key)
      return [keys.join("+"), bind.description]
    })
    .sort((a, b) => a[0].localeCompare(b[0]))

  const width = Math.max(...rows.map(([key]) => key.length), 0)
  for (const [key, description] of rows)
    process.stdout.write(`${key.padEnd(width)}  ${description}\n`)
})
