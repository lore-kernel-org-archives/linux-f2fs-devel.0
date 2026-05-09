Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4B2CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 May 2026 09:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/sTNHd0atEye6oFqGNVw/lkFAwadey2hLpLY1ZzwtXc=; b=bWxXdYA9+6Z6/R6aBIfk3lei3k
	cmxpXbJ8WZzBMH8r8QDBsAlq0gACZA7S/QpGIvP+VTGYeCxP9X0XzGb0WkK1AsBqwjQTB0jznGTQn
	GzeiZrzdoRxC8WX64m6I7yVSzSWbTxFKuCEK1raWH6rT10I1obH2C1mTFI0zEMj0H0KE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLdro-0004GZ-2X;
	Sat, 09 May 2026 09:21:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wLdrl-0004GQ-TB
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 09:20:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/2eg7lZnxGhuYi21Jald3uMYwLH9t5PXSyxMeyDyRWU=; b=NEDMeBvCejn/ZHWILTJ9UOBeV1
 kFwo7vxlCen5fL0rPzUHIuvD484W9mYYAfiLfBSsyY5n5CwWUoze0GLX/4cHy8WJ54XANdRcgy7RC
 P1N4BRB/9EXlBkATgI1CXkJkdBkfqYQ80NTBKI64JFl3dciW2unVyjktV1I8JUzqZpQ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/2eg7lZnxGhuYi21Jald3uMYwLH9t5PXSyxMeyDyRWU=; b=Kxxf1oIYShppT2pSNXbnD+526C
 e4EtY8OQJIx+bUpOsKl9eEl+uNAoe7ZI6e+HVOYy/S+cAB1f8+s97bcjk7nTr7OIRTcm/5pWWqk2L
 3mRQZOKjl5HQLOBB9rJsRxzQaKuEUwNYkHUlOuvYQkKT7MrilCULdhTGUtYmOkzwK2kY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wLdrk-0000TG-Fd for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 09:20:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 269FB43D37;
 Sat,  9 May 2026 09:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CECC2BCB2;
 Sat,  9 May 2026 09:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778318451;
 bh=krsPfKK1vqMLINxwwPErrOYJlL15v+TR0oMbAvaur00=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=q800Hx/UuGvpIZCR5OB5ox3/InofxN3NcdQ7RG4DPytymhEKFamcgggNSHTU96sRf
 idbUHyJHBKFVqpCSpdSRwk+g9Um0DAJjFAV15hdZH6VWZz25FE/dnBT1tMTZOOlYJz
 NOiWOF9BEjEoAZGJkbZWWjGft+M+rOK3t7EPF4e6mIkNCMbQtTbvwcOagZHTpRV5DT
 hXSouTLQY0g24To1RRndnT3f2gygv1yYlmXMRBImlqxbeIflos0VmYqJc341vTK77y
 dH5sbzYobrHtGNg153/yyDLPtxDgte1G/jArghD91I4H7TONQgWUNXnEgM54JlPh7U
 Nf03T3stwLxWw==
Message-ID: <3f01a4cb-349a-47b0-8282-48dbc36c1797@kernel.org>
Date: Sat, 9 May 2026 17:20:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
References: <20260508135955.2391208-1-jinbaoliu365@gmail.com>
Content-Language: en-US
In-Reply-To: <20260508135955.2391208-1-jinbaoliu365@gmail.com>
X-Headers-End: 1wLdrk-0000TG-Fd
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add iostat latency tracking for
 direct IO
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: shengyong1 <shengyong1@xiaomi.com>, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/8/26 21:59, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> F2FS did not collect iostat latency for direct IO reads and writes,
> hook iomap_dio_ops.submit_io to bind an iostat context and record the
> submission timestamp. Replace bi_end_io with f2fs_dio_end_bio() to
> collect IO latency on completion before calling back to the original
> iomap_dio_bio_end_io(), to add iostat latency tracking support for
> F2FS DIO.
> 
> Signed-off-by: shengyong1 <shengyong1@xiaomi.com>
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> ---
> v2:
> - add f2fs_dio_iostat_start() to avoid duplicated code
> and CONFIG_F2FS_IOSTAT guard
> ---
>   fs/f2fs/file.c   | 35 +++++++++++++++++++++++++++++++++++
>   fs/f2fs/iostat.c |  2 +-
>   2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 091a9db29228..d35e3cf158bf 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4790,6 +4790,30 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
>   	return true;
>   }
>   
> +#ifdef CONFIG_F2FS_IOSTAT
> +static void f2fs_dio_end_bio(struct bio *bio)
> +{
> +	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
> +	void *orig_bi_private = iostat_ctx->post_read_ctx;
> +
> +	iostat_update_and_unbind_ctx(bio);
> +	bio->bi_private = orig_bi_private;
> +	iomap_dio_bio_end_io(bio);
> +}
> +
> +static void f2fs_dio_iostat_start(struct f2fs_sb_info *sbi, struct bio *bio)
> +{
> +	void *bi_private = bio->bi_private;
> +
> +	iostat_alloc_and_bind_ctx(sbi, bio, bi_private);
> +	iostat_update_submit_ctx(bio, DATA);
> +	bio->bi_end_io = f2fs_dio_end_bio;
> +}
> +#else
> +static inline void f2fs_dio_iostat_start(struct f2fs_sb_info *sbi,
> +					 struct bio *bio) {}
> +#endif
> +
>   static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
>   				unsigned int flags)
>   {
> @@ -4802,8 +4826,18 @@ static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
>   	return 0;
>   }
>   
> +static void f2fs_dio_read_submit_io(const struct iomap_iter *iter,
> +					struct bio *bio, loff_t file_offset)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(iter->inode);
> +
> +	f2fs_dio_iostat_start(sbi, bio);
> +	blk_crypto_submit_bio(bio);
> +}
> +
>   static const struct iomap_dio_ops f2fs_iomap_dio_read_ops = {
>   	.end_io = f2fs_dio_read_end_io,
> +	.submit_io = f2fs_dio_read_submit_io,
>   };
>   
>   static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
> @@ -5082,6 +5116,7 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
>   	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
>   
>   	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
> +	f2fs_dio_iostat_start(sbi, bio);
>   	blk_crypto_submit_bio(bio);
>   }
>   
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index ae265e3e9b2c..232fdec036c1 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -254,7 +254,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>   	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
>   	unsigned long flags;
>   
> -	if (!sbi->iostat_enable)
> +	if (!sbi->iostat_enable || iostat_ctx->submit_ts == 0)

Which path we will see zeroed .submit_ts?

Thanks,

>   		return;
>   
>   	ts_diff = jiffies - iostat_ctx->submit_ts;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
