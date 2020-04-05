import React from 'react';

class WhiskeyTable extends React.Component {
  render() {
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
        <tbody></tbody>
      </table>
    )
  }
}

export default WhiskeyTable;
