/* Tournament
- Author: Rachala Ovin Gunawardana
- Creation date: 26/10/2026
 */
MACHINE
    Tournament

SETS
    PLAYERS = { Alice , Bob , Christine , Dennis , Eloise , Frank , Gabrielle , Hugo , Ida , John , Kate , Louis } ;
    TEAMS = { Red , Green , Blue } ;
    PHASES = { Selection , Setup , Play } ;
    REPORT = {
        success ,
        teamsCompleted ,
        wrongPhase ,
        teamNotEmpty ,
        invalidMemberCount ,
        playerAlreadyInTeam ,
        matchAlreadyScheduled ,
        playersInSameTeam ,
        notEnoughScheduled ,
        playerMaxScheduled ,
        teamMaxScheduled ,
        noMatchesToUndo ,
        noMatchesToPlay ,
        matchesRemaining
    }

CONCRETE_CONSTANTS
    playerAbility

PROPERTIES
    playerAbility : PLAYERS >-> 1 .. 12 &
    playerAbility = {
        Alice |-> 12 ,
        Bob |-> 11 ,
        Christine |-> 10 ,
        Dennis |-> 9 ,
        Eloise |-> 8 ,
        Frank |-> 7 ,
        Gabrielle |-> 6 ,
        Hugo |-> 5 ,
        Ida |-> 4 ,
        John |-> 3 ,
        Kate |-> 2 ,
        Louis |-> 1
    }

ABSTRACT_VARIABLES
    // teamPlayers is a relation between TEAMS and PLAYERS where each player
    // belongs to at most one team (inverse is a partial function).
    teamPlayers ,
    phase ,
    // matches is a sequence because it needs to be ordered for
    // LIFO undo and FIFO nextGame operations.
    matches ,
    pScores ,
    teamScores

INVARIANT
    teamPlayers : TEAMS <-> PLAYERS &
    teamPlayers ~ : PLAYERS +-> TEAMS &
    ! tt . ( tt : TEAMS => card ( teamPlayers [ { tt } ] ) <= 4 ) &
    phase : PHASES &
    matches : iseq ( PLAYERS * PLAYERS ) &
    ran ( matches ) /\ id ( PLAYERS ) = {} &
    pScores : PLAYERS --> NAT &
    teamScores : TEAMS --> NAT

INITIALISATION
    teamPlayers := {} ||
    phase := Selection ||
    matches := <> ||
    pScores := PLAYERS * { 0 } ||
    teamScores := TEAMS * { 0 }

OPERATIONS
    report <-- setPlayers ( team , members ) =
    PRE
        team : TEAMS &
        members <: PLAYERS
    THEN
        IF phase /= Selection THEN
            report := wrongPhase
        ELSIF team : dom ( teamPlayers ) THEN
            report := teamNotEmpty
        ELSIF card ( members ) /= 4 THEN
            report := invalidMemberCount
        ELSIF ran ( teamPlayers ) /\ members /= {} THEN
            report := playerAlreadyInTeam
        ELSIF card ( dom ( teamPlayers ) ) = 0 THEN
            teamPlayers := teamPlayers \/ ( { team } * members ) ||
            report := success
        ELSIF card ( dom ( teamPlayers ) ) = 1 THEN
            // Set remaining players after the second try.
            LET remainingTeam , remainingPlayers BE
                remainingTeam = ( TEAMS - dom ( teamPlayers ) ) - { team } &
                remainingPlayers = PLAYERS - ( ran ( teamPlayers ) \/ members )
            IN
                teamPlayers := teamPlayers \/ ( { team } * members ) \/ ( remainingTeam * remainingPlayers ) ||
                phase := Setup ||
                report := teamsCompleted
            END
        ELSE
            report := teamNotEmpty
        END
    END ;

    report <-- setupMatch ( players ) =
    PRE
        players : PLAYERS * PLAYERS &
        prj1 ( PLAYERS , PLAYERS ) ( players ) /= prj2 ( PLAYERS , PLAYERS ) ( players )
    THEN
        IF phase /= Setup THEN
            report := wrongPhase
        ELSE
            LET p1 , p2 , scheduledPairs , t1 , t2 BE
                p1 = prj1 ( PLAYERS , PLAYERS ) ( players ) &
                p2 = prj2 ( PLAYERS , PLAYERS ) ( players ) &
                scheduledPairs = ran ( matches ) &
                t1 = teamPlayers ~ ( p1 ) &
                t2 = teamPlayers ~ ( p2 )
            IN
                IF ( p1 |-> p2 : scheduledPairs ) or ( p2 |-> p1 : scheduledPairs ) THEN
                    report := matchAlreadyScheduled
                ELSIF t1 = t2 THEN
                    report := playersInSameTeam
                ELSIF card ( { p1 } <| scheduledPairs \/ scheduledPairs |> { p1 } ) >= 6 or
                      card ( { p2 } <| scheduledPairs \/ scheduledPairs |> { p2 } ) >= 6 THEN
                    report := playerMaxScheduled
                    // (prj1 = t1 & prj2 = t2) OR (prj1 = t2 & prj2 = t1) fn over scheduledPairs
                    // to check if either teams of the pairs of players in collective has >= 12 matches.
                ELSIF card ( { pair | pair : scheduledPairs &
                            ( ( teamPlayers ~ ( prj1 ( PLAYERS , PLAYERS ) ( pair ) ) = t1 &
                              teamPlayers ~ ( prj2 ( PLAYERS , PLAYERS ) ( pair ) ) = t2 ) or
                             ( teamPlayers ~ ( prj1 ( PLAYERS , PLAYERS ) ( pair ) ) = t2 &
                              teamPlayers ~ ( prj2 ( PLAYERS , PLAYERS ) ( pair ) ) = t1 ) ) } ) >= 12 THEN
                    report := teamMaxScheduled
                ELSE
                    // Append match to the sequence
                    matches := matches <- ( p1 |-> p2 ) ||
                    report := success
                END
            END
        END
    END ;

    report <-- undo =
    BEGIN
        IF phase /= Setup THEN
            report := wrongPhase
        ELSIF matches = <> THEN
            report := noMatchesToUndo
        ELSE
            // front removes the last element
            matches := front ( matches ) ||
            report := success
        END
    END ;

    report <-- proceed =
    BEGIN
        IF phase /= Setup THEN
            report := wrongPhase
        // (12 players * 6 matches) / 2 = 36 matches (3 team pairs * 12 matches = 36)
        ELSIF size ( matches ) /= 36 THEN
            report := notEnoughScheduled
        ELSE
            phase := Play ||
            report := success
        END
    END ;

    report <-- nextGame =
    BEGIN
        IF phase /= Play THEN
            report := wrongPhase
        ELSIF matches = <> THEN
            report := noMatchesToPlay
        ELSE
            // Play the first scheduled game; more skilled player always wins
            LET firstMatch , p1 , p2 BE
                firstMatch = first ( matches ) &
                p1 = prj1 ( PLAYERS , PLAYERS ) ( firstMatch ) &
                p2 = prj2 ( PLAYERS , PLAYERS ) ( firstMatch )
            IN
                IF playerAbility ( p1 ) > playerAbility ( p2 ) THEN
                    LET t1 BE t1 = teamPlayers ~ ( p1 ) IN
                        pScores ( p1 ) := pScores ( p1 ) + 1 ||
                        teamScores ( t1 ) := teamScores ( t1 ) + 1
                    END
                ELSE
                    LET t2 BE t2 = teamPlayers ~ ( p2 ) IN
                        pScores ( p2 ) := pScores ( p2 ) + 1 ||
                        teamScores ( t2 ) := teamScores ( t2 ) + 1
                    END
                END ||
                // tail removes the first element
                matches := tail ( matches ) ||
                report := success
            END
        END
    END ;

    report <-- restart =
    BEGIN
        IF phase /= Play THEN
            report := wrongPhase
        ELSIF matches /= <> THEN
            report := matchesRemaining
        ELSE
            teamPlayers := {} ||
            phase := Selection ||
            matches := <> ||
            pScores := PLAYERS * { 0 } ||
            teamScores := TEAMS * { 0 } ||
            report := success
        END
    END ;

    scores <-- playerScores ( team ) =
    PRE
        team : TEAMS
    THEN
        scores := teamPlayers [ { team } ] <| pScores
    END

END
