import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { NavLink } from "react-router-dom";
import env from "react-dotenv";

const Record = (props) => (
  <tr>
    <td>{props.record.name}</td>
    <td>{props.record.position}</td>
    <td>{props.record.level}</td>
    <td>
      <Link className="btn btn-link" to={`/edit/${props.record._id}`}>Edit</Link> |
      <button className="btn btn-link"
        onClick={() => {
          props.deleteRecord(props.record._id);
        }}
      >
        Delete
      </button>
    </td>
  </tr>
);

export default function RecordList() {
  const [records, setRecords] = useState([]);

  // This method fetches the records from the database.
  useEffect(() => {
    async function getRecords() {
      let backEndConnection = 'http://localhost:5000/record/';
      if (env.BACK_END_URL) {
        backEndConnection = env.BACK_END_URL + ':5000/record/';
      }
      console.log('backEndConnection is:', backEndConnection);
      const response = await fetch(backEndConnection);

      if (!response.ok) {
        const message = `An error occured: ${response.statusText}`;
        window.alert(message);
        return;
      }

      const records = await response.json();
      setRecords(records);
    }

    getRecords();

    return; 
  }, [records.length]);

  // This method will delete a record
  async function deleteRecord(id) {
    let backEndConnection = `http://localhost:5000/${id}`;
    if (env.BACK_END_URL) {
      backEndConnection = env.BACK_END_URL + `:5000/${id}`;
    }
    await fetch(backEndConnection, {
      method: "DELETE"
    });

    const newRecords = records.filter((el) => el._id !== id);
    setRecords(newRecords);
  }

  // This method will map out the records on the table
  function recordList() {
    return records.map((record) => {
      return (
        <Record
          record={record}
          deleteRecord={() => deleteRecord(record._id)}
          key={record._id}
        />
      );
    });
  }

  // This following section will display the table with the records of individuals.
  return (
    <div>
      <h3>harpoon Valentines day invite list</h3>
      <div>
          <NavLink className="nav-link" to="/create" style={{ padding: 0 }}>
            Create Record
          </NavLink>
      </div>
      <table className="table table-striped" style={{ marginTop: 20 }}>
        <thead>
          <tr>
            <th>Name</th>
            <th>Relation</th>
          </tr>
        </thead>
        <tbody>{recordList()}</tbody>
      </table>
    </div>
  );
}
