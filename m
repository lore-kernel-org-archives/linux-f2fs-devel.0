From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs: avoid abnormal behavior on broken symlink
Date: Wed, 22 Apr 2015 13:27:22 +0300
Message-ID: <20150422102722.GK16501@mwanda>
References: <20150420144947.GA10518@mwanda>
	<20150421182045.GB66459@jaegeuk-mac02>
	<051e01d07cc5$9fb78370$df268a50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1Ykrsh-0004Pn-FX
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Apr 2015 10:27:47 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ykrsg-0005Gb-EM
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Apr 2015 10:27:47 +0000
Content-Disposition: inline
In-Reply-To: <051e01d07cc5$9fb78370$df268a50$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On Wed, Apr 22, 2015 at 02:28:22PM +0800, Chao Yu wrote:
> > > fs/f2fs/namei.c
> > >    299  static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
> > >    300  {
> > >    301          struct page *page;
> > >    302
> > >    303          page = page_follow_link_light(dentry, nd);
> > >    304          if (IS_ERR(page))
> > >                            ^^^^
> > > The code in page_follow_link_light() is a bit hard to follow but it
> > > returns NULL on error.
> 
> I try to find out the other callers' error handling method for
> page_follow_link_light, and it shows all of them use the "IS_ERR" one.
> 
> In page_follow_link_light I also can't find a path which will return a NULL value.
> 
> So, Dan, is that report from smatch not true? or I made a mistake? If so, please
> correct me.

Smatch is correct, it returns NULL on error.  However, I agree that it
looks like it is supposed to return an ERR_PTR.  Every caller seems to
expect that.

I suspect the right fix is to change page_follow_link_light().  But I
don't know this code very well so I just sent the bug report instead of
fixing it myself.  :)

regards,
dan carpenter

diff --git a/fs/namei.c b/fs/namei.c
index ffab2e0..5ca251e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4473,7 +4473,12 @@ EXPORT_SYMBOL(page_readlink);
 void *page_follow_link_light(struct dentry *dentry, struct nameidata *nd)
 {
 	struct page *page = NULL;
-	nd_set_link(nd, page_getlink(dentry, &page));
+	char *link;
+
+	link = page_getlink(dentry, &page);
+	if (IS_ERR(link))
+		return link;
+	nd_set_link(nd, link);
 	return page;
 }
 EXPORT_SYMBOL(page_follow_link_light);

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
