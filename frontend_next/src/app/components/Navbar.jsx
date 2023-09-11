import React from 'react'

export default function Navbar() {
  return (
    <div className='flex flex-row justify-between items-center bg-primary'>
        <div className="m-6 ml-10 text-white text-2xl">Wanchain Message</div>
        <button className="m-6 mr-10 p-2 rounded-xl text-white text-xl border-2 hover:bg-secondary">Connect</button>
    </div>
  )
}
