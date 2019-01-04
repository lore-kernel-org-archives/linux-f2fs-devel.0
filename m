From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: export pin_file flag to user
Date: Fri, 4 Jan 2019 12:33:50 -0800
Message-ID: <20190104203350.GB57873@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190104041945.31802-1-jaegeuk@kernel.org>
 <444eef3d-78eb-7c17-b44c-0ab310fb7c7b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <444eef3d-78eb-7c17-b44c-0ab310fb7c7b@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 01/04, Chao Yu wrote:
> On 2019/1/4 12:19, Jaegeuk Kim wrote:
> > This exports pin_file status to user.
> 
> Semantics of pin_file flag is the same as nocow flag which is more widely
> used in lsattr/chattr and vfs now.
> 
> #define FS_NOCOW_FL                     0x00800000 /* Do not cow file */
> 
> lsattr/chattr
> no copy on write (C)
> 
> How about exporting it via F2FS_NOCOW_FL(0x00800000)?

Yeah, let me send v2.

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/f2fs.h | 3 ++-
> >  fs/f2fs/file.c | 2 ++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 12fabd6735dd..036fd62010c1 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -2303,9 +2303,10 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
> >  #define F2FS_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
> >  #define F2FS_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
> >  #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> > +#define F2FS_PIN_FILE_FL		0x40000000 /* pin_file status */
> >  #define F2FS_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
> >  
> > -#define F2FS_FL_USER_VISIBLE		0x304BDFFF /* User visible flags */
> > +#define F2FS_FL_USER_VISIBLE		0x704BDFFF /* User visible flags */
> >  #define F2FS_FL_USER_MODIFIABLE		0x204BC0FF /* User modifiable flags */
> >  
> >  /* Flags we can manipulate with through F2FS_IOC_FSSETXATTR */
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index ae2b45e75847..eb099f1ee937 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1651,6 +1651,8 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
> >  		flags |= F2FS_ENCRYPT_FL;
> >  	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
> >  		flags |= F2FS_INLINE_DATA_FL;
> > +	if (is_inode_flag_set(inode, FI_PIN_FILE))
> > +		flags |= F2FS_PIN_FILE_FL;
> >  
> >  	flags &= F2FS_FL_USER_VISIBLE;
> >  
> > 
