import { init } from 'https://esm.sh/modern-monaco'
import { evaluateSync } from 'https://esm.sh/@mdx-js/mdx@3?bundle'
import * as runtime from 'https://esm.sh/preact@11.0.1/jsx-runtime'
import { render, h } from 'https://esm.sh/preact@11.0.1'

const monaco = await init()
const editor = monaco.editor.create(document.querySelector('#editor'), {
  value: '',
  language: 'mdx',
  automaticLayout: true
})

let savedValue = editor.getValue()
let savedViewState = editor.saveViewState()

document.querySelector('#editor-submit').addEventListener('click', () => {
  const code = editor.getValue()
  try {
    const { default: mdxContent } = evaluateSync(code, runtime)
    render(h(mdxContent), document.querySelector('#preview'))
    savedValue = code
    savedViewState = editor.saveViewState()
    document.querySelector('#editor-dialog').hidePopover()
  } catch (err) {
    const startLineNumber = err.line
    const startColumn = err.column
    let endLineNumber = startLineNumber
    let endColumn = startColumn
    if (err.place && err.place.end) {
      endLineNumber = err.place.end.line
      endColumn = err.place.end.column
    }
    const markers = [
      {
        startLineNumber,
        startColumn,
        endLineNumber,
        endColumn,
        message: err.message,
        severity: monaco.MarkerSeverity.Error
      }
    ]
    monaco.editor.setModelMarkers(editor.getModel(), 'mdx-parse-error', markers)
  }
})

document.querySelector('#editor-close').addEventListener('click', () => {
  editor.setValue(savedValue)
  editor.restoreViewState(savedViewState)
})

function reader (file) {
  return new Promise((res, rej) => {
    let reader = new FileReader()
    reader.onload = () => res(reader.result)
    reader.onerror = () => rej(reader.error)
    reader.readAsText(file)
  })
}

const editorInput = document.querySelector('#editor-upload-input')

editorInput.addEventListener('change', async e => {
  const content = await reader(e.target.files[0])
  editor.setValue(content)
})

document.querySelector('#editor-upload').addEventListener('click', () => {
  editorInput.click()
})

document.querySelector('#editor-save').addEventListener('click', () => {
  const code = editor.getValue()
  const file = new Blob([code], { type: 'text/plain' })
  const url = URL.createObjectURL(file)
  let a = document.createElement('a')
  a.href = url
  a.download = 'sheet.mdx'
  a.click()
  setTimeout(() => {
    document.body.removeChild(a)
    window.URL.revokeObjectURL(url)
  }, 0)
})
