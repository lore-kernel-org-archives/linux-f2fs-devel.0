Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC1AC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CX/AQcNUTAbJqlI/UMUVE6oILa+okK7y6zAwYaTSWkk=; b=YEYBoDnN8xP/djNCyULPG9Fws7
	U7PIhMz2JKvK4EXhcgL06FPfYjmimP9/84uV2ObjZ0U2R7x15UtG8G7VAkdWJQK4ruaNb4YOkOUf2
	Oh0dYlfGUu7xmEUaxZ+R1U4vXNmw5+yvm3MUkf5GelAVbAbHN9o0P620VKtBGRXZyx94=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1we10d-0005uH-7q;
	Mon, 29 Jun 2026 01:42:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1we10c-0005uB-2y
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 01:41:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aFDWzvV8jidVwY1lr9cy5rVyVZdNqwropTAthMChb5M=; b=hB/yqPUxGz+CeSws8y/yzyCrj3
 xnhALyeWXgrdCKwbArX5a/54gH6T9KxyRTjpW2U0g42udXIz1ogj4yyVXOUOSU1Bdrv7yRlRKZs9/
 48V/qSKueRkjwtaA0Sn2suNFT8aMY5eXzzqVjbUbYqZbshmrucP9T2uxtZa4029AJ5mc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:
 Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aFDWzvV8jidVwY1lr9cy5rVyVZdNqwropTAthMChb5M=; b=MhFqb2O7DMnvCH2iR02mNGJicL
 WQPifmbhh/ITCjraVvoaSqrh2vejlSekFqgvnrIaSTGHdpeK7GCjHliJ3wSkuHgbDmrSNjuLthxZJ
 jm11dbZJD9apItKVolDcJAKxZ5AwkV9gLo4trm1QMd0JSpG1sPFeJZ5PUFzwrPvL8U1M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1we10Y-0006j0-FV for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 01:41:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AEB86001D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 01:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188F01F000E9;
 Mon, 29 Jun 2026 01:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782697312;
 bh=aFDWzvV8jidVwY1lr9cy5rVyVZdNqwropTAthMChb5M=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=Fyzkb+01XWQOIW7qUYAc+9GVi0TP7NsOC05WDie+GVk6+VSbIvq/+52YzbwQ/Up7S
 nC1bw0yLelW0zCAotUus7Zm4lehJtqxbAmuM+AMmp0HtOsIAW8oXAncBXMlhGWuYXj
 i0SjSDQJ4v6lud5sYxFBA/ud0LyrpSrqlNiQxEM+3d6G3dSULPJBy3g0/NbATTwrWE
 xmfE3VZHQSPE/7+OfEIVmsMLTPUJ+wmK7yddfNsWh1/FGHWY+jG1FouGChO9AGdkJ3
 CQauEvxIlSgqICl+uWc3NGtmHQb734jIHdfRSXyo3+WQ6evW0Dt+71PsIaQEbATvGa
 yoACvjeTpt4vQ==
Message-ID: <7c7dfece-0dc2-45a6-818f-b0cd9bdcd2d3@kernel.org>
Date: Mon, 29 Jun 2026 09:41:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jaegeuk@kernel.org
References: <20260617073357.93682-1-chao@kernel.org>
Content-Language: en-US
In-Reply-To: <20260617073357.93682-1-chao@kernel.org>
X-Headers-End: 1we10Y-0006j0-FV
Subject: Re: [f2fs-dev] [PATCH v2] f2fs_io: adapt w/ page_size in
 aligned_xalloc()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/17/26 15:33, Chao Yu wrote:
> When allocating memory in aligned_xalloc(), if the requested alignment
> (e.g., F2FS_DEFAULT_BLKSIZE) is smaller than the system's page size,
> aligned_alloc() will allocate memory that is not page-aligned on systems
> with 16KB or 64KB page sizes.
> 
> As a result, subsequent calls to madvise(..., MADV_HUGEPAGE) will fail
> because madvise() requires the memory address and length to be page-aligned.
> 
> Fix this by dynamically adjusting the alignment and rounding up the requested
> allocation size (via roundup()) to the system's page size, ensuring that
> memory is correctly page-aligned for madvise().

Minor thing:

Author info seems wrong, please help to correct, thanks.

author	Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=94525ec03cbdc3ead2e92c5e4ae229f9868317f2

Thanks,

> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   tools/f2fs_io/f2fs_io.c | 17 +++++++++++++++++
>   tools/f2fs_io/f2fs_io.h |  3 +++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index 94e61b8..9a866cc 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -97,6 +97,23 @@ static void *xmalloc(size_t size)
>   
>   static void *aligned_xalloc(size_t alignment, size_t size)
>   {
> +	long page_size = F2FS_DEFAULT_BLKSIZE;
> +
> +#ifdef _SC_PAGESIZE
> +	page_size = sysconf(_SC_PAGESIZE);
> +	if (page_size < 0)
> +		page_size = F2FS_DEFAULT_BLKSIZE;
> +#endif
> +
> +	/*
> +	 * On systems with large page sizes (e.g., 16KB/64KB), alignment and
> +	 * allocation size must be page-aligned to satisfy madvise().
> +	 */
> +	if (alignment < (size_t)page_size)
> +		alignment = page_size;
> +
> +	size = roundup(size, alignment);
> +
>   	void *p = aligned_alloc(alignment, size);
>   
>   	if (!p)
> diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
> index 539964f..cf1c334 100644
> --- a/tools/f2fs_io/f2fs_io.h
> +++ b/tools/f2fs_io/f2fs_io.h
> @@ -49,6 +49,9 @@ typedef u32	__be32;
>   #endif
>   
>   #define F2FS_DEFAULT_BLKSIZE	4096
> +#ifndef roundup
> +#define roundup(x, y)		((((x) + ((y) - 1)) / (y)) * (y))
> +#endif
>   #define NEW_ADDR	0xFFFFFFFF
>   
>   #ifndef FS_IOC_GETFLAGS



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
