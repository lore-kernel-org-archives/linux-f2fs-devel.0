From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: add braces for macro variables more
Date: Sat, 22 Apr 2017 08:30:01 +0800
Message-ID: <ed638ae8-e40b-9160-c06a-0b69e01ae2a2@huawei.com>
References: <20170421004957.23760-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170421004957.23760-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/4/21 8:49, Jaegeuk Kim wrote:
> This patch adds braces for macro variables more in include/linux/f2fs_fs.h.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h          |  1 +
>  include/linux/f2fs_fs.h | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e2d9a8d9101e..ca647d264b61 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -16,6 +16,7 @@
>  #include <linux/buffer_head.h>
>  #include <linux/slab.h>
>  #include <linux/crc32.h>
> +#include <linux/quota.h>

This is no needed. ;)

Thanks,

>  #include <linux/magic.h>
>  #include <linux/kobject.h>
>  #include <linux/sched.h>
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index e2d239ed4c60..639cbdf65e2b 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -32,9 +32,9 @@
>  /* 0, 1(node nid), 2(meta nid) are reserved node id */
>  #define F2FS_RESERVED_NODE_NUM		3
>  
> -#define F2FS_ROOT_INO(sbi)	(sbi->root_ino_num)
> -#define F2FS_NODE_INO(sbi)	(sbi->node_ino_num)
> -#define F2FS_META_INO(sbi)	(sbi->meta_ino_num)
> +#define F2FS_ROOT_INO(sbi)	((sbi)->root_ino_num)
> +#define F2FS_NODE_INO(sbi)	((sbi)->node_ino_num)
> +#define F2FS_META_INO(sbi)	((sbi)->meta_ino_num)
>  
>  #define F2FS_IO_SIZE(sbi)	(1 << (sbi)->write_io_size_bits) /* Blocks */
>  #define F2FS_IO_SIZE_KB(sbi)	(1 << ((sbi)->write_io_size_bits + 2)) /* KB */
> @@ -161,7 +161,7 @@ struct f2fs_checkpoint {
>   */
>  #define F2FS_ORPHANS_PER_BLOCK	1020
>  
> -#define GET_ORPHAN_BLOCKS(n)	((n + F2FS_ORPHANS_PER_BLOCK - 1) / \
> +#define GET_ORPHAN_BLOCKS(n)	(((n) + F2FS_ORPHANS_PER_BLOCK - 1) / \
>  					F2FS_ORPHANS_PER_BLOCK)
>  
>  struct f2fs_orphan_block {
> @@ -449,7 +449,7 @@ typedef __le32	f2fs_hash_t;
>  #define F2FS_SLOT_LEN		8
>  #define F2FS_SLOT_LEN_BITS	3
>  
> -#define GET_DENTRY_SLOTS(x)	((x + F2FS_SLOT_LEN - 1) >> F2FS_SLOT_LEN_BITS)
> +#define GET_DENTRY_SLOTS(x) (((x) + F2FS_SLOT_LEN - 1) >> F2FS_SLOT_LEN_BITS)
>  
>  /* MAX level for dir lookup */
>  #define MAX_DIR_HASH_DEPTH	63
> 
