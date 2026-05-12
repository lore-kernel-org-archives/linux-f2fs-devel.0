Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C5BCD4F24
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qd2FImmTDRUapvXDI/ZURt8IeKeHtCpPw/zB0o9Rr+g=; b=UXAR1CoqxCmn+esTyd/TLTy78b
	5pUHF6FDQwKFOOqjW2gkOxn2kvHJr3hRnrTVmt05CcNWoC5RsMG6Vk6IvmlV93NF/qG4aY6f77JEP
	p0/XkKGsA1MtslK2WZZ2eWLw6qMbl9PDdP0hEny3DeNww+lQOoMe2MkSkqNwXCo3gexU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMqbL-00089l-6P;
	Tue, 12 May 2026 17:08:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wMqbK-00089X-5Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 17:08:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KdIwxhE44Yq4qV2SnYLz6hAb1N+IgVV4bJ/hIou1Jp4=; b=dNuOoy99j5uizkGPA+19Fs2SHM
 9wlF/RfwgpAGV7QcrGq70FjiFKOSbWPO9jUiPhsWNuRXpwESJicewGDAXPDGIOoBesHRbQea1ZNW9
 O3YS6UcrDByIk2CzMovQLYj6OQFS2CmhalsB0oAvlWXKrthkRAU9tXlE+dY+Q8XrMpRI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KdIwxhE44Yq4qV2SnYLz6hAb1N+IgVV4bJ/hIou1Jp4=; b=JDgHx5Dv37TP4Ini6NUlhpm4WB
 qW6qaGTvxLC2RFoSa6qphKeRZl1CYyzZcxzQNUMIEIekf25qoAms+FP8mAcIwX6wd3lCJeJ5vWz7Y
 LRVwLi3l68OX7Ke3L3YX0KM4X2VCzfDS2tz6XwPv+WRtaq844AxdMTTLrm6+1sdMPn/s=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMqbJ-0000Ys-Is for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 17:08:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EA4960120;
 Tue, 12 May 2026 17:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0488AC2BCB0;
 Tue, 12 May 2026 17:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778605727;
 bh=sVVODp3FlRWZt0085AhF6/0c9Y54VioUFXOyMcpSdl8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UJflnRm6SyyebasilDKjjTMaTpzMjJu1nDkjFBw12Q8ys93lS4T5SkwVsmql5u44E
 9COiwostSmZp93nnSioVTeUSZy1eDPwytqhDSbQrtz+KgPT9bD7YFnS+McUwXeV1h8
 LgzDS7wt9P4VVHHXphzL/JOZ+tuiP5KIbfbPapYnHT62iaaCCTD455/6iIs8kZi83N
 GJ2sLX5BXvjivClIj4FM/J5OxJ75G9ZqWZ6HC+NlCyEGiL0kJvSMH9znL+vWnh7oAu
 Rw2xMqdTg1sKp20gQW6iHYZGVSH1uI8KL+IWc0hoZUOeogME2oEp9O9rCZkTKCKG5j
 OrtX03iel0R+w==
Date: Tue, 12 May 2026 10:08:46 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260512170846.GJ9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-10-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-10-hch@lst.de>
X-Headers-End: 1wMqbJ-0000Ys-Is
Subject: Re: [f2fs-dev] [PATCH 09/12] swap: push down setting sis->bdev into
 ->swap_activate
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 linux-mm@kvack.org, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Chris Li <chrisl@kernel.org>,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Kairui Song <kasong@tencent.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-cifs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 linux-btrfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 12, 2026 at 07:35:25AM +0200, Christoph Hellwig wrote:
> Only the file operation method knows what block device we'll swap
> to.  So move down setting sis->bdev and the special blockdev flag
> into ->swap_activate.
> =

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/fops.c         |  9 ++++++++-
>  fs/btrfs/inode.c     |  7 ++++---
>  fs/f2fs/data.c       |  3 ++-
>  fs/iomap/swapfile.c  |  7 ++-----
>  fs/nfs/file.c        |  2 +-
>  fs/smb/client/file.c |  2 +-
>  fs/xfs/xfs_file.c    |  6 ------
>  include/linux/swap.h |  4 ++--
>  mm/page_io.c         |  3 +--
>  mm/swapfile.c        | 38 ++++++++++++--------------------------
>  10 files changed, 33 insertions(+), 48 deletions(-)
> =

