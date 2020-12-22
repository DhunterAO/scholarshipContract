// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import ElementUI from 'element-ui'
import swal from 'sweetalert'
import Web3 from 'web3'

import 'element-ui/lib/theme-chalk/index.css'

Vue.config.productionTip = false
Vue.use(ElementUI)

const abi = [{'constant': true, 'inputs': [{'internalType': 'uint256', 'name': 'one', 'type': 'uint256'}, {'internalType': 'uint256', 'name': 'two', 'type': 'uint256'}], 'name': 'add', 'outputs': [{'internalType': 'uint256', 'name': '', 'type': 'uint256'}], 'payable': false, 'stateMutability': 'view', 'type': 'function'}, {'constant': true, 'inputs': [{'internalType': 'uint256', 'name': 'one', 'type': 'uint256'}, {'internalType': 'uint256', 'name': 'two', 'type': 'uint256'}], 'name': 'div', 'outputs': [{'internalType': 'uint256', 'name': '', 'type': 'uint256'}], 'payable': false, 'stateMutability': 'view', 'type': 'function'}, {'constant': true, 'inputs': [{'internalType': 'uint256', 'name': 'one', 'type': 'uint256'}, {'internalType': 'uint256', 'name': 'two', 'type': 'uint256'}], 'name': 'mul', 'outputs': [{'internalType': 'uint256', 'name': '', 'type': 'uint256'}], 'payable': false, 'stateMutability': 'view', 'type': 'function'}, {'constant': true, 'inputs': [{'internalType': 'uint256', 'name': 'one', 'type': 'uint256'}, {'internalType': 'uint256', 'name': 'two', 'type': 'uint256'}], 'name': 'sub', 'outputs': [{'internalType': 'uint256', 'name': '', 'type': 'uint256'}], 'payable': false, 'stateMutability': 'view', 'type': 'function'}];
const addr = '0xbfDd201430d916D9978109d7E16F00Ad0e416249';
const w3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/e7e1c67e53db416bb1a2d355f7839c3a"));

export var contract = new w3.eth.Contract(abi, addr)

/* eslint-disable no-new */
new Vue({
    el: '#app',
    router,
    components: { App },
    template: '<App/>'
})