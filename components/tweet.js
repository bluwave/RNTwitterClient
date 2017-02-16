import React, {Component} from 'react';
import {
    StyleSheet,
    Text,
    View,
    TouchableHighlight,
    Image,
} from 'react-native';

export default class Tweet extends Component {

    render() {
        return (
            <TouchableHighlight underlayColor='#ddd'>
                <View>
                    <View style={styles.row}>
                        <Image source={{uri: this.props.data.profile_image_url_https}} style={styles.thumb} key={this.props.data.profile_image_url_https} />
                        <Text style={styles.text}>{this.props.data.name} - {this.props.data.text}</Text>
                    </View>
                </View>
            </TouchableHighlight>
        )
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#fff',
    },
    thumb: {
        width: 64,
        height: 64,
        borderRadius: 32,
        borderWidth: 0.1,
        borderColor: '#f00',
    },
    row: {
        flexDirection: 'row',
        justifyContent: 'center',
        padding: 10,
        backgroundColor: '#fff',
    },
    text: {
        padding: 10,
        flex: 1,
    },
});

