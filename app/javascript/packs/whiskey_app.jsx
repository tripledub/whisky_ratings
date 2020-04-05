import React from 'react';
import ReactDOM from 'react-dom';
import WhiskeyTable from './whiskey_table';
// import PropTypes from 'prop-types'


class WhiskeyApp extends React.Component {
  // getInitialState() {
  //   return { whiskeys: [] }
  // }

  constructor(props) {
    super(props);
    this.state = {
      error: null,
      isLoaded: false,
      whiskeys: []
    };
  }

  componentDidMount() {
    this.getWhiskeys();
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
