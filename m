Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70109C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 26 Mar 2022 08:41:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nY1zF-0007Ax-UY; Sat, 26 Mar 2022 08:41:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nY1zD-0007AW-Mc
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 Mar 2022 08:41:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1bFUegqYT8k2poPh+xdDZvwTixg5gnF0UeprrNhFoVk=; b=VK4YSq4F3qr3+lIz4N8FiXwWWo
 0DTFEiT3YPBUgNXIoJbEebHO7gLXk8IE8e2ZB9ywacYEnrNpl3qodwPv27hVb1vD/exvlfm2y6zck
 jvr9NpJTe2nqCDj1xayUBZxv61OO5OP67VqZacMDwtSPDjTPFOf01GLkqYzjitUsRjt4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1bFUegqYT8k2poPh+xdDZvwTixg5gnF0UeprrNhFoVk=; b=SksIl9HJ9cuVMDCgzKAKXLN791
 mhw6tsUUY1FzOwkw/RmiaWsBCas34T9YmdLQRhReHI3KOanQw7x9BXLKEmADA39FMeb1nOzKx2C1U
 CDFdyT8lVbq7OO3l0a/WZiZfANU0inUOIkg7hg12G/NZ9bd0lELnfUCp6iApir2YvP9c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nY1zB-00CbrE-7S
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 Mar 2022 08:41:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8E4CB60E17;
 Sat, 26 Mar 2022 08:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362B5C2BBE4;
 Sat, 26 Mar 2022 08:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648284076;
 bh=MzvQcR96gyo7RqQQpE892/lFN19x54FxFHC5aLVYzKw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rXVumBjYyJgGoDJQvG0zZZrIvOjRYcNSmF9H+qWFcfBXO6sc0IFlQKcEXJczfuhoH
 1Zp/RMudRTfydYWOjbLhkv27ZlBT2GU6glq06x7b1SGqZwxb1gApbpNaYEIZJlcdJV
 slSm3qQlpjDuC8UkzC7yBlA/QmaN87YCZQswSWnkm9hwekKL4z3CH/H3JIbjVTVz7t
 tvvJfMXgCSzS6G+NVRn8ySnBT/hSw6tyfDtOcBY+7XjkqZ55K9hdZNaWDZXu5bmtBG
 /vP+FuQD/cYo9HgLFnEfY3WoFyZB8DpJaH8gVrgbd6YBXXa26Izs4E9a8fVpLiOoRx
 4J613z2NQZk3g==
Message-ID: <c1101316-fd59-812c-aa4a-a0fa2d2004eb@kernel.org>
Date: Sat, 26 Mar 2022 16:41:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20220325181850.513023-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220325181850.513023-1-jaegeuk@kernel.org>
X-Headers-End: 1nY1zB-00CbrE-7S
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unnecessary f2fs_lock_op in
 f2fs_new_inode
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/3/26 2:18, Jaegeuk Kim wrote:
> This can be removed, since f2fs_alloc_nid() actually doesn't require to block
> checkpoint and __f2fs_build_free_nids() is covered by nm_i->nat_tree_lock.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Looks fine, but still it needs more test to check stability w/ the patch. ;)

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
