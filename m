Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B277ECD4F3C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xa82BhO2oME5M2SP+mq3az6CWc/PZ9LL3vmCNufVpF4=; b=hGzH8M87xVp3H6iBFs0/VZPIBP
	YtyVe2t8uTZv72nMXRBYpBHwj2Zxi8LmHITT6K/AzYB+MkEwl80SvLngt9WXk4l0T1hN2R3lijEWG
	S8GTfHbLCM1KTnNQR2TiUSn6IPnnzQKb6VB9xKbWy49vw8pPbvxG9o1SCuh8DVuqwjdg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMqcN-00029C-FG;
	Tue, 12 May 2026 17:10:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wMqcL-000294-HP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 17:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CQElBpLn1nS3xLhKLyy0LAuDhAI6VScuxHNo4Sy5ycU=; b=dsBEV+ZPq9qROgqWHbpXMNaZuh
 Jn05dxL+CUiR2ip8pkWKyGCt6hC0/JZat+V8KF/4CiTjaw8mkRYcGx5ZgNYmrsuULk4XJjKKjeTLp
 MMq7AaJqfr+2WQ/QNo+20wT38KQCofRzqU+hQ+oFQZBp/Xz15C0eBkTi8tpUvwSySGvo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CQElBpLn1nS3xLhKLyy0LAuDhAI6VScuxHNo4Sy5ycU=; b=AWvf2ih9P41kQH/Ugeqw120Giv
 1watgvf1+4QSZrN7pYdM97K3MDehyvshYkIzK2rd3TQNZD/bUA48Ihkjcb0r868gmAv9IaQ15s2Ot
 tUA8w993hcQhpez9Iv2Nt8Ohc4FKMluOk6/W7FwxtfMIDukSKTKFuQRJwZnUXYfpBJXs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMqcK-0000d6-MT for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 17:10:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DCF464191B;
 Tue, 12 May 2026 17:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD890C2BCC7;
 Tue, 12 May 2026 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778605795;
 bh=3aHXpzD86WhvrwXcIwdK9qFl/6Uw/9X6ePBZAS123EQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RxFaNE5wPAV876f9BvjR4wqLnwTIKIo7fOPGapy+ipTeWdy0jpxo8hQ2Ri0GGHmrp
 CqEc/osq1V/20la7b58M49nDmb9ZDPQ1HRb652DRaiRlrgV68syhNYSwQ7oTHrZcE6
 e3va7ElR0K9PdL8DhzMxSzWHChNELJn1/XKK6AOCxoD6uzKfeHErjVWG/d7wnQJObm
 qV6eLTMTIGPO9wJvaDH523pfBAeOI6zjjN0aAdpxBGGOZXqoEOYhYlGqvV2ZUbFiua
 kABUvY5GndwreOZSc90aCC87nHpz2HeFvQqE+CWvH5k/2Gj9vksO/G6bmHaKnlQRkP
 sADrDRhCj51HQ==
Date: Tue, 12 May 2026 10:09:55 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260512170955.GL9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-12-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-12-hch@lst.de>
X-Headers-End: 1wMqcK-0000d6-MT
Subject: Re: [f2fs-dev] [PATCH 11/12] swap: move struct swap_extent to
 swapfile.c
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

On Tue, May 12, 2026 at 07:35:27AM +0200, Christoph Hellwig wrote:
> struct swap_extent is only used inside of mm/swapfile.c, so move it
> there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Woo, information hiding!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  include/linux/swap.h | 15 ---------------
>  mm/swapfile.c        | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 916889738f08..95237ee065c2 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -178,21 +178,6 @@ struct sysinfo;
>  struct writeback_control;
>  struct zone;
>  
> -/*
> - * A swap extent maps a range of a swapfile's PAGE_SIZE pages onto a range of
> - * disk blocks.  A rbtree of swap extents maps the entire swapfile (Where the
> - * term `swapfile' refers to either a blockdevice or an IS_REG file). Apart
> - * from setup, they're handled identically.
> - *
> - * We always assume that blocks are of size PAGE_SIZE.
> - */
> -struct swap_extent {
> -	struct rb_node rb_node;
> -	pgoff_t start_page;
> -	pgoff_t nr_pages;
> -	sector_t start_block;
> -};
> -
>  /*
>   * Max bad pages in the new format..
>   */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 26852c2ad36e..c0479533f9ef 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -260,6 +260,21 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
>  	return ret;
>  }
>  
> +/*
> + * A swap extent maps a range of a swapfile's PAGE_SIZE pages onto a range of
> + * disk blocks.  A rbtree of swap extents maps the entire swapfile (Where the
> + * term `swapfile' refers to either a blockdevice or an IS_REG file). Apart
> + * from setup, they're handled identically.
> + *
> + * We always assume that blocks are of size PAGE_SIZE.
> + */
> +struct swap_extent {
> +	struct rb_node rb_node;
> +	pgoff_t start_page;
> +	pgoff_t nr_pages;
> +	sector_t start_block;
> +};
> +
>  static inline struct swap_extent *first_se(struct swap_info_struct *sis)
>  {
>  	struct rb_node *rb = rb_first(&sis->swap_extent_root);
> -- 
> 2.53.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
