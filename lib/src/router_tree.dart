import 'package:shelf_tree/shelf_tree.dart';

class RouterTree {
  const RouterTree(this.route, {this.methods, this.branches = const []});

  final String route;
  final RouteMethods? methods;
  final List<RouterTree> branches;

  Router router({
    Router? outRouter,
    String parentPath = '',
    List<Middleware> middlewares = const [],
  }) {
    var router = outRouter ?? Router();
    String path = parentPath == '/' ? route : '$parentPath$route';

    print('register $path');
    final currentMiddlewares = [?methods?.middleware, ...middlewares];

    if (methods != null) {
      var pipeline = const Pipeline();

      for (final middleware in currentMiddlewares) {
        pipeline = pipeline.addMiddleware(middleware);
      }

      final handler = pipeline.addHandler(methods!.direct);

      router
        ..get(path, handler)
        ..post(path, handler)
        ..put(path, handler)
        ..delete(path, handler);
    }

    for (final branch in branches) {
      router = branch.router(outRouter: router, parentPath: path, middlewares: currentMiddlewares);
    }

    return router;
  }

  Handler get handler {
    var pipe = const Pipeline();
    return pipe.addHandler(router().call);
  }
}
