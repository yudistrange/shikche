import React from 'react';
import {Word} from './Word';
import {searchBackend} from '../api';
import './Search.css'

const SearchFailed = () => (
  <div className="search-failure-message">
    Translation doesn't exist
  </div>
)

interface SearchState {
  text: string,
  result: { translation: string, word: string, example: string},
  searchFailed?: boolean,
}

export class Search extends React.Component<{}, SearchState> {
  state = {
    text: '',
    result: {translation: '', word: '', example: ''},
    searchFailed: false,
  }

  handleSearchInput(e: React.ChangeEvent<HTMLInputElement>) {
    const text = e.target.value;
    this.setState({ text: text, searchFailed: false });
  }

  async handleSearch() {
    const response = await searchBackend(this.state.text)
    if (!response.ok) {
      this.setState({searchFailed: true})
    } else {
      const result = await response.json()
      this.setState((state, _props) => {
        return {
          text: state.text, result: result,
        }
      })
    }
  }

  render() {
    return (
      <>
        <div className="search-component row">
          <input className="search-bar" type="text" placeholder="word.." onChange={this.handleSearchInput.bind(this)} />
          <input className="search-button button button-outline" type="button" onClick={(e) => this.handleSearch()} value="search" />
        </div>
        {this.state.result.translation && this.state.result.word &&
          <Word translation={this.state.result.translation} word={this.state.result.word} />
        }
        {this.state.searchFailed === true && <SearchFailed />}
      </>
    )
  }
}