const pug = require('pug')

function openModal (node) {
  document.querySelectorAll(node.dataset.modal).forEach(n => n.style.display='block')
}

function closeModal (node) {
  document.querySelectorAll(node.dataset.modal).forEach(n => n.style.display='none')
}

function downloadText (text) {
  const file = new Blob([text], { type: 'text/plain' })
  const url = URL.createObjectURL(file)
  let a = document.createElement('a')
  a.classList.add('w3-hide')
  a.href = url
  a.download = 'sheet.pug'
  document.body.appendChild(a)
  a.click()
  setTimeout(() => {
    document.body.removeChild(a)
    window.URL.revokeObjectURL(url)
  }, 0)
}

function reader (file) {
  return new Promise((res, rej) => {
    let reader = new FileReader()
    reader.onload = () => res(reader.result)
    reader.onerror = () => rej(reader.error)
    reader.readAsText(file)
  })
}

function init () {
  const editor = ace.edit('editor')
  editor.setOptions({ wrap: true, maxLines: Infinity, tabSize: 2, useSoftTabs: true })
  editor.session.setMode('ace/mode/jade')

  async function input (e) {
    try {
      const content = editor.getValue()
      const pugtext = pug.render(content)
      const parser = new DOMParser()
      const html = parser.parseFromString(pugtext, 'text/html')
      const root = document.querySelector('#show')
      const shadow = root.shadowRoot || root.attachShadow({ mode: 'open' })
      window.editorDocument = shadow
      shadow.innerHTML = html.documentElement.outerHTML
      editor.getSession().setAnnotations([])
    } catch (e) {
      window.errs = e
      const nline = isFinite(e.line) ? e.line - 1 : 0
      editor.getSession().setAnnotations([{ row: nline, type: 'error', text: e.message }])
    }
  }
  editor.on('change', input)
  
  input()
  
  window.downloadFromEditor = () => {
    const text = editor.getValue()
    downloadText(text)
  }

  window.uploadFromFile = async node => {
    const file = node.files[0]
    const text = await reader(file)
    editor.setValue(text)
  }
}

window.onload = init
