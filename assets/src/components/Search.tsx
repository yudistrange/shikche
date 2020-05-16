import React from 'react';
import {Word} from './Word';
import {searchBackend} from '../api';
import './Search.css'

const SearchFailed = () => (
  <div className="search-failure-message">
    Translation doesn't exist
  </div>
)

interface SearchResult { translation: string, word: string, metadata: {example: string}}
interface SearchState {
  text: string,
  result: SearchResult[],
  searchFailed?: boolean,
}

export class Search extends React.Component<{}, SearchState> {
  state = {
    text: '',
    result: [],
    searchFailed: false,
  }

  handleSearchInput(e: React.ChangeEvent<HTMLInputElement>) {
    const text = e.target.value;
    this.setState({ text: text, searchFailed: false, result: []});
  }

  async handleSearch() {
    const response = await searchBackend(this.state.text)
    if (!response.ok) {
      this.setState({searchFailed: true})

    } else {
      const results = await response.json()

      this.setState((state, _props) => {
        return {
          text: state.text,
          result: results.map((r: SearchResult) => {
            return {translation: r.translation, word: r.word, metadata: r.metadata}
          }),
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
        <Word translations={this.state.result.map((r: SearchResult) => {return {translation: r.translation, word: r.word, example: r.metadata.example}})} />
        {this.state.searchFailed === true && <SearchFailed />}
      </>
    )
  }
}