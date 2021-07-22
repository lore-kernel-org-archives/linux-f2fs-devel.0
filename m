Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9A5C00142
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 19:05:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E4860EBC
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 19:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5E4860EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6e0W-0005oR-Sa; Thu, 22 Jul 2021 19:05:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <djwong@kernel.org>) id 1m6e0M-0005mu-AU
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 19:05:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QH69JZ0ro/6mMHp3t6fa0UGYS8OLDRprIsAx0T8NAgY=; b=mBk3GjUFv1oYg3eh3dLHIwW4qn
 /gXfVhDJSkZDGJqp1f3hPRqxUAsXCqmCkyabgxZRJq5auARLWrArax6U2b4gZO/Y1h3Rskk1Ozq5e
 yq74oDrvBQsf33tEamUT4oIukkaHZtnMwN9rLALMYE76xQzEYVD/A5hrJUmTjB2nsq5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QH69JZ0ro/6mMHp3t6fa0UGYS8OLDRprIsAx0T8NAgY=; b=iJQGvrnG7I2gCBoEB+Ag7b6Qci
 eLsrj5crfEbCQfs15bznZOkrD0jj3qr3XqDk2E3dK67QmpzDFS4kkRAGlz0KOtRDUIUb4RmKRq3ez
 fP/IHf9TCfccK8BzoF1t1buMowlUlM01XyG4doZRKIn9LIEOsIaZhBYrV2KGGvjmtpBw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6e0B-00H7Jo-Vx
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 19:05:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9748D60EB9;
 Thu, 22 Jul 2021 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626980689;
 bh=oWDsz2mqAq9NcEEh1BJyznZQCPm+facoTqPnYlRRhJQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QilYXNDAdzMfF+frM57wtEsK8q1xBhGM/Fw6ySzsoC5LukRf2pi9r343XIPOGGjhw
 inNMRBNKyr2+WCSrrUv7uZJuoNSJm64GbfIJc7Nquu2D6EMLTWmWw7Xcm69xxwN3em
 MyoZQsSMilN6DlmympazHrgl3V3HkOqFgjlkpozftLq0ixlYnwg7iEVqAdfLcbBwTk
 ZW76MEHP/kBQ047J1PXSwSXqVmaV5PZ0ohUOezoWPe17OJPGuQKeNSN8UQV9MkpcKg
 zqijpJkmcGOjHCLVgEUIRAlnaOnsquR9/cTWbypuBNqFkKdQ78gVo4VnpOSwqM3DnS
 zmr2Bt9gIvk1A==
Date: Thu, 22 Jul 2021 12:04:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20210722190449.GH559212@magnolia>
References: <20210604210908.2105870-1-satyat@google.com>
 <20210604210908.2105870-7-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210604210908.2105870-7-satyat@google.com>
X-Headers-End: 1m6e0B-00H7Jo-Vx
Subject: Re: [f2fs-dev] [PATCH v9 6/9] iomap: support direct I/O with
 fscrypt using blk-crypto
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
 "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, linux-kernel@vger.kernel.org,
 Eric Biggers <ebiggers@google.com>, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jun 04, 2021 at 09:09:05PM +0000, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Set bio crypt contexts on bios by calling into fscrypt when required.
> No DUN contiguity checks are done - callers are expected to set up the
> iomap correctly to ensure that each bio submitted by iomap will not have
> blocks with incontiguous DUNs by calling fscrypt_limit_io_blocks()
> appropriately.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

Looks like a straightforward conversion...

Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..1c825deb36a9 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -6,6 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/compiler.h>
>  #include <linux/fs.h>
> +#include <linux/fscrypt.h>
>  #include <linux/iomap.h>
>  #include <linux/backing-dev.h>
>  #include <linux/uio.h>
> @@ -185,11 +186,14 @@ static void
>  iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  		unsigned len)
>  {
> +	struct inode *inode = file_inode(dio->iocb->ki_filp);
>  	struct page *page = ZERO_PAGE(0);
>  	int flags = REQ_SYNC | REQ_IDLE;
>  	struct bio *bio;
>  
>  	bio = bio_alloc(GFP_KERNEL, 1);
> +	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> +				  GFP_KERNEL);
>  	bio_set_dev(bio, iomap->bdev);
>  	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>  	bio->bi_private = dio;
> @@ -306,6 +310,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		}
>  
>  		bio = bio_alloc(GFP_KERNEL, nr_pages);
> +		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> +					  GFP_KERNEL);
>  		bio_set_dev(bio, iomap->bdev);
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>  		bio->bi_write_hint = dio->iocb->ki_hint;
> -- 
> 2.32.0.rc1.229.g3e70b5a671-goog
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
