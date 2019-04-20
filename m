From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Force type conversion from __le32 to
 u32
Date: Sat, 20 Apr 2019 11:05:05 +0800
Message-ID: <00548c37-765a-a2df-9ddf-d53c6ae6bae7@huawei.com>
References: <20190418073510.GA11396@bharath12345-Inspiron-5559>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hHgJY-0003o6-1G
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Apr 2019 03:05:16 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hHgJW-000G75-4A
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Apr 2019 03:05:15 +0000
In-Reply-To: <20190418073510.GA11396@bharath12345-Inspiron-5559>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Bharath Vedartham <linux.bhar@gmail.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2019/4/18 15:35, Bharath Vedartham wrote:
> This patch forces type conversion from __le32 to u32 to prevent sparse
> warnings like:
> warning: restricted __le32 degrades to integer
> 
> dir.c:
> fscrypt_fname_disk_to_usr takes a hash of type u32 as it's second arg
> but de->hash_code is of type __le32.
> 
> node.c
> NULL_ADDR is of type u32 but block_addr is of type __le32.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  fs/f2fs/dir.c  | 2 +-
>  fs/f2fs/node.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 59bc460..4f39872 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -828,7 +828,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>  			int save_len = fstr->len;
>  
>  			err = fscrypt_fname_disk_to_usr(d->inode,
> -						(u32)de->hash_code, 0,

le32_to_cpu(de->hash_code)

> +						(__force u32)de->hash_code, 0,
>  						&de_name, fstr);
>  			if (err)
>  				goto out;
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 3f99ab2..9e333a5 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2706,7 +2706,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
>  		i = 1;
>  	}
>  	for (; i < NAT_ENTRY_PER_BLOCK; i++) {
> -		if (nat_blk->entries[i].block_addr != NULL_ADDR)
> +		if ((__force u32)nat_blk->entries[i].block_addr != NULL_ADDR)

block_t blkaddr = le32_to_cpu(nat_blk->entries[i].block_addr);

if (blkaddr != NULL_ADDR)

Thanks,

>  			valid++;
>  	}
>  	if (valid == 0) {
> 
