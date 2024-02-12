--
with ada.Text_IO; use ada.Text_IO;
procedure linkedList is 
type node;
type pNode is access node;
type node is record

valor : Integer;
nextNode :  pNode;
end record;



root : pNode;

newNode : pNode;
lastNode : pNode;
begin

root := new node'(valor => 3, nextNode => null);
newNode := new node'(valor => -1, nextNode => null);
root.all.nextNode := newNode;
for J in 0 .. 10 loop
    lastNode := newNode;
    newNode := new node;
    newNode.all.valor := J;
    lastNode.all.nextNode := newNode;
end loop;
newNode := root;
while newNode.all.nextNode /= null loop

    Put(Integer'Image(newNode.all.valor));
    newNode := newNode.all.nextNode;
    
end loop;

end linkedList;