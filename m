From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] f2fs: Don't clear SGID when inheriting ACLs
Date: Thu, 13 Jul 2017 17:19:08 +0200
Message-ID: <20170713151908.GE5884@quack2.suse.cz>
References: <20170711205324.90260-1-jaegeuk@kernel.org>
 <20170711233124.GA96177@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170711233124.GA96177@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org, Jan Kara <jack@suse.cz>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue 11-07-17 16:31:24, Jaegeuk Kim wrote:
> This patch copies commit b7f8a09f80:
> "btrfs: Don't clear SGID when inheriting ACLs" written by Jan.
> 
> Fixes: 073931017b49d9458aa351605b43a7e34598caef
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Ah, somehow I've missed f2fs when going through filesystems that needed
fixing up. Thanks for catching that. The patch looks good to me. It would
just look a bit cleaner to me to move posix_acl_update_mode() call out of
__f2fs_set_acl() into f2fs_set_acl() similarly as we do in other
filesystems. But whatever, you are the maintainer ;) Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
> 
> Change log from v1:
>  - fix for simple change
> 
>  fs/f2fs/acl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
> index a140c5e3dc54..b4b8438c42ef 100644
> --- a/fs/f2fs/acl.c
> +++ b/fs/f2fs/acl.c
> @@ -211,7 +211,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
>  	switch (type) {
>  	case ACL_TYPE_ACCESS:
>  		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
> -		if (acl) {
> +		if (acl && !ipage) {
>  			error = posix_acl_update_mode(inode, &inode->i_mode, &acl);
>  			if (error)
>  				return error;
> -- 
> 2.13.0.rc1.294.g07d810a77f-goog
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
