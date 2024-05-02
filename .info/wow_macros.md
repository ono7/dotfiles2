# hunter

Prioritize mouse over targets

reference: `https://huntsmanslodge.com/9392/hunter-macros-for-pvp/`

```
-- trinkets
/use 13 or /use 14

-- trap launchers, at cursor, alt for alternate trap
#showtooltip
/cast [mod:alt,@cursor] Explosive Trap; [@cursor]Frost Trap

-- healthstone first, or potion if hs is missing
/use Healthstone
/use Runic Healing Potion
/script UIErrorsFrame:Clear()


-- single macros
/cast [@mouseover,harm][harm] Silencing Shot
/cast [@mouseover,harm][harm] Scatter Shot

-- cast over friendly if mouse over, or self
/cast [@mouseover,help][@player] Intervene
/cast [@mouseover,help][@player] Roar of Sacrifice
/cast [@mouseover,help][@player] Master's Call

-- flare
/cast !Flare

-- manual spirit mend in pvp
/cast [@mouseover,help][@player] Spirit Mend
/script UIErrorsFrame:Clear()


-- ks
/cancelaura Deterrence
/cancelaura Hand of Protection
/cast Kill Shot

-- rapid fire
/use 14
/cast Rapid Fire
/cast Call of the Wild
/script UIErrorsFrame:Clear()

-- aspect
/cast [mod:alt] !Aspect of the Wild; Aspect of the Hawk
/cast Aspect of the Fox

-- pet
/petpassive
/petfollow
/cast [mod:alt] Dash
/cast [mod:shift] Dismiss Pet
/script UIErrorsFrame:Clear()

or

-- if pet is not in LoS, hold shift
/cast [mod:alt] Call Pet 2
/cast [@pet,dead][mod:shift] Revive Pet; [nopet] Call Pet 1; Mend Pet

```
