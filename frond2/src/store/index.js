import Vue from 'vue'
import Vuex from 'vuex'
import Stack from '@/utils/stack'
Vue.use(Vuex)

const { floor, random } = Math

export default new Vuex.Store({
    state: {
        tagsList: [],
        collapse: false,
        token: '',
        loading1: false,
        loading2: false,
        range: 20,
        sortingSequence: [],
        stack: new Stack(),
        start: false,
        isUnique: true
    },
    mutations: {
       set_token(state, token) {
           state.token = token
           sessionStorage.token = token
       },

           GENERATOR_SORTING_SEQUENCE (state) {
             state.sortingSequence = []
             for (let i = 0; i < state.range; i++) {
               let rand = floor(random() * state.range)
               if (!state.isUnique) {
                 state.sortingSequence.push(rand)
               } else {
                 while (isExist(state.sortingSequence, rand)) {
                   rand = floor(random() * state.range)
                 }
                 state.sortingSequence.push(rand)
               }
             }
           },
           SET_START (state, start) {
             if (start) {
               state.stack.push(start)
               state.start = start
             } else {
               state.stack.pop(false)
             }
             if (!start && state.stack.isEmpty()) {
               state.start = false
             }
           },
       del_token(state) {
           state.token = ''
           sessionStorage.removeItem('token')
       },
        delTagsItem(state, data) {
            state
                .tagsList
                .splice(data.index, 1);
        },
        setTagsItem(state, data) {
            state
                .tagsList
                .push(data)
        },
        clearTags(state) {
            state.tagsList = []
        },
        closeTagsOther(state, data) {
            state.tagsList = data;
        },
        closeCurrentTag(state, data) {
            for (let i = 0, len = state.tagsList.length; i < len; i++) {
                const item = state.tagsList[i];
                if (item.path === data.$route.fullPath) {
                    if (i < len - 1) {
                        data
                            .$router
                            .push(state.tagsList[i + 1].path);
                    } else if (i > 0) {
                        data
                            .$router
                            .push(state.tagsList[i - 1].path);
                    } else {
                        data
                            .$router
                            .push("/");
                    }
                    state
                        .tagsList
                        .splice(i, 1);
                    break;
                }
            }
        },
        // 侧边栏折叠
        handleCollapse(state, data) {
            state.collapse = data;
        }
    },
    actions: {},
    modules: {}
    })

function isExist (arr, ele) {
  return arr.indexOf(ele) > -1
}
