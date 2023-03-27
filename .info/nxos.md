# gracefully reconfigure a vxlan profile on a switch

1. create new profile with same properties as the old

  configure terminal
  configure profile 10-101-184-160_28_VL2472_12472
    vlan 2472
      vn-segment 12472
    interface nve1
      member vni 12472
        mcast-group 239.1.1.1
    evpn
      vni 12472 l2
        rd auto
        route-target import auto
        route-target export auto


2. refresh profile old_profile new_profile

  refresh profile OLD_PROFILE_THAT_SUCKS 10-101-184-160_28_VL2472_12472

3. check vni

  show nve vni | i (vlan id)


