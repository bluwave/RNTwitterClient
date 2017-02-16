import React, { Component } from 'react';
import {
    StyleSheet,
    Text,
    View
} from 'react-native';

import {Scene, Router} from 'react-native-router-flux';
import Feed from './feed'


export default class TwitterFeedApp extends Component {
    render() {
        return (
            <Router>
                <Scene key="root">
                    <Scene key="Feed" component={Feed} title="RN Twitter client"/>
                </Scene>
            </Router>
        )
    }
}
