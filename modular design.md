             | Low strength     | High strength |
Low distance | Local complexity | High cohesion |
High distance| Loose coupling   | Global complexity 

Global complexity: high cost of cascading changes, high shared knowledge, frequent cascading changes

MODULARITY = STRENGTH XOR distance
Everything either has high cohesions (stongly related and close in distance), or loose coupling (weakly related and far in distance)


Distance:
. methods           ##
. classes           ###
. submodules        ####
. modules           #####
. components        ######
. (micro)services   #######
. systems           #########



            integration strength
Upstream   <----------  downstream
module       depends on   module

|---------------------------|
          distance



