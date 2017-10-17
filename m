From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] fsck: introduce generic function
 f2fs_fsync_device
Date: Tue, 17 Oct 2017 21:35:51 +0800
Message-ID: <0d031dd4-d2ef-a668-d41e-1c1df022d852@kernel.org>
References: <1508223831-29251-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e4S2S-0006v2-Ud
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Oct 2017 13:36:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e4S2N-0001Hv-3c
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Oct 2017 13:36:08 +0000
In-Reply-To: <1508223831-29251-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com, jaegeuk@kernel.org

On 2017/10/17 15:03, Yunlei He wrote:
> We use f2fs_finalize_device to fsync previous data in
> checkpoint area before write last CP pack, in order to avoid
> cp corruption in sudden-power-off case. But this function will
> close the device, so this patch introduce a function to call
> fsync() only.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fsck/mount.c      |  2 +-
>  include/f2fs_fs.h |  1 +
>  lib/libf2fs_io.c  | 10 ++++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 7a8aeae..e234fe9 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1939,7 +1939,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>  		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
>  
>  	/* in case of sudden power off */
> -	f2fs_finalize_device();
> +	f2fs_fsync_device();
>  
>  	/* write the last cp */
>  	ret = dev_write_block(cp, cp_blk_no++);
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index bd609b9..3673817 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -1013,6 +1013,7 @@ extern int f2fs_dev_is_umounted(char *);
>  extern int f2fs_get_device_info(void);
>  extern int get_device_info(int);
>  extern void f2fs_finalize_device(void);
> +extern void f2fs_fsync_device(void);
>  
>  extern int dev_read(void *, __u64, size_t);
>  extern int dev_write(void *, __u64, size_t);
> diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
> index aa99068..50ff171 100644
> --- a/lib/libf2fs_io.c
> +++ b/lib/libf2fs_io.c
> @@ -193,6 +193,16 @@ int dev_reada_block(__u64 blk_addr)
>  	return dev_readahead(blk_addr << F2FS_BLKSIZE_BITS, F2FS_BLKSIZE);
>  }
>  
> +void f2fs_fsync_device(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < c.ndevs; i++) {
> +		if (fsync(c.devices[i].fd) < 0)
> +			MSG(0, "\tError: Could not conduct fsync!!!\n");
> +	}
> +}
> +
>  void f2fs_finalize_device(void)
>  {
>  	int i;
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
