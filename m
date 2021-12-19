Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A05AC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Dec 2021 08:54:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1myrxP-00048u-9h; Sun, 19 Dec 2021 08:54:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1myrxN-00048n-4i
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 19 Dec 2021 08:54:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lu2P2OOYyj8Bg7V38UxEm9vPAdzOI6OLvsoGMiUTHYU=; b=HmsbEVx6E2SZOZmwr/RKCH047I
 9rIOr0cEQjPEDx2nLYWq16PIoTWdQ3yPu20PVC3TdO9sBLmxNz/0poBi5YlJXhAhvsRLId35QHTEk
 qwcgG+YgUfi/xPQ3tmZi5rm9Q17FtVhSVWvldVLWLo3JjqbjDBM0xQ08EhfF9j6H2q6k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Lu2P2OOYyj8Bg7V38UxEm9vPAdzOI6OLvsoGMiUTHYU=; b=A+dRFlWG4TzdJgHJ8ohTKXXbFk
 6ORpGq1Afh4LkpjK/xFwB1aCI+IQYJf5gxXOArPR28AfrMohKCJJYwZseH7r+qIQ0G6yT4Yh6zdFb
 1E/rcdFKPsMfKaQwShoeKU70NBSTDNvwm/W4Frk69SQuJ4lZdhsRYv/qsDEpmPIuaTRo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1myrxK-002yhl-Tv
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 19 Dec 2021 08:54:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BB24760C8B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 19 Dec 2021 08:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75268C36AE8;
 Sun, 19 Dec 2021 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639904040;
 bh=z5TBNVZ279yBP2Gr+ocvS8LswwGW8gBcfOilhzacPrg=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=TdvZ+Nxp/75q46DM0qE6jfCXywWF6y7Z2byX1QX0/oBxo33kYpCEhtaeCguaoKK2Q
 i4PJEXdCjNHeLBFsN06et8q0YDXJGBB2yoErDxwMT8y1SJUaWkpHkqlVeGm6eVWI/7
 FIWhebThTkw0Gsw6ddvE9DvGlDOJo850AYqu8pJ5xxFVSpF2KjCAz52ovDpsC91j5Z
 UZKzFwzyvJx1KNK3vYaALAoO2veOEugcl9kbzLp0avsudUxyDz4VtGp6+qAVBDfw5v
 3roaUhPvt400iNAaX2L2AA68ol8JtbwfYzChzrPH8uoNAXQUk6Fk6j8Bp2YKnwuKR0
 5gRSZ1QrAdDcw==
Message-ID: <443927c3-8eaf-8f00-0e41-2173143fe166@kernel.org>
Date: Sun, 19 Dec 2021 16:53:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20211214182435.2595176-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211214182435.2595176-1-jaegeuk@kernel.org>
X-Headers-End: 1myrxK-002yhl-Tv
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid down_write on nat_tree_lock
 during checkpoint
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

On 2021/12/15 2:24, Jaegeuk Kim wrote:
> Let's cache nat entry if there's no lock contention only.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/node.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 556fcd8457f3..b1bc7d76da3b 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -430,6 +430,10 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
>   	struct f2fs_nm_info *nm_i = NM_I(sbi);
>   	struct nat_entry *new, *e;
>   
> +	/* Let's mitigate lock contention of nat_tree_lock during checkpoint */
> +	if (rwsem_is_locked(&sbi->cp_global_sem))

Why not down_write_trylock(nat_tree_lock)? cp_global_sem lock coverage is larger than
nat_tree_lock's in f2fs_write_checkpoint().

Thanks,

> +		return;
> +
>   	new = __alloc_nat_entry(sbi, nid, false);
>   	if (!new)
>   		return;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
