# Malfoy bot on Render — v12.0.0

Name kept: **Malfoy**. Same stack (Node 20, Baileys, Docker, Render).

## What's new in v12.0.0 (more commands, cohesive RPG/economy set)

### New commands
- **`.status` / `.stats`** — one panel: level + XP bar, coins/vault/gems/treasures, geo/power/attraction, pet, zone + visited count, active boosts, inventory count.
- **`.titles` / `.title` / `.title set <name>`** — 8 unlockable titles (Beginner, Bug Slayer, Bossbane, Geo Baron, Coin Baron, Attraction Star, Pet Lover, Crowned). Set one to display it in `.status` and `.profile`.
- **`.achievements`** — lifetime progress summary (hunts, boss kills, quests, streak, treasures, guild donated, items, titles).
- **`.vault` / `.bank`** — safe coin storage: `.vault deposit <amt>`, `.vault withdraw <amt>`. Vault coins cannot be robbed.
- **`.use <item>`** — consume shop items: XP Boost / Coin Boost / Lucky Charm / Speed / Shield (24h timed boosts), Energy Drink, Treasure Key, gifts (bond), pickaxe/drill (boosts), crown (title), cat/dog/dragon (adopt pet). Passive gear/VIP says so instead of wasting it.
- **`.sell <item>`** — sell an item back for 50% refund (permanent unlocks like miners/VIP cannot be sold).
- **`.gift @user <item>`** — transfer a shop item to another user.
- **`.rob @user`** — steal up to ~12% of a target's wallet coins. Blocked by `.use shield`. Target must hold 100+ coins. Chance scales with your Power + Luck.
- **`.weekly`** — 7-day reward: +2000 Coins, +500 Geo, +1000 XP.
- **`.hourly`** — 1-hour reward: +100 Coins, +30 XP.
- **`.pet`** — care for an owned shop pet: `.pet adopt [cat|dog|dragon]`, `.pet feed` (50 Coins, 1h cooldown, +10 Bond), `.pet play` (10m cooldown, +5 Bond +XP).
- **`.map`** — current zone + visited/locked zones.
- **`.travel <zone>`** — travel between the 6 Hollow Knight zones (Dirtmouth, Forgotten Crossroads, Greenpath, City of Tears, Resting Grounds, Crystal Peak). First visit to a zone: +100 Coins, +50 Geo, +15 XP.
- **`.guild donate <amount>`** — donate coins to Griffin Guild for XP (tracked in `.achievements`), plus `.guilddonate` alias.

### Anti-abuse / cooldowns added
- `.hunt` 30s cooldown, `.boss` 60s cooldown (was unlimited farming).
- All gambling (`.slot` `.coinflip` `.dice` `.blackjack`): shared 10s cooldown, bet range 10 to 5000 enforced, insufficient-funds checked before deducting, `.dice` face must be 1 to 6.
- `.rob`: 30min global cooldown + 1h per-target cooldown, anti-shield, victim too-broke check, failure fine.
- `.travel` 60s cooldown, `.pet feed` 1h / `.pet play` 10m cooldowns.
- `.pay`: cannot pay yourself, amount must be positive.
- `.vault` keeps coins rob-proof; timed boosts expire automatically (`boosts` map with timestamps).

### Previous (v11.0.0, kept)
- FAST v2 DB caching + instant ⚡ react, `.sm`, `.kill`, `.infogc`, `.play` with thumbnail + audio, `.exp`, shop GEARS + ATTRACTION, Hollow Knight quests/hunt/boss/bench/geo/power/attraction.

## Setup (same as before)
1. Put files in a GitHub repo (add `media/menu.jpg`, `media/tagall.jpg`, optional `media/shop.jpg`, and `waifu/*.jpg`).
2. Render > New > Blueprint (uses `render.yaml`) or New > Web Service > Docker.
3. Env: `GROQ_API_KEY`, `PAIRING_NUMBER` (e.g. 2348101234567) or `QR_KEY`, `FAST_MODE` (default true), `DATA_DIR=/var/data`.
4. Deploy, open Logs for pairing code / QR.

## Notes
- No new dependencies. Existing users auto-migrate: new fields (vault, boosts, pet, zone, titles, cooldowns) are added on first use after updating.
- `.play` needs `yt-dlp` (already in Dockerfile). Thumbnail comes from yt-search/noembed.
- `.kill` image source is Pinterest scrape (may vary); fallback waifu.
- Save to Render disk to keep DB; FAST_MODE keeps changes in memory until flush (every 5s).
