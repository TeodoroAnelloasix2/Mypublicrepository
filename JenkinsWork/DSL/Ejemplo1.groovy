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
  	choiceParam('path',['/var','/null'])
  }
}
