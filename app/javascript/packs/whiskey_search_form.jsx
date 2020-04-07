import React from 'react';
import ReactDOM from 'react-dom';
import axios from 'axios';
import qs from 'qs';

class WhiskeySearchForm extends React.Component {
  performSearch() {
    let query = ReactDOM.findDOMNode(this.refs.query).value;
    let taste = ReactDOM.findDOMNode(this.refs.taste).value;
    let color = ReactDOM.findDOMNode(this.refs.color).value;
    let smokiness = ReactDOM.findDOMNode(this.refs.smokiness).value;

    let self = this;

    let search_params = qs.stringify(
      {
        search: {
          query: query,
          taste: taste,
          color: color,
          smokiness: smokiness
        }
      }
    );

    axios(
      {
        method: 'GET', 
        url: `/api/v1/whiskeys/search?${search_params}`,
        headers: {
          'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
        }
      }
    )
    .then(function(response) {
      self.props.processSearch(response.data);
    });  
  }

  render() {

    return(
      <div>
        <input
          onChange={this.performSearch.bind(this)}
          type="text"
          className="form-control"
          placeholder="Search ..."
          ref="query"
        />
        <select onChange={this.performSearch.bind(this)} ref="taste" className="form-control">
          <option value="0">0</option>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select>
        <select onChange={this.performSearch.bind(this)} ref="color" className="form-control">
          <option value="0">0</option>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select>
        <select onChange={this.performSearch.bind(this)} ref="smokiness" className="form-control">
          <option value="0">0</option>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select>
      </div>
    )
  }
}

export default WhiskeySearchForm;
