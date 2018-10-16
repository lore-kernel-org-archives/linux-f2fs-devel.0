From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/4] mkfs.f2fs: Added missing statements
 related to error checking.
Date: Tue, 16 Oct 2018 19:18:43 +0800
Message-ID: <47edfc4f-ac80-9164-5c6e-31deb19720a4@huawei.com>
References: <0A9E2DD2-E2DA-4C24-A362-8778454B2142@cs.toronto.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gCNNH-0006E6-JV
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 11:18:55 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCNND-002hc4-Ea
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 11:18:55 +0000
In-Reply-To: <0A9E2DD2-E2DA-4C24-A362-8778454B2142@cs.toronto.edu>
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
To: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>, linux-f2fs-devel@lists.sourceforge.net

On 2018/10/12 6:20, Sotirios-Efstathios Maneas wrote:
> The following patch adds a few missing statements related to error checking.
> 
> Signed-off-by: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
> ---
>  mkfs/f2fs_format.c       | 10 ++++++++--
>  mkfs/f2fs_format_utils.c |  5 +++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 9b0a0d1..a2685cb 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -991,12 +991,16 @@ static int f2fs_write_super_block(void)
>  	u_int8_t *zero_buff;
>  
>  	zero_buff = calloc(F2FS_BLKSIZE, 1);
> +	if (zero_buff == NULL) {

I think it will be good to keep the coding style:

if (!zero_buff)

> +		MSG(1, "\tError: Calloc Failed for super_blk_zero_buf!!!\n");
> +		return -1;
> +	}
>  
>  	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
>  	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
>  	for (index = 0; index < 2; index++) {
>  		if (dev_write_block(zero_buff, index)) {
> -			MSG(1, "\tError: While while writing supe_blk "
> +			MSG(1, "\tError: While while writing super_blk "

This typo should be fixed in another patch.

>  					"on disk!!! index : %d\n", index);
>  			free(zero_buff);
>  			return -1;
> @@ -1021,8 +1025,10 @@ static int f2fs_discard_obsolete_dnode(void)
>  		return 0;
>  
>  	raw_node = calloc(sizeof(struct f2fs_node), 1);
> -	if (!raw_node)
> +	if (raw_node == NULL) {

Coding style.

> +		MSG(1, "\tError: Calloc Failed for discard_raw_node!!!\n");
>  		return -1;
> +	}
>  
>  	/* avoid power-off-recovery based on roll-forward policy */
>  	offset = get_sb(main_blkaddr);
> diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
> index bf9ffbd..36b363a 100644
> --- a/mkfs/f2fs_format_utils.c
> +++ b/mkfs/f2fs_format_utils.c
> @@ -51,6 +51,11 @@ static int trim_device(int i)
>  	int fd = dev->fd;
>  
>  	stat_buf = malloc(sizeof(struct stat));
> +	if (stat_buf == NULL) {

Ditto.

How about fixing all error handling of calloc/malloc from differnet .c
files in one patch?

Thanks,

> +		MSG(1, "\tError: Malloc Failed for trim_stat_buf!!!\n");
> +		return -1;
> +	}
> +
>  	if (fstat(fd, stat_buf) < 0 ) {
>  		MSG(1, "\tError: Failed to get the device stat!!!\n");
>  		free(stat_buf);
> 
