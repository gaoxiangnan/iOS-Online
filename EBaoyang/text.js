function showAlert() {
    alert('in show alert');
}
//- (void)viewDidLoad
//{    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    //页面的 url网址
//    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://10.161.84.55/demo.html"]];
//    [_webView loadRequest:req];
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
////webView每调用一次url  都会启动这个函数- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
//{    //可以根据url  1.传递参数   2.调用特定的函数    NSLog(@"%@",request.URL);    //调用js的函数 we  是传给js函数的参数
//[webView stringByEvaluatingJavaScriptFromString:@"window.Mycallback('we')"];    return YES;}@end