import Cookies from 'universal-cookie';

const cookie = new Cookies();

function setToken(val: string) {
  console.log("Got token", val)
  cookie.set('token', val, {secure: false, httpOnly: false, sameSite: true});
}

function getToken(): string {
  return cookie.get('token')
}

function revokeToken() {
  cookie.remove('token')
}

export {setToken, getToken, revokeToken}