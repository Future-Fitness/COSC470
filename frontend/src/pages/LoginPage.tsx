import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './LoginPage.css';
import Textbox from '../components/Textbox';
import Button from '../components/Button';
import { tryLogin } from '../util/api';

export default function LoginPage() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const attemptLogin = async () => {
    setError(''); // Clear any previous errors
    const result = await tryLogin(username, password);

    if (result.error) {
      setError(result.message);
      return;
    }

    if (result.token) {
      navigate('/home');
    }
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter') {
      attemptLogin();
    }
  }

  return (
    <div className="LoginPage">
      <div className="LoginBlock">
        <h1>Login</h1>

        <div className="LoginInner">
          <div className="LoginInputs">
            <div className="LoginInputChunk">
              <span>Username</span>
              <Textbox
                placeholder='Username...'
                onInput={setUsername}
                className='LoginInput'
              />
            </div>

            <div className="LoginInputChunk">
              <span>Password</span>
              <Textbox
                type='password'
                placeholder='Password...'
                onInput={setPassword}
                className='LoginInput'
                onKeyPress={handleKeyPress}
              />
            </div>
          </div>

        </div>

        {error && <div style={{ color: 'red', marginTop: '10px' }}>{error}</div>}

        <Button
          onClick={()=> attemptLogin()}
          children="Login"
        />

      </div>
    </div>
  );
}
