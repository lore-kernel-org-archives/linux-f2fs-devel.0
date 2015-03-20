From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/1] f2fs: correctly check empty xattr key
Date: Fri, 20 Mar 2015 13:52:01 -0700
Message-ID: <20150320205201.GC19413@jaegeuk-mac02.mot.com>
References: <1426825147-26981-1-git-send-email-tsgatesv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426825147-26981-1-git-send-email-tsgatesv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taesoo Kim <tsgatesv@gmail.com>
Cc: cm224.lee@samsung.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, taesoo@gatech.edu, changwoo@gatech.edu, sanidhya@gatech.edu, blee@gatech.edu, csong84@gatech.edu
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Taesoo,

On Fri, Mar 20, 2015 at 12:19:07AM -0400, Taesoo Kim wrote:
> When xattr name (key) is empty (""), correctly return -EINVAL
> error. xattr_advise_set/get() seem to make the same mistake.

The intention here is to disallow any xattr name, since this is used to get or
set the i_advise value by users.

Thanks,

> 
> Signed-off-by: Taesoo Kim <tsgatesv@gmail.com>
> ---
>  fs/f2fs/xattr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 5072bf9..6b1fbc4 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -132,7 +132,7 @@ static int f2fs_xattr_advise_get(struct dentry *dentry, const char *name,
>  {
>  	struct inode *inode = dentry->d_inode;
>  
> -	if (strcmp(name, "") != 0)
> +	if (strcmp(name, "") == 0)
>  		return -EINVAL;
>  
>  	*((char *)buffer) = F2FS_I(inode)->i_advise;
> @@ -144,7 +144,7 @@ static int f2fs_xattr_advise_set(struct dentry *dentry, const char *name,
>  {
>  	struct inode *inode = dentry->d_inode;
>  
> -	if (strcmp(name, "") != 0)
> +	if (strcmp(name, "") == 0)
>  		return -EINVAL;
>  	if (!inode_owner_or_capable(inode))
>  		return -EPERM;
> -- 
> 2.3.3
