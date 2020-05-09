import React from 'react';
import {Word} from './Word';
import {searchBackend} from '../api';

interface SearchState {
  text: string,
  result: { translation: string, word: string },
}

export class Search extends React.Component<{}, SearchState> {
  state = {
    text: '',
    result: {translation: '', word: ''},
  }

  handleSearchInput(e: React.ChangeEvent<HTMLInputElement>) {
    const text = e.target.value;
    this.setState({ text: text });
  }

  async handleSearch() {
    const result = await searchBackend(this.state.text).then((res) => res.json());
    this.setState((state, _props) => {
      return {
        text: state.text, result: result
      }
    })
  }

  render() {
    return (
      <>
        <div className="row">
          <input className="column column-50 column-offset-20" type="text" placeholder="word.." onChange={this.handleSearchInput.bind(this)} />
          <input className="column column-10 column-offset-10" type="button" onClick={(e) => this.handleSearch()} value="Search" />
          <br />
        </div>
        {this.state.result.translation !== '' && this.state.result.word !== '' &&
          <Word translation={this.state.result.translation} word={this.state.result.word} />
        }
      </>
    )
  }
}