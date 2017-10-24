From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: add missing quota_initialize in f2fs_set_acl
Date: Tue, 24 Oct 2017 17:46:17 +0800
Message-ID: <f20fe8e5-b3f1-59f9-a9be-e16732f52e83@huawei.com>
References: <20171023221409.59148-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20171023221409.59148-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/10/24 6:14, Jaegeuk Kim wrote:
> This patch adds to call quota_intialize in f2fs_set_acl.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/acl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
> index 436b3a1464d9..f6471f9d707e 100644
> --- a/fs/f2fs/acl.c
> +++ b/fs/f2fs/acl.c
> @@ -209,6 +209,10 @@ static int __f2fs_set_acl(struct inode *inode, int type,
>  	int error;
>  	umode_t mode = inode->i_mode;
>  
> +	error = dquot_initialize(inode);
> +	if (error)
> +		return error;

Could you move this to f2fs_setxattr, and also add missing dquot_initialize in
unlink and rename like ext4?

Thanks,

> +
>  	switch (type) {
>  	case ACL_TYPE_ACCESS:
>  		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
> 
