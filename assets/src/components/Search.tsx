import React from 'react';
import {debounce} from 'lodash';
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

  debouncedSearch = debounce(this.handleSearch, 500)

  async handleSearchInput(e: React.ChangeEvent<HTMLInputElement>) {
    const text = e.target.value;
    this.debouncedSearch(text)
    this.setState({ text: text, searchFailed: false, result: []});
  }

  async handleSearch(text: string) {
    const response = await searchBackend(text)

    if (!response.ok) {
      this.setState({ searchFailed: true })

    } else {
      const results = await response.json()

      this.setState((state, _props) => {
        return {
          text: state.text,
          result: results.map((r: SearchResult) => {
            return { translation: r.translation, word: r.word, metadata: r.metadata }
          }),
        }
      })
    }
  }

  render() {
    return (
      <>
        <div className="search-component row">
          <input className="search-bar" type="text" placeholder="word.." onChange={(e) => this.handleSearchInput(e)}/>
        </div>
        <Word translations={this.state.result.map((r: SearchResult) => {return {translation: r.translation, word: r.word, example: r.metadata.example}})} />
        {this.state.searchFailed === true && <SearchFailed />}
      </>
    )
  }
}