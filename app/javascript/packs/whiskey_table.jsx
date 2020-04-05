import React from 'react';
import WhiskeyRow from './whiskey_row';

class WhiskeyTable extends React.Component {
  render() {
    let whiskeys = [];

    this.props.whiskeys.forEach(function(whiskey) {
      whiskeys.push(
        <WhiskeyRow whiskey={whiskey} key={whiskey.id} />
      );
    });

    return(
      <table className="table table-striped">
        <thead>
          <tr>
            <th className="col-md-3">Title</th>
            <th className="col-md-2">Taste</th>
            <th className="col-md-3">Colour</th>
            <th className="col-md-4">Smokiness</th>
          </tr>
        </thead>
        <tbody>
          {whiskeys}
        </tbody>
      </table>
    )
  }
}

export default WhiskeyTable;
