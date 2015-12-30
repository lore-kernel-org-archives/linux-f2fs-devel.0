From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: early check broken symlink length
 in the encrypted case
Date: Tue, 29 Dec 2015 16:45:56 -0800
Message-ID: <20151230004556.GD13809@jaegeuk.local>
References: <1451345497-65784-1-git-send-email-jaegeuk@kernel.org>
 <00a701d141db$c2f7d480$48e77d80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00a701d141db$c2f7d480$48e77d80$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Tue, Dec 29, 2015 at 09:52:49AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, December 29, 2015 7:32 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 1/3] f2fs: early check broken symlink length in the encrypted case
> > 
> > If link is broken, its len is zero, and we don't need to move forward.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/namei.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index fb41c80..5cc4128 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -931,7 +931,7 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void
> > **cook
> >  {
> >  	struct page *cpage = NULL;
> >  	char *caddr, *paddr = NULL;
> > -	struct f2fs_str cstr;
> > +	struct f2fs_str cstr = FSTR_INIT(NULL, 0);
> >  	struct f2fs_str pstr = FSTR_INIT(NULL, 0);
> >  	struct inode *inode = d_inode(dentry);
> >  	struct f2fs_encrypted_symlink_data *sd;
> > @@ -952,6 +952,12 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void
> > **cook
> >  	/* Symlink is encrypted */
> >  	sd = (struct f2fs_encrypted_symlink_data *)caddr;
> >  	cstr.len = le16_to_cpu(sd->len);
> > +
> > +	/* this is broken symlink case */
> > +	if (cstr.len == 0) {
> 
> This case seems rare, can we add unlikely here?

Agreed.
Will change them.

Thanks,

> 
> > +		res = -ENOENT;
> > +		goto errout;
> > +	}
> >  	cstr.name = kmalloc(cstr.len, GFP_NOFS);
> >  	if (!cstr.name) {
> >  		res = -ENOMEM;
> > @@ -960,7 +966,7 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void
> > **cook
> >  	memcpy(cstr.name, sd->encrypted_path, cstr.len);
> > 
> >  	/* this is broken symlink case */
> > -	if (cstr.name[0] == 0 && cstr.len == 0) {
> > +	if (cstr.name[0] == 0) {
> 
> ditto.
> 
> Thanks,
> 
> >  		res = -ENOENT;
> >  		goto errout;
> >  	}
> > --
> > 2.5.4 (Apple Git-61)
> > 
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
