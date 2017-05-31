From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove false-positive bug_on
Date: Wed, 31 May 2017 21:24:18 +0800
Message-ID: <995a8c2b-d29f-5c82-6d7c-90e93770f620@kernel.org>
References: <20170526235923.31058-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170526235923.31058-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/5/27 7:59, Jaegeuk Kim wrote:
> If we got failure from both of create and evict_inode, we can hit this wrong
> bug_on.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/inode.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index e53c784ab11e..5673b0bd83b5 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -426,8 +426,6 @@ void f2fs_evict_inode(struct inode *inode)
>  		alloc_nid_failed(sbi, inode->i_ino);
>  		clear_inode_flag(inode, FI_FREE_NID);
>  	}
> -	f2fs_bug_on(sbi, err &&
> -		!exist_written_data(sbi, inode->i_ino, ORPHAN_INO));

We expect that we can keep the inode in orphan list in
handle_failed_inode path when inode page have been persisted, so that if
there is anything error in evice_inode, we can have another chance to
release inode resource during next mount.

Here we need to check this case, additionally, if we failed to add the
inode into orphan list in handle_failed_inode, we must have set
SBI_NEED_FSCK in cp pack, so we need check the case too.

So we can change the code to:

f2fs_bug_on(err && err != -ENOENT &&
		(!exist_written_data(sbi, inode->i_ino, ORPHAN_INO) ||
		!is_sbi_flag_set(sbi, SBI_NEED_FSCK));

How do you think?

Thanks,

>  out_clear:
>  	fscrypt_put_encryption_info(inode, NULL);
>  	clear_inode(inode);
> 
