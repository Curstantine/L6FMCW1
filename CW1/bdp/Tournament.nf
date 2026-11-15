Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(Tournament))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(Tournament))==(Machine(Tournament));
  Level(Machine(Tournament))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(Tournament)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(Tournament))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(Tournament))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(Tournament))==(?);
  List_Includes(Machine(Tournament))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(Tournament))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(Tournament))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(Tournament))==(?);
  Context_List_Variables(Machine(Tournament))==(?);
  Abstract_List_Variables(Machine(Tournament))==(?);
  Local_List_Variables(Machine(Tournament))==(teamScores,pScores,matches,phase,teamPlayers);
  List_Variables(Machine(Tournament))==(teamScores,pScores,matches,phase,teamPlayers);
  External_List_Variables(Machine(Tournament))==(teamScores,pScores,matches,phase,teamPlayers)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(Tournament))==(?);
  Abstract_List_VisibleVariables(Machine(Tournament))==(?);
  External_List_VisibleVariables(Machine(Tournament))==(?);
  Expanded_List_VisibleVariables(Machine(Tournament))==(?);
  List_VisibleVariables(Machine(Tournament))==(?);
  Internal_List_VisibleVariables(Machine(Tournament))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(Tournament))==(btrue);
  Gluing_List_Invariant(Machine(Tournament))==(btrue);
  Expanded_List_Invariant(Machine(Tournament))==(btrue);
  Abstract_List_Invariant(Machine(Tournament))==(btrue);
  Context_List_Invariant(Machine(Tournament))==(btrue);
  List_Invariant(Machine(Tournament))==(teamPlayers: TEAMS <-> PLAYERS & teamPlayers~: PLAYERS +-> TEAMS & !tt.(tt: TEAMS => card(teamPlayers[{tt}])<=4) & phase: PHASES & matches: iseq(PLAYERS*PLAYERS) & ran(matches)/\id(PLAYERS) = {} & pScores: PLAYERS --> NAT & teamScores: TEAMS --> NAT)
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(Tournament))==(btrue);
  Abstract_List_Assertions(Machine(Tournament))==(btrue);
  Context_List_Assertions(Machine(Tournament))==(btrue);
  List_Assertions(Machine(Tournament))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(Tournament))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(Tournament))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(Tournament))==(teamPlayers,phase,matches,pScores,teamScores:={},Selection,<>,PLAYERS*{0},TEAMS*{0});
  Context_List_Initialisation(Machine(Tournament))==(skip);
  List_Initialisation(Machine(Tournament))==(teamPlayers:={} || phase:=Selection || matches:=<> || pScores:=PLAYERS*{0} || teamScores:=TEAMS*{0})
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(Tournament))==(?)
END
&
THEORY ListInstanciatedParametersX END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(Tournament))==(btrue);
  List_Constraints(Machine(Tournament))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(Tournament))==(setPlayers,setupMatch,undo,proceed,nextGame,restart,playerScores);
  List_Operations(Machine(Tournament))==(setPlayers,setupMatch,undo,proceed,nextGame,restart,playerScores)
END
&
THEORY ListInputX IS
  List_Input(Machine(Tournament),setPlayers)==(team,members);
  List_Input(Machine(Tournament),setupMatch)==(players);
  List_Input(Machine(Tournament),undo)==(?);
  List_Input(Machine(Tournament),proceed)==(?);
  List_Input(Machine(Tournament),nextGame)==(?);
  List_Input(Machine(Tournament),restart)==(?);
  List_Input(Machine(Tournament),playerScores)==(team)
END
&
THEORY ListOutputX IS
  List_Output(Machine(Tournament),setPlayers)==(report);
  List_Output(Machine(Tournament),setupMatch)==(report);
  List_Output(Machine(Tournament),undo)==(report);
  List_Output(Machine(Tournament),proceed)==(report);
  List_Output(Machine(Tournament),nextGame)==(report);
  List_Output(Machine(Tournament),restart)==(report);
  List_Output(Machine(Tournament),playerScores)==(scores)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(Tournament),setPlayers)==(report <-- setPlayers(team,members));
  List_Header(Machine(Tournament),setupMatch)==(report <-- setupMatch(players));
  List_Header(Machine(Tournament),undo)==(report <-- undo);
  List_Header(Machine(Tournament),proceed)==(report <-- proceed);
  List_Header(Machine(Tournament),nextGame)==(report <-- nextGame);
  List_Header(Machine(Tournament),restart)==(report <-- restart);
  List_Header(Machine(Tournament),playerScores)==(scores <-- playerScores(team))
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(Tournament),setPlayers)==(team: TEAMS & members <: PLAYERS);
  List_Precondition(Machine(Tournament),setupMatch)==(players: PLAYERS*PLAYERS & prj1(PLAYERS,PLAYERS)(players)/=prj2(PLAYERS,PLAYERS)(players));
  List_Precondition(Machine(Tournament),undo)==(btrue);
  List_Precondition(Machine(Tournament),proceed)==(btrue);
  List_Precondition(Machine(Tournament),nextGame)==(btrue);
  List_Precondition(Machine(Tournament),restart)==(btrue);
  List_Precondition(Machine(Tournament),playerScores)==(team: TEAMS)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(Tournament),playerScores)==(team: TEAMS | scores:=teamPlayers[{team}]<|pScores);
  Expanded_List_Substitution(Machine(Tournament),restart)==(btrue | phase/=Play ==> report:=wrongPhase [] not(phase/=Play) ==> (matches/=<> ==> report:=matchesRemaining [] not(matches/=<>) ==> teamPlayers,phase,matches,pScores,teamScores,report:={},Selection,<>,PLAYERS*{0},TEAMS*{0},success));
  Expanded_List_Substitution(Machine(Tournament),nextGame)==(btrue | phase/=Play ==> report:=wrongPhase [] not(phase/=Play) ==> (matches = <> ==> report:=noMatchesToPlay [] not(matches = <>) ==> @(firstMatch,p1,p2).(firstMatch = first(matches) & p1 = prj1(PLAYERS,PLAYERS)(firstMatch) & p2 = prj2(PLAYERS,PLAYERS)(firstMatch) ==> (playerAbility(p1)>playerAbility(p2) ==> @t1.(t1 = teamPlayers~(p1) ==> pScores,teamScores:=pScores<+{p1|->pScores(p1)+1},teamScores<+{t1|->teamScores(t1)+1}) [] not(playerAbility(p1)>playerAbility(p2)) ==> @t2.(t2 = teamPlayers~(p2) ==> pScores,teamScores:=pScores<+{p2|->pScores(p2)+1},teamScores<+{t2|->teamScores(t2)+1}) || matches:=tail(matches) || report:=success))));
  Expanded_List_Substitution(Machine(Tournament),proceed)==(btrue | phase/=Setup ==> report:=wrongPhase [] not(phase/=Setup) ==> (size(matches)/=36 ==> report:=notEnoughScheduled [] not(size(matches)/=36) ==> phase,report:=Play,success));
  Expanded_List_Substitution(Machine(Tournament),undo)==(btrue | phase/=Setup ==> report:=wrongPhase [] not(phase/=Setup) ==> (matches = <> ==> report:=noMatchesToUndo [] not(matches = <>) ==> matches,report:=front(matches),success));
  Expanded_List_Substitution(Machine(Tournament),setupMatch)==(players: PLAYERS*PLAYERS & prj1(PLAYERS,PLAYERS)(players)/=prj2(PLAYERS,PLAYERS)(players) | phase/=Setup ==> report:=wrongPhase [] not(phase/=Setup) ==> @(p1,p2,scheduledPairs,t1,t2).(p1 = prj1(PLAYERS,PLAYERS)(players) & p2 = prj2(PLAYERS,PLAYERS)(players) & scheduledPairs = ran(matches) & t1 = teamPlayers~(p1) & t2 = teamPlayers~(p2) ==> (p1|->p2: scheduledPairs or p2|->p1: scheduledPairs ==> report:=matchAlreadyScheduled [] not(p1|->p2: scheduledPairs or p2|->p1: scheduledPairs) ==> (t1 = t2 ==> report:=playersInSameTeam [] not(t1 = t2) ==> (card({p1}<|scheduledPairs\/scheduledPairs|>{p1})>=6 or card({p2}<|scheduledPairs\/scheduledPairs|>{p2})>=6 ==> report:=playerMaxScheduled [] not(card({p1}<|scheduledPairs\/scheduledPairs|>{p1})>=6 or card({p2}<|scheduledPairs\/scheduledPairs|>{p2})>=6) ==> (card({pair | pair: scheduledPairs & (teamPlayers~(prj1(PLAYERS,PLAYERS)(pair)) = t1 & teamPlayers~(prj2(PLAYERS,PLAYERS)(pair)) = t2 or (teamPlayers~(prj1(PLAYERS,PLAYERS)(pair)) = t2 & teamPlayers~(prj2(PLAYERS,PLAYERS)(pair)) = t1))})>=12 ==> report:=teamMaxScheduled [] not(card({pair | pair: scheduledPairs & (teamPlayers~(prj1(PLAYERS,PLAYERS)(pair)) = t1 & teamPlayers~(prj2(PLAYERS,PLAYERS)(pair)) = t2 or (teamPlayers~(prj1(PLAYERS,PLAYERS)(pair)) = t2 & teamPlayers~(prj2(PLAYERS,PLAYERS)(pair)) = t1))})>=12) ==> matches,report:=matches<-(p1|->p2),success))))));
  Expanded_List_Substitution(Machine(Tournament),setPlayers)==(team: TEAMS & members <: PLAYERS | phase/=Selection ==> report:=wrongPhase [] not(phase/=Selection) ==> (team: dom(teamPlayers) ==> report:=teamNotEmpty [] not(team: dom(teamPlayers)) ==> (card(members)/=4 ==> report:=invalidMemberCount [] not(card(members)/=4) ==> (ran(teamPlayers)/\members/={} ==> report:=playerAlreadyInTeam [] not(ran(teamPlayers)/\members/={}) ==> (card(dom(teamPlayers)) = 0 ==> teamPlayers,report:=teamPlayers\/{team}*members,success [] not(card(dom(teamPlayers)) = 0) ==> (card(dom(teamPlayers)) = 1 ==> @(remainingTeam,remainingPlayers).(remainingTeam = TEAMS-dom(teamPlayers)-{team} & remainingPlayers = PLAYERS-(ran(teamPlayers)\/members) ==> teamPlayers,phase,report:=teamPlayers\/{team}*members\/remainingTeam*remainingPlayers,Setup,teamsCompleted) [] not(card(dom(teamPlayers)) = 1) ==> report:=teamNotEmpty))))));
  List_Substitution(Machine(Tournament),setPlayers)==(IF phase/=Selection THEN report:=wrongPhase ELSIF team: dom(teamPlayers) THEN report:=teamNotEmpty ELSIF card(members)/=4 THEN report:=invalidMemberCount ELSIF ran(teamPlayers)/\members/={} THEN report:=playerAlreadyInTeam ELSIF card(dom(teamPlayers)) = 0 THEN teamPlayers:=teamPlayers\/{team}*members || report:=success ELSIF card(dom(teamPlayers)) = 1 THEN LET remainingTeam,remainingPlayers BE remainingTeam = TEAMS-dom(teamPlayers)-{team} & remainingPlayers = PLAYERS-(ran(teamPlayers)\/members) IN teamPlayers:=teamPlayers\/{team}*members\/remainingTeam*remainingPlayers || phase:=Setup || report:=teamsCompleted END ELSE report:=teamNotEmpty END);
  List_Substitution(Machine(Tournament),setupMatch)==(IF phase/=Setup THEN report:=wrongPhase ELSE LET p1,p2,scheduledPairs,t1,t2 BE p1 = prj1(PLAYERS,PLAYERS)(players) & p2 = prj2(PLAYERS,PLAYERS)(players) & scheduledPairs = ran(matches) & t1 = teamPlayers~(p1) & t2 = teamPlayers~(p2) IN IF p1|->p2: scheduledPairs or p2|->p1: scheduledPairs THEN report:=matchAlreadyScheduled ELSIF t1 = t2 THEN report:=playersInSameTeam ELSIF card({p1}<|scheduledPairs\/scheduledPairs|>{p1})>=6 or card({p2}<|scheduledPairs\/scheduledPairs|>{p2})>=6 THEN report:=playerMaxScheduled ELSIF card({pair | pair: scheduledPairs & (teamPlayers~(prj1(PLAYERS,PLAYERS)(pair)) = t1 & teamPlayers~(prj2(PLAYERS,PLAYERS)(pair)) = t2 or (teamPlayers~(prj1(PLAYERS,PLAYERS)(pair)) = t2 & teamPlayers~(prj2(PLAYERS,PLAYERS)(pair)) = t1))})>=12 THEN report:=teamMaxScheduled ELSE matches:=matches<-(p1|->p2) || report:=success END END END);
  List_Substitution(Machine(Tournament),undo)==(IF phase/=Setup THEN report:=wrongPhase ELSIF matches = <> THEN report:=noMatchesToUndo ELSE matches:=front(matches) || report:=success END);
  List_Substitution(Machine(Tournament),proceed)==(IF phase/=Setup THEN report:=wrongPhase ELSIF size(matches)/=36 THEN report:=notEnoughScheduled ELSE phase:=Play || report:=success END);
  List_Substitution(Machine(Tournament),nextGame)==(IF phase/=Play THEN report:=wrongPhase ELSIF matches = <> THEN report:=noMatchesToPlay ELSE LET firstMatch,p1,p2 BE firstMatch = first(matches) & p1 = prj1(PLAYERS,PLAYERS)(firstMatch) & p2 = prj2(PLAYERS,PLAYERS)(firstMatch) IN IF playerAbility(p1)>playerAbility(p2) THEN LET t1 BE t1 = teamPlayers~(p1) IN pScores(p1):=pScores(p1)+1 || teamScores(t1):=teamScores(t1)+1 END ELSE LET t2 BE t2 = teamPlayers~(p2) IN pScores(p2):=pScores(p2)+1 || teamScores(t2):=teamScores(t2)+1 END END || matches:=tail(matches) || report:=success END END);
  List_Substitution(Machine(Tournament),restart)==(IF phase/=Play THEN report:=wrongPhase ELSIF matches/=<> THEN report:=matchesRemaining ELSE teamPlayers:={} || phase:=Selection || matches:=<> || pScores:=PLAYERS*{0} || teamScores:=TEAMS*{0} || report:=success END);
  List_Substitution(Machine(Tournament),playerScores)==(scores:=teamPlayers[{team}]<|pScores)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(Tournament))==(playerAbility);
  Inherited_List_Constants(Machine(Tournament))==(?);
  List_Constants(Machine(Tournament))==(playerAbility)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(Tournament),PLAYERS)==({Alice,Bob,Christine,Dennis,Eloise,Frank,Gabrielle,Hugo,Ida,John,Kate,Louis});
  Context_List_Enumerated(Machine(Tournament))==(?);
  Context_List_Defered(Machine(Tournament))==(?);
  Context_List_Sets(Machine(Tournament))==(?);
  List_Valuable_Sets(Machine(Tournament))==(?);
  Inherited_List_Enumerated(Machine(Tournament))==(?);
  Inherited_List_Defered(Machine(Tournament))==(?);
  Inherited_List_Sets(Machine(Tournament))==(?);
  List_Enumerated(Machine(Tournament))==(PLAYERS,TEAMS,PHASES,REPORT);
  List_Defered(Machine(Tournament))==(?);
  List_Sets(Machine(Tournament))==(PLAYERS,TEAMS,PHASES,REPORT);
  Set_Definition(Machine(Tournament),TEAMS)==({Red,Green,Blue});
  Set_Definition(Machine(Tournament),PHASES)==({Selection,Setup,Play});
  Set_Definition(Machine(Tournament),REPORT)==({success,teamsCompleted,wrongPhase,teamNotEmpty,invalidMemberCount,playerAlreadyInTeam,matchAlreadyScheduled,playersInSameTeam,notEnoughScheduled,playerMaxScheduled,teamMaxScheduled,noMatchesToUndo,noMatchesToPlay,matchesRemaining})
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(Tournament))==(?);
  Expanded_List_HiddenConstants(Machine(Tournament))==(?);
  List_HiddenConstants(Machine(Tournament))==(?);
  External_List_HiddenConstants(Machine(Tournament))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(Tournament))==(btrue);
  Context_List_Properties(Machine(Tournament))==(btrue);
  Inherited_List_Properties(Machine(Tournament))==(btrue);
  List_Properties(Machine(Tournament))==(playerAbility: PLAYERS >-> 1..12 & playerAbility = {Alice|->12,Bob|->11,Christine|->10,Dennis|->9,Eloise|->8,Frank|->7,Gabrielle|->6,Hugo|->5,Ida|->4,John|->3,Kate|->2,Louis|->1} & PLAYERS: FIN(INTEGER) & not(PLAYERS = {}) & TEAMS: FIN(INTEGER) & not(TEAMS = {}) & PHASES: FIN(INTEGER) & not(PHASES = {}) & REPORT: FIN(INTEGER) & not(REPORT = {}))
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(Tournament),setPlayers)==(?);
  List_ANY_Var(Machine(Tournament),setupMatch)==(?);
  List_ANY_Var(Machine(Tournament),undo)==(?);
  List_ANY_Var(Machine(Tournament),proceed)==(?);
  List_ANY_Var(Machine(Tournament),nextGame)==(?);
  List_ANY_Var(Machine(Tournament),restart)==(?);
  List_ANY_Var(Machine(Tournament),playerScores)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(Tournament)) == (playerAbility,PLAYERS,TEAMS,PHASES,REPORT,Alice,Bob,Christine,Dennis,Eloise,Frank,Gabrielle,Hugo,Ida,John,Kate,Louis,Red,Green,Blue,Selection,Setup,Play,success,teamsCompleted,wrongPhase,teamNotEmpty,invalidMemberCount,playerAlreadyInTeam,matchAlreadyScheduled,playersInSameTeam,notEnoughScheduled,playerMaxScheduled,teamMaxScheduled,noMatchesToUndo,noMatchesToPlay,matchesRemaining | ? | teamScores,pScores,matches,phase,teamPlayers | ? | setPlayers,setupMatch,undo,proceed,nextGame,restart,playerScores | ? | ? | ? | Tournament);
  List_Of_HiddenCst_Ids(Machine(Tournament)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Tournament)) == (playerAbility);
  List_Of_VisibleVar_Ids(Machine(Tournament)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(Tournament)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(Tournament)) == (Type(PLAYERS) == Cst(SetOf(etype(PLAYERS,0,11)));Type(TEAMS) == Cst(SetOf(etype(TEAMS,0,2)));Type(PHASES) == Cst(SetOf(etype(PHASES,0,2)));Type(REPORT) == Cst(SetOf(etype(REPORT,0,13))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(Tournament)) == (Type(Alice) == Cst(etype(PLAYERS,0,11));Type(Bob) == Cst(etype(PLAYERS,0,11));Type(Christine) == Cst(etype(PLAYERS,0,11));Type(Dennis) == Cst(etype(PLAYERS,0,11));Type(Eloise) == Cst(etype(PLAYERS,0,11));Type(Frank) == Cst(etype(PLAYERS,0,11));Type(Gabrielle) == Cst(etype(PLAYERS,0,11));Type(Hugo) == Cst(etype(PLAYERS,0,11));Type(Ida) == Cst(etype(PLAYERS,0,11));Type(John) == Cst(etype(PLAYERS,0,11));Type(Kate) == Cst(etype(PLAYERS,0,11));Type(Louis) == Cst(etype(PLAYERS,0,11));Type(Red) == Cst(etype(TEAMS,0,2));Type(Green) == Cst(etype(TEAMS,0,2));Type(Blue) == Cst(etype(TEAMS,0,2));Type(Selection) == Cst(etype(PHASES,0,2));Type(Setup) == Cst(etype(PHASES,0,2));Type(Play) == Cst(etype(PHASES,0,2));Type(success) == Cst(etype(REPORT,0,13));Type(teamsCompleted) == Cst(etype(REPORT,0,13));Type(wrongPhase) == Cst(etype(REPORT,0,13));Type(teamNotEmpty) == Cst(etype(REPORT,0,13));Type(invalidMemberCount) == Cst(etype(REPORT,0,13));Type(playerAlreadyInTeam) == Cst(etype(REPORT,0,13));Type(matchAlreadyScheduled) == Cst(etype(REPORT,0,13));Type(playersInSameTeam) == Cst(etype(REPORT,0,13));Type(notEnoughScheduled) == Cst(etype(REPORT,0,13));Type(playerMaxScheduled) == Cst(etype(REPORT,0,13));Type(teamMaxScheduled) == Cst(etype(REPORT,0,13));Type(noMatchesToUndo) == Cst(etype(REPORT,0,13));Type(noMatchesToPlay) == Cst(etype(REPORT,0,13));Type(matchesRemaining) == Cst(etype(REPORT,0,13));Type(playerAbility) == Cst(SetOf(etype(PLAYERS,0,11)*btype(INTEGER,1,12))))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(Tournament)) == (Type(teamScores) == Mvl(SetOf(etype(TEAMS,0,2)*btype(INTEGER,0,MAXINT)));Type(pScores) == Mvl(SetOf(etype(PLAYERS,0,11)*btype(INTEGER,0,MAXINT)));Type(matches) == Mvl(SetOf(btype(INTEGER,?,?)*(etype(PLAYERS,?,?)*etype(PLAYERS,?,?))));Type(phase) == Mvl(etype(PHASES,?,?));Type(teamPlayers) == Mvl(SetOf(etype(TEAMS,?,?)*etype(PLAYERS,?,?))))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(Tournament)) == (Type(playerScores) == Cst(SetOf(etype(PLAYERS,?,?)*btype(INTEGER,?,?)),etype(TEAMS,?,?));Type(restart) == Cst(etype(REPORT,?,?),No_type);Type(nextGame) == Cst(etype(REPORT,?,?),No_type);Type(proceed) == Cst(etype(REPORT,?,?),No_type);Type(undo) == Cst(etype(REPORT,?,?),No_type);Type(setupMatch) == Cst(etype(REPORT,?,?),etype(PLAYERS,?,?)*etype(PLAYERS,?,?));Type(setPlayers) == Cst(etype(REPORT,?,?),etype(TEAMS,?,?)*SetOf(etype(PLAYERS,?,?))));
  Observers(Machine(Tournament)) == (Type(playerScores) == Cst(SetOf(etype(PLAYERS,?,?)*btype(INTEGER,?,?)),etype(TEAMS,?,?)))
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  project_type == SOFTWARE_TYPE;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == KO;
  event_b_coverage == KO;
  event_b_exclusivity == KO;
  genFeasibilityPO == KO
END
)
