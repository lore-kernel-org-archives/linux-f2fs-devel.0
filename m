Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5800FF9EDC5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KN7xx8SL9o4ZzOZAiGrLvVMOPWGDoOghJS+7ZOxPi80=; b=JKbpRX8j8+dVhtTMcXi4GZrgRi
	yQA3zXJVDUkancSfw2Q9WN7AJJWMDWh7A/8WyXyqCZrrtcH9bshl7ESnztvkoZzFC2db49cf40Qsb
	cqc/MsjH93hJysVSH/7OFMrq/PWj63ohrekqV4lctt1j5VxOzw3q+DvclLjcGp4iIrDM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFWly-0006Rk-Qa;
	Wed, 22 Apr 2026 12:33:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wFWlk-0006RU-FG
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 12:33:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8j5PmRafhsJeMBpFjdqml6Gs+reY5z9sK2uCvKakcvI=; b=bjGla61eLwLkLzXhxeeLGl4TgZ
 Izhnc2zwHViSp3IU9mLWQg1lRmAuSk+F2bGJ76VwBjiTjuTOhRCGHJ6WqZNmtCYROQSDuTTdvUKqt
 W6X7UwHk9EHf2OcVn0UxshX2DwvGJ27AgE/2AH7uSQk2745azIYWvMUp/a8q/sO/xk/Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8j5PmRafhsJeMBpFjdqml6Gs+reY5z9sK2uCvKakcvI=; b=biUCZNigBJSWBrOvjPdBiN9Khl
 4OJLsG0tkGlRK6t+RBe0J3VF8S0IZvosxwRHgWDJEXGTVLEOluOputjx93ZoS6LVXMrLrSruCFnuq
 XvF7I4KNyUpbkFagVL/9/m3YN1d6FZO8tXsvOZR7xKxlyGmhx0T/ZlSIsqd2SVwfOdRs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFWlh-0005T8-T6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 12:33:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E9894420F;
 Wed, 22 Apr 2026 12:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9532FC19425;
 Wed, 22 Apr 2026 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776861195;
 bh=nAmz0+PBMwNgKBUFmaghqo3euw/h0X0sfmkZygrD+i4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=P9/2LPbZbfT/8L6QzXNbzeExQRTL679uwLhCbBBq+yogiVXzXnJD0b0hrzsFsYLWk
 DSM9FOkF0JvSRY8OzPB414+vIGUTe921c2VjZJgRvBMyjjTUuSc6LAdvI4+vNlhnFW
 WCuK/9YFg5pO/q5CP+Nqil7SOhITePR+pbynBfzuR8czs0zHUtzOtLxR2SFPOthizr
 OVU8kbA3B/MUEHEJCxB09Km7ojvVcop0yFXJ+IQTPDX84HX9PNaeoFpSX8teaPJHvz
 3ovKpjFXjMnayPee7aaKYZKLacT4133+kHHilMUHl3aPIhJHjyQU+f4iu/9TWeGGQI
 jbx1RLuCUcl6A==
Message-ID: <206a897a-2860-40b5-bbb8-829954d7e568@kernel.org>
Date: Wed, 22 Apr 2026 20:33:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260422073525.2063784-2-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260422073525.2063784-2-monty_pavel@sina.com>
X-Headers-End: 1wFWlh-0005T8-T6
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix incorrect FI_NO_EXTENT handling in
 __destroy_extent_node()
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/22/2026 3:35 PM, Yongpeng Yang wrote:
> From: yangyongpeng <yangyongpeng@xiaomi.com>
> 
> When __destroy_extent_node() sets the inode flag FI_NO_EXTENT, it does
> not reset the length of the largest extent to 0 and update the inode
> folio. Since modifications to the extent tree are disallowed afterward,
> the cached largest extent may become stale. This can trigger the
> following error in xfstests generic/388:
> 
> F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761) extent info [220057, 57, 6] is incorrect, run fsck to fix
> 
> In the f2fs_drop_inode path, __destroy_extent_node() does not need to
> guarantee that et->node_cnt is 0, because concurrency with writeback
> is expected in this path, and writeback may update the extent cache.
> 
> This patch updates __destroy_extent_node() to avoid setting the inode
> flag FI_NO_EXTENT, and to remove the check zero of et->node_cnt.
> 
> Fixes: ed78aeebef05 ("f2fs: fix node_cnt race between extent node destroy and writeback")
> Cc: stable@vger.kernel.org
> Reported-by: Chao Yu <chao@kernel.org>
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: yangyongpeng <yangyongpeng@xiaomi.com>
> ---
>   fs/f2fs/extent_cache.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 87169fd29d89..3adbead27953 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -645,14 +645,10 @@ static unsigned int __destroy_extent_node(struct inode *inode,
>   
>   	while (atomic_read(&et->node_cnt)) {
>   		write_lock(&et->lock);
> -		if (!is_inode_flag_set(inode, FI_NO_EXTENT))
> -			set_inode_flag(inode, FI_NO_EXTENT);

We'd better revert all change lines in "f2fs: fix node_cnt race between
extent node destroy and writeback"?

Thanks,

>   		node_cnt += __free_extent_tree(sbi, et, nr_shrink);
>   		write_unlock(&et->lock);
>   	}
>   
> -	f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
> -
>   	return node_cnt;
>   }
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
