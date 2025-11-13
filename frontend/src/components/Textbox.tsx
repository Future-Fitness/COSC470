import './Textbox.css'

interface Props {
  onInput?: (value: string) => void
  className?: string
  placeholder?: string
  type?: string
  onKeyPress?: (e: React.KeyboardEvent) => void
}

export default function Textbox(props: Props) {
  return (
    <input
      type={props.type || 'text'}
      className={'Textbox ' + props.className}
      placeholder={props.placeholder}
      onInput={(e) => {
        e.preventDefault()
        if (!props?.onInput) {
          return
        }

        // @ts-expect-error womp womp
        props.onInput(e.target.value)
      }}
      onKeyPress={props.onKeyPress}
    />
  )
}