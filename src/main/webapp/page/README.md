This directory will serve as the main source for static pages. JSP and HTML files can be
served from this directory. Some data can be retrieved with JSP, but most interraction
with the back-end should be done via XHR/REST.

The directory and page structure is very straightforward — very much like a 'traditional'
website. Pages can be accessed directly at `/page/home/` — the `index.jsp` file is
displayed by default, which usually includes the `content.jsp` file in the same directory.
These files are separate so they can be served either directly (`/page/{name}/`), 
included through JSP (`/page/?view={name}`), or via XHR (`/page/#/{name}`)
Values that need to be passed to included pages can be sent in the URL hash or query string,
or passed as parameters when including a JSP file.

You can also access page content using a query string or hash value at the root `/page/`:

- `/page/#/home/` - loads the `/page/admin/content.jsp` template via XHR into the content area. 
  This makes navigating between pages faster since only the central page content needs to be re-loaded 
  (all core js and image files will already be loaded, although page-specific js and images 
  will still need loading).
- `/page/home/` - serves the `index.jsp` file in the `home` directory, which by default,
  includes the `content.jsp` file in the same directory.
- `/page/?view=home` - includes the `/page/home/content.jsp` page into the main content area.
  Loading pages this way can leverage any special handling that the main `/page/index.jsp` file 
  offers. This is also similar to how Velocity templates are included in the `Page.vm` file.


