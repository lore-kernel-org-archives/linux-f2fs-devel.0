From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbZjJmcy1kZXY=?= =?utf-8?Q?=5D?= [PATCH]
 f2fs: relax permission for atomic/volatile ioctls
Date: Thu, 6 Jul 2017 19:12:03 -0700
Message-ID: <20170707021203.GB12435@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170706022326.52594-1-jaegeuk@kernel.org>
 <8346aeca-c28b-e5b9-5973-b5648b015c88@kernel.org>
 <20170707001609.GA8300@jaegeuk-macbookpro.roam.corp.google.com>
 <6929112f-e8f2-8fe2-bb13-7a7ebcdbf7db@kernel.org>
 <9047C53C18267742AB12E43B65C7F9F70BB9FFBF@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9047C53C18267742AB12E43B65C7F9F70BB9FFBF@dggemi505-mbs.china.huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "gaoxiang (P)" <gaoxiang25@huawei.com>
Cc: Chao Yu <chao@kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/07, gaoxiang (P) wrote:
> Hi,
> I think Sdcardfs should override task_struct cred fsuid/fsgid before calling the underlay fs operation.
> And it seems sdcardfs implementations misses override cred fsuid/fsgid before the ioctl operation.

Oh, good catch!

Thank you. ;)

> 
> Thanks.
> 
> -----邮件原件-----
> 发件人: Chao Yu [mailto:chao@kernel.org] 
> 发送时间: 2017年7月7日 8:58
> 收件人: Jaegeuk Kim
> 抄送: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> 主题: Re: [f2fs-dev] [PATCH] f2fs: relax permission for atomic/volatile ioctls
> 
> On 2017/7/7 8:16, Jaegeuk Kim wrote:
> > On 07/07, Chao Yu wrote:
> >> On 2017/7/6 10:23, Jaegeuk Kim wrote:
> >>> This patch allows atomic/volatile ioctls for sqlite under sdcardfs.
> >>
> >> Out of curiosity, we will lose some capable when passing through sdcardfs?
> > 
> > I don't think so. But, it seems a test applicaion tries to access database from
> > difference uid.
> 
> Oh, is that really allowed? if the sqlite database is public in sdcard directory,
> application needs to apply WRITE_EXTERNAL_STORAGE in order to add itself to
> sdcard_rw group, then it can access the database. Right?
> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>> ---
> >>>  fs/f2fs/file.c | 15 ---------------
> >>>  1 file changed, 15 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>> index f5d6357e8360..dd8f5d2caa48 100644
> >>> --- a/fs/f2fs/file.c
> >>> +++ b/fs/f2fs/file.c
> >>> @@ -1587,9 +1587,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >>>  	struct inode *inode = file_inode(filp);
> >>>  	int ret;
> >>>  
> >>> -	if (!inode_owner_or_capable(inode))
> >>> -		return -EACCES;
> >>> -
> >>>  	if (!S_ISREG(inode->i_mode))
> >>>  		return -EINVAL;
> >>>  
> >>> @@ -1636,9 +1633,6 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
> >>>  	struct inode *inode = file_inode(filp);
> >>>  	int ret;
> >>>  
> >>> -	if (!inode_owner_or_capable(inode))
> >>> -		return -EACCES;
> >>> -
> >>>  	ret = mnt_want_write_file(filp);
> >>>  	if (ret)
> >>>  		return ret;
> >>> @@ -1672,9 +1666,6 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
> >>>  	struct inode *inode = file_inode(filp);
> >>>  	int ret;
> >>>  
> >>> -	if (!inode_owner_or_capable(inode))
> >>> -		return -EACCES;
> >>> -
> >>>  	if (!S_ISREG(inode->i_mode))
> >>>  		return -EINVAL;
> >>>  
> >>> @@ -1707,9 +1698,6 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
> >>>  	struct inode *inode = file_inode(filp);
> >>>  	int ret;
> >>>  
> >>> -	if (!inode_owner_or_capable(inode))
> >>> -		return -EACCES;
> >>> -
> >>>  	ret = mnt_want_write_file(filp);
> >>>  	if (ret)
> >>>  		return ret;
> >>> @@ -1736,9 +1724,6 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
> >>>  	struct inode *inode = file_inode(filp);
> >>>  	int ret;
> >>>  
> >>> -	if (!inode_owner_or_capable(inode))
> >>> -		return -EACCES;
> >>> -
> >>>  	ret = mnt_want_write_file(filp);
> >>>  	if (ret)
> >>>  		return ret;
> >>>
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
