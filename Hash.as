// From: geeksforgeeks.org
// CPP program to implement hashing with chaining
class Hash
{
    int BUCKET;    // No. of buckets

    // Pointer to an array containing buckets
    list<int> *table;
public:
    Hash(int V);  // Constructor

    // inserts a key into hash table
    void insertItem(int key);

    // deletes a key from hash table
    void deleteItem(int key);

    // deletes the whole table
    void clear();

    // hash function to map values to key
    int hashFunction(int x) {
        return (x % BUCKET);
    }

    void displayHash();
};

Hash::Hash(int b)
{
    this->BUCKET = b;
    table = new list<int>[BUCKET];
}

void Hash::insertItem(int key)
{
    int index = hashFunction(key);
    table[index].push_back(key);
}

void Hash::deleteItem(int key)
{
  // get the hash index of key
  int index = hashFunction(key);

  // find the key in (index)th list
  list <int> :: iterator i;
  for (i = table[index].begin();
           i != table[index].end(); i++) {
    if (*i == key)
      break;
  }

  // if key is found in hash table, remove it
  if (i != table[index].end())
    table[index].erase(i);
}

void Hash::clear()
{
    table.clear();
    BUCKETS = 0;
    displayHash();
}

// function to display hash table
void Hash::displayHash() {
  for (int i = 0; i < BUCKET; i++) {
    print(i);
    for (auto x : table[i])
    {
        print(" --> ");
        print(x);
    }
    print("\n");
  }
}