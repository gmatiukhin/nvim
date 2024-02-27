local status_ok, xkbswitch = pcall(require, "xkbswitch")
if not status_ok then
  print("Could not find xkbswitch")
  return
end

xkbswitch.setup()
