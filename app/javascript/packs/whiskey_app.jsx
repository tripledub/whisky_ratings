import axios from 'axios';
import React from 'react';
import ReactDOM from 'react-dom';
import WhiskeyTable from './whiskey_table';
import WhiskeySearchForm from './whiskey_search_form';

class WhiskeyApp extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      error: null,
      isLoaded: false,
      whiskeys: []
    };
    this.processSearch = this.processSearch.bind(this)
  }

  componentDidMount() {
    this.getWhiskeys();
  }

  processSearch (whiskeys) {
    this.setState({ whiskeys: whiskeys });
  }
 
  getWhiskeys() {
      let self = this
      axios(
        {
          method: 'GET', 
          url: '/api/v1/whiskeys/',
          headers: {
            'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
          }
        }
      )
      .then(function(response) {
        self.setState({
          isLoaded: true,
          whiskeys: response.data
        });
      }); 
  }

  render() {
    return(
      <div className="container">
        <div className="jumbotron">
          <h1>Whiskey App</h1>
        </div>
        <div className="row">
          <div className="col-md-12">
            <WhiskeySearchForm processSearch={this.processSearch} />
          </div>
        </div>
        <div className="row">
          <div className="col-md-12">
            <WhiskeyTable whiskeys={this.state.whiskeys} />
          </div>
        </div>
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const rootElement = document.getElementById("whiskey");
  ReactDOM.render(<WhiskeyApp/>, rootElement);
});
