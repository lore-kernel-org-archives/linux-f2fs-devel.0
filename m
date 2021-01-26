Return-Path: <SRS0=TqvU=G5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CCC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 Jan 2021 21:51:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72372064C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 Jan 2021 21:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72372064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l4WFB-0001bp-Hj; Tue, 26 Jan 2021 21:51:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1l4WFA-0001ba-1B
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Jan 2021 21:51:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PVXe/0mnYC9gBx+P4ki/TAy9pdcHveLUHCBkOxpzoLI=; b=DlB/8lOc0iUrGh9yGtKqyPelkt
 heKM75meyu58E7w8neX4ivJDmTXlD9/2kU79t79abCEklXHxkS/gJbw2sJYkZodYkaYUsEM8mQLhm
 kDwbdXnaSG5UtWm6S+TxWW9f3QJNGnHEAt0D8bT1Nbz9W7YAK2xYoZwCdQMp1dPX16zk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PVXe/0mnYC9gBx+P4ki/TAy9pdcHveLUHCBkOxpzoLI=; b=eYWM1KfJ+9FUjGWQ3iNVYDyWKe
 mUrvI9pEDttmlWCsezwJxJjeEsq8IxQhJVOtYZ5DotuCYoIIOXtDhYB4T/46SZJzA78OFZYXz5jg4
 wAy8hNBa70BDjDY222Sc95afBmgMvCwZKDYwumcpAv4s8QGiVlUPu0ugxJWnOTeyM1aQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1l4WF3-008FDm-2h
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Jan 2021 21:51:23 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0E7A20449;
 Tue, 26 Jan 2021 21:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611697866;
 bh=uF4Zh493+gdGT/Bg0kWKqJydeGxsHWjFoA7xBs16rsw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lCGLIreDb/5Hwx8N2JmnAiiS0jiqRFkx5lWB+dYgajzTx5WDO2x1R1zbHYLyQO1UE
 98ScSw7v1shjHJr3DWN8DeVEKxjccGxz8l94yiaaEhvMgOjW92D6rHh7wIPb+Z8Wcf
 /WrH9o9CZLj9VLpBgdfMlPa9On6Ygs1IpZ1Ijf2DQsb5xhrrGFiJVmYaEU6R3mgkut
 QaKR1+XYY5LF7MORkDaq36e+R/ZWRbwey+gnJIfZYHPT0K+eh+0B9d6nRjRnNDd/S0
 dIZkNMAj/KUbyyLBEMzujKws37eYXRnxT13Nwk2S64RN7RIaBpTrze3+70kHOv4aD1
 nwTbNcB4SZj3w==
Date: Tue, 26 Jan 2021 13:51:04 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <YBCOyBxDnSsT4jzU@sol.localdomain>
References: <20210126145247.1964410-1-hch@lst.de>
 <20210126145247.1964410-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210126145247.1964410-4-hch@lst.de>
X-Headers-End: 1l4WF3-008FDm-2h
Subject: Re: [f2fs-dev] [PATCH 03/17] blk-crypto: use bio_kmalloc in
 blk_crypto_clone_bio
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
Cc: Mike Snitzer <snitzer@redhat.com>, linux-mm@kvack.org, dm-devel@redhat.com,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-nilfs@vger.kernel.org,
 Damien Le Moal <damien.lemoal@wdc.com>, Josef Bacik <josef@toxicpanda.com>,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Lars Ellenberg <lars.ellenberg@linbit.com>,
 drbd-dev@tron.linbit.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 Coly Li <colyli@suse.de>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nfs@vger.kernel.org, Song Liu <song@kernel.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jan 26, 2021 at 03:52:33PM +0100, Christoph Hellwig wrote:
> Use bio_kmalloc instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-crypto-fallback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 50c225398e4d60..e8327c50d7c9f4 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -164,7 +164,7 @@ static struct bio *blk_crypto_clone_bio(struct bio *bio_src)
>  	struct bio_vec bv;
>  	struct bio *bio;
>  
> -	bio = bio_alloc_bioset(GFP_NOIO, bio_segments(bio_src), NULL);
> +	bio = bio_kmalloc(GFP_NOIO, bio_segments(bio_src));
>  	if (!bio)
>  		return NULL;
>  	bio->bi_bdev		= bio_src->bi_bdev;
> -- 

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
