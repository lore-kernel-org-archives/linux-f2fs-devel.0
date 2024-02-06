Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9DCC4828D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:16:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rXBwa-00075z-Vf;
	Tue, 06 Feb 2024 03:16:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rXBwY-00075t-FQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Feb 2024 03:16:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=to3wWLn3S6jLuCZgJl0VSDZef3fE6D/ObHC7fxwrsVU=; b=NSrKkekNsan5S3xIG7f9We0+ml
 UBJk3o7u6B8+Hk3b/UJmizON7D8YTu4Ympazl8EGbzliM96BB9KQOOOpGljQB/joM8H7omSEzBfLT
 +HOQq4bU0GxL4GSuqv+9OH8FfFBxafJydhXNhU2dErRtIGMVbBlSeTW/pLiGbRc98Fiw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=to3wWLn3S6jLuCZgJl0VSDZef3fE6D/ObHC7fxwrsVU=; b=NFTClkwHlvJQTl+sF7lxmGtekq
 dq8wF3RYQyqQdrdu9vNof3cTldxuXA0/LSxF7psT6sVDjXfLC9eoCQW+8rz/pe0WGv7d7/07dUlTa
 l1TSsOzNOMGXPHjCVK5DYf7l8sSUtYDXuiihGevQhumJY78xphxiVksXC20mQqv8qYWE=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rXBwM-0004oc-JG for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Feb 2024 03:16:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7B80FCE115E;
 Tue,  6 Feb 2024 03:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C69C433F1;
 Tue,  6 Feb 2024 03:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707189352;
 bh=ZyYwGOE43v5bqv5SSEQtS2xBP8aZCZp/iRGVX0g5PWg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lUt6WHfJxWiOVqLa2xhNkZifpLXNDCndlkbeZaQlBBSOkDPEkbxy1PHuyJfCoNhFv
 MqYlAOy35Jk+KI/lZCicpehE4CqxsO5B8vO7h9I9kbQVu4XxSIFsWNhPBD0AvV96bK
 lDxv4gAAEaok0JiyEf9/WqN/A3yBE8MV4d9CbbyN/muH0QyQoVC6PjZdpWUAs4VC1Z
 z/xiUAPtSkaB6TWTMS04sRFO376eKWSZPaHsIWgMorwig3zMrHg0a1d5fJlm1pHmev
 CyMOuSFV6y9jjWsbFNMENZD3hPCgmtaIvMtz6mD3IP3/r37ugkCUoDTOqeOEdq+raU
 BXl7hWOJrDSDQ==
Date: Mon, 5 Feb 2024 19:15:50 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Message-ID: <ZcGkZslfFLP8wqUr@google.com>
References: <1706523684-24540-1-git-send-email-zhiguo.niu@unisoc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1706523684-24540-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1rXBwM-0004oc-JG
Subject: Re: [f2fs-dev] [PATCH 0/3] f2fs: fix panic issue in small capacity
 device
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hongyu.jin@unisoc.com,
 niuzhiguo84@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 01/29, Zhiguo Niu wrote:
> A panic issue happened in a reboot test in small capacity device
> as following:
> 1.The device size is 64MB, and main area has 24 segments, and
> CONFIG_F2FS_CHECK_FS is not enabled.
> 2.There is no any free segments left shown in free_segmap_info,
> then another write request cause get_new_segment get a out-of-bound
> segment with segno 24.
> 3.panic happen in update_sit_entry because access invalid bitmap
> pointer.

The goal here is to stop f2fs when it hits no space to write anymore?
And, we need f2fs_stop_checkpoint() at the end?

> 
> More detail shown in following three patches.
> The three patches are splited here because the modifications are
> relatively independent and more readable.
> 
> Zhiguo Niu (3):
>   f2fs: correct counting methods of free_segments in __set_inuse
>   f2fs: fix panic issue in update_sit_entry
>   f2fs: enhance judgment conditions of GET_SEGNO
> 
>  fs/f2fs/file.c    | 7 ++++++-
>  fs/f2fs/segment.c | 9 ++++++---
>  fs/f2fs/segment.h | 7 ++++---
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> -- 
> 1.9.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
