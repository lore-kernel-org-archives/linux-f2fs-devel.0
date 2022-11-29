Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC50C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Nov 2022 07:14:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ozupL-0005S1-Nr;
	Tue, 29 Nov 2022 07:14:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1ozup7-0005Rt-Ro
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Nov 2022 07:14:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uopDUAu/Fex85YsnbeGt15fUp2+Zc2WrIHFQ9Sp/QTk=; b=MKmYBo/8JOFMWtle2l0XJXkoJe
 LbGjNS5bTOqdKW4ABypMyU6I2dA93nvBAy4voOCOS6Y+YjFj/ZVqPrlj5tcFMXYsVLZ2qjYYCExKU
 Fo+WTlb1yxxs7tOcdp4N9QScx2feXXqPYORvbhqU0uAXMemf1GK22KOUb48bz4sgvwL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uopDUAu/Fex85YsnbeGt15fUp2+Zc2WrIHFQ9Sp/QTk=; b=e1EO2dGCTQfXiPc7dxGipKE/O/
 ELlZnFeFFeZeEGUOQbUPXCbARHEY4wLb8QiWEHqGSzrSsK77r88ll9W+lWGbopdtOsN19SSoZj40s
 ezO/wl52+AZQhEXngFUkH2XoHUP0qXBBzo8oWBrG9ULRhiI2JBgxIu1y6kSjMNMXlmGE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ozup7-0001JJ-3G for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Nov 2022 07:14:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A8CB3615B1;
 Tue, 29 Nov 2022 07:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A2DC433C1;
 Tue, 29 Nov 2022 07:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669706067;
 bh=us0xxwnUQweVKC2bsLBc59jamq4rwG2vuwf65B53Rfk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r3nhquNGwkJp4h1DWM5InakWl/6nwkm3jRfMDQ4lUMMThLJt5JHODtnj5i9KOeCjD
 rJ+AnZT6nsQftI8YgD9rRkyM2aLU5Xgbpwjwt15+gCXYo7kBS3B0wcVEa9PnpQIHFk
 5wyisa7hgbnwQtoYl5BhpUUwq3pOo4k/iiZOabj6x0K4LbEMpsuydNgnKblZ9FR5B3
 RocI8vGci7EUzd9I5go+yXZgt0qfnd23ZHKVtLTeYqkFbZ2sBMav/0Z4s8nFn2bSY3
 YiPXhOeHCpttvtenaGLh9U6ffjWm+vcBat7foTSoE0at5HWRe6g1ZwZnvditRm75QT
 WVe4ZGFsIFJyA==
Date: Mon, 28 Nov 2022 23:14:25 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <Y4WxUZesKJ79mI9e@sol.localdomain>
References: <20221125190642.12787-1-ebiggers@kernel.org>
 <Y4WrSeIf+E6+tL1y@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4WrSeIf+E6+tL1y@google.com>
X-Headers-End: 1ozup7-0001JJ-3G
Subject: Re: [f2fs-dev] [PATCH v4] fsverity: stop using PG_error to track
 error status
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
Cc: Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Nov 28, 2022 at 10:48:41PM -0800, Jaegeuk Kim wrote:
> >  static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
> >  {
> >  	struct bio_vec *bv;
> >  	struct bvec_iter_all iter_all;
> > +	struct bio_post_read_ctx *ctx = bio->bi_private;
> >  
> > -	/*
> > -	 * Update and unlock the bio's pagecache pages, and put the
> > -	 * decompression context for any compressed pages.
> > -	 */
> >  	bio_for_each_segment_all(bv, bio, iter_all) {
> >  		struct page *page = bv->bv_page;
> >  
> >  		if (f2fs_is_compressed_page(page)) {
> > -			if (bio->bi_status)
> > +			if (!ctx->decompression_attempted)
> 
> If seems this causes a panic due to the ctx nullified by f2fs_verify_bio.
> 

Thanks for catching that!  I've sent out v5 that checks for 'ctx &&
!ctx->decompression_attempted' here.  That's the right thing to do, since if ctx
is NULL then decompression must have been attempted.

I'd like to get rid of freeing the bio_post_read_ctx in f2fs_verify_bio().
But I believe it's still needed, at least in theory.

Do you have a suggestion for testing f2fs compression + verity with xfstests?
I missed this because compression isn't covered by the "verity" group tests.
Maybe there should be an "f2fs/compress" config in xfstests-bld that uses mkfs
and mount options that cause all files to be automatically compressed, similar
to how f2fs/encrypt automatically encrypts all files with test_dummy_encryption.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
