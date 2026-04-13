Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AC9EBFD37
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q9juYCvkTTVRsnpn39CWvuRBAMF8lDnZnNgDLVD7hag=; b=XiIlvhC0lfNbbZoLuZjmFIk4LW
	Okayzqj7Ipjx8vwd/mB9OV6YJD9XxYemNY3y6ovw7mEbGeWrIVwCf1MD/VV7kdswxzM/2mxTI70eJ
	1ON/CyPdSLNb7rWIenk8wRn3SU0k4GhGyT5lgGiBTZkGzCDOjckkzpyze2mJXMsjk7dg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCFSc-00056Y-DO;
	Mon, 13 Apr 2026 11:28:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wCFSb-00056R-3f
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 11:28:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W+fpzzp1Fo01x3e7YFbwCT0TRXxcyqxWZCUkF78jlBA=; b=hoW6t0xMJjX1rpWCeDANjn1h6Q
 0CIP5/klsfzH2PGDC32D8Co4VqGeWNvjkgdixVuBPpSjlwG7bgAmKS6cEnbvg0Z7rM4MP5egE2SIL
 GxRPMf6tZU5uH3BIt2lA4JOHZ6VGkcDTH5OmdEukAeUthYQaCctigQETFhuTaAGgHRo0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=W+fpzzp1Fo01x3e7YFbwCT0TRXxcyqxWZCUkF78jlBA=; b=CKT1eK9PjZBd9nTn3QQxAaVZrR
 XMc+hw7W64iQZ/vbS/Wgso8BiUwDTwWO4KnoWDvqex4QYL4YBxQROgd3ssL78YIv9UT4glMNRjU8C
 3OGo1/g6NN0Y3Kxm/D3ryZ1z6rftfoRTJhAjnI0hkpdAFEtioizse+I2Zg32TcKO7vu4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCFSa-0003TF-K3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 11:28:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E52D060172
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Apr 2026 11:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BD2C116C6;
 Mon, 13 Apr 2026 11:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776079677;
 bh=1V66m994SQyVyDOYYQ2DerYF/StQSxPSJ4YO7HRuc1U=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=sDtT38vbnXwBsWN+TnuqbGL2eZKAJ6nr35PsVglPzZ7KVMV8yWHmmfLu65N+4rW6V
 SFIgTO4quSF9g6x1ENMJiDwf3l2GwEoRidHyRLwUmWYemRWA5aUmXOs0AvJgPL92Ny
 Qhn/YHnLigw4Erxs71dk5YhbiKXALM8XggZMVniKbJ79sjqj5dWv0ROrKs5ozsVylJ
 raY4H8+bL7vaQQ4XCvKvdPDTIYDtOr4odod7Bd7/PDP8r4Q4ppLtPjbB8H47YfI/Lc
 1cqWTbJXgoqyTsSMY00mIfl91tG6Enp17jFYSinJJS7VP5PHTZ9MNA+XVg/37A1UdL
 4LClhKAX9d8Sw==
Message-ID: <116344cd-c591-42c9-9593-2e999c2029d8@kernel.org>
Date: Mon, 13 Apr 2026 19:27:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260406154940.2407853-1-jaegeuk@kernel.org>
 <adaasm42rLxRY2GN@google.com>
Content-Language: en-US
In-Reply-To: <adaasm42rLxRY2GN@google.com>
X-Headers-End: 1wCFSa-0003TF-K3
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: do not support mmap write for large
 folio
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/9/2026 2:13 AM, Jaegeuk Kim via Linux-f2fs-devel wrote:
> Let's check mmap writes onto the large folio, since we don't support writing
> large folios.
> 
> Reviewed-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
>   - log v2:
>    : add comments
> 
>   fs/f2fs/file.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 2c4880f24b54..c0220cd7b332 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -82,7 +82,12 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>   	int err = 0;
>   	vm_fault_t ret;
>   
> -	if (unlikely(IS_IMMUTABLE(inode)))
> +	/*
> +	 * We only support large folio on the read case.
> +	 * Don't make any dirty pages.
> +	 */
> +	if (unlikely(IS_IMMUTABLE(inode)) ||
> +	    mapping_large_folio_support(inode->i_mapping))
>   		return VM_FAULT_SIGBUS;

The code itself looks good, since it's an impossible case, should we
use f2fs_bug_on(, mapping_large_folio_support()) to catch any bug case
rather than just returning error here w/o log?

Thanks,

>   
>   	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
