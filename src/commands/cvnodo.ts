
import { GluegunCommand } from 'gluegun'


const command: GluegunCommand = {
  name: 'cvnodo',
  run: async toolbox => {
    const { print } = toolbox

    print.info('Welcome to your CLI')
  },
}

module.exports = command
