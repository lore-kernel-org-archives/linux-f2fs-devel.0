Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989CF103E2FB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Mar 2026 01:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1HXoAPWsCYRrHjTY6l9k9AcY7gWJ05L/aef2oVL2IY4=; b=SW+TeVfvKrlUfgR0rMSS/h3Dbz
	UsS0urwv+N1nPPdhVcfDgxelek4BbCGFK+IQxewg7efVDrC7Cdobg7YIIieZdqnDombiesGvD6+md
	UEs+l82DuL/+BfHJUzF0si+kJBnoKch2ddJJq5dmDsDGx5mJRQQULlbJ+iBxIESWPmsQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w0UW6-0001ab-U6;
	Thu, 12 Mar 2026 01:07:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1w0UW2-0001aR-1B
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Mar 2026 01:07:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KORkZkYntOXKNFvIEU03hodMnjs+nmmc55+WCBMWFsw=; b=T4/NKb4l+66VhefNlyv2uKrTBc
 Z+0vFBNDW0aJ3oMMbhVRLpDphNrs1DVIX8UugZHR4hdZqj59twEed8RwnkHMH+h86aFK4zL5PHk9p
 uoKGwhwexm+7X7RYsMeLmFktjebMGh5P+SFX6pJFGu6XzxM+8NQ8Kj3q8gLGBVFQu8qk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KORkZkYntOXKNFvIEU03hodMnjs+nmmc55+WCBMWFsw=; b=kNf4+UOmQZF7MNCX0n8UINXuX3
 IwnZliOkKz8sfBy9YCAswcZQhLOr26R2ghuBa4+nYhW7I7OA8jVdWWeCylrP/YuX7NAg7kC6DqX5t
 dzluJsxM3cdDWmmA4mubqdpMTHyFa1q1D8olxuATJbB1F+HQEQzogEpD6bFM9iuGmv3Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w0UW1-0002iz-Iq for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Mar 2026 01:07:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 38D3D4045E;
 Thu, 12 Mar 2026 01:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EE6C4CEF7;
 Thu, 12 Mar 2026 01:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773277615;
 bh=X4vQYal9Owo6/v6itp7GqhHdaQXQjB/FER1wCraiDTM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=uSMGty0E9HPvDvAxWISAoXknpZgMAJttEmj7H7ZlDroMfupFG+Dq46DPiXMnGx2sb
 5CfIQv7biegWwfHI7wmYo1t+x0d549ix2AoIfrSU1B5MszU+gQtAhGfKxYUVjNtEMK
 D0nBxDWP90ZLYNkY5186SeWIhrHs9lmEyY4UV98qwsIPUjXLeeejEhwRIVInlOKjH2
 e/nvHKKcmvf4JiXuh0bS+FSdFQE2taVO7HJlOHmuLu/mvOiZbPfh8yVTmqnz1zSGIm
 gTGtTxuR1pcYtmjeK8olzix7nPOFNXeEodydls2WgACOcP6cDUn3CxtqWFsRCWbnbq
 +SE1WXYcwOSpw==
Message-ID: <daa86ab7-fa33-4c31-92b0-0ec0492aa33d@kernel.org>
Date: Thu, 12 Mar 2026 09:06:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260216112841.67508-2-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260216112841.67508-2-monty_pavel@sina.com>
X-Headers-End: 1w0UW1-0002iz-Iq
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: invalidate block device page
 cache before reading metadata
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026/2/16 19:28, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> After the device is mounted, f2fs updates on-disk metadata without
> updating the block device page cache. As a result, f2fs-tools may read
> stale metadata from the page cache.
> 
> For example:
> mount /dev/vdb /mnt/f2fs
> touch mx // ino = 4
> sync
> dump.f2fs -i 4 /dev/vdb
> touch mx2 // ino = 5
> sync
> dump.f2fs -i 5 /dev/vdb // block addr is 0

Actually, it will be better to wait for /mnt/f2fs being umounted first and then
call dump.f2fs, as if there are two users on the device, we can not guarantee
dump.f2fs can always flush and clean up all cache while another user continue
to update the data via /mnt/f2fs mount point.

Thanks,

> 
> Since `dump.f2fs -i 4 /dev/vdb` has already populated the metadata area
> into the block device page cache, the cached pages remain resident in
> memory. After creating mx2, the page cache is not updated accordingly.
> Therefore, `dump.f2fs -i 5 /dev/vdb` reads stale metadata, and the
> physical block address of inode 5 is incorrectly reported as 0.
> 
> This patch issues a BLKFLSBUF ioctl to the block device before reading
> metadata. The kernel then invalidates the block device page cache,
> ensuring that subsequent reads fetch uptodate metadata from disk.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>   lib/libf2fs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 1a496b7..31b5924 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -1027,6 +1027,7 @@ int get_device_info(int i)
>   	}
>   
>   	dev->fd = fd;
> +	ioctl(fd, BLKFLSBUF);
>   
>   	if (c.sparse_mode && i == 0) {
>   		if (f2fs_init_sparse_file()) {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
