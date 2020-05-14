import React from 'react';
import ReactDOM from 'react-dom';
import 'milligram';
import {App} from './components/App'
import {BrowserRouter, Switch, Route} from 'react-router-dom';
import {Login} from './components/Login';
import {getToken} from './cookie';

const token = getToken();

ReactDOM.render(
  <React.StrictMode>
    <BrowserRouter>
      <Switch>
        <Route path="/login" component={Login} />
        <Route path='/'>
          <App token={token}/>
        </Route>
      </Switch>
    </BrowserRouter>
  </React.StrictMode>,
  document.getElementById('root')
);
