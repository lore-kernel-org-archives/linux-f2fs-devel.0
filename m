Return-Path: <SRS0=Q+BT=UU=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A89C43613
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Jun 2019 21:15:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A77205C9;
	Fri, 21 Jun 2019 21:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="g749IbbS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="P1dDOTzy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9DfiZ1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A77205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1heQsA-0000ar-64; Fri, 21 Jun 2019 21:15:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1heQs8-0000aI-QY
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Jun 2019 21:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HtzJasL8gBS8kZ7UuL9gM+A/DUZKv8o6sZNJfXr+A0U=; b=g749IbbSrRmCqd4it1AWF4Fl3F
 Cmmnezb2kxcrYecW1oUrQtT71lfUiFtuSJpco4jXrSaCDVNTIHtv7wW0G5JN0MxylYE/qZO2mINYE
 q+PE/4usnIacTvnC2H6Ex1Y1V6dhRT+KL4kbwnhM/0uk3YXVQ/laJnYs4zfDrT3EiihU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HtzJasL8gBS8kZ7UuL9gM+A/DUZKv8o6sZNJfXr+A0U=; b=P1dDOTzyRh9hDWlkK/LLnsa6e6
 DZ4t9Yb1CwlgUU6ASfS9U4sIm3b1CdT+Uac/JR+elIHJILpCqrd0QEG9su5LE7k4A8+gpLoqWvHV4
 WMqTWxiR/Ew2aYPVqUluSAsh7XTFu0Tf7ihrQ8iyAoYBpCxo4dsYsqJcgSiBoMLKbE40=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1heQsB-007lDh-3e
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Jun 2019 21:15:04 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3077F205C9;
 Fri, 21 Jun 2019 21:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561151697;
 bh=+A5ovqJOpzLcVONMQRqVKOitIoP9VN9sjk5zTETdR4Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j9DfiZ1uUH08EceCSIPbtAHoj+1iKMIXKrynwMLsOWtqLgEvj48Zi/fotz29tZEY+
 tCYq1rAzXvfnE+5rfL6YujS5izY4ah+/Y9ndYmG1Hqs3rbscRdy5Dcw0/GVUAW7vts
 4zcql4EErO0CmjrdcxzOSjskFJq4jMSCuFI+hxms=
Date: Fri, 21 Jun 2019 14:14:55 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chandan Rajendra <chandan@linux.ibm.com>
Message-ID: <20190621211454.GC167064@gmail.com>
References: <20190616160813.24464-1-chandan@linux.ibm.com>
 <20190616160813.24464-5-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190616160813.24464-5-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1heQsB-007lDh-3e
Subject: Re: [f2fs-dev] [PATCH V3 4/7] fs/mpage.c: Integrate read callbacks
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
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org,
 linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Jun 16, 2019 at 09:38:10PM +0530, Chandan Rajendra wrote:
> This commit adds code to make do_mpage_readpage() to be "read callbacks"
> aware i.e. for files requiring decryption, do_mpage_readpage() now
> sets up the read callbacks state machine when allocating a bio and later
> starts execution of the state machine after file data is read from the
> underlying disk.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> ---
>  fs/mpage.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 436a85260394..611ad122fc92 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -30,6 +30,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/pagevec.h>
>  #include <linux/cleancache.h>
> +#include <linux/read_callbacks.h>
>  #include "internal.h"
>  
>  /*
> @@ -49,6 +50,8 @@ static void mpage_end_io(struct bio *bio)
>  	struct bio_vec *bv;
>  	struct bvec_iter_all iter_all;
>  
> +	if (read_callbacks_end_bio(bio))
> +		return;
>  	bio_for_each_segment_all(bv, bio, iter_all) {
>  		struct page *page = bv->bv_page;
>  		page_endio(page, bio_op(bio),
> @@ -309,6 +312,12 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  					gfp);
>  		if (args->bio == NULL)
>  			goto confused;
> +
> +		if (read_callbacks_setup(inode, args->bio, NULL)) {
> +			bio_put(args->bio);
> +			args->bio = NULL;
> +			goto confused;
> +		}
>  	}
>  
>  	length = first_hole << blkbits;
> @@ -330,7 +339,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  confused:
>  	if (args->bio)
>  		args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
> -	if (!PageUptodate(page))
> +	if (!PageUptodate(page) && !PageError(page))
>  		block_read_full_page(page, args->get_block);
>  	else
>  		unlock_page(page);
> -- 
> 2.19.1

Why is the !PageError() check needed here?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
