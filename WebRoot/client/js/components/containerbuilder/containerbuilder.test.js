require(["components/containerbuilder/containerbuilder"],function(a){describe("containerbuilder createContainer",function(){it("should create a DIV with the arcComponentContainer css class, and with dimensions matching the passed BaseProperties object",function(){var b,c;b={Position:{XPos:"22",YPos:"33"},Width:{Value:"44"},Height:{Value:"55"}},c=a.createContainer(b),expect(c.is("div")).toEqual(!0),expect(c.hasClass("arcComponentContainer")).toEqual(!0),expect(c.css("left")).toEqual("22px"),expect(c.css("top")).toEqual("33px"),expect(c.css("width")).toEqual("44px"),expect(c.css("height")).toEqual("55px")})})})