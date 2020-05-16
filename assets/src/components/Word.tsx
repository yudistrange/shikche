import React from 'react';
import './Word.css'

export interface WordTranslation { translation: string, word: string, example: string }

export const Word = (props: { translations: WordTranslation[]}) => {
  if (props.translations.length === 0) {
    return <></>
  } else {
    return (
    <div className="word-table-container">
      <table className="word-table">
        <thead>
          <tr>
            <th>word</th>
            <th>translation</th>
            <th>usage</th>
          </tr>
        </thead>
        <tbody>
          { props.translations.map((translation: WordTranslation, index: number) =>
            <tr key={index}>
              <td>{translation.word}</td>
              <td>{translation.translation}</td>
              <td>{translation.example}</td>
            </tr>
          )
          }
        </tbody>
      </table>
    </div>
    )
  }
}