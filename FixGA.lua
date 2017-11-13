_G.ValidTarget = function(object, distance, enemyTeam)
    local enemyTeam = (enemyTeam ~= false)
    return object ~= nil and object.valid and (object.team ~= player.team) == enemyTeam and object.visible and not object.dead and object.bTargetable and (enemyTeam == false or object.bInvulnerable ~= 1) and (distance == nil or GetDistanceSqr(object) <= distance * distance)
end
