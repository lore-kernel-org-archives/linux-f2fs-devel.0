Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D404ACA6012
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C2NjzV/qbkKGt8RuJ6SZLe8mcL/EDadGy4brfJhGUTc=; b=Ttw7snvVe3fCpeNdzRLDxVSlFr
	OktW5CtS3WDj0e95G2e8PG7LEzv8tVBbkY6ohOZlT9JzZY4inZDwDUY/HPfXl0hfXfKpPtOPORcox
	S3tpFsIA/TbDapqVKeuPt75UuBLVFcejoe+9howVrYAZxWMP3zRKYM7rDZXqdpbO3zw0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF5zR-000262-Oa;
	Fri, 09 Oct 2026 08:30:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF5zQ-00025w-Jd
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:30:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q4jmmasQ/0jT937eO5jL+cJshoUDEJU04avQ9ToLdpU=; b=Y3FMGT6BWJchc1LvSIII0IesKu
 shZDSWdTYmmnx46dQ27z+KA2V+nRTVmzETX9f1E7a/6ugAA/bW6mUg8J9jwbVkR/NKAAmvCZvCd8S
 npMtQV3V0mSk9zBYGwS1xlQhID4ouvx+eLqT1SaqobIF3yVmQ6TL/Q6C52lZutrURz2E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q4jmmasQ/0jT937eO5jL+cJshoUDEJU04avQ9ToLdpU=; b=Ya+3zkevRLLvAu7mNe/ehpzRGT
 8OZtvsYFiNhwnF8SKTOEHIegCsXZbV8QI+Ucas+8FYa3bRyL4/SmnEkfKp1xM59XoPBwHedUcvq2+
 4Ah6uAfUrsIlOjmHivZrj2CzaMMO25hmVeQ49HJOjRA/dnJfZgkiCDXYlLRRskOL+T2I=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF5zQ-0002TK-NP for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:30:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B1F0601F9;
 Fri,  9 Oct 2026 08:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE931F000FF;
 Fri,  9 Oct 2026 08:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791534598;
 bh=q4jmmasQ/0jT937eO5jL+cJshoUDEJU04avQ9ToLdpU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VQjINi6FGbYwSlk7R64p+A9Y3z/pYDooJ0nSJloIGXeRWqN5H69bJKE0o4FHZlUMx
 VSCvqDuPbzG7U6tRnpHdFJ/NAVzJ6JyZaHCZfGket7x8FgUSvZUa6luBuHsoR2+y4v
 hhZexMOyb1V23iLiBkx/JTTEwJIsyCTvrGFHQ+a1jLwHYQJXxQY9Xt6TdO2Dl8l9+a
 iot5pGdEVVQ71xzhoW6ei7nFyMlAv5HkdQWa7R4fR4U3QlmzHDCorc4TAAlstkMnwM
 q8n4ZGMFWbf32e1ZSv5w3qwhBZBCadZUfDeRNc91kyKh/y/ES6Z6LUTQ/E4TfBnx0Q
 BwevlEf6cJJmQ==
Message-ID: <29c03ab9-fdf8-4e45-8432-84690e656157@kernel.org>
Date: Fri, 9 Oct 2026 16:29:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20261009035354.3330915-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261009035354.3330915-1-qiwenjie@xiaomi.com>
X-Headers-End: 1xF5zQ-0002TK-NP
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid cache writeback busy loop with
 zero thresholds
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/9/26 11:53, Wenjie Qi wrote:
> When both cache writeback thresholds are zero,
> f2fs_should_wake_up_cache_wb() returns true even with no dirty caches.
> This makes wait_event_freezable_timeout() return immediately and the
> writeback thread busy-loop instead of waiting for its periodic timeout.
> 
> Return false when both thresholds are disabled so periodic writeback
> can proceed without busy-looping.
> 
> Fixes: d7f084b1ad93 ("f2fs: cache: wake up f2fs_writeback when exceeding threshold")
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
> Based on f2fs/dev-test at ce439a2b0690.
> 
>  fs/f2fs/cache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
> index c76c4660606c5..88d4e479c8469 100644
> --- a/fs/f2fs/cache.c
> +++ b/fs/f2fs/cache.c
> @@ -740,7 +740,8 @@ static inline bool f2fs_should_wake_up_cache_wb(struct f2fs_sb_info *sbi)
>  	    nr_dirty < cache_thread->cache_wb_dirty_threshold)
>  		return false;
>  
> -	return true;
> +	return cache_thread->cache_wb_total_threshold ||
> +		cache_thread->cache_wb_dirty_threshold;

Thanks for the fix, do you mind I fold this into original patch? as it
is still in dev-test.

Thanks,

>  }
>  
>  static int f2fs_cache_writeback_kthread(void *data)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
