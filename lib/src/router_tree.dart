import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_tree/shelf_tree.dart';

class RouterTree {
  const RouterTree(this.route, {this.methods, this.branches = const []});

  final String route;
  final RouteMethods? methods;
  final List<RouterTree> branches;

  Router router({Router? outRouter, String parentPath = ''}) {
    var router = outRouter ?? Router();
    String path = parentPath == '/' ? route : '$parentPath$route';

    print('register $path');
    if (methods != null) {
      router
        ..get(path, methods!.direct)
        ..post(path, methods!.direct)
        ..put(path, methods!.direct)
        ..delete(path, methods!.direct);
    }

    for (final branch in branches) {
      router = branch.router(outRouter: router, parentPath: path);
    }

    return router;
  }

  Handler get handler {
    var pipe = const Pipeline();
    final methods = this.methods;

    if (methods != null && methods.middleware != null) {
      pipe = pipe.addMiddleware(methods.middleware!);
    }

    return pipe.addHandler(router().call);
  }
}
