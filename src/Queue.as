// From:    https://www.geeksforgeeks.org/introduction-to-circular-queue/#
class Queue
{
    // Initialize front and rear
    int rear;
    int front;

    // Circular Queue
    int size;
    int[] arr;

    Queue() {}

    Queue(int s)
    {
       front = rear = -1;
       size = s;
       arr = array<int>(s);
    }

    /* Function to create Circular queue */
    void enqueue(int value)
    {
        if ((front == 0 && rear == size-1) ||
                ((rear+1) % size == front))
        {
//            print("Queue is Full");
            return;
        }

        else if (front == -1) /* Insert First Element */
        {
            front = rear = 0;
            arr[rear] = value;
        }

        else if (rear == size-1 && front != 0)
        {
            rear = 0;
            arr[rear] = value;
        }

        else
        {
            rear++;
            arr[rear] = value;
        }
    }

    // Function to delete element from Circular Queue
    int dequeue()
    {
        if (front == -1)
        {
//            trace("Queue is Empty");
            return -1;
        }

        int data = arr[front];
        arr[front] = -1;
        if (front == rear)
        {
            front = -1;
            rear = -1;
        }
        else if (front == size-1)
            front = 0;
        else
            front++;

        return data;
    }

    // Function to peak at the front of the Circular Queue
    int peakFront()
    {
        if (front == -1)
        {
//            trace("Queue is Empty");
            return -1;
        }

        int data = arr[front];
        return data;
    }

    // Function to peak at the rear of the Circular Queue
    int peakRear()
    {
        if (rear == -1)
        {
//            trace("Queue is Empty");
            return -1;
        }

        int data = arr[rear];
        return data;
    }

    // Function displaying the elements
    // of Circular Queue
    void displayQueue()
    {
        if (front == -1)
        {
            print("Queue is Empty");
            return;
        }
        print("Elements in Circular Queue are: ");
        if (rear >= front)
        {
            for (int i = front; i <= rear; i++)
                print(arr[i]);
        }
        else
        {
            for (int i = front; i < size; i++)
                print(arr[i]);

            for (int i = 0; i <= rear; i++)
                print(arr[i]);
        }
    }
}
