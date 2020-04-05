import React from 'react';

class WhiskeyRow extends React.Component {
  render() {
    let whiskey = this.props.whiskey;

    return(
      <tr>
        <td>{whiskey.title}</td>
        <td>{whiskey.taste}</td>
        <td>{whiskey.color}</td>
        <td>{whiskey.smokiness}</td>
      </tr>     
    )
  }
}

export default WhiskeyRow;
