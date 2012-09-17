should     = load 'should'
{resolve}  = load 'path'
dashboard  = load 'services.jobs.dashboard'
paths      = load 'services.paths'
contract   = load 'test.app.contract'
module.exports =

  dashboard:
    "start new @agent with contract": ->
      contract.log   = -> # mute log
      contract.web   = port: 8103
      contract.paths = paths "#{app.paths.app}/test"
      @agent = dashboard contract
    'agent.web.server started on 8103': ->
      should.exist @agent.web.server
#    'agent.web.socket (vein) started': ->
#      should.exist @agent.web.socket
    'views should': ->
    'agent.web.server closed on 8103': ->
      @agent.web.server.close()
