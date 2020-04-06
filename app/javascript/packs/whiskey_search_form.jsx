import React from 'react';
import ReactDOM from 'react-dom';
import axios from 'axios';
import qs from 'qs';

class WhiskeySearchForm extends React.Component {
  performSearch() {
    let query = ReactDOM.findDOMNode(this.refs.query).value;
    let self = this;

    let search_params = qs.stringify(
      {
        search: {
          query: query
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
      <input
        onChange={this.performSearch.bind(this)}
        type="text"
        className="form-control"
        placeholder="Search ..."
        ref="query"
      /> 
    )
  }
}

export default WhiskeySearchForm;
