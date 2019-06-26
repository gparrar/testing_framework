
struct ActionRedirection {
    1: required string public_url, /* public relative url that will be exposed */
    2: required string private_url, /* private full url to which calls will be redirected */
}

exception InternalError {
    /* This exception is used when an internal component of the service is not working properly*/
    1: string message;
}

exception WrongParametersException {
    /* This exception is used when the paramters submitted have caused an error */
    1: string message;
}

service ActionRedirectionService {
  void configureActionGroup(1: string name, 2: list<ActionRedirection> actions)
        throws (1: WrongParametersException wrongParameters, 2: InternalError internalError),
  void deleteActionGroup(1: string name)
        throws (1: WrongParametersException wrongParameters, 2: InternalError internalError),
  map<string, list<string>> getActionGroups()
        throws (1: InternalError internalError),
  /* These are private methods */
  void setLogLevel(1: string source, 2: string level),
}
