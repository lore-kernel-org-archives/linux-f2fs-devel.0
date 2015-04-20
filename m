From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs: avoid abnormal behavior on broken symlink
Date: Mon, 20 Apr 2015 17:49:47 +0300
Message-ID: <20150420144947.GA10518@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1YkD1f-0003eF-V3
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Apr 2015 14:50:19 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YkD1e-00039I-Mf
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Apr 2015 14:50:19 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello Jaegeuk Kim,

The patch feb7cbb079e6: "f2fs: avoid abnormal behavior on broken
symlink" from Apr 15, 2015, leads to the following static checker
warning:

	fs/f2fs/namei.c:304 f2fs_follow_link()
	warn: 'page' isn't an ERR_PTR

fs/f2fs/namei.c
   299  static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
   300  {
   301          struct page *page;
   302  
   303          page = page_follow_link_light(dentry, nd);
   304          if (IS_ERR(page))
                           ^^^^
The code in page_follow_link_light() is a bit hard to follow but it
returns NULL on error.

   305                  return page;
   306  
   307          /* this is broken symlink case */
   308          if (*nd_get_link(nd) == 0) {
   309                  kunmap(page);
                        ^^^^^^^^^^^^
Potential NULL deref.

   310                  page_cache_release(page);
   311                  return ERR_PTR(-ENOENT);
   312          }
   313          return page;
   314  }

regards,
dan carpenter

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
