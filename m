Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B28CD4F24
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+pfxSHdBUYwWumHUcs8J2bC8b1/talhE17UOoWs9NY=; b=mdmeuFsOkMpvZlHfDMK3/5r3yD
	Dg7lgj+cT2eh2WvWg9nVkuLQNwjrUIFim7Op/i6nEOOZb3Bk79/qlr/PlH9YV90In6JBoSQDhAQld
	dSKiWGl+7lP0QL/7gaDGYKNPJRaFiYzarUvAIeLBxo99wNv4Cu2msB1kzEpbXmv1IoeM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMqby-0001RZ-KY;
	Tue, 12 May 2026 17:09:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wMqbx-0001RS-H6
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 17:09:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QtFTnWMWJzFGeaKLLmcb0EqyVQvprDE94/pwqwGkskw=; b=ZrBw4aK45wIaJm4jz6vKKZ6bd8
 6+bKLHRoePpUZCRY6pDKq/UQZvUi93gv3DunyLfltqdiSbyCS+OIhoExfBDpzrlP2XIaXvAM7duOI
 8PT7b0QIPLXYUNe8CzlQqtjJRd6Bx4agF6rwuW8ft1qZ/KHkgnuC2xxzDGurjdeb4ybk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QtFTnWMWJzFGeaKLLmcb0EqyVQvprDE94/pwqwGkskw=; b=jxG8MM6J5axaWZE4RGFQrEar7t
 aGxaQ9Pu4fPVUnFHydLAJ0wec4LuWaXySE9neLc41sZnSWqE+NHSj4lxybjkAqjzRtTOsxmU2r3Yy
 blXgcgJahnrN6urRMuYeGoLZj9G3sNbzAO8KFWG+O/Mfo+yXvxVmJfXk+dSmHJ3d1OA8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMqbs-0000av-EX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 17:09:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9233D40740;
 Tue, 12 May 2026 17:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66493C2BCB0;
 Tue, 12 May 2026 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778605767;
 bh=Adu4k9PdOIdLwtwgwkK9s/zvDBkfua5WJ/GmI2xgu9g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NOIMsY8RFaGmBa1B0NfQZRKTTC2Opt5G0UGNWkG2xX+oKei2g/2sY1sAEGHPUfcfE
 bCnaHbLx2Behy/Q86tImeSUpr4suA18Ov4lpRDztKh8E1mdkpboOF+xdQN+859Ke+k
 YHA9pQoNGul4pjzyGV+AcILGaOLieox338qli/gOFjxsVI3VZUdR9VCQ/hWphy05U9
 dBvIgkYEiq6XWk478ZrgLGvSBsP97O+F642Ovkd5vN1N1txh6n6sjbOBn/tivsY95b
 w8EPdawuqPfAI8KY93US4598VyP4RHdazNd8TO2VApANA5L6CfFSVNFZTlOMQzXONy
 BQNmYWhO7KwKg==
Date: Tue, 12 May 2026 10:09:27 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260512170927.GK9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-11-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-11-hch@lst.de>
X-Headers-End: 1wMqbs-0000av-EX
Subject: Re: [f2fs-dev] [PATCH 10/12] swap: add a swap_activate_fs_ops helper
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 12, 2026 at 07:35:26AM +0200, Christoph Hellwig wrote:
> Add a helper abstracting away the low-level details of enabling
> fs_ops-based swapping.  This prepares for taking swap_info_struct
> private.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/nfs/file.c        | 4 +---
>  fs/smb/client/file.c | 3 +--
>  include/linux/swap.h | 5 +++++
>  mm/swapfile.c        | 7 +++++++
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 10ab2a923835..ce4d860c4e7a 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -588,7 +588,7 @@ int nfs_swap_activate(struct file *file, struct swap_info_struct *sis)
>  	ret = rpc_clnt_swap_activate(clnt);
>  	if (ret)
>  		return ret;
> -	ret = add_swap_extent(sis, sis->max, NULL, 0);
> +	ret = swap_activate_fs_ops(sis);
>  	if (ret < 0) {
>  		rpc_clnt_swap_deactivate(clnt);
>  		return ret;
> @@ -596,8 +596,6 @@ int nfs_swap_activate(struct file *file, struct swap_info_struct *sis)
>  
>  	if (cl->rpc_ops->enable_swap)
>  		cl->rpc_ops->enable_swap(inode);
> -
> -	sis->flags |= SWP_FS_OPS;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(nfs_swap_activate);
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index e1bbc65ce7f3..e11065be1e64 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -3326,8 +3326,7 @@ int cifs_swap_activate(struct file *swap_file, struct swap_info_struct *sis)
>  	 * from reading or writing the file
>  	 */
>  
> -	sis->flags |= SWP_FS_OPS;
> -	return add_swap_extent(sis, sis->max, NULL, 0);
> +	return swap_activate_fs_ops(sis);
>  }
>  
>  void cifs_swap_deactivate(struct file *file)
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index b1cbb67ddd8e..916889738f08 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -406,6 +406,7 @@ extern void __meminit kswapd_stop(int nid);
>  int add_swap_extent(struct swap_info_struct *sis, unsigned long nr_pages,
>  		struct block_device *bdev, sector_t start_block);
>  int generic_swap_activate(struct file *swap_file, struct swap_info_struct *sis);
> +int swap_activate_fs_ops(struct swap_info_struct *sis);
>  
>  static inline unsigned long total_swapcache_pages(void)
>  {
> @@ -532,6 +533,10 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
>  {
>  	return -EINVAL;
>  }
> +static inline int swap_activate_fs_ops(struct swap_info_struct *sis)
> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_SWAP */
>  #ifdef CONFIG_MEMCG
>  static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2c9d2af736c4..26852c2ad36e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2757,6 +2757,13 @@ add_swap_extent(struct swap_info_struct *sis, unsigned long nr_pages,
>  }
>  EXPORT_SYMBOL_GPL(add_swap_extent);
>  
> +int swap_activate_fs_ops(struct swap_info_struct *sis)
> +{
> +	sis->flags |= SWP_FS_OPS;
> +	return add_swap_extent(sis, sis->max, NULL, 0);
> +}
> +EXPORT_SYMBOL_GPL(swap_activate_fs_ops);
> +
>  /*
>   * A `swap extent' is a simple thing which maps a contiguous range of pages
>   * onto a contiguous range of disk blocks.  A rbtree of swap extents is
> -- 
> 2.53.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
