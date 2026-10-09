Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD3FCA6012
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xnlJ/xUI6QiHxjnvXmyf9d4gyLoJRKBF9mBKG+Y0PeM=; b=QbSTUklzpe2d6EbTJIceM40pGL
	UCzFgWvchhhP+SEaQ1YTSQU8p9vv5iBXuDwIkVCJV78/+9y1GNEr/93nS3pzqlxqwt7E6Kes8M2ny
	ckiwQ1OjL8j1P433j3jInwZs/+c4w9yqiFvM6s51lCQWbfiBOBb+jbXEaAYLaCf4p6AU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF6Nw-0008IU-Is;
	Fri, 09 Oct 2026 08:55:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF6Nr-0008GE-O6
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o+UzLAz30/55bQE/HG+JQhNOGPlk+V9zlOAxlU1PhQo=; b=iPukQwIiMvEem8eqANmgCiOqDJ
 ECpwPTXq2HUvAAQ7rY7j/k6sUfWhSPVr5emdH4dtXL7lgK+SCvUBnIYgVK+lzmk3IRyeHmaY3+kGW
 DRRiBbpoEbqegYop+G4rID2haCu4Q2qbHCbT05R4QH1V/4z5/LXiRZ2toNZJUpx9SNQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o+UzLAz30/55bQE/HG+JQhNOGPlk+V9zlOAxlU1PhQo=; b=f1TF5ZQfH9uLbjlYXoEX21qiBf
 r5/W5M5aKgr7CtHuRLdkagkoeKO7uEGl2qbF+m0HiU4nKeMz1bTauIpWilV8DWCM78yKevXMggugS
 rEBTKxliyIaT2OIhUgvohNZhdTkoR5JedGPJsO6fONfI9rx9Wnp75wqsm5KS3RkF8gvE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF6No-00044z-Nf for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:55:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 13E84602C3;
 Fri,  9 Oct 2026 08:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0AB1F00893;
 Fri,  9 Oct 2026 08:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791536110;
 bh=o+UzLAz30/55bQE/HG+JQhNOGPlk+V9zlOAxlU1PhQo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=FRcII014FwTy1cxgsXHO/AyCMVyVOnwB4pMaRsKpGsz/Y12aYP2TDh1DAtLTkx9TN
 BsSgUp4aRPYa70dH3n9y8uAx9d2RUQPTEXOls1S/3FLBZPmDkZgqubPOzGSaejDpuB
 Aa0o+bIM5QJboRXdhVVVpmRZODQm6hOKFNW6tuNHGfU/Ie3wmBV7wUgaRj/UxnQxPZ
 M0lQIl8RJLW9cRdqJ06qQ4cE/YqU2JdXNYH9zcPrsMUky34DizlH8Jz5JcsHoZkX5a
 gl0/yQ3mtyNXCNhHwuFeuKM+gIMPezgfimp9LOfuM5L8QKXNbFkJl80Y8Yw+p6b3pm
 g8d2TNQVzydxw==
Message-ID: <296d69c0-b284-4186-a71d-9754df409690@kernel.org>
Date: Fri, 9 Oct 2026 16:55:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261004170456.4104287-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261004170456.4104287-1-daeho43@gmail.com>
X-Headers-End: 1xF6No-00044z-Nf
Subject: Re: [f2fs-dev] [PATCH] f2fs: convert inline quota files when
 turning quota on
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/5/26 01:04, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> With a block size larger than 4KB, the inline data area is large enough
> to hold a freshly created quota file (quotacheck writes 6KB), so
> aquota.user/aquota.group stay inline after quotaon. f2fs does not
> expect quota files to be inline, and this causes two problems:
> 
> 1. Quota file corruption. f2fs_write_single_data_page() sends quota
>    inodes straight to f2fs_do_write_data_page(), which sees NULL_ADDR
>    for index 0, treats the folio as truncated and drops it. Updates to
>    the quota file are lost once the folio is reclaimed, so the quota
>    tree reads stale data: chown/chgrp fail with EIO and quota entries
>    of users disappear. For example, the kernel log shows:
> 
>      find_free_dqentry: Data block full but it shouldn't
>      qtree_write_dquot: Error -5 occurred while creating quota
> 
> 2. Deadlock. Writing a quota file past MAX_INLINE_DATA converts it from
>    f2fs_write_begin() under f2fs_lock_op(). dquot_transfer() is called
>    from f2fs_setattr() with f2fs_lock_op() already held, so chown/chgrp
>    take cp_rwsem for read twice and hang, together with the checkpoint
>    and every other writer, once a checkpoint waits for cp_rwsem in
>    between (seen with generic/232).
> 
> Quota files only grow and there are at most MAXQUOTAS of them, so there
> is no point in keeping them inline. Convert them in f2fs_quota_on() and
> after dquot_quota_on_mount(), which keeps every block size on the same
> path as 4KB blocks, where quota files never fit inline. Quota sysfiles
> are created by mkfs with real blocks and are not affected.
> 

Cc: stable@kernel.org

> Fixes: d7e9a9037de2 ("f2fs: Support Block Size == Page Size")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
