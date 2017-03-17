From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: don't allow atomic writes for not
 regular files
Date: Fri, 17 Mar 2017 20:40:20 +0800
Message-ID: <20170317124020.GA34674@jaegeuk.local>
References: <20170317020906.28165-1-jaegeuk@kernel.org>
	<20170317020906.28165-2-jaegeuk@kernel.org>
	<d3c6be41-7b81-b10f-c3f6-8a7beceae202@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1corBf-0002Xa-QE
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 12:40:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1corBd-00050F-Qy
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 12:40:55 +0000
Content-Disposition: inline
In-Reply-To: <d3c6be41-7b81-b10f-c3f6-8a7beceae202@huawei.com>
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

On 03/17, Chao Yu wrote:
> On 2017/3/17 10:09, Jaegeuk Kim wrote:
> > The atomic writes only supports regular files for database.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index da6d33d1bb34..d486e02b43c2 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1522,6 +1522,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >  	if (f2fs_is_atomic_file(inode))
> >  		goto out;
> >  
> > +	if (!S_ISREG(inode->i_mode))
> > +		return -EINVAL;
> 
> goto out;

Oh, I just move it to the beginning of the function.

Thanks,

> 
> Thanks,
> 
> > +
> >  	ret = f2fs_convert_inline_inode(inode);
> >  	if (ret)
> >  		goto out;
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
