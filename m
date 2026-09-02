Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57E0C624D4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CB99Mr9/pspeLh97yToF7rGQc4INgP0ZAEW1gV1IF9c=; b=jOUPCC379pdxeJFecmzsNxDB6j
	Ax99QJp6SIxG4b4VS16ei295RpbIsJDeeCdDfuxTiFRkQmCfIxHtKzJuQcycbbFwus9fKWqTR0+Em
	OUfAaH/pXagMkWWsi0+EYu/AW3cL9srdAY/W1kzX6j0rwNv6RbWYepJLUk117T7Hy8y0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1oPY-0003U8-Sx;
	Wed, 02 Sep 2026 17:06:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1oPW-0003Tr-JM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 17:06:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UkkIJXmm06Q530gnh7GO6HjRrvmtv8fJgdeibS3GebU=; b=IoNubj2okVwZPywE3kfvmC4hrk
 AfbHzyoOoLxb42newkeTT+vzKaI/MzRhB2P+LWUpzj7llpYCRLMmjvNkO41n6N+PFtX1ZeotJJarJ
 2r/qR8oul0UUXKpXWgicf3KAg+1n3acrZOeh3oktRa5fQMtsxSXvdr9m6wNiEsRRQiIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UkkIJXmm06Q530gnh7GO6HjRrvmtv8fJgdeibS3GebU=; b=XmhkkAeVnIrX5P5loR35HucVaG
 BBxlMDBEA/H/r0DaZDyyv0ARuvk+I9bNH5Srx4ul8kBfiFvZJdVXJbPRWa6BSLPHmaOJO7KNKFENr
 msPlwlsiUEBWiiDhJ9ECpJ8T/kCMXc9e3wRnWigKO/AT+riGcMJK2EHcD4bLqS+CZLmM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1oPS-00081K-0M for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 17:06:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 72AC941AB6;
 Wed,  2 Sep 2026 17:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BF81F000E9;
 Wed,  2 Sep 2026 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788368756;
 bh=UkkIJXmm06Q530gnh7GO6HjRrvmtv8fJgdeibS3GebU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=A7F2joVxCJ43LB4CVuDnYaREbD1f9Vtnr6zpD3bGGqNfhTk/y9WEVX4pWwk6mygQP
 cxqETcgsLXlSvswvGYpdNEj7lbNI6R7v4pjVttcxaAsq0jS+ktqLrDVaSvZ6HoAGtH
 0tEN5k93HlGoPtet0a8tRnMLtYf7/iyE2cv2ny9jKVhRf9EsEj1ZkFLCrpt6ovSKs1
 WiG2gpwdVv66ShDTEVDcX3OfsjCLaxWHon7kCSReUFma8h+XYqEMfL0ZHMwspYjsN5
 6thlvpKTVSaq6k8wnYeBdsUdOaGDfPPMyB/5ZU+jGXmYWOE0eDALFN26xsnZL3oZbh
 1328hSHeB6Vew==
Date: Thu, 3 Sep 2026 01:05:49 +0800
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Message-ID: <aphWZOOQLPoN6L1K@zlang-mailbox>
Mail-Followup-To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, 
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260902050133.2413-1-prabhakar.pujeri@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260902050133.2413-1-prabhakar.pujeri@dell.com>
X-Headers-End: 1x1oPS-00081K-0M
Subject: Re: [f2fs-dev] [PATCH] f2fs/015,
 016: add missing _require_scratch checks
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Oh, there's one more "add _require_scratch" related patch :)

On Wed, Sep 02, 2026 at 05:01:33AM +0000, Prabhakar Pujeri wrote:
> Both tests run _scratch_mkfs in a loop without first requiring a scratch device, so they fail messily instead of skipping when no scratch device is configured.

This line is too long. I can help to change that when I merge it.
Or *if you have more* similar patches, I can wait for your next
combined patch or patchset.

Reviewed-by: Zorro Lang <zlang@kernel.org>

> 
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---
>  tests/f2fs/015 | 1 +
>  tests/f2fs/016 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/f2fs/015 b/tests/f2fs/015
> index 54cada4a..75ae91f2 100755
> --- a/tests/f2fs/015
> +++ b/tests/f2fs/015
> @@ -12,6 +12,7 @@ _begin_fstest auto quick mount
>  _require_kernel_config CONFIG_F2FS_FS_XATTR
>  _require_kernel_config CONFIG_F2FS_FS_POSIX_ACL
>  _require_kernel_config CONFIG_F2FS_FAULT_INJECTION
> +_require_scratch
>  
>  options=(
>  #	mount_option			mkfs_option
> diff --git a/tests/f2fs/016 b/tests/f2fs/016
> index a6df827d..e0857e0a 100755
> --- a/tests/f2fs/016
> +++ b/tests/f2fs/016
> @@ -15,6 +15,7 @@ _require_kernel_config CONFIG_F2FS_FS_LZORLE
>  _require_kernel_config CONFIG_F2FS_FS_LZ4
>  _require_kernel_config CONFIG_F2FS_FS_LZ4HC
>  _require_kernel_config CONFIG_F2FS_FS_ZSTD
> +_require_scratch
>  
>  options=(
>  #	mount_option			mkfs_option
> -- 
> 2.55.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
