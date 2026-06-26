Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E9DCDE010
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g5KHKJ4H8SLsHDaJnmjtokz/BXVJWPGaXBdGG2N6SWg=; b=RxlfChfU3NCyl66mp8WFrHv6oW
	jjTYT8Id8Y1nI6291lZOrBIQOA3BGRaAeth4LLv/yleELLHJYYg37RHnYh6NqBWiHtWNLMG3MH5sd
	nj5O99apakfROQZ6XpJ1mKiFWWREXgBb2T0x8WEXQWRCx62dsKC5pvcVW9uf5zNilFxo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wczAu-0002R4-Ln;
	Fri, 26 Jun 2026 05:32:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wczAu-0002Qy-3I
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 05:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e0uct1L3IgAtqbOcFCvfL9SMtjjUEZsQND8tvgvJ9a0=; b=MUEktW0jMlBuHWQgrBaLUE2RWk
 EE45wj/mG0LKqiMHv9gUC+kGT5qkpL+SFwThiR1xs0horMNfdpjjBBgN8662BA39+YLRVcHi5qGsB
 Yd+c0BiT4qHbyoKxUMUrmdoC5Li7wsD94nNTMxwvXlDw/wTmbwbY1bUZP7dF+WByRAYg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=e0uct1L3IgAtqbOcFCvfL9SMtjjUEZsQND8tvgvJ9a0=; b=FGp5qigrixR98DSEznt+dTFwAD
 5dIgAzNgbc0N/g6w5/aYXbAB8xgUZdwCHbviiMqE9YMQOa2UMiFK7KTta0Hr+oQDxXffqJXUpT6ZO
 TRB1sKFvewQbQXrXJtbRWL82fyf6hCMheCeYcGC6EStUuf/bCbNMVxMlp+MbH6s8EGws=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wczAr-0001Gh-US for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 05:32:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7065F68B05; Fri, 26 Jun 2026 07:32:08 +0200 (CEST)
Date: Fri, 26 Jun 2026 07:32:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260626053207.GN9043@lst.de>
References: <20260624050334.124606-1-ebiggers@kernel.org>
 <20260624050334.124606-16-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260624050334.124606-16-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wczAr-0001Gh-US
Subject: Re: [f2fs-dev] [PATCH 15/16] fscrypt: Merge bio.c and
 inline_crypt.c into block.c
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 23, 2026 at 10:03:33PM -0700, Eric Biggers wrote:
> Now that fscrypt always uses blk-crypto on block-based filesystems,
> there's no meaningful difference between bio.c and inline_crypt.c.
> Therefore merge the two files into one named block.c.
> 
> Note: I didn't carry over bio.c's "Copyright (C) 2015, Motorola
> Mobility", as none of the code that applied to remained.

Yeah the current from of the code is almost entirely mine,
with some slight traces of your earlier version.

> +struct fscrypt_zero_done {
> +	atomic_t		pending;
> +	blk_status_t		status;
> +	struct completion	done;
> +};
> +
> +static void fscrypt_zeroout_range_done(struct fscrypt_zero_done *done)
> +{
> +	if (atomic_dec_and_test(&done->pending))
> +		complete(&done->done);
> +}
> +
> +static void fscrypt_zeroout_range_end_io(struct bio *bio)
> +{
> +	struct fscrypt_zero_done *done = bio->bi_private;
> +
> +	if (bio->bi_status)
> +		cmpxchg(&done->status, 0, bio->bi_status);
> +	fscrypt_zeroout_range_done(done);
> +	bio_put(bio);
> +}
> +
> +/**
> + * fscrypt_zeroout_range() - zero out a range of blocks in an encrypted file
> + * @inode: the file's inode
> + * @pos: the first file position (in bytes) to zero out
> + * @sector: the first sector to zero out
> + * @len: bytes to zero out
> + *
> + * Zero out filesystem blocks in an encrypted regular file on-disk, i.e. write
> + * ciphertext blocks which decrypt to the all-zeroes block.  The blocks must be
> + * both logically and physically contiguous.  It's also assumed that the
> + * filesystem only uses a single block device, ->s_bdev.  @len must be a
> + * multiple of the file system logical block size.
> + *
> + * Note that since each block uses a different IV, this involves writing a
> + * different ciphertext to each block; we can't simply reuse the same one.
> + *
> + * Return: 0 on success; -errno on failure.
> + */
> +int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
> +			  sector_t sector, u64 len)

.. but I wonder if we should rename this and move it to libfs, as it
works just fine without encyption and file systems could call it
for the non-fscrypt case and consolidate on a single implementation.

But maybe some other time, no need to complicate this series.

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
