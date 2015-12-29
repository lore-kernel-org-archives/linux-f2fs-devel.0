From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH] f2fs: fix to stop recovering dot dentries in a readonly fs
Date: Tue, 29 Dec 2015 14:26:53 +0800
Message-ID: <00c601d14202$016a0c30$043e2490$@samsung.com>
References: <006f01d14158$63fa4a90$2beedfb0$@samsung.com>
 <20151228225350.GC61500@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20151228225350.GC61500@jaegeuk.local>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, December 29, 2015 6:54 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] f2fs: fix to stop recovering dot dentries in a readonly fs
> 
> Hi Chao,
> 
> On Mon, Dec 28, 2015 at 06:12:45PM +0800, Chao Yu wrote:
> > If filesystem is readonly, don't recover inline dot inode.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/namei.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index 5cc4128..b4a5836 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -269,7 +269,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
> >  	if (IS_ERR(inode))
> >  		return ERR_CAST(inode);
> >
> > -	if (f2fs_has_inline_dots(inode)) {
> > +	if (f2fs_has_inline_dots(inode) && !f2fs_readonly(dir->i_sb)) {
> 
> We need to return -EROFS if f2fs is readonly?

In a readonly mountpoint, we should still allow user to stat file/dir in
directory structure, rather than returning -EROFS when trying to recover,
Right?

Thanks,

> 
> Thanks,
> 
> >  		err = __recover_dot_dentries(inode, dir->i_ino);
> >  		if (err)
> >  			goto err_out;
> > --
> > 2.6.3
> >
