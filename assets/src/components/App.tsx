import React from 'react';
import {Link} from 'react-router-dom';
import {Search} from './Search';
import './App.css'

export const App = (props: {token: string}) => {
  return(
      <div className="container">
        <header className="header-text">
          <h3>shikche</h3>
          <SessionLink token={props.token}/>
        </header>
        <hr className="header-hr"/>
        <Search />
      </div>
    );
  }

const SessionLink = (props: {token: string}) => {
  if (!props.token) {
    return <Link to="/login">login</Link>
  } else {
    return <div></div>;
  }
}