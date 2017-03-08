From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: don't need to invalidate wrong
 node page
Date: Wed, 8 Mar 2017 13:35:46 -0800
Message-ID: <20170308213546.GB5483@jaegeuk.local>
References: <20170306215102.3807-1-jaegeuk@kernel.org>
	<8fa2118d-1da0-29f6-a755-fd661333d05d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cljFT-0003xR-TI
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 21:35:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cljFT-0007hx-3P
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 21:35:55 +0000
Content-Disposition: inline
In-Reply-To: <8fa2118d-1da0-29f6-a755-fd661333d05d@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 03/08, Chao Yu wrote:
> On 2017/3/7 5:51, Jaegeuk Kim wrote:
> > If f2fs_new_inode() is failed, the bad inode will invalidate 0'th node page
> > during f2fs_evict_inode(), which doesn't need to do.
> 
> Hmm...should not allow other using of inode->i_ino in following codes of
> f2fs_evict_inode, right?

Right.

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/inode.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 24bb8213d974..ef8610bf950f 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -411,7 +411,10 @@ void f2fs_evict_inode(struct inode *inode)
> >  	stat_dec_inline_dir(inode);
> >  	stat_dec_inline_inode(inode);
> >  
> > -	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
> > +	/* ino == 0, if f2fs_new_inode() was failed t*/
> > +	if (inode->i_ino)
> > +		invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino,
> > +							inode->i_ino);
> >  	if (xnid)
> >  		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
> >  	if (inode->i_nlink) {
> > 

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
