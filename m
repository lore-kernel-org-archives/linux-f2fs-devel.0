From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to show encrypt flag in
 FS_IOC_GETFLAGS
Date: Wed, 4 Apr 2018 20:46:09 -0700
Message-ID: <20180405034609.GA50337@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180402102446.32832-1-yuchao0@huawei.com>
 <20180402202105.GB19195@jaegeuk-macbookpro.roam.corp.google.com>
 <3f76800a-8b68-b378-8b03-c14248966be4@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f3vqt-0004mE-Po
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Apr 2018 03:46:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f3vqs-009VHh-8E
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Apr 2018 03:46:19 +0000
Content-Disposition: inline
In-Reply-To: <3f76800a-8b68-b378-8b03-c14248966be4@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 04/03, Chao Yu wrote:
> On 2018/4/3 4:21, Jaegeuk Kim wrote:
> > On 04/02, Chao Yu wrote:
> >> This patch fixes to show encrypt flag in FS_IOC_GETFLAGS like ext4 does.
> > 
> > Actually, we have to show internal flags owned by f2fs, not generic ones.
> > We may need to define all of them separately?
> 
> Agreed, I wrote a patch, could check that? and in that patch, do we need to
> delete flag definition f2fs don't use?

IMO, we'd better keep the flags. I merged it and could you add encryption part
on top of it?

Thanks,

> 
> Thanks,
> 
> > 
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/file.c | 9 +++++++--
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index 8068b015ece5..271fadadaa36 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -1584,8 +1584,13 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
> >>  {
> >>  	struct inode *inode = file_inode(filp);
> >>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> >> -	unsigned int flags = fi->i_flags &
> >> -			(FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL);
> >> +	unsigned int flags = fi->i_flags;
> >> +
> >> +	if (file_is_encrypt(inode))
> >> +		flags |= FS_ENCRYPT_FL;
> >> +
> >> +	flags &= FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL;
> >> +
> >>  	return put_user(flags, (int __user *)arg);
> >>  }
> >>  
> >> -- 
> >> 2.15.0.55.gc2ece9dc4de6
> > 
> > .
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
