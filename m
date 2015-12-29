From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH v2] f2fs: add a max block check for
 get_data_block_bmap
Date: Tue, 29 Dec 2015 17:53:40 +0800
Message-ID: <00d001d1421e$e7ed3670$b7c7a350$@samsung.com>
References: <1451310512-11210-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aDqzH-00040i-0f
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 09:54:39 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aDqzE-0001EN-U7
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 09:54:38 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0401L896675A70@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 18:54:29 +0900 (KST)
In-reply-to: <1451310512-11210-1-git-send-email-heyunlei@huawei.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Yunlei He' <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi all,

> -----Original Message-----
> From: Yunlei He [mailto:heyunlei@huawei.com]
> Sent: Monday, December 28, 2015 9:49 PM
> To: linux-f2fs-devel@lists.sourceforge.net; jaegeuk@kernel.org; chao2.yu@samsung.com
> Cc: bintian.wang@huawei.com; Yunlei He; Xue Liu
> Subject: [f2fs-dev][PATCH v2] f2fs: add a max block check for get_data_block_bmap
> 
> This patch adds a max block check for get_data_block_bmap.
> 
> Trinity test program will send a block number as parameter into
> ioctl_fibmap, which will be used in get_node_path(), when the block
> number large than f2fs max blocks, it will trigger kernel bug.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
> ---
>  fs/f2fs/data.c  | 4 ++++
>  fs/f2fs/f2fs.h  | 1 +
>  fs/f2fs/super.c | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index e34b1bd..51cbf68 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -741,6 +741,10 @@ static int get_data_block_dio(struct inode *inode, sector_t iblock,
>  static int get_data_block_bmap(struct inode *inode, sector_t iblock,
>  			struct buffer_head *bh_result, int create)
>  {
> +	/* Block number less than F2FS MAX BLOCKS */
> +	if (unlikely(iblock > max_file_size(0)))

Should be iblock >= max_file_size(0).

Thanks,

> +		return -EFBIG;
> +
>  	return __get_data_block(inode, iblock, bh_result, create,
>  						F2FS_GET_BLOCK_BMAP);
>  }
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 19beabe..e248b8da 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1724,6 +1724,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
>   * super.c
>   */
>  int f2fs_commit_super(struct f2fs_sb_info *, bool);
> +loff_t max_file_size(unsigned bits);
>  int f2fs_sync_fs(struct super_block *, int);
>  extern __printf(3, 4)
>  void f2fs_msg(struct super_block *, const char *, const char *, ...);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index c3070c1..4075402 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -906,7 +906,7 @@ static const struct export_operations f2fs_export_ops = {
>  	.get_parent = f2fs_get_parent,
>  };
> 
> -static loff_t max_file_size(unsigned bits)
> +loff_t max_file_size(unsigned bits)
>  {
>  	loff_t result = (DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS);
>  	loff_t leaf_count = ADDRS_PER_BLOCK;
> --
> 1.9.1



------------------------------------------------------------------------------
