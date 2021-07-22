Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E4EC6377B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 00:46:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F38361249
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 00:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F38361249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6MrJ-0000xY-Lo; Thu, 22 Jul 2021 00:46:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ebiggers@kernel.org>) id 1m6MrH-0000xP-FN
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 00:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fOuV3guMlvcwaVi2a2fsRlvvBBXTJx/o8dumkocpy44=; b=X+aZTDWVSuxqr6UWL2pWGBarIu
 ilpZzqErBbO7yWMY1btDu8OPOEFb5CPNhGl65IDpnW3Cs42A8qlVENmduF7ziLkmVgaMY9hjgAHUS
 UnBj3r4BvLs8wQ0HLuJgml47dycilPEodjA6MOEwHJGUF0OQsh79WNDFG3T/328sGll8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fOuV3guMlvcwaVi2a2fsRlvvBBXTJx/o8dumkocpy44=; b=KOWgnAujVdCTROQo6a3GaslPcj
 +/vgwA2i+waftfg8R4exycbTu0Tnq1lddHfU+sQSRmUBVxmnUQ0YJ3dkGzysWXoZOBMi0kImycM2R
 WAo7VBK5X5PmOtGXt9cWyXpbOlACGIJWCBzXjwUJklAvzh2TqD9MWC/0sfXljV3MqtSg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6MrG-0006Bf-7O
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 00:46:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5B3161249;
 Thu, 22 Jul 2021 00:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626914787;
 bh=mz+LGLYopDu3grjmRh1FTALJXKcS5wBE1910DCuddj0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qzsxEazLzBmEZ437kjht81tKYqZt/WeJh3+pXlm50qFk6gmVtVXBzuOEhN5P05tfM
 DzUGaqHxo5lS7zxHBOHFy5bnqtnzSZibKXI6NEwnWXDr8Ylsv+V5j+n7GEnqubPMtA
 mEKB5ZxjFQV5OJAJQxWf3oOTHOlKKq6aVkkczCWdFGn/vit/6EMtTbnfwddL8d0htB
 ZhEe3rE/RvYu74hnj6wUf9U76pJCglMFC2CIf7CtM5bMpJ71/Vkjl5Mzt34q9uW+Qp
 KhOQXb82I5SjUkJoHEVgBz8sFjJoc6Q4hjl/gI4nmUIFeay3BX0dkocLyPyihr5v9R
 D9g0UDm3lM5ow==
Date: Wed, 21 Jul 2021 17:46:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YPi/4kMUAhlRZV3M@sol.localdomain>
References: <20210719084548.25895-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210719084548.25895-1-chao@kernel.org>
X-Headers-End: 1m6MrG-0006Bf-7O
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix wrong inflight page stats for
 directIO
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jul 19, 2021 at 04:45:48PM +0800, Chao Yu wrote:
> Previously, we use sbi->nr_pages[] to account direct IO, the count should
> be based on page granularity rather than bio granularity, fix it.
> 
> Fixes: 02b16d0a34a1 ("f2fs: add to account direct IO")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - There is one missing line when I reorder in development patches,
> so just resend the patch as v2, sorry.
>  fs/f2fs/data.c | 11 +++++++----
>  fs/f2fs/f2fs.h | 13 +++++++++++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index e6f107de4c92..095350ccf80d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3494,8 +3494,9 @@ static void f2fs_dio_end_io(struct bio *bio)
>  {
>  	struct f2fs_private_dio *dio = bio->bi_private;
>  
> -	dec_page_count(F2FS_I_SB(dio->inode),
> -			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> +	dec_page_counts(F2FS_I_SB(dio->inode),
> +			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ,
> +			dio->blkcnt);
>  
>  	bio->bi_private = dio->orig_private;
>  	bio->bi_end_io = dio->orig_end_io;
> @@ -3510,6 +3511,7 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
>  {
>  	struct f2fs_private_dio *dio;
>  	bool write = (bio_op(bio) == REQ_OP_WRITE);
> +	unsigned int blkcnt = bio_sectors(bio) >> F2FS_LOG_SECTORS_PER_BLOCK;
>  
>  	dio = f2fs_kzalloc(F2FS_I_SB(inode),
>  			sizeof(struct f2fs_private_dio), GFP_NOFS);
> @@ -3519,13 +3521,14 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
>  	dio->inode = inode;
>  	dio->orig_end_io = bio->bi_end_io;
>  	dio->orig_private = bio->bi_private;
> +	dio->blkcnt = blkcnt;
>  	dio->write = write;
>  
>  	bio->bi_end_io = f2fs_dio_end_io;
>  	bio->bi_private = dio;
>  
> -	inc_page_count(F2FS_I_SB(inode),
> -			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> +	inc_page_counts(F2FS_I_SB(inode),
> +			write ? F2FS_DIO_WRITE : F2FS_DIO_READ, dio->blkcnt);
>  
>  	submit_bio(bio);
>  	return;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 867f2c5d9559..7369f8087f64 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1759,6 +1759,7 @@ struct f2fs_private_dio {
>  	struct inode *inode;
>  	void *orig_private;
>  	bio_end_io_t *orig_end_io;
> +	unsigned int blkcnt;
>  	bool write;
>  };
>  
> @@ -2267,6 +2268,12 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
>  		set_sbi_flag(sbi, SBI_IS_DIRTY);
>  }
>  
> +static inline void inc_page_counts(struct f2fs_sb_info *sbi, int count_type,
> +							unsigned int count)
> +{
> +	atomic_add(count, &sbi->nr_pages[count_type]);
> +}
> +
>  static inline void inode_inc_dirty_pages(struct inode *inode)
>  {
>  	atomic_inc(&F2FS_I(inode)->dirty_pages);
> @@ -2281,6 +2288,12 @@ static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
>  	atomic_dec(&sbi->nr_pages[count_type]);
>  }
>  
> +static inline void dec_page_counts(struct f2fs_sb_info *sbi, int count_type,
> +							unsigned int count)
> +{
> +	atomic_sub(count, &sbi->nr_pages[count_type]);
> +}
> +

Please give these proper names like add_to_page_count() and
sub_from_page_count().  They change one counter, not multiple.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
