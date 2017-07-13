From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Don't clear SGID when inheriting ACLs
Date: Thu, 13 Jul 2017 12:08:13 +0800
Message-ID: <290aabd7-dc61-081a-bbda-74fa97197e62@kernel.org>
References: <20170711205324.90260-1-jaegeuk@kernel.org>
 <20170711233124.GA96177@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170711233124.GA96177@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jan Kara <jack@suse.cz>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/7/12 7:31, Jaegeuk Kim wrote:
> This patch copies commit b7f8a09f80:
> "btrfs: Don't clear SGID when inheriting ACLs" written by Jan.
> 
> Fixes: 073931017b49d9458aa351605b43a7e34598caef
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

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
> 
