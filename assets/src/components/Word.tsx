import React from 'react';
import './Word.css'

export const Word = (props: { translation: string, word: string, example: string }) => (
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
        <tr>
          <td>{props.word}</td>
          <td>{props.translation}</td>
          <td>{props.example}</td>
        </tr>
      </tbody>
    </table>
  </div>
)