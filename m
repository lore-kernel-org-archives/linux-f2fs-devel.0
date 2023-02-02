Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4F2C61DA4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Feb 2023 21:35:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pNhEi-0002VZ-KV;
	Thu, 02 Feb 2023 21:35:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pNhEh-0002VS-3Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Feb 2023 21:35:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rAx8PO7PIRZJNpOOUMyZipfQL7paYwPbNp2Sx4SBQKc=; b=OypRi2BsQocf76T6CEs0hK3ll4
 xrbtGkvhyu/YwEzY4JXOzD4k9kZvuZrmbgvNjnP8E5H318LA4cMGsQE8+B5RGQRGZXUriY5hIN6nz
 fI9t4uU8Vp68u4Gl+5bW8bHErdn6VoE52AK8HhtTKUO7+FTI6oQmKf0qDFMyg4O42Eac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rAx8PO7PIRZJNpOOUMyZipfQL7paYwPbNp2Sx4SBQKc=; b=F57ywG4ehjBMohD4AFQI6T2SVb
 IDJPfTmCFJ07gAsywBizdIdKX4YSNroEzke0npyuyHKk0A9VkHofJzbMtW7kS3Em7+rqbQYa7FqBi
 0DuvygvU61B9n5bBFk9Fb/RwbSIdrfB5Qbs+AzXis/dsGBuWN72ev5sOAanFVi7SJuPc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pNhEZ-0004RC-Iu for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Feb 2023 21:35:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EFC6761B72;
 Thu,  2 Feb 2023 21:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40A6C433A7;
 Thu,  2 Feb 2023 21:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675373702;
 bh=uJDn851yK+BrevF94iZ7LAZiRgm42e9IzrvdJtjGikQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MxxNvIwjB7l7rnX6Xl06YsNMT4w75RmKbnwVG19qoI55+/vxiR4mrzw6gEBwa43+i
 yQe3x+b7s0Lq0IyMRk9D/1RmSqWNWvWfQL8kIK26vOKI74kYQq9vUm8pzU4LxvQGLG
 zbsK2vKIchyCJJXVC8IMHrEzw23DvJC1Xrx569SYPGTzwb/+flam1Jv9dvsPRfukVw
 5YIKU3EjN0jqzn0y9s/pNtENz8dGNNV/Km9o6FTFJamrnKegMmAZ1utnu3/uIwEiDj
 /VLrfeBzXhU4wGJ3Mft7CubCoe3M5Dku2BK9v8m1613A0soD0PqeaAf6alDdstYA0Z
 lf1DPsTNFrBVA==
Date: Thu, 2 Feb 2023 13:35:00 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Message-ID: <Y9wshEwTfCAwEb/4@google.com>
References: <20230201104703.31008-1-frank.li@vivo.com>
 <20230201104703.31008-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230201104703.31008-2-frank.li@vivo.com>
X-Headers-End: 1pNhEZ-0004RC-Iu
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: clean up parameters of
 iostat_update_and_unbind_ctx()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I combined two patches into one w/ Chao's reviewed-by.
Let me know if you have other concern.

On 02/01, Yangtao Li wrote:
> From: Chao Yu <chao@kernel.org>
> 
> Parsing sync/rw type from bio inside iostat_update_and_unbind_ctx()
> to avoid unnecessary parameters.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> [Yangtao: remove lat_type check]
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> change:
> -remove lat_type check
>  fs/f2fs/data.c   |  4 ++--
>  fs/f2fs/iostat.c | 19 ++++++++++---------
>  fs/f2fs/iostat.h |  4 ++--
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 86fc28adc970..82e326c0e11d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -292,7 +292,7 @@ static void f2fs_read_end_io(struct bio *bio)
>  	struct bio_post_read_ctx *ctx;
>  	bool intask = in_task();
>  
> -	iostat_update_and_unbind_ctx(bio, READ_IO);
> +	iostat_update_and_unbind_ctx(bio);
>  	ctx = bio->bi_private;
>  
>  	if (time_to_inject(sbi, FAULT_READ_IO))
> @@ -330,7 +330,7 @@ static void f2fs_write_end_io(struct bio *bio)
>  	struct bio_vec *bvec;
>  	struct bvec_iter_all iter_all;
>  
> -	iostat_update_and_unbind_ctx(bio, bio->bi_opf & REQ_SYNC ? WRITE_SYNC_IO : WRITE_ASYNC_IO);
> +	iostat_update_and_unbind_ctx(bio);
>  	sbi = bio->bi_private;
>  
>  	if (time_to_inject(sbi, FAULT_WRITE_IO))
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index c767a2e7d5a9..3d5bfb1ad585 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -228,11 +228,6 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>  		return;
>  	}
>  
> -	if (lat_type >= MAX_IO_TYPE) {
> -		f2fs_warn(sbi, "%s: %d over MAX_IO_TYPE", __func__, lat_type);
> -		return;
> -	}
> -
>  	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>  	io_lat->sum_lat[lat_type][page_type] += ts_diff;
>  	io_lat->bio_cnt[lat_type][page_type]++;
> @@ -241,14 +236,20 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>  	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
>  }
>  
> -void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type lat_type)
> +void iostat_update_and_unbind_ctx(struct bio *bio)
>  {
>  	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
> +	enum iostat_lat_type lat_type;
>  
> -	if (lat_type == READ_IO)
> -		bio->bi_private = iostat_ctx->post_read_ctx;
> -	else
> +	if (op_is_write(bio_op(bio))) {
> +		lat_type = bio->bi_opf & REQ_SYNC ?
> +				WRITE_SYNC_IO : WRITE_ASYNC_IO;
>  		bio->bi_private = iostat_ctx->sbi;
> +	} else {
> +		lat_type = READ_IO;
> +		bio->bi_private = iostat_ctx->post_read_ctx;
> +	}
> +
>  	__update_iostat_latency(iostat_ctx, lat_type);
>  	mempool_free(iostat_ctx, bio_iostat_ctx_pool);
>  }
> diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
> index 1f827a2fe6b2..eb99d05cf272 100644
> --- a/fs/f2fs/iostat.h
> +++ b/fs/f2fs/iostat.h
> @@ -58,7 +58,7 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
>  	return iostat_ctx->post_read_ctx;
>  }
>  
> -extern void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type);
> +extern void iostat_update_and_unbind_ctx(struct bio *bio);
>  extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
>  		struct bio *bio, struct bio_post_read_ctx *ctx);
>  extern int f2fs_init_iostat_processing(void);
> @@ -68,7 +68,7 @@ extern void f2fs_destroy_iostat(struct f2fs_sb_info *sbi);
>  #else
>  static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
>  		enum iostat_type type, unsigned long long io_bytes) {}
> -static inline void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type) {}
> +static inline void iostat_update_and_unbind_ctx(struct bio *bio) {}
>  static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
>  		struct bio *bio, struct bio_post_read_ctx *ctx) {}
>  static inline void iostat_update_submit_ctx(struct bio *bio,
> -- 
> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