> diff --git a/block/fops.c b/block/fops.c
> index 067e46299666..da09ce3f072f 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -951,9 +951,16 @@ static int blkdev_mmap_prepare(struct vm_area_desc *=
desc)
>  =

>  static int blkdev_swap_activate(struct file *file, struct swap_info_stru=
ct *sis)
>  {
> +	struct block_device *bdev =3D I_BDEV(file->f_mapping->host);
>  	loff_t isize =3D i_size_read(bdev_file_inode(file));
>  =

> -	return add_swap_extent(sis, div_u64(isize, PAGE_SIZE), 0);
> +	/*
> +	 * The swap code performs arbitrary overwrites, which are not supported
> +	 * on zones with sequential write constraints.
> +	 */
> +	if (bdev_is_zoned(bdev))
> +		return -EINVAL;
> +	return add_swap_extent(sis, div_u64(isize, PAGE_SIZE), bdev, 0);
>  }
>  =

>  const struct file_operations def_blk_fops =3D {
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ee0a7947706a..84003c520530 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -10201,6 +10201,7 @@ static void btrfs_free_swapfile_pins(struct inode=
 *inode)
>  }
>  =

>  struct btrfs_swap_info {
> +	struct btrfs_device *device;
>  	u64 start;
>  	u64 block_start;
>  	u64 block_len;
> @@ -10214,7 +10215,8 @@ static int btrfs_add_swap_extent(struct swap_info=
_struct *sis,
>  	first_ppage =3D PAGE_ALIGN(bsi->block_start) >> PAGE_SHIFT;
>  	next_ppage =3D PAGE_ALIGN_DOWN(bsi->block_start + bsi->block_len) >> PA=
GE_SHIFT;
>  =

> -	return add_swap_extent(sis, next_ppage - first_ppage, first_ppage);
> +	return add_swap_extent(sis, next_ppage - first_ppage, bsi->device->bdev,
> +			first_ppage);
>  }
>  =

>  void btrfs_swap_deactivate(struct file *file)
> @@ -10503,6 +10505,7 @@ int btrfs_swap_activate(struct file *file, struct=
 swap_info_struct *sis)
>  			bsi.start =3D key.offset;
>  			bsi.block_start =3D physical_block_start;
>  			bsi.block_len =3D len;
> +			bsi.device =3D device;
>  		}
>  =

