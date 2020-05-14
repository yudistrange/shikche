import React from 'react';
import {RouteComponentProps} from 'react-router-dom';
import {login} from '../api'
import {setToken} from '../cookie'
import "./Login.css";

interface LoginState {
  email: string,
  password: string,
  error: string,
}

export class Login extends React.Component<RouteComponentProps, LoginState> {
  state = {
    email: '',
    password: '',
    error: ''
  }

  handleEmailUpdate(e: React.ChangeEvent<HTMLInputElement>) {
    const text = e.target.value;
    this.setState((state, _props) => {
      return {email: text, password: state.password}
    });
  }

  handlePasswordUpdate(e: React.ChangeEvent<HTMLInputElement>) {
    const passwd = e.target.value;
    this.setState((state, _props) => {
      return { email: state.email, password: passwd }
    });
  }

  redirect() {
    this.props.history.push('/')
  } 

  async handleLogin() {
    const response = await login(this.state.email, this.state.password);

    if (!response.ok) {
      this.setState({error: "Bad credentials"});
    } else {
      const creds = await response.json();
      console.log(creds.token)
      setToken(creds.token)
      this.setState({error: ''});
      this.redirect();
    }
  }

  render() {
    return (
      <div className="login-container container">
        {errorDialog(this.state.error)}
        <input type="text" placeholder="email" onChange={this.handleEmailUpdate.bind(this)}/>
        <input type="password" placeholder="password" onChange={this.handlePasswordUpdate.bind(this)}/>
        <button className="login-button button button-outline" disabled={!this.state.email || !this.state.password} 
          onClick={(e) => this.handleLogin()}>login</button>
      </div>
    )
  }
};

const errorDialog = (errorMessage: string) => {
  if (errorMessage != '') {
    return (<pre><code>Login failed</code></pre>)
  }
}