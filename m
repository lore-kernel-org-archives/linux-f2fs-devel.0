From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs: avoid abnormal behavior on broken symlink
Date: Tue, 21 Apr 2015 11:20:45 -0700
Message-ID: <20150421182045.GB66459@jaegeuk-mac02>
References: <20150420144947.GA10518@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Ykcn0-0002KH-Ks
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Apr 2015 18:20:54 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ykcmz-0003MM-GU for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Apr 2015 18:20:54 +0000
Content-Disposition: inline
In-Reply-To: <20150420144947.GA10518@mwanda>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Dan,

Thank you for letting me know.
I wrote a patch for this below.

Thanks,

On Mon, Apr 20, 2015 at 05:49:47PM +0300, Dan Carpenter wrote:
> Hello Jaegeuk Kim,
> 
> The patch feb7cbb079e6: "f2fs: avoid abnormal behavior on broken
> symlink" from Apr 15, 2015, leads to the following static checker
> warning:
> 
> 	fs/f2fs/namei.c:304 f2fs_follow_link()
> 	warn: 'page' isn't an ERR_PTR
> 
> fs/f2fs/namei.c
>    299  static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
>    300  {
>    301          struct page *page;
>    302  
>    303          page = page_follow_link_light(dentry, nd);
>    304          if (IS_ERR(page))
>                            ^^^^
> The code in page_follow_link_light() is a bit hard to follow but it
> returns NULL on error.
> 
>    305                  return page;
>    306  
>    307          /* this is broken symlink case */
>    308          if (*nd_get_link(nd) == 0) {
>    309                  kunmap(page);
>                         ^^^^^^^^^^^^
> Potential NULL deref.
> 
>    310                  page_cache_release(page);
>    311                  return ERR_PTR(-ENOENT);
>    312          }
>    313          return page;
>    314  }
> 
> regards,
> dan carpenter

>From 52889398489d4edc0cb016ae24036b994e3d9ccd Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 20 Apr 2015 16:30:14 -0700
Subject: [PATCH] f2fs: fix wrong error hanlder in f2fs_follow_link

The page_follow_link_light returns NULL and its error pointer was remained
in nd->path.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 407dde3..678b6dd 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -301,8 +301,8 @@ static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
 	struct page *page;
 
 	page = page_follow_link_light(dentry, nd);
-	if (IS_ERR(page))
-		return page;
+	if (!page)
+		return NULL;
 
 	/* this is broken symlink case */
 	if (*nd_get_link(nd) == 0) {
-- 
2.1.1

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
