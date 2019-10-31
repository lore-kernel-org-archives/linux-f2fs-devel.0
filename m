Return-Path: <SRS0=XOwI=YY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57975CA9ECB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Oct 2019 18:16:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F3F216F4;
	Thu, 31 Oct 2019 18:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="c7o6tBLw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ZsOr2Yd+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EBzOdjKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F3F216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iQEze-0003fc-Kh; Thu, 31 Oct 2019 18:16:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+4fa4615b85c97fbb822c+5912+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1iQEzd-0003fS-TC
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Oct 2019 18:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=17ny2tyYchuJcZntPepC2H7DRLPjDMpL4NN+oqkqSow=; b=c7o6tBLwdxpg0dt72etrav8Iba
 FyBmxF5OaDA4cDNBk8AgaXpZo0lN8kx5io+zpV5t/9Llcbe7tNaJuxECsXZumilCykaHk9aHUgjtC
 TvEj/vYHbCZxKV6AsALO8lu5pi9YY2aPNiWXYn/1ZbMixCHESMX18i+Il4ZGYPVSSoCs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=17ny2tyYchuJcZntPepC2H7DRLPjDMpL4NN+oqkqSow=; b=ZsOr2Yd+Ldu0wsd2Ury6vIFyNc
 82hOOA1ncqE3kjXOsrOYy0hI+biNkIZP2QpA2q4JdAeTJXWUANidCniJY8GbIttRB4P17TDN+j+Wa
 zSxFQzhQHXQ8bMlwOASgrGDGnnt3LQApO7YNB+KLzZf6hC5bbtrNO+TITGXPwWSh12zA=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iQEzc-00CoyZ-C5
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Oct 2019 18:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=17ny2tyYchuJcZntPepC2H7DRLPjDMpL4NN+oqkqSow=; b=EBzOdjKJXHWIkOTWFGwr92r+5
 0oG5g6sFqfUFUORDYSobteMoX8yA7NquOFErl5Jbz48+hIfWxcIUd2t2rdIZi79XuvjBBJ5u0JR5Y
 1F55Lv6918LQWZoZNR0zcsCTYbcDkUJVBfxYGHHyap6eigddijJxdEyEJvoQqxC+3jdOkv7IN+Tiz
 /QJ+TO5k0wyIxrT7zBPR8NnxUbpBYPSLan8jovTam+iF8BawhDJe8Pil4dHgM7+JZL19l8rxuJCL0
 gGiMvL4q+csvDWn1upZy/WdDiVB7gvPUgBphrTTpgS6GJigFEPhaoVk6oTAWNhk2EDUBX8lqdpV/u
 Rdo2k2J2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iQEzV-00005I-Jz; Thu, 31 Oct 2019 18:16:13 +0000
Date: Thu, 31 Oct 2019 11:16:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20191031181613.GC23601@infradead.org>
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-3-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191028072032.6911-3-satyat@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1iQEzc-00CoyZ-C5
Subject: Re: [f2fs-dev] [PATCH v5 2/9] block: Add encryption context to
 struct bio
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> +static int num_prealloc_crypt_ctxs = 128;

Where does that magic number come from?

> +struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask)
> +{
> +	return mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
> +}
> +EXPORT_SYMBOL(bio_crypt_alloc_ctx);

This isn't used by an modular code.

> +void bio_crypt_free_ctx(struct bio *bio)
> +{
> +	mempool_free(bio->bi_crypt_context, bio_crypt_ctx_pool);
> +	bio->bi_crypt_context = NULL;
> +}
> +EXPORT_SYMBOL(bio_crypt_free_ctx);

This one is called from modular code, but I think the usage in DM
is bogus, as the caller of the function eventually does a bio_put,
which ends up in bio_free and takes care of the freeing as well.

> +bool bio_crypt_should_process(struct bio *bio, struct request_queue *q)
> +{
> +	if (!bio_has_crypt_ctx(bio))
> +		return false;
> +
> +	WARN_ON(!bio_crypt_has_keyslot(bio));
> +	return q->ksm == bio->bi_crypt_context->processing_ksm;
> +}

Passing a struct request here and also adding the ->bio != NULL check
here would simplify the only caller in ufs a bit.

> +/*
> + * Checks that two bio crypt contexts are compatible - i.e. that
> + * they are mergeable except for data_unit_num continuity.
> + */
> +bool bio_crypt_ctx_compatible(struct bio *b_1, struct bio *b_2)
> +{
> +	struct bio_crypt_ctx *bc1 = b_1->bi_crypt_context;
> +	struct bio_crypt_ctx *bc2 = b_2->bi_crypt_context;
> +
> +	if (bio_has_crypt_ctx(b_1) != bio_has_crypt_ctx(b_2))
> +		return false;
> +
> +	if (!bio_has_crypt_ctx(b_1))
> +		return true;
> +
> +	return bc1->keyslot == bc2->keyslot &&
> +	       bc1->data_unit_size_bits == bc2->data_unit_size_bits;
> +}

