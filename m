Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE932CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nlc5EsCPfkGRPW+w429Cha4XjHSeX9nXFOoImH/W+8c=; b=FubJQow7kMdWshVJ1VHjp7yhjQ
	JoIx8tqTVs5J3JQCJGtg73DUk7Me/o4J8Mv1tEvWE6fVUxhyOlxM68/vMvpOUew2J6MPlxWpUCBST
	6tov8tyaZyVvUrSMu/kXgKdTZGT5MG2YuJVlk+LBHi40QZjHXeV4Yx3FDaNCGGUoP03I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMpkX-0005XE-Ph;
	Tue, 12 May 2026 16:14:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wMpkW-0005X6-85
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 16:14:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jVM4DfUVCcEgrG+8nfDyufkWHXji2ICb2GvkaG2MzZE=; b=W686CNh/rv7RW7AQKQd2TibJoJ
 qwBIQhaI2IRcvxI++KBzPQzZYWRu7qsz54Vnil/wyH/1cuXtXsuWTgbYXCJkSQ7WJSYACCPgvXMlg
 Vt1nIMHYaHEIZwtVRCSkBjR0odm6bmPyvSrypsIDF3tTxf3LOMf9OeFX3jNOjXU9HizE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jVM4DfUVCcEgrG+8nfDyufkWHXji2ICb2GvkaG2MzZE=; b=ftSdGt9vk+SpFXgl+AR/sfWfEI
 gnatOgqDrLo1kz06cCQvhehqoqWV0vUOQlUbXM5IM66J7VaQMCIkTGB4bhvEPXTSZgS+RZt0fB/PS
 VwJVyOaFT6vy5DF0BbFn2bn0O2USj33nfa2oDuNVr0ZQlFccpEnCiVMiUMeVW4H86Ow4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMpkS-0004uC-Hi for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 16:14:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 90FC943D00;
 Tue, 12 May 2026 16:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646AEC2BCFA;
 Tue, 12 May 2026 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778602455;
 bh=IUNQoj40BBpUNJf0ajtJqYtGemiYL8A1ke06SM7+b4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J/S/PcOS1XPcZV7Syc+JlqArxkXZ/hbxBjwDT1oINHHwBvkhhEWP9INmRvwBy5uMs
 IQ7LRTkDcpdEEKM0Tw08keNfDow4yaHa7b0CVm3jBd1tISNFLljNv2sMqAGoS/qtXU
 kvv4bupqJjw57mXwLGv3YQYnlWf91aYSUfKamfSgWAYibwIdHaKI2hKtoE8SnMjl/r
 yss2iKimG4E33ynm2qH/k2CFu5aRhuOAM/21vTLClYeYWVJ5nzDy2SveAFpZ27Z4QK
 HnDMLSECA8B5Mln82mBvnzgxuWuoXQxgVvLQ2dQycDnG6am4VL4o8Rvgtxso9ns8vD
 fQ/KjPYMec+yg==
Date: Tue, 12 May 2026 09:14:14 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260512161414.GB9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-2-hch@lst.de>
X-Headers-End: 1wMpkS-0004uC-Hi
Subject: Re: [f2fs-dev] [PATCH 01/12] swap: remove the maxpages variable in
 sys_swapon
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

On Tue, May 12, 2026 at 07:35:17AM +0200, Christoph Hellwig wrote:
> Always use si->max which is updated setup_swap_extents instead of copying

"...updated in setup_swap_extents..."

> into and out of maxpages.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

But yes, it's much harder to track the data flows if we keep copying the
value in and out of local variables.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  mm/swapfile.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9174f1eeffb0..f7ebd97e28a3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3350,10 +3350,9 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
>  }
>  
>  static int setup_swap_clusters_info(struct swap_info_struct *si,
> -				    union swap_header *swap_header,
> -				    unsigned long maxpages)
> +				    union swap_header *swap_header)
>  {
> -	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
> +	unsigned long nr_clusters = DIV_ROUND_UP(si->max, SWAPFILE_CLUSTER);
>  	struct swap_cluster_info *cluster_info;
>  	int err = -ENOMEM;
>  	unsigned long i;
> @@ -3395,7 +3394,7 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
>  		if (err)
>  			goto err;
>  	}
> -	for (i = maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i++) {
> +	for (i = si->max; i < round_up(si->max, SWAPFILE_CLUSTER); i++) {
>  		err = swap_cluster_setup_bad_slot(si, cluster_info, i, true);
>  		if (err)
>  			goto err;
> @@ -3425,7 +3424,7 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
>  	si->cluster_info = cluster_info;
>  	return 0;
>  err:
> -	free_swap_cluster_info(cluster_info, maxpages);
> +	free_swap_cluster_info(cluster_info, si->max);
>  	return err;
>  }
>  
> @@ -3440,7 +3439,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	union swap_header *swap_header;
>  	int nr_extents;
>  	sector_t span;
> -	unsigned long maxpages;
>  	struct folio *folio = NULL;
>  	struct inode *inode = NULL;
>  	bool inced_nr_rotate_swap = false;
> @@ -3512,14 +3510,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	}
>  	swap_header = kmap_local_folio(folio, 0);
>  
> -	maxpages = read_swap_header(si, swap_header, inode);
> -	if (unlikely(!maxpages)) {
> +	si->max = read_swap_header(si, swap_header, inode);
> +	if (unlikely(!si->max)) {
>  		error = -EINVAL;
>  		goto bad_swap_unlock_inode;
>  	}
>  
> -	si->max = maxpages;
> -	si->pages = maxpages - 1;
> +	si->pages = si->max - 1;
>  	nr_extents = setup_swap_extents(si, swap_file, &span);
>  	if (nr_extents < 0) {
>  		error = nr_extents;
> @@ -3531,14 +3528,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		goto bad_swap_unlock_inode;
>  	}
>  
> -	maxpages = si->max;
> -
>  	/* Set up the swap cluster info */
> -	error = setup_swap_clusters_info(si, swap_header, maxpages);
> +	error = setup_swap_clusters_info(si, swap_header);
>  	if (error)
>  		goto bad_swap_unlock_inode;
>  
> -	error = swap_cgroup_swapon(si->type, maxpages);
> +	error = swap_cgroup_swapon(si->type, si->max);
>  	if (error)
>  		goto bad_swap_unlock_inode;
>  
> @@ -3546,7 +3541,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
>  	 * be above MAX_PAGE_ORDER incase of a large swap file.
>  	 */
> -	si->zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(long),
> +	si->zeromap = kvmalloc_array(BITS_TO_LONGS(si->max), sizeof(long),
>  				     GFP_KERNEL | __GFP_ZERO);
>  	if (!si->zeromap) {
>  		error = -ENOMEM;
> @@ -3597,7 +3592,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		}
>  	}
>  
> -	error = zswap_swapon(si->type, maxpages);
> +	error = zswap_swapon(si->type, si->max);
>  	if (error)
>  		goto bad_swap_unlock_inode;
>  
> -- 
> 2.53.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
