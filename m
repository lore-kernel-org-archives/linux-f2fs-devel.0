Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DB9CD98DA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3SZ/ZCkbZloz3gGm+tEOAWhbmJ5HJWwj1NTc7Rpmnnk=; b=N15vsi77YtVnDFgWdYN/G3W2oP
	YSqJXP4CTD5h8Rv4tKdHUjze78vlVf1pAUvBngoA+d8kluGljmQomiwMxO5/tR4gEMBajcdLwjjjJ
	5VWCoem6w9binYW4AT6Q9Z3LyUbWANwYuaAYLfe3gdv+vkhQN+7w1ycwF4u5mrLHNd54=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZKcH-0005lk-VY;
	Tue, 16 Jun 2026 03:37:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZKcH-0005le-Ez
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 03:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yl9lakeIMTfMDdeq/Ttt7hj01mSxIfxp4XHyTh90FBI=; b=hIEbarXv/khMCEBy6MDuZLdmKu
 tr+aBolJ39jwQ83JsA0fE0VwaSe/m6sIS0wANNnL29wMrvyTAezrzr9UOI4mI/Gemi+AP0iKIefXn
 262pyaH/QX44uiTfkUn6w61XRK/0Fhydr2V4yjhBPtbTQFlmi3fwpc/7yk7Yr2Fngmvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yl9lakeIMTfMDdeq/Ttt7hj01mSxIfxp4XHyTh90FBI=; b=Pg5HQKYOcAYr+r0E/RSZr9qXSW
 X8zhDGfC2Z3KCz0+w140HT+wFIH6aUGtr3PIjk69FQ6tkC+wfdH11ktA2+s+1daXiBX4PqU+3WEJ/
 OHKoLeR4ryasrKRf6Lzey7qPVhxpvWa/g+4/vCgX8rmmPk3AZnXxR4nGZ7qgXjKQIHJI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZKcG-0006CJ-Bi for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 03:37:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D7A941A93;
 Tue, 16 Jun 2026 03:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53591F000E9;
 Tue, 16 Jun 2026 03:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781581042;
 bh=yl9lakeIMTfMDdeq/Ttt7hj01mSxIfxp4XHyTh90FBI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=TDzDfxOSQ616YflIoWjXhIztKRzYDGZ/YsXJMdo8tp1bEHHfpBy1aHSEMF2eV5/kA
 5SMUKvejUtB+uwLgZM+6RWobLKu+4nj3TVKD389njKrBB1Qka3KeDX3bP6m97Ktaw9
 ZkNfxZ27aJjx95hciQNzb6SXIMToaurNo2ZxRdrTmJC0xlo9H9OHdykYqx3Djw9nye
 t1t9ehmbdzpek3II2v7E4DQ3qCRKxWGWo/VZKpLFljUj3YuUetB8lRKboXZ09XihMK
 e1W23yw9bVLzOsiVo8IYyAlCDeEhulsGcrES2esyMymyEPB6/QmMGxU+ywDdJDaPzm
 5gP14mcI7T+vg==
Message-ID: <bd3d9950-80b9-4099-a088-d2d07fb3092c@kernel.org>
Date: Tue, 16 Jun 2026 11:37:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260616033146.127000-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260616033146.127000-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wZKcG-0006CJ-Bi
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: use post-decrement count for
 cp_wait wakeup
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
Cc: geoo115@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/16/26 11:31, Wenjie Qi wrote:
> f2fs_write_end_io() decrements the writeback page counter and then
> reads it again with get_pages() to decide whether the last
> F2FS_WB_CP_DATA completion should wake cp_wait.
> 
> Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
> decision is made from the value produced by the decrement itself. Keep
> the existing dec_page_count() path for other writeback counters.
> 
> Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")

Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint for better performance")
Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")

Thanks,

> Cc: stable@vger.kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
> Changes in v4:
> - Add Fixes and Cc stable tags.
> 
>  fs/f2fs/data.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d83a21998ec2..58d23eb74ec2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
>  		if (f2fs_in_warm_node_list(folio))
>  			f2fs_del_fsync_node_entry(sbi, folio);
>  
> -		dec_page_count(sbi, type);
> -
>  		/*
>  		 * we should access sbi before folio_end_writeback() to
>  		 * avoid racing w/ kill_f2fs_super()
>  		 */
> -		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
> -				wq_has_sleeper(&sbi->cp_wait))
> -			wake_up(&sbi->cp_wait);
> +		if (type == F2FS_WB_CP_DATA) {
> +			if (!atomic_dec_return(&sbi->nr_pages[type]) &&
> +			    wq_has_sleeper(&sbi->cp_wait))
> +				wake_up(&sbi->cp_wait);
> +		} else {
> +			dec_page_count(sbi, type);
> +		}
>  
>  		folio_clear_f2fs_gcing(folio);
>  		folio_end_writeback(folio);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
