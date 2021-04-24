require(["components/button/buttondatatranslator"],function(a){describe("buttondatatranslator createTranslator",function(){it("should return a translator with a viewModel property and an updateViewModel function",function(){var b={ObjectData:{value:"test content"},ObjectProperties:{}},c=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),d;d=a.createTranslator("dummyDocName",b,c),expect(typeof d).toEqual("object"),expect(typeof d.viewModel).toEqual("object"),expect(typeof d.updateViewModel).toEqual("function")}),describe("translator viewModel",function(){it("should have a content property for textual content",function(){var b={ObjectData:{value:"test content"},ObjectProperties:{}},c=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),d;d=a.createTranslator("dummyDocName",b,c),expect(d.viewModel.content).toEqual("test content")}),it("should have a onClickCallback property when the objectNode has a click event",function(){var b={ObjectData:{value:"test content"},ObjectProperties:{Events:{Elements:[{Event:{Type:"OnMouseIn"}},{Event:{Type:"OnClick"}},{Event:{Type:"OnMouseOut"}}]}}},c=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),d;d=a.createTranslator("dummyDocName",b,c),expect(typeof d.viewModel.onClickCallback).toEqual("function")}),it("should not have a onClickCallback property when the objectNode has no click event",function(){var b={ObjectData:{value:"test content"},ObjectProperties:{Events:{Elements:[{Event:{Type:"OnMouseIn"}},{Event:{Type:"OnMouseOut"}}]}}},c=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),d;d=a.createTranslator("dummyDocName",b,c),expect(typeof d.viewModel.onClickCallback).toEqual("undefined")}),it("should call buttonEventCallbacks.onClick when the view model onClickCallback is called",function(){var b={ObjID:"42",ObjectData:{value:"test content"},ObjectProperties:{Events:{Elements:[{Event:{Type:"OnClick"}}]}}},c=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),d;d=a.createTranslator("docName",b,c),d.viewModel.onClickCallback(!0,!1),expect(c.onClick).toHaveBeenCalledWith("docName","42",!0,!1),d.viewModel.onClickCallback(!1,!0),expect(c.onClick).toHaveBeenCalledWith("docName","42",!1,!0)}),it("should call buttonEventCallbacks.onClick with the correct parameters when there are multiple buttons and documents",function(){var b={ObjID:"1",ObjectData:{value:""},ObjectProperties:{Events:{Elements:[{Event:{Type:"OnClick"}}]}}},c={ObjID:"2",ObjectData:{value:""},ObjectProperties:{Events:{Elements:[{Event:{Type:"OnClick"}}]}}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f,g;e=a.createTranslator("doc1",b,d),f=a.createTranslator("doc1",c,d),g=a.createTranslator("doc2",b,d),e.viewModel.onClickCallback(!0,!0),f.viewModel.onClickCallback(!0,!1),g.viewModel.onClickCallback(!1,!1),expect(d.onClick.calls.length).toEqual(3),expect(d.onClick).toHaveBeenCalledWith("doc1","1",!0,!0),expect(d.onClick).toHaveBeenCalledWith("doc1","2",!0,!1),expect(d.onClick).toHaveBeenCalledWith("doc2","1",!1,!1)}),it("should have a fontColor property",function(){var b={ObjectData:{value:"dummy"},ObjectProperties:{ForegroundColor:{TrueColor1:"#001122"}}},c=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),d;d=a.createTranslator("dummyDocName",b,c),expect(d.viewModel.fontColor).toEqual("#001122")}),it("should have the fontColor property set to 'transparent' when ObjectProperties.ForegroundColor.Transparency is 'true'",function(){var b={ObjectData:{value:"dummy"},ObjectProperties:{ForegroundColor:{TrueColor1:"#001122",Transparency:"true"}}},c=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),d;d=a.createTranslator("dummyDocName",b,c),expect(d.viewModel.fontColor).toEqual("transparent")})}),describe("translator updateViewModel",function(){it("should return true and update the viewModel when the objectNode has different content",function(){var b={ObjectData:{value:"original content"},ObjectProperties:{}},c={ObjectData:{value:"new content"}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f;e=a.createTranslator("dummyDocName",b,d),f=e.updateViewModel(c),expect(f).toEqual(!0),expect(e.viewModel.content).toEqual("new content")}),it("should return false when the objectNode has the same content",function(){var b={ObjectData:{value:"static content"},ObjectProperties:{}},c={ObjectData:{value:"static content"}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f;e=a.createTranslator("dummyDocName",b,d),f=e.updateViewModel(c),expect(f).toEqual(!1),expect(e.viewModel.content).toEqual("static content")}),it("should return false when the objectNode has no ObjectData property",function(){var b={ObjectData:{value:"static content"},ObjectProperties:{}},c={},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f;e=a.createTranslator("dummyDocName",b,d),f=e.updateViewModel(c),expect(f).toEqual(!1),expect(e.viewModel.content).toEqual("static content")}),it("should update the correct viewModel when there are two translators",function(){var b={ObjectData:{value:"content1"},ObjectProperties:{}},c={ObjectData:{value:"content2"},ObjectProperties:{}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f,g;e=a.createTranslator("dummyDocName",b,d),f=a.createTranslator("dummyDocName",c,d),g=e.updateViewModel(b),expect(g).toEqual(!1),expect(e.viewModel.content).toEqual("content1"),expect(f.viewModel.content).toEqual("content2")}),it("should return true and update the viewModel when the onClick event is no longer there",function(){var b={ObjectData:{value:""},ObjectProperties:{Events:{Elements:[{Event:{Type:"OnClick"}}]}}},c={ObjectData:{value:""},ObjectProperties:{Events:{Elements:[]}}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f;e=a.createTranslator("dummyDocName",b,d),expect(typeof e.viewModel.onClickCallback).toEqual("function"),f=e.updateViewModel(c),expect(f).toEqual(!0),expect(typeof e.viewModel.onClickCallback).toEqual("undefined")}),it("should return true and update the viewModel when the onClick event exists in the new data only",function(){var b={ObjectData:{value:""},ObjectProperties:{Events:{Elements:[]}}},c={ObjectData:{value:""},ObjectProperties:{Events:{Elements:[{Event:{Type:"OnClick"}}]}}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f;e=a.createTranslator("dummyDocName",b,d),expect(typeof e.viewModel.onClickCallback).toEqual("undefined"),f=e.updateViewModel(c),expect(f).toEqual(!0),expect(typeof e.viewModel.onClickCallback).toEqual("function")}),it("should return false when the onClick event exists in the new and old data",function(){var b={ObjectData:{value:""},ObjectProperties:{Events:{Elements:[{Event:{Type:"OnClick"}}]}}},c={ObjectData:{value:""},ObjectProperties:{Events:{Elements:[{Event:{Type:"OnClick"}}]}}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f;e=a.createTranslator("dummyDocName",b,d),expect(typeof e.viewModel.onClickCallback).toEqual("function"),f=e.updateViewModel(c),expect(f).toEqual(!1),expect(typeof e.viewModel.onClickCallback).toEqual("function")}),it("should return true and update the viewModel when the content and the onClick event changes",function(){var b={ObjectData:{value:"old"},ObjectProperties:{Events:{Elements:[]}}},c={ObjectData:{value:"new"},ObjectProperties:{Events:{Elements:[{Event:{Type:"OnClick"}}]}}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f;e=a.createTranslator("dummyDocName",b,d),expect(typeof e.viewModel.onClickCallback).toEqual("undefined"),expect(e.viewModel.content).toEqual("old"),f=e.updateViewModel(c),expect(f).toEqual(!0),expect(typeof e.viewModel.onClickCallback).toEqual("function"),expect(e.viewModel.content).toEqual("new")}),it("should return false when the fontColor has no change",function(){var b={ObjectData:{value:"dummy"},ObjectProperties:{ForegroundColor:{TrueColor1:"#001122"}}},c={ObjectData:{value:"dummy"},ObjectProperties:{ForegroundColor:{TrueColor1:"#001122"}}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f;e=a.createTranslator("dummyDocName",b,d),f=e.updateViewModel(c),expect(f).toEqual(!1),expect(e.viewModel.fontColor).toEqual("#001122")}),it("should return true and update the viewModel when the fontColor has changed",function(){var b={ObjectData:{value:"dummy"},ObjectProperties:{ForegroundColor:{TrueColor1:"#001122"}}},c={ObjectData:{value:"dummy"},ObjectProperties:{ForegroundColor:{TrueColor1:"#998877"}}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f;e=a.createTranslator("dummyDocName",b,d),f=e.updateViewModel(c),expect(f).toEqual(!0),expect(e.viewModel.fontColor).toEqual("#998877")}),it("should return false when the ForegroundColor is not in the ObjectProperties anymore",function(){var b={ObjectData:{value:"dummy"},ObjectProperties:{ForegroundColor:{TrueColor1:"#001122"}}},c={ObjectData:{value:"dummy"},ObjectProperties:{}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f;e=a.createTranslator("dummyDocName",b,d),f=e.updateViewModel(c),expect(f).toEqual(!1),expect(e.viewModel.fontColor).toEqual("#001122")}),it("should return false when there are no ObjectProperties",function(){var b={ObjectData:{value:"dummy"},ObjectProperties:{ForegroundColor:{TrueColor1:"#001122"}}},c={ObjectData:{value:"dummy"}},d=jasmine.createSpyObj("buttonEventCallbacksSpy",["onClick"]),e,f;e=a.createTranslator("dummyDocName",b,d),f=e.updateViewModel(c),expect(f).toEqual(!1),expect(e.viewModel.fontColor).toEqual("#001122")})})})})