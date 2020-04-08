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
    fetch('/api/v1/whiskeys')
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({
            isLoaded: true,
            whiskeys: result
          });
        },
        (error) => {
          this.setState({
            isLoaded: true,
            error
          });
        }
      )
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
