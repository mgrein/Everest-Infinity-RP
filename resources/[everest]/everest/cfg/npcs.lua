cfg = {}

cfg.density = {
	peds = 2.00,
	vehicles = 0.02
}

cfg.peds = { -- these peds wont show up anywhere, they will be removed and their vehicles deleted
  "s_m_y_cop_01",
  -- "s_f_y_sheriff_01",
  -- "s_m_y_sheriff_01",
  -- "s_m_y_hwaycop_01",
  -- "s_m_y_swat_01",
  -- "s_m_m_snowcop_01",
  -- "s_m_m_paramedic_01"
}

cfg.noguns = { -- these peds wont have any weapons
  -- "s_m_m_security_01",
  -- "s_m_y_cop_01",
  -- "s_f_y_sheriff_01",
  -- "s_m_y_sheriff_01",
  -- "s_m_y_hwaycop_01",
  -- "s_m_y_swat_01",
  -- "s_m_m_snowcop_01",
  -- "s_m_m_paramedic_01",
}

cfg.nodrops = { -- these peds wont drop their weapons when killed
}


--[[ WORK IN PROGRESS // DOES NOT WORK
cfg.vehs = { -- these vehicles wont show up anywhere, they will be removed unless a player is in the driver seat
  "police",
  "policet",
  "sheriff",
  "fbi",
  "pranger",
  "riot",
  "pbus"
}
]]