

# Hastebin Container

## Customizations

### Environment Variables

 1. KEY_LENGTH: The number which indicates the length of the keys to generate for identifying entries. Default is 10
 2. MAX_LENGTH: The maximum length of the key. Default is 400000.
 3. STATIC_MAX_AGE: The maximum time of inactivity before a paste is cleaned up. Default is 86400.
 4. KEY_TYPE: The type of the keys to generate. Default is 'phonetic' which acts like pwgen or it can be 'random'.
 5. STORAGE_TYPE: The type of storage to be used for storing the pastes. The default type is 'file' which will be stored
    in directory within the container itself. It can also be 'redis', 'postgres' or memcached.
 6. STORAGE_HOST: The reachable ip or host name of where the storage is running. This can be the redis server or the 
    memcached server.
 7. STORAGE_PORT: The port at which the storage service is exposed. Again, applicable to redis and memcached. Default
    value is 6379.
 8. STORAGE_DB: The storage DB. Required for redis with the default value is 2.
 9. STORAGE_FILE_PATH: Required if STORAGE_TYPE is 'file'. This is the path of directory where pastes will be stored.
    Default value is /opt/data. This is where you will mount storage into the container as well.
 10. STORAGE_EXPIRE: The maximum time of inactivity before a paste is removed from the server in seconds. Default value
     is 2592000.
 11. DATABASE_URL: Required in case of postgresql database. The format of the same will be `postgres://user:password@hos
     t:5432/database`.

### Storage Mount

In case you are using the default 'file' storage type, you will need to mount a volume, with appropriate permissions
into the container. Unless you are specifying your own mount point this can be done at /opt/data.

## Usage

### Building the container

You can build the container with

    $ docker build -t YOUR_NAME -f Dockerfile .

### Running the container

You can run the container with 

    $ docker run -d YOUR_NAME

**NOTE**:  If your are using postgres as the storage, then make sure you manually create a necessary table in the same in the database by running the following:

    create table entries (id serial primary key, key varchar(255) not null, value text not null, expiration int, unique(key));

You can find out more about hastebin server [here](https://github.com/seejohnrun/haste-server/blob/master/README.md "Hastebin readme").