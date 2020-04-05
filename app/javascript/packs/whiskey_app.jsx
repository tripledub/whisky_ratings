import React from 'react';
import ReactDOM from 'react-dom';
import WhiskeyTable from './whiskey_table';
// import PropTypes from 'prop-types'


class WhiskeyApp extends React.Component {
  render() {
    return(
      <div className="container">
        <div className="jumbotron">
          <h1>Whiskey App</h1>
        </div>
        <div className="row">
          <div className="col-md-12">
            <WhiskeyTable />
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
