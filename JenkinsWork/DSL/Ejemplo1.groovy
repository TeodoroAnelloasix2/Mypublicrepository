job('ejemplo-dsl') {
  description('Job creado con dsl')
  scm{
    git('https://github.com/TeodoroAnelloasix2/Mypublicrepository.git','main'){ node ->
      node / gitConfigName('Teodoro Anello')
      node / gitConfigEmail('giacomoeneldo@gmail.com')
    }
  }
  parameters{
    booleanParam('ejecutar',false)
    stringParam('comando',defaultValue='hostname',description='Comando extra a ejecutar!')
  	choiceParam('ruta',['/var','/null'])
  }
  triggers {
      cron('H/10 * * * *')
  }
  steps{
    shell('JenkinsWork/scripts/backupjenkinscontenedor.sh "$ruta" "$ejecutar" "$comando"')
  }
  publishers {
    mailer('gopycodewar@gmail.com',true,true)
    slackNotifier{ 
      notifyAborted(true)
      notifyEveryFailure(true)
      notifyNotBuilt(false)
      notifyUnstable(false)
      notifyBackToNormal(true)
      notifySuccess(false)
      notifyRepeatedFailure(false)
      startNotification(false)
      includeTestSummary(false)
      includeCustomMessage(false)
      customMessage(null)
      sendAs(null)
      commitInfoChoice('NONE')
      teamDomain(null)
      authToken(null)
    }
  }
  
}
