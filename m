From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: forbid to do fstrim if fs has some
	error
Date: Wed, 7 Sep 2016 17:02:25 -0700
Message-ID: <20160908000225.GA14665@jaegeuk>
References: <1472696079-7063-1-git-send-email-heyunlei@huawei.com>
	<177e0232-b89b-1540-f315-c1ca6a92e3ba@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bhmnb-0008Al-JU
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Sep 2016 00:02:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bhmna-0000Mv-JJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Sep 2016 00:02:35 +0000
Content-Disposition: inline
In-Reply-To: <177e0232-b89b-1540-f315-c1ca6a92e3ba@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: heyunlei@huwei.com, linux-f2fs-devel@lists.sourceforge.net

On Wed, Sep 07, 2016 at 09:24:31PM +0800, Chao Yu wrote:
> Hi Yunlei,
> 
> On 2016/9/1 10:14, Yunlei He wrote:
> > This patch skip fstrim if sbi set SBI_NEED_FSCK flag
> > 
> > Signed-off-by: Yunlei He <heyunlei@huawei.com>
> > ---
> >  fs/f2fs/segment.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 93c5e26..1b62213 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1353,6 +1353,9 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
> >  	if (end <= MAIN_BLKADDR(sbi))
> >  		goto out;
> >  
> > +	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
> > +		goto out;
> 
> IMO, it's better to check this condition in f2fs_ioc_fstrim, and return error
> number to user, such as EIO?

I don't think it's an error case such as EIO, ENOMEM, EINVAL, and so on.
Instead, It'd be okay to return trimmed size with zero.
Oh, we'd better give a message to notify like this?

	f2fs_msg(sbi->sb, KERN_WARNING,
		"Found FS corruption, run fsck to fix.");

Thanks,

------------------------------------------------------------------------------
