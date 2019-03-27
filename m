From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH] fs: fix warning about Using plain integer as NULL pointer
Date: Wed, 27 Mar 2019 19:23:10 +0530
Message-ID: <ac5a9f95-e04a-54bc-e7cb-4103555a79b4@codeaurora.org>
References: <20190322221021.GA24814@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322221021.GA24814@hari-Inspiron-1545>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Richard Weinberger <richard@nod.at>, Artem Bityutskiy <dedekind1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-f2fs-devel.lists.sourceforge.net


On 3/23/2019 3:40 AM, Hariprasad Kelam wrote:
> Sparse warning below:
>
> sudo make C=2 CF=-D__CHECK_ENDIAN__ M=fs
>
> CHECK   fs/f2fs/data.c
> fs/f2fs/data.c:426:47: warning: Using plain integer as NULL pointer
> CHECK   fs/notify/fdinfo.c
> fs/notify/fdinfo.c:53:87: warning: Using plain integer as NULL pointer
>   CHECK   fs/ubifs/xattr.c
> fs/ubifs/xattr.c:615:58: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   fs/f2fs/data.c     | 2 +-
>   fs/notify/fdinfo.c | 2 +-
>   fs/ubifs/xattr.c   | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 97279441..15a2381 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -423,7 +423,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>   
>   void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
>   {
> -	__submit_merged_write_cond(sbi, NULL, 0, 0, type, true);
> +	__submit_merged_write_cond(sbi, NULL, NULL, 0, type, true);
>   }
>   
>   void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 1e2bfd2..ef83f40 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -50,7 +50,7 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
>   	f.handle.handle_bytes = sizeof(f.pad);
>   	size = f.handle.handle_bytes >> 2;
>   
> -	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, 0);
> +	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
>   	if ((ret == FILEID_INVALID) || (ret < 0)) {
>   		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
>   		return;
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index f5ad1ed..066a566 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -612,7 +612,7 @@ int ubifs_init_security(struct inode *dentry, struct inode *inode,
>   	int err;
>   
>   	err = security_inode_init_security(inode, dentry, qstr,
> -					   &init_xattrs, 0);
> +					   &init_xattrs, NULL);
>   	if (err) {
>   		struct ubifs_info *c = dentry->i_sb->s_fs_info;
>   		ubifs_err(c, "cannot initialize security for inode %lu, error %d",