>  		if (fatal_signal_pending(current)) {
> @@ -10533,8 +10536,6 @@ int btrfs_swap_activate(struct file *file, struct=
 swap_info_struct *sis)
>  	up_write(&BTRFS_I(inode)->i_mmap_lock);
>  	btrfs_free_backref_share_ctx(backref_ctx);
>  	btrfs_free_path(path);
> -	if (!ret && device)
> -		sis->bdev =3D device->bdev;
>  	return ret;
>  }
>  #endif
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8bcf630df557..8d116ff517c9 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4326,7 +4326,8 @@ static int check_swap_activate(struct swap_info_str=
uct *sis,
>  		/*
>  		 * We found a PAGE_SIZE-length, PAGE_SIZE-aligned run of blocks
>  		 */
> -		ret =3D add_swap_extent(sis, nr_pblocks, pblock);
> +		ret =3D add_swap_extent(sis, nr_pblocks, inode->i_sb->s_bdev,
> +				pblock);
>  		if (ret < 0)
>  			goto out;
>  		cur_lblock +=3D nr_pblocks;
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index a4e0ca462cc4..862b4c02a8bd 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -50,10 +50,6 @@ static int iomap_swapfile_iter(struct iomap_iter *iter=
, struct file *file,
>  	if (iomap->flags & IOMAP_F_SHARED)
>  		return iomap_swapfile_fail(file, "has shared extents");
>  =

> -	/* Only one bdev per swap file. */
> -	if (iomap->bdev !=3D sis->bdev)
> -		return iomap_swapfile_fail(file, "outside the main device");
> -
>  	/*
>  	 * Round the start up and the end down so that the physical extent
>  	 * aligns to a page boundary.
> @@ -61,7 +57,8 @@ static int iomap_swapfile_iter(struct iomap_iter *iter,=
 struct file *file,
>  	first_ppage =3D ALIGN(iomap->addr, PAGE_SIZE) >> PAGE_SHIFT;
>  	next_ppage =3D ALIGN_DOWN(iomap->addr + iomap->length, PAGE_SIZE) >>
>  			PAGE_SHIFT;
> -	error =3D add_swap_extent(sis, next_ppage - first_ppage, first_ppage);
> +	error =3D add_swap_extent(sis, next_ppage - first_ppage, iomap->bdev,
> +			first_ppage);
>  	if (error)
>  		return error;
>  	return iomap_iter_advance_full(iter);
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 2bc55d9d71e1..10ab2a923835 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -588,7 +588,7 @@ int nfs_swap_activate(struct file *file, struct swap_=
info_struct *sis)
>  	ret =3D rpc_clnt_swap_activate(clnt);
>  	if (ret)
>  		return ret;
> -	ret =3D add_swap_extent(sis, sis->max, 0);
> +	ret =3D add_swap_extent(sis, sis->max, NULL, 0);
>  	if (ret < 0) {
>  		rpc_clnt_swap_deactivate(clnt);
>  		return ret;
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 84459f87907e..e1bbc65ce7f3 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -3327,7 +3327,7 @@ int cifs_swap_activate(struct file *swap_file, stru=
ct swap_info_struct *sis)
>  	 */
>  =

>  	sis->flags |=3D SWP_FS_OPS;
> -	return add_swap_extent(sis, sis->max, 0);
> +	return add_swap_extent(sis, sis->max, NULL, 0);
>  }
>  =

>  void cifs_swap_deactivate(struct file *file)
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 41f7e19bd31f..74128ebf7161 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -2116,12 +2116,6 @@ xfs_file_swap_activate(
>  	 */
>  	xfs_inodegc_flush(ip->i_mount);
>  =

> -	/*
> -	 * Direct the swap code to the correct block device when this file
> -	 * sits on the RT device.
> -	 */
> -	sis->bdev =3D xfs_inode_buftarg(ip)->bt_bdev;
> -
>  	return iomap_swap_activate(file, sis, &xfs_read_iomap_ops);
>  }
>  =

> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 657779485ae4..b1cbb67ddd8e 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -404,7 +404,7 @@ extern void __meminit kswapd_stop(int nid);
>  #ifdef CONFIG_SWAP
>  =

>  int add_swap_extent(struct swap_info_struct *sis, unsigned long nr_pages,
> -		sector_t start_block);
> +		struct block_device *bdev, sector_t start_block);
>  int generic_swap_activate(struct file *swap_file, struct swap_info_struc=
t *sis);
>  =

>  static inline unsigned long total_swapcache_pages(void)
> @@ -528,7 +528,7 @@ static inline bool folio_free_swap(struct folio *foli=
o)
>  =

