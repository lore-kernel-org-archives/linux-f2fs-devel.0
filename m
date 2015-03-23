From: Taesoo Kim <taesoo@gatech.edu>
Subject: Re: [PATCH 1/1] f2fs: correctly check empty xattr key
Date: Sun, 22 Mar 2015 21:13:13 -0400
Message-ID: <20150323011313.GJ5170@taesoo.org>
References: <1426825147-26981-1-git-send-email-tsgatesv@gmail.com>
 <20150320205201.GC19413@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150320205201.GC19413@jaegeuk-mac02.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Taesoo Kim <tsgatesv@gmail.com>, cm224.lee@samsung.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, changwoo@gatech.edu, sanidhya@gatech.edu, blee@gatech.edu, csong84@gatech.edu
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

Thank you for letting us know. We have another question:

@f2fs_sync_file()

  if (unlikely(f2fs_readonly(inode->i_sb)))
     return 0;

Isn't it better to report '-EROFS' as ext3/4? I suspect that f2fs
returns 0 as fsync() man page doesn't specify such error condition. We
are wondering if it is the real reason for f2fs's design decision.

Thank you,
Taesoo

On 03/20/15 at 01:52pm, Jaegeuk Kim wrote:
> Hi Taesoo,
> 
> On Fri, Mar 20, 2015 at 12:19:07AM -0400, Taesoo Kim wrote:
> > When xattr name (key) is empty (""), correctly return -EINVAL
> > error. xattr_advise_set/get() seem to make the same mistake.
> 
> The intention here is to disallow any xattr name, since this is used to get or
> set the i_advise value by users.
> 
> Thanks,
> 
> > 
> > Signed-off-by: Taesoo Kim <tsgatesv@gmail.com>
> > ---
> >  fs/f2fs/xattr.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> > index 5072bf9..6b1fbc4 100644
> > --- a/fs/f2fs/xattr.c
> > +++ b/fs/f2fs/xattr.c
> > @@ -132,7 +132,7 @@ static int f2fs_xattr_advise_get(struct dentry *dentry, const char *name,
> >  {
> >  	struct inode *inode = dentry->d_inode;
> >  
> > -	if (strcmp(name, "") != 0)
> > +	if (strcmp(name, "") == 0)
> >  		return -EINVAL;
> >  
> >  	*((char *)buffer) = F2FS_I(inode)->i_advise;
> > @@ -144,7 +144,7 @@ static int f2fs_xattr_advise_set(struct dentry *dentry, const char *name,
> >  {
> >  	struct inode *inode = dentry->d_inode;
> >  
> > -	if (strcmp(name, "") != 0)
> > +	if (strcmp(name, "") == 0)
> >  		return -EINVAL;
> >  	if (!inode_owner_or_capable(inode))
> >  		return -EPERM;
> > -- 
> > 2.3.3