I think we'd normally call this bio_crypt_ctx_mergeable.

> +	if (bio_crypt_clone(b, bio, gfp_mask) < 0) {
> +		bio_put(b);
> +		return NULL;
> +	}
>  
> -		if (ret < 0) {
> -			bio_put(b);
> -			return NULL;
> -		}
> +	if (bio_integrity(bio) &&
> +	    bio_integrity_clone(b, bio, gfp_mask) < 0) {
> +		bio_put(b);
> +		return NULL;

Pleae use a goto to merge the common error handling path

> +		if (!bio_crypt_ctx_back_mergeable(req->bio,
> +						  blk_rq_sectors(req),
> +						  next->bio)) {
> +			return ELEVATOR_NO_MERGE;
> +		}

No neef for the braces.  And pretty weird alignment, normal Linux style
would be:

		if (!bio_crypt_ctx_back_mergeable(req->bio,
				blk_rq_sectors(req), next->bio))
			return ELEVATOR_NO_MERGE;

> +		if (!bio_crypt_ctx_back_mergeable(rq->bio,
> +						  blk_rq_sectors(rq), bio)) {
> +			return ELEVATOR_NO_MERGE;
> +		}
>  		return ELEVATOR_BACK_MERGE;
> -	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
> +	} else if (blk_rq_pos(rq) - bio_sectors(bio) ==
> +		   bio->bi_iter.bi_sector) {
> +		if (!bio_crypt_ctx_back_mergeable(bio,
> +						  bio_sectors(bio), rq->bio)) {
> +			return ELEVATOR_NO_MERGE;
> +		}

Same for these two.

> +++ b/block/bounce.c
> @@ -267,14 +267,15 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
>  		break;
>  	}
>  
> -	if (bio_integrity(bio_src)) {
> -		int ret;
> +	if (bio_crypt_clone(bio, bio_src, gfp_mask) < 0) {
> +		bio_put(bio);
> +		return NULL;
> +	}
>  
> -		ret = bio_integrity_clone(bio, bio_src, gfp_mask);
> -		if (ret < 0) {
> -			bio_put(bio);
> -			return NULL;
> -		}
> +	if (bio_integrity(bio_src) &&
> +	    bio_integrity_clone(bio, bio_src, gfp_mask) < 0) {
> +		bio_put(bio);
> +		return NULL;

Use a common error path with a goto, please.

> +static inline int bio_crypt_set_ctx(struct bio *bio,
> +				    const u8 *raw_key,
> +				    enum blk_crypto_mode_num crypto_mode,
> +				    u64 dun,
> +				    unsigned int dun_bits,
> +				    gfp_t gfp_mask)

Pleae just open code this in the only caller.

> +{
> +	struct bio_crypt_ctx *crypt_ctx;
> +
> +	crypt_ctx = bio_crypt_alloc_ctx(gfp_mask);
> +	if (!crypt_ctx)
> +		return -ENOMEM;

Also bio_crypt_alloc_ctx with a waiting mask will never return an
error.  Changing this function and its call chain to void returns will
clean up a lot of code in this series.

> +static inline void bio_set_data_unit_num(struct bio *bio, u64 dun)
> +{
> +	bio->bi_crypt_context->data_unit_num = dun;
> +}

This function is never used and can be removed.

> +static inline void bio_crypt_set_keyslot(struct bio *bio,
> +					 unsigned int keyslot,
> +					 struct keyslot_manager *ksm)
> +{
> +	bio->bi_crypt_context->keyslot = keyslot;
> +	bio->bi_crypt_context->processing_ksm = ksm;
> +}

Just adding these two lines to the only caller will be a lot cleaner.

> +static inline const u8 *bio_crypt_raw_key(struct bio *bio)
> +{
> +	return bio->bi_crypt_context->raw_key;
> +}

Can be inlined into the only caller.

> +
> +static inline enum blk_crypto_mode_num bio_crypto_mode(struct bio *bio)
> +{
> +	return bio->bi_crypt_context->crypto_mode;
> +}

Same here.

> +static inline u64 bio_crypt_sw_data_unit_num(struct bio *bio)
> +{
> +	return bio->bi_crypt_context->sw_data_unit_num;
> +}

Same here.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
