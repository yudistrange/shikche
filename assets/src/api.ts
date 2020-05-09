function searchBackend(value: string) {
  return fetch("/api/v1/translations/" + value)
}

export {searchBackend}