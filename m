Return-Path: <SRS0=VCAv=6T=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207F0C3A5A9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 May 2020 01:53:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9B8206C0;
	Tue,  5 May 2020 01:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="kA4zX5xA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="VRwJcfsW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A40hyaPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9B8206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jVmle-0006iD-5b; Tue, 05 May 2020 01:53:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1jVmlc-0006hy-SJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 May 2020 01:53:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pqerY56arna1M2JGw2cM4hBelT9rXqN+vlbSgD2rZU0=; b=kA4zX5xAcKx3cbxZ1aH0wt2yZi
 lbFWadDzhyFf6wjcyt8P/eTVxAPg9ALQMhZw0yTEvuY30hFaFw22mXJEu5X/EBFWpG58nBcfGIHVF
 AejRvMyNsDd9x56o+ZinDE40W8MOzeZe2lXOKU+8Cm4yTaPygelRWzBghToycKxYJ76o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pqerY56arna1M2JGw2cM4hBelT9rXqN+vlbSgD2rZU0=; b=VRwJcfsW8ol7/rV78mys1PD1SN
 vpT6uVlz6PSuu8V4NGYWCKeGGRvLTa/ZDtyzmfV0V4G2hLjSIZN6PafRKnbKMe12aN/FT2WbhDk/9
 jLbrmMhjwPddbHpi1O0+92OGijQGBPnkokeuHI/kQfNM1J19hCQ+ogXOBIuZJf7HtzMM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jVmla-00AmWc-Uc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 May 2020 01:53:04 +0000
Received: from [192.168.0.107] (unknown [58.213.210.203])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 66A34206C0;
 Tue,  5 May 2020 01:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588643572;
 bh=otlpl9kgwwzoyQGAsBIJNT4k36SElcRlfWNTe5IWlao=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=A40hyaPiyapzdGNG+jUJHa7VQ2T3Wjwrtw1OVfzgaDIfxIXeSTgA43oQ7r2Xbo4Ug
 SIC9g4ead+0Dv1uTmRsYZSLckqfSOPyHEMdOsg/iV4oMLuWBuxyZXCNw8uE5pl6l6h
 YsCiuNUTKhUjb0B6zitn1PKycvYpt3DcrwUGbaE0=
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20200504143039.155644-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <7177aab9-630e-e077-7005-0023c93134b3@kernel.org>
Date: Tue, 5 May 2020 09:52:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200504143039.155644-1-jaegeuk@kernel.org>
X-Headers-End: 1jVmla-00AmWc-Uc
Subject: Re: [f2fs-dev] [PATCH] f2fs: change maximum zstd compression buffer
 size
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020-5-4 22:30, Jaegeuk Kim wrote:
> From: Daeho Jeong <daehojeong@google.com>
>
> Current zstd compression buffer size is one page and header size less
> than cluster size. By this, zstd compression always succeeds even if
> the real compression data is failed to fit into the buffer size, and
> eventually reading the cluster returns I/O error with the corrupted
> compression data.

What's the root cause of this issue? I didn't get it.

>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/compress.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 4c7eaeee52336..a9fa8049b295f 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -313,7 +313,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
>  	cc->private = workspace;
>  	cc->private2 = stream;
>
> -	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> +	cc->clen = ZSTD_compressBound(PAGE_SIZE << cc->log_cluster_size);

In my machine, the value is 66572 which is much larger than size of dst buffer, 
so, in where we can tell the real size of dst buffer to zstd compressor? 
Otherwise, if compressed data size is larger than dst buffer size, when we flush 
compressed data into dst buffer, we may suffer overflow.

>  	return 0;
>  }
>
> @@ -330,7 +330,7 @@ static int zstd_compress_pages(struct compress_ctx *cc)
>  	ZSTD_inBuffer inbuf;
>  	ZSTD_outBuffer outbuf;
>  	int src_size = cc->rlen;
> -	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> +	int dst_size = cc->clen;
>  	int ret;
>
>  	inbuf.pos = 0;
>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
