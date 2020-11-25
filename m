Return-Path: <SRS0=F/Dq=E7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC92BC56202
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2020 22:15:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55582206D9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2020 22:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JkGsGPhN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fZJL2+af";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY5RPIIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55582206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ki34G-0002Jz-Lw; Wed, 25 Nov 2020 22:15:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1ki34E-0002Jh-Uv
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Nov 2020 22:15:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9lUMIC11/zz2uEr/DoH6JbU2GShptGuMHjJqsG/QpYw=; b=JkGsGPhNbQXvkO2LBx+JOLyvvl
 9xieOOzhOrdnp/vgLS9kg96kfSFSP44ziR5piJXQ0o5+sop5vljC1umKGJmquSgq/eluZPEDybMGk
 KNo70Rsffo5JSyi09fAM5U2gcJrwGBUaAgH4mWAmUKqb98iafzUb/BWiGGQ7rcfvWdms=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9lUMIC11/zz2uEr/DoH6JbU2GShptGuMHjJqsG/QpYw=; b=fZJL2+afg5hkK2bttz3aRUIAFr
 4a4wYz83BlDsx6QWkoQpgu8Ww8/vYN8qiRyXsBO1ZSAL6dnyAIbTNDmcdUOwd5Oi7fxriJJ0Hejz9
 3Y2svzOc7Y4DpAGkg9fX2JgQEHj3AMkNutdSSF1v8ocm33Dpc7OdfIEyK4eAEk3Ax3eQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ki34B-004b33-Cn
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Nov 2020 22:15:14 +0000
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net
 [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 676AD206D9;
 Wed, 25 Nov 2020 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606342505;
 bh=//mTbDz2JjRGYIh1GwXxXW8kmqk4YvkDaY1/++XJIn0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VY5RPIIyvrFY4c/vetEDGaxUA9jOSaakmSVQw0Q1OasRAiZUBJ/F7aSPHVJNJV4i6
 t408rVBospirzyiG4A0Bz0x10gjsY8A9wASMrrtC8rHc++m/VZ5sLatmlHd/f6CjyS
 /z2CHKSoNg4dCcDvPeFPMis8mAMTCtEVPIDia/1Q=
Date: Wed, 25 Nov 2020 14:15:03 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <X77XZ/WVIuw9aCHb@sol.localdomain>
References: <20201117140708.1068688-1-satyat@google.com>
 <20201117140708.1068688-2-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201117140708.1068688-2-satyat@google.com>
X-Headers-End: 1ki34B-004b33-Cn
Subject: Re: [f2fs-dev] [PATCH v7 1/8] block: ensure bios are not split in
 middle of crypto data unit
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Nov 17, 2020 at 02:07:01PM +0000, Satya Tangirala wrote:
> @@ -275,11 +331,24 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  		bvprvp = &bvprv;
>  	}
>  
> +	/*
> +	 * The input bio's number of sectors is assumed to be aligned to
> +	 * bio_sectors_alignment. If that's the case, then this function should
> +	 * ensure that aligned_segs == nsegs and aligned_sectors == sectors if
> +	 * the bio is not going to be split.
> +	 */
> +	WARN_ON(aligned_segs != nsegs || aligned_sectors != sectors);
>  	*segs = nsegs;
>  	return NULL;
>  split:
> -	*segs = nsegs;
> -	return bio_split(bio, sectors, GFP_NOIO, bs);
> +	*segs = aligned_segs;
> +	if (WARN_ON(aligned_sectors == 0))
> +		goto err;
> +	return bio_split(bio, aligned_sectors, GFP_NOIO, bs);
> +err:
> +	bio->bi_status = BLK_STS_IOERR;
> +	bio_endio(bio);
> +	return bio;
>  }
[...]
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..de5c97ab8e5a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2161,6 +2161,9 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  	blk_queue_bounce(q, &bio);
>  	__blk_queue_split(&bio, &nr_segs);
>  
> +	if (bio->bi_status != BLK_STS_OK)
> +		goto queue_exit;
> +

Note that as soon as bio_endio() is called, the bio may be freed.

So accessing the bio after that is not correct.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