>  static inline int add_swap_extent(struct swap_info_struct *sis,
>  		unsigned long start_page, unsigned long nr_pages,
> -		sector_t start_block)
> +		struct block_device *bdev, sector_t start_block)
>  {
>  	return -EINVAL;
>  }
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 3e1c12649448..2ab8994ed1c2 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -132,7 +132,7 @@ int generic_swap_activate(struct file *swap_file, str=
uct swap_info_struct *sis)
>  		/*
>  		 * We found a PAGE_SIZE-length, PAGE_SIZE-aligned run of blocks
>  		 */
> -		ret =3D add_swap_extent(sis, 1,
> +		ret =3D add_swap_extent(sis, 1, inode->i_sb->s_bdev,
>  				first_block >> (PAGE_SHIFT - blkbits));
>  		if (ret < 0)
>  			return ret;
> @@ -141,7 +141,6 @@ int generic_swap_activate(struct file *swap_file, str=
uct swap_info_struct *sis)
>  		continue;
>  	}
>  	return 0;
> -
>  bad_bmap:
>  	pr_err("swapon: swapfile has holes\n");
>  	return -EINVAL;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index fbf11c8c5c69..2c9d2af736c4 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2707,7 +2707,7 @@ static void destroy_swap_extents(struct swap_info_s=
truct *sis,
>   */
>  int
>  add_swap_extent(struct swap_info_struct *sis, unsigned long nr_pages,
> -		sector_t start_block)
> +		struct block_device *bdev, sector_t start_block)
>  {
>  	struct rb_node **link =3D &sis->swap_extent_root.rb_node, *parent =3D N=
ULL;
>  	struct swap_extent *se;
> @@ -2718,6 +2718,12 @@ add_swap_extent(struct swap_info_struct *sis, unsi=
gned long nr_pages,
>  		return 0;
>  	nr_pages =3D min(nr_pages, sis->max - sis->pages);
>  =

> +	/* Only one bdev per swap file for now. */
> +	if (!sis->bdev)
> +		sis->bdev =3D bdev;
> +	else if (bdev !=3D sis->bdev)
> +		return -EINVAL;

Should this return error if the bdev is zoned?  AFAICT XFS and zonefs
already guard against this, but other fses might be more na=EFve.

--D

> +
>  	/*
>  	 * place the new node at the right most since the
>  	 * function is called in ascending page order.
> @@ -2793,6 +2799,8 @@ static int setup_swap_extents(struct swap_info_stru=
ct *sis,
>  	sis->flags |=3D SWP_ACTIVATED;
>  	if (sis->flags & SWP_FS_OPS)
>  		error =3D sio_pool_init();
> +	else if (WARN_ON_ONCE(!sis->bdev))
> +		error =3D -EINVAL;
>  	if (error)
>  		destroy_swap_extents(sis, swap_file);
>  	return error;
> @@ -3224,26 +3232,6 @@ static struct swap_info_struct *alloc_swap_info(vo=
id)
>  	return p;
>  }
>  =

> -static int claim_swapfile(struct swap_info_struct *si, struct inode *ino=
de)
> -{
> -	if (S_ISBLK(inode->i_mode)) {
> -		si->bdev =3D I_BDEV(inode);
> -		/*
> -		 * Zoned block devices contain zones that have a sequential
> -		 * write only restriction.  Hence zoned block devices are not
> -		 * suitable for swapping.  Disallow them here.
> -		 */
> -		if (bdev_is_zoned(si->bdev))
> -			return -EINVAL;
> -		si->flags |=3D SWP_BLKDEV;
> -	} else if (S_ISREG(inode->i_mode)) {
> -		si->bdev =3D inode->i_sb->s_bdev;
> -	}
> -
> -	return 0;
> -}
> -
> -
>  /*
>   * Find out how many pages are allowed for a single swap device. There
>   * are two limiting factors:
> @@ -3500,16 +3488,14 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
>  	dentry =3D swap_file->f_path.dentry;
>  	inode =3D mapping->host;
>  =

> -	error =3D claim_swapfile(si, inode);
> -	if (unlikely(error))
> -		goto bad_swap;
> -
>  	inode_lock(inode);
>  	if (d_unlinked(dentry) || cant_mount(dentry)) {
>  		error =3D -ENOENT;
>  		goto bad_swap_unlock_inode;
>  	}
> -	if (!S_ISBLK(inode->i_mode) && !S_ISREG(inode->i_mode)) {
> +	if (S_ISBLK(inode->i_mode)) {
> +		si->flags |=3D SWP_BLKDEV;
> +	} else if (!S_ISREG(inode->i_mode)) {
>  		error =3D -EINVAL;
>  		goto bad_swap_unlock_inode;
>  	}
> -- =

> 2.53.0
> =

> =



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
