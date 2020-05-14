function searchBackend(value: string) {
  return fetch("/api/v1/translations/" + value)
}

function login(email: string, password: string) {
  return fetch(
    "/api/v1/login",
    {
      method: "post",
      headers: {"Content-type": "application/json"},
      body: JSON.stringify({
        "email": email,
        "password": password
      })
  })
}

export {searchBackend, login}