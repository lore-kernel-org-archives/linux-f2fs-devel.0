Return-Path: <SRS0=MQND=5M=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBE8C43331
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:05:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5A1206F2;
	Fri, 27 Mar 2020 17:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="WqWS3Uje";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="XzoW6KQ8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tJHUKbZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5A1206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jHsQV-00070i-21; Fri, 27 Mar 2020 17:05:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+db0fc927f0092e366218+6060+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jHsQU-00070b-3f
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Mar 2020 17:05:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nQwtzNXpf86itTjaB1edkzN5h3XvovjaCziQk9DtCjM=; b=WqWS3UjeNxg72eg6eUcnQOQ0zn
 gUdTmcOjThqIrRwz+B6TV+GExdwQPi44WtbM7EjWBs0PnvkVkT6MMezYTQ9Fn8RTBHyf43myhuNSF
 4+k4c8sh2nM6BXBi3mf4RfeCVehJCucO3gGdZWyVEvO6tBFy4jBxMQilLltQxT0DywuA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nQwtzNXpf86itTjaB1edkzN5h3XvovjaCziQk9DtCjM=; b=XzoW6KQ8uMWdzYWmP+HmFEx6vi
 /nGs0tNHt9SthxwFVBASywObcKwU2Tp7tjCJiuX4ef8a5p55gkdpl0b98iRLcO5cGxiz9qgiiUd43
 lEwy0aWge9lvLvdbLFN9mspDW1ESF1aINg30sLnlnwUBt3j2XhOsCoJohgxfDZ1/gl3M=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jHsQQ-00AKSW-GJ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Mar 2020 17:05:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nQwtzNXpf86itTjaB1edkzN5h3XvovjaCziQk9DtCjM=; b=tJHUKbZBjsey04PmV3H0dCje7e
 bYKkkq6017QpkZgT1ElJKViJOrTCd7UCVOEZRVRF6tPwwlnll/gKoVxqCy/1XMb/AHQaUrLBj/NC3
 tBw4POPUFD3N/CFouNP73J5J5wYWrOGmz+YqLJ3hKO5+/AhYSOTmdJvvjogLQxzbSLqpgAoASBzgI
 QqiQJeYh+w/7R4WbwSgVu5ZYKTZyajcVh058adQbz/pv1GRD16BS0VUde8wkrh3+gCs0MZljoIzIM
 GJQRxIF3ZihKK2bgZ2ln/osQrAbO/suKfl6oWss51RtXITpHhUsGodIPRNRreKE0Y8uC8VX9l0j3a
 LhqGwHBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jHsQI-0002G0-5a; Fri, 27 Mar 2020 17:05:34 +0000
Date: Fri, 27 Mar 2020 10:05:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20200327170534.GB24682@infradead.org>
References: <20200326030702.223233-1-satyat@google.com>
 <20200326030702.223233-3-satyat@google.com>
 <20200326200511.GA186343@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200326200511.GA186343@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1jHsQQ-00AKSW-GJ
Subject: Re: [f2fs-dev] [PATCH v9 02/11] block: Inline encryption support
 for blk-mq
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
Cc: linux-ext4@vger.kernel.org, linux-scsi@vger.kernel.org,
 Kim Boojin <boojin.kim@samsung.com>, Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 26, 2020 at 01:05:11PM -0700, Eric Biggers wrote:
> > +{
> > +	int i = 0;
> > +	unsigned int inc = bytes >> bc->bc_key->data_unit_size_bits;
> > +
> > +	while (i < BLK_CRYPTO_DUN_ARRAY_SIZE) {
> > +		if (bc->bc_dun[i] + inc != next_dun[i])
> > +			return false;
> > +		/*
> > +		 * If addition of inc to the current entry caused an overflow,
> > +		 * then we have to carry "1" for the next entry - so inc
> > +		 * needs to be "1" for the next loop iteration). Otherwise,
> > +		 * we need inc to be 0 for the next loop iteration. Since
> > +		 * overflow can be determined by (bc->bc_dun[i] + inc)  < inc
> > +		 * we can do the following.
> > +		 */
> > +		inc = ((bc->bc_dun[i] + inc)  < inc);
> > +		i++;
> > +	}
> 
> This comment is verbose but doesn't really explain what's going on.
> I think it would be much more useful to add comments like:

Also the code is still weird.  Odd double whitespaces, expression that
evaluate to bool.

> 
> 		/*
> 		 * If the addition in this limb overflowed, then the carry bit
> 		 * into the next limb is 1.  Else the carry bit is 0.
> 		 */
> 		inc = ((bc->bc_dun[i] + inc)  < inc);

		if (bc->bc_dun[i] + carry < carry)
			carry = 1;
		else
			carry = 0;

> 
> > +blk_status_t __blk_crypto_init_request(struct request *rq,
> > +				       const struct blk_crypto_key *key)
> > +{
> > +	return blk_ksm_get_slot_for_key(rq->q->ksm, key, &rq->crypt_keyslot);
> > +}
> 
> The comment of this function seems outdated.  All it does it get a keyslot, but
> the comment talks about initializing "crypto fields" (plural).

This is a classic case where I think the top of the function comment
is entirely useless. If there is a single caller in core code and the
function is completely trivial, there really is no point in a multi-line
comment.  Comment should explain something unexpected or non-trivial,
while much of the comments in this series are just boilerplate making
the code harder to read.

> >  	blk_queue_bounce(q, &bio);
> >  	__blk_queue_split(q, &bio, &nr_segs);
> > @@ -2002,6 +2006,14 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
> >  
> >  	cookie = request_to_qc_t(data.hctx, rq);
> >  
> > +	ret = blk_crypto_init_request(rq, bio_crypt_key(bio));
> > +	if (ret != BLK_STS_OK) {
> > +		bio->bi_status = ret;
> > +		bio_endio(bio);
> > +		blk_mq_free_request(rq);
> > +		return BLK_QC_T_NONE;
> > +	}
> > +
> >  	blk_mq_bio_to_request(rq, bio, nr_segs);
> 
> Wouldn't it make a lot more sense to do blk_crypto_init_request() after
> blk_mq_bio_to_request() rather than before?
> 
> I.e., initialize request::crypt_ctx first, *then* get the keyslot.  Not the
> other way around.
> 
> That would allow removing the second argument to blk_crypto_init_request() and
> removing bio_crypt_key().  blk_crypto_init_request() would only need to take in
> the struct request.

And we can fail just the request on an error, so yes this doesn't
seem too bad.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
