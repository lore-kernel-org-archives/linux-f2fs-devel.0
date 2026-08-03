Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786A7C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7u3rYrJWMB0ZxCLC3K+//ZfCFPJCYgwYSGJQ2jS/tEo=; b=g8x2bj/ZUjD/OSQTJx+ObL1lKV
	KoZby/77pgFbjf1fsqPHH7dJ5KvbWUud26dPMF8X6pVBdn76bKa6Cabg5IYJ2qigAnyeSUCTn0MkH
	NUgYyV48bo0F2Pnxk4rjwUORev52qgswonkyQLLzqD9unYduzG21d2XN/Z3AdMHogHHU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqoBc-0001Oa-D5;
	Mon, 03 Aug 2026 08:38:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqoBb-0001OU-1F
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:38:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WQ5o/ZS88bX3vd4nCEy6hjeaPlzSqlhG9oApBltnFQs=; b=hrIQH1QK6E7bq3rSmZZjdFZNqu
 YAaPHWYsOt0NY2w7PpnCKPMtWnMjGig+yxBwoyxvgzmP3rVytxq3gHYrFdhKyAcCzypATOFlWiyQi
 37aZYIxpllddKMNspk+/MB1WvB/PXOuFxgdJwNLhk5TSURHV4IP1eSB8NpWtUYfGnxUw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WQ5o/ZS88bX3vd4nCEy6hjeaPlzSqlhG9oApBltnFQs=; b=Fxu15mNDAuo5akMEkdFzqV1sHh
 jnpydeLxQwK1B4UIJDuaCJSLcuGNAbZx0XKRywRwUXHR350S2Z9UVAfZdX+a/WacPj9vG9RAknBSo
 kS+t0wS19MpiRWgyeAF3iSiRa7rAiTR0To97LwLNXbzjei25JVRm66gVhsImzyzkoIBk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqoBe-0001PR-Mx for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:38:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C03E54023D;
 Mon,  3 Aug 2026 08:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B851F000E9;
 Mon,  3 Aug 2026 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785746289;
 bh=WQ5o/ZS88bX3vd4nCEy6hjeaPlzSqlhG9oApBltnFQs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ZyCpFj1bAj6C/EoMGPixNTbuEHEr7WvD2uM0TgWTN57rT6m3R2T+UqY6PBZ+tVVH9
 mibmvtL0/StwOvHAI+LujlpGpFLxeY+jXrt9e5veGyawPLkB2MuylU2blHalWY9M6o
 jEgWsYdgDeiRPWmZiZ+yMnHDqrRM86oCdHhyJjFYT9qrZYZ/6GJI2/1ZSAXOFNMyRm
 6XotQF+8jndXGmjpP0VG+GuNP7PAR42CPw6G+YE/pshr4WGO8tFaixK9ws5oYYItxZ
 yMKdnNvjmZpLonTN7HHOn0gf6lVpECGYooNkVIx1dx7ulQmthjbx3Nbim1Pen9r0yT
 pUkLUc2OljDDg==
Message-ID: <4e5ffe9b-6f93-4210-95cb-918686c17639@kernel.org>
Date: Mon, 3 Aug 2026 16:38:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260727130430.2109181-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260727130430.2109181-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wqoBe-0001PR-Mx
Subject: Re: [f2fs-dev] [PATCH] f2fs: only redirty pinned folios in
 redirty_blocks
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
Cc: linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com, stable@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/27/26 21:04, Wenjie Qi wrote:
> redirty_blocks() pins folios with read_cache_folio() and then walks the
> same range again with filemap_lock_folio() to redirty them and drop the
> references it took.
> 
> Commit 5951fee46bef ("f2fs: Use a folio in redirty_blocks()") changed
> the second pass to a do/while loop. If read_cache_folio() fails before
> anything is pinned, page_idx does not advance but the cleanup loop still
> runs once.
> 
> If readahead has already populated the failed folio in page cache, that
> extra iteration finds it and folio_put_refs(folio, 2) drops one
> reference too many. Later drop_caches or reclaim can then report
> "BUG: Bad page state".
> 
> Only redirty the range that was pinned successfully.
> 
> Fixes: 5951fee46bef ("f2fs: Use a folio in redirty_blocks()")
> Cc: stable@kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
