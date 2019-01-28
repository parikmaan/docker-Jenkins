#!groovy

import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule

def instance = Jenkins.getInstance()

def user = new File("/run/secrets/jenkinsUsername").text.trim()
def pass = new File("/run/secrets/jenkinsPassword").text.trim()

println("**************************************************")
println("**************************************************")
println(user + ":" + pass)
println("**************************************************")
println("**************************************************")
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(user, pass)
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)
instance.save()
println("**************************************************")
println("**************************************************")
//Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)