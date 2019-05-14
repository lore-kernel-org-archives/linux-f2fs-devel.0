From: zhaowuyun via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH v4 2/2] sload.f2fs: introduce
 f2fs_sparse_initialize_meta()
Date: Tue, 14 May 2019 20:22:48 +0800
Message-ID: <000901d50a4f$be344b50$3a9ce1f0$@wingtech.com>
Reply-To: zhaowuyun <zhaowuyun@wingtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhaowuyun@wingtech.com>) id 1hQWSR-00021D-Ax
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 12:22:59 +0000
Received: from mail.wingtech.com ([180.166.216.14])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA:256) (Exim 4.90_1) id 1hQWSP-003PvA-ST
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 12:22:59 +0000
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Chao Yu' <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

Hi Chao,

using the same steps, 
make the userdata partition dirty and fastboot-flash userdata.img to see the mount is successful or not

to test the patch, confirm that issue is fixed by this patch.
Hope to see it accepted.

Tested-by: zhaowuyun <zhaowuyun@wingtech.com>

Best Wishes,
Zac (zhaowuyun@wingtech.com)

> 
> This patch fixes to initialize NAT/SIT/CP.payload region in sparse file mode for
> sload.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> - move initialize_meta() before do_umount().
>  fsck/fsck.h  |  1 +
>  fsck/main.c  |  4 +++
>  fsck/mount.c | 70
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/fsck/fsck.h b/fsck/fsck.h
> index dd831de..4db14af 100644
> --- a/fsck/fsck.h
> +++ b/fsck/fsck.h
> @@ -181,6 +181,7 @@ extern int fsck_verify(struct f2fs_sb_info *);  extern
> void fsck_free(struct f2fs_sb_info *);  extern int f2fs_do_mount(struct
> f2fs_sb_info *);  extern void f2fs_do_umount(struct f2fs_sb_info *);
> +extern int f2fs_sparse_initialize_meta(struct f2fs_sb_info *);
> 
>  extern void flush_journal_entries(struct f2fs_sb_info *);  extern void
> zero_journal_entries(struct f2fs_sb_info *); diff --git a/fsck/main.c
> b/fsck/main.c index afdfec9..d844820 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -813,6 +813,10 @@ fsck_again:
>  		if (do_sload(sbi))
>  			goto out_err;
> 
> +		ret = f2fs_sparse_initialize_meta(sbi);
> +		if (ret < 0)
> +			goto out_err;
> +
>  		f2fs_do_umount(sbi);
> 
>  		/* fsck to fix missing quota */
> diff --git a/fsck/mount.c b/fsck/mount.c index 843742e..230f330 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -2721,3 +2721,73 @@ void f2fs_do_umount(struct f2fs_sb_info *sbi)
>  	free(sbi->ckpt);
>  	free(sbi->raw_super);
>  }
> +
> +#ifdef WITH_ANDROID
> +int f2fs_sparse_initialize_meta(struct f2fs_sb_info *sbi) {
> +	struct f2fs_super_block *sb = sbi->raw_super;
> +	u_int32_t sit_seg_count, sit_size;
> +	u_int32_t nat_seg_count, nat_size;
> +	u_int64_t sit_seg_addr, nat_seg_addr, payload_addr;
> +	u_int32_t seg_size = 1 << get_sb(log_blocks_per_seg);
> +	int ret;
> +
> +	if (!c.sparse_mode)
> +		return 0;
> +
> +	sit_seg_addr = get_sb(sit_blkaddr);
> +	sit_seg_count = get_sb(segment_count_sit);
> +	sit_size = sit_seg_count * seg_size;
> +
> +	DBG(1, "\tSparse: filling sit area at block offset: 0x%08"PRIx64"
> len: %u\n",
> +							sit_seg_addr,
> sit_size);
> +	ret = dev_fill(NULL, sit_seg_addr * F2FS_BLKSIZE,
> +					sit_size * F2FS_BLKSIZE);
> +	if (ret) {
> +		MSG(1, "\tError: While zeroing out the sit area "
> +				"on disk!!!\n");
> +		return -1;
> +	}
> +
> +	nat_seg_addr = get_sb(nat_blkaddr);
> +	nat_seg_count = get_sb(segment_count_nat);
> +	nat_size = nat_seg_count * seg_size;
> +
> +	DBG(1, "\tSparse: filling nat area at block offset 0x%08"PRIx64"
> len: %u\n",
> +							nat_seg_addr,
> nat_size);
> +	ret = dev_fill(NULL, nat_seg_addr * F2FS_BLKSIZE,
> +					nat_size * F2FS_BLKSIZE);
> +	if (ret) {
> +		MSG(1, "\tError: While zeroing out the nat area "
> +				"on disk!!!\n");
> +		return -1;
> +	}
> +
> +	payload_addr = get_sb(segment0_blkaddr) + 1;
> +
> +	DBG(1, "\tSparse: filling bitmap area at block offset 0x%08"PRIx64"
> len: %u\n",
> +					payload_addr, get_sb(cp_payload));
> +	ret = dev_fill(NULL, payload_addr * F2FS_BLKSIZE,
> +					get_sb(cp_payload) * F2FS_BLKSIZE);
> +	if (ret) {
> +		MSG(1, "\tError: While zeroing out the nat/sit bitmap area "
> +				"on disk!!!\n");
> +		return -1;
> +	}
> +
> +	payload_addr += seg_size;
> +
> +	DBG(1, "\tSparse: filling bitmap area at block offset 0x%08"PRIx64"
> len: %u\n",
> +					payload_addr, get_sb(cp_payload));
> +	ret = dev_fill(NULL, payload_addr * F2FS_BLKSIZE,
> +					get_sb(cp_payload) * F2FS_BLKSIZE);
> +	if (ret) {
> +		MSG(1, "\tError: While zeroing out the nat/sit bitmap area "
> +				"on disk!!!\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +#else
> +int f2fs_sparse_initialize_meta(struct f2fs_sb_info *sbi) { return 0; }
> +#endif
> --
> 2.18.0.rc1
