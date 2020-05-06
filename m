Return-Path: <SRS0=zUg3=6U=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8273FC28CBC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 May 2020 14:56:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8A2208D5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 May 2020 14:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="WwA3Puoo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="mVVBTWZf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx0fK9Fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8A2208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jWLTF-0003M8-Em; Wed, 06 May 2020 14:56:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jWLTE-0003Lw-AI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 May 2020 14:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aT4yOgEge3hTF3FaTKwc4a+1Sl1Mq9yw9j7lWipHnrc=; b=WwA3PuooiTR4UOz6V2Nwid61Q6
 UoNitanMFieiaCrYlHpv9ZUjRdZHCB8E4aEYIKSRGLcepnt14W35C0rY27otcMT+Ecvs1G/MZNMpy
 8iGfLRDU/YzD6yhlPtFZLIT4+2YHSmTD8I9SjXCVpGyZhanvzVDaHt5LapsWtMtPpD0s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aT4yOgEge3hTF3FaTKwc4a+1Sl1Mq9yw9j7lWipHnrc=; b=mVVBTWZfj3kSiwuThwEKPmEjxp
 tqDuTJf8daQ0TJjwoTccGW7oWgbxoRW9NK/fTNyS0Xh95JxAbuBBZeN9g4XjyUgdkQjyYtX+KvPYR
 KjMJW0kTeO5wBk/l7UDtQVwk7C6MBsKV/9fkZ8Tx60M3Brx/uvGLyWkRUbdSJnjGiC7E=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jWLTC-009wMe-TZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 May 2020 14:56:24 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B32C208D5;
 Wed,  6 May 2020 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588776969;
 bh=LEE9kaUuq3swcyipv2Z5cVdwEM6Qz9YdRajLpVMAeUs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xx0fK9FbNR3TwpC9RsM9U17z+Mt/rhgEorkbaAzNLrrJ5WXebxTK6DxpMb2Sts2Kt
 2WZlLZ3Z4qZT1yyx73AZOjHrvnd1l+JnjbHu8P9OJ7Gz9mYE7Cx8da7oJKDsWObkY/
 Ym2zOZ0YfaUYi7Ja/4gf4WIJLkZzi6HrVMsxYrx0=
Date: Wed, 6 May 2020 07:56:08 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200506145608.GD107238@google.com>
References: <20200504143039.155644-1-jaegeuk@kernel.org>
 <7177aab9-630e-e077-7005-0023c93134b3@kernel.org>
 <20200505230559.GA203407@google.com>
 <9aaeac5e-4511-5c81-653c-23a85b3c335a@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9aaeac5e-4511-5c81-653c-23a85b3c335a@huawei.com>
X-Headers-End: 1jWLTC-009wMe-TZ
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/06, Chao Yu wrote:
> On 2020/5/6 7:05, Jaegeuk Kim wrote:
> > On 05/05, Chao Yu wrote:
> >> On 2020-5-4 22:30, Jaegeuk Kim wrote:
> >>> From: Daeho Jeong <daehojeong@google.com>
> >>>
> >>> Current zstd compression buffer size is one page and header size less
> >>> than cluster size. By this, zstd compression always succeeds even if
> >>> the real compression data is failed to fit into the buffer size, and
> >>> eventually reading the cluster returns I/O error with the corrupted
> >>> compression data.
> >>
> >> What's the root cause of this issue? I didn't get it.
> >>
> >>>
> >>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>> ---
> >>>  fs/f2fs/compress.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> >>> index 4c7eaeee52336..a9fa8049b295f 100644
> >>> --- a/fs/f2fs/compress.c
> >>> +++ b/fs/f2fs/compress.c
> >>> @@ -313,7 +313,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
> >>>  	cc->private = workspace;
> >>>  	cc->private2 = stream;
> >>>
> >>> -	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> >>> +	cc->clen = ZSTD_compressBound(PAGE_SIZE << cc->log_cluster_size);
> >>
> >> In my machine, the value is 66572 which is much larger than size of dst
> >> buffer, so, in where we can tell the real size of dst buffer to zstd
> >> compressor? Otherwise, if compressed data size is larger than dst buffer
> >> size, when we flush compressed data into dst buffer, we may suffer overflow.
> > 
> > Could you give it a try compress_log_size=2 and check decompression works?
> 
> I tried some samples before submitting the patch, did you encounter app's data
> corruption when using zstd algorithm? If so, let me check this issue.

Daeho reported:
1. cp -a src_file comp_dir/dst_file (comp_dir is a directory for compression)
2. sync comp_dir/dst_file
3. echo 3 > /proc/sys/vm/drop_caches
4. cat comp_dir/dst_file > dump (it returns I/O error depending on the file).

> 
> Thanks,
> 
> > 
> >>
> >>>  	return 0;
> >>>  }
> >>>
> >>> @@ -330,7 +330,7 @@ static int zstd_compress_pages(struct compress_ctx *cc)
> >>>  	ZSTD_inBuffer inbuf;
> >>>  	ZSTD_outBuffer outbuf;
> >>>  	int src_size = cc->rlen;
> >>> -	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> >>> +	int dst_size = cc->clen;
> >>>  	int ret;
> >>>
> >>>  	inbuf.pos = 0;
> >>>
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
