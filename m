Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E505C5DF7D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/iMQ9GSzOPZCUQJODuH6Q3bg80aCQyHECy/cgRiQ4j4=; b=O20uD24hBdlNiOb0B4CdEeNySt
	QM3dzvAdE1e0uKWZVxUOKQ0TYPMfugaMWFsJAumiKVt0KKMGLoad/Pc8Aw6Bc6OFk66oWD9F+rEJ5
	hBoPYWrLUQNjwOj/V7gKAzmO9BAMsEWcpl0/uD8z3EGOh/JRtpI7bMkBth+Du9UOX6pI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwVM5-0003yl-Rj;
	Wed, 19 Aug 2026 01:44:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwVLk-0003yS-AW
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 01:44:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y1r7r1ef+XaZdtVHqxWc3yLM/RtI5eF6GflDDDAKlSs=; b=mM1Dh3va/wXsON2ZvfeCb+EOy2
 NkgAMn7hhEPJLl+qW2gu8P7lvel8Ke96Izb9GuTHn5LhlO0fYqPyOiBtDUpsmp+JAlfoGEZgxTU2n
 n+bwZAIaIEQ9A3t9ylfXDlpDQ8RptJx6nYRbkniUWpJAQ3+hjj5+j7hEPx4mbeT2/m04=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y1r7r1ef+XaZdtVHqxWc3yLM/RtI5eF6GflDDDAKlSs=; b=IGnqtmHPjiZY8uvaWkbMBNX/IB
 kOjxbBjNs1mWHcizR0aDcY4RZM1zCau7LlNXpmvtpA67Rdq4mut19/EzcUHC0X36Jz7+GEa5oWHvL
 /QjSw+T+8tUP7cSlyaEJ5j9T6FQrZPMxERY2hLHfcxDSTniM/X0tZsXlcFaRBOfTFCUM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwVLm-000303-7F for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 01:44:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 202F74195C;
 Wed, 19 Aug 2026 01:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5961F000E9;
 Wed, 19 Aug 2026 01:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787103849;
 bh=y1r7r1ef+XaZdtVHqxWc3yLM/RtI5eF6GflDDDAKlSs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=FYZdizJ6iBbR7KHKgktjZMXk40APAX0sPCEi3LxnKXveCgYS7ZvyQEjEMOPiVg7ng
 xx1d7iSkI6fDqK12bvn9xZrv7wubNCVZ4NZ6EipmmyfDoVCPF3a3TNE7yLXxvv3NS2
 Y0EO/yHlZJPwQiIjpswpikTzktRBu9IZc0da6srmxRXmztgf0he4slW4zXeAfgFhdH
 AYQ2lrIOLxHeYvW5rL+dHZsatTAAAAhPsmVH/06lC7OxrU6GSBJAfxqchlhNf93wsb
 q11gBfIoHZbjyBvUaDB7UilRcIBwQXRt9W5z5twKCyod8WpAyM6EZ1iXq0HzpfC/CL
 vj3r61H5Pr+OQ==
Message-ID: <8f85cf1e-fcc2-431e-b005-59a8ca6f5b8e@kernel.org>
Date: Wed, 19 Aug 2026 09:44:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260818145535.449055-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260818145535.449055-1-zhanxusheng@xiaomi.com>
X-Headers-End: 1wwVLm-000303-7F
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix i_size when pinned fallocate
 partially fails
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
Cc: zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/18/26 22:55, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng1024@gmail.com>
> 
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Commit 4275b59673eb ("f2fs: fix to round down start offset of fallocate
> for pin file") moved the allocation loop's start down to a section
> boundary, but the error path still converts @expanded against @pg_start,
> which holds the unrounded start.
> 
> @pg_start exists for that conversion: commit 88f2cfc5fa90 ("f2fs: fix to
> update last i_size if fallocate partially succeeds") added it as an
> immutable base because map.m_lblk moves every round.  Each round now maps
> exactly sec_blks blocks starting from rounddown(pg_start, sec_blks), so
> pg_start + expanded overshoots the last allocated block by
> pg_start % sec_blks, and a partial failure leaves i_size covering a tail
> that was never allocated.  Nothing corrects that afterwards either, since
> file_dont_truncate() has already cleared FADVISE_TRUNC_BIT.
> 
> It needs a start offset that is not section aligned plus a fallocate that
> hits ENOSPC partway, so the error path runs with expanded > 0.  On an
> 80 MiB image with 2 MiB sections:
> 
>   truncate -s 80M img
>   mkfs.f2fs -s 1 -f img
>   mount -o loop img /mnt
>   touch /mnt/pinned
>   f2fs_io pinfile set /mnt/pinned
>   # 2093056 = block 511, so pg_start % sec_blks = 511
>   f2fs_io fallocate 0 2093056 536870912 /mnt/pinned
>   stat -c %s /mnt/pinned
>   filefrag -v /mnt/pinned
> 
> The last extent ends at block 10737 either way.  Before, i_size is
> 46075904, block 11249, so 511 blocks of it were never allocated, and
> filefrag does not mark the last extent eof.  After, i_size is 43982848,
> block 10738, and eof is back.  A kernel from before that commit also
> shows no overshoot.
> 
> Keep @pg_start pointing at where allocation actually begins.
> 
> Fixes: 4275b59673eb ("f2fs: fix to round down start offset of fallocate for pin file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
