import json
import thriftpy
import os
thrift_file_path = os.path.join(os.path.dirname(__file__), 'action_service.thrift')
thriftpy.load(thrift_file_path, module_name="controller_thrift")
from controller_thrift import ActionRedirectionService, ActionRedirection
from thriftpy.rpc import make_client

class ActionController:

    def __init__(self, ip='127.0.0.1', port=6000):
        self.arm = make_client(ActionRedirectionService, ip, int(port))

    def configure_actions(self, group_name, action_group_json):
        group_in = json.loads(action_group_json)
        actions = []
        for action in group_in:
            actions.append(ActionRedirection(public_url=action["public_url"],
                                             private_url=action["private_url"]))
        self.arm.configureActionGroup(group_name, actions)

    def delete_actions(self, group_name):
        self.arm.deleteActionGroup(group_name)

    def get_actions(self):
        return self.arm.getActionGroups()
