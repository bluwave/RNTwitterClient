import React, {Component} from 'react';
import {
    StyleSheet,
    Text,
    View,
    ListView,
} from 'react-native';



import { NativeModules } from 'react-native';
var Twitter = NativeModules.TwitterManager

import  Tweet  from './tweet'

export default class Feed extends Component {
    constructor() {
        super();
        const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
        this.state = {
            dataSource: ds.cloneWithRows([]),
        };
    }

    componentDidMount() {
        // Twitter.foo('john doe', (res) => console.log('res: ' + res))
        this.refreshFeed()
    }

    async refreshFeed() {
        try {
            let data = await Twitter.feed(25)
            if (data.length > 0) {
                this.reloadList(data)
            }
            else {
                console.error('[refreshFeed] Error: data was empty')
            }
        } catch (e) {
            console.error(e)
        }
    }

    reloadList(data) {
        this.setState({
            dataSource: this.state.dataSource.cloneWithRows([])
        }, () => {
            this.setState({
                dataSource: this.state.dataSource.cloneWithRows(data)
            })
        })
    }

    render() {
        return (
            <View style={styles.container}>
                <ListView
                    automaticallyAdjustContentInsets={false}
                    dataSource={this.state.dataSource}
                    renderRow={(rowData) => <Tweet data={rowData} />  }
                    enableEmptySections={true}
                />
            </View>
        )
    }
}

const styles = StyleSheet.create({
    container: {
        marginTop: 64,
        flex: 1,
    },
});

