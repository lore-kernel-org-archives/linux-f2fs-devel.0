Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1D8C5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XQAdPnDy15nsS52gM9VO8c8VHD7sxElfcYx+olxS0LU=; b=TOtEhfVCI7U8tNRLfxz7YeZrHo
	qd63nxY9JxyvbNJnuZClZ2yKh0FC/RK8QXjwPst7364z8ePrlYL7Q5K5SUlEFLhRBnu3J8uUr+QiK
	O/yoDb+l5KGgeF/sqLwOnWukGz8Nx77gu25BIFeaFx4oSwQzhfTplwa2LoIzvRP42ZHw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvnmS-0002Sq-RO;
	Mon, 17 Aug 2026 03:12:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wvnmM-0002Sd-U1
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 03:12:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BRFbMgM0fP8bN6SVHVyTTETj/PNKQbV2eBDfSpHMY3k=; b=W4YnXAWIzhE8vBjvpXKCTuz4qs
 5byL/YDQtYdSW3qZEJzHUWqXk130nQ3PbgvsRATLyEjx8a3uAoQhtLEazPnn/7q3a4eXz088lpCKb
 UWppq/F7tuSOgTRcZp0wDNdRBYgEnFij+FgwHteXGtAH67OykBpvqZBoGATq996eQK4Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BRFbMgM0fP8bN6SVHVyTTETj/PNKQbV2eBDfSpHMY3k=; b=YpHo0jTkOGua0k3bj3c9LXWZa4
 GLrkkEseHt890lUUVwBjvKzN+Rt7bBI7svM7Br+WU/O/58d5grrG/53b9HrTSrq4Zv8V5kl2oemCo
 54nMXPM7odRrinNcs/RnatCsKVVrzwWg8rzQUGcP3d4pJJeiLJrqckqIlKrDNeewv/lA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvnmN-00087A-4P for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 03:12:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2A5143CDC;
 Mon, 17 Aug 2026 03:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2F71F000E9;
 Mon, 17 Aug 2026 03:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786936365;
 bh=BRFbMgM0fP8bN6SVHVyTTETj/PNKQbV2eBDfSpHMY3k=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=bAjkpPImAXeRH3XQpe5pSLpBRxy5Zyy029ebaTKXlCEkA4by8khQMPLjPa741g4ra
 n+bAbiLKy8CDO0fHT4UVO1HquwC3pKrj4h+PwzOBn4KNdV9vhTh2cN3ww2/6ufDjfi
 FV+K+GWZZ1KPpHmaK5XCcbuTDh46nLyhAkrlnd2rrPewRV1SPuAxsfGEcUA43pSoBr
 C9l1eX5+r1fmDmbOWOIXyPlQ1LgXLYhKq4fn+5DLeLFda2kzSUTGw6ag4nrh1szhB7
 AlSw/VDRPyzgnHfCHWvmaCAsZIS3kMVDUvxdb5zYl7uBlurkWf1GtTg/rJbQ6iEm79
 C0knKfK+60C/w==
Message-ID: <c3a4a131-4a97-4227-8968-03fcd491c0a4@kernel.org>
Date: Mon, 17 Aug 2026 11:12:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Jaegeuk Kim
 <jaegeuk@kernel.org>, Sunmin Jeong <s_min.jeong@samsung.com>
References: <20260817022723.3324123-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260817022723.3324123-1-zhanxusheng@xiaomi.com>
X-Headers-End: 1wvnmN-00087A-4P
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix i_size when pinned fallocate
 partially fails
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
Cc: zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Sungjong Seo <sj1557.seo@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/17/26 10:27, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng1024@gmail.com>
> 
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Commit 4275b59673eb ("f2fs: fix to round down start offset of fallocate
> for pin file") moved the allocation loop's start down to a section
> boundary, but the error path still converts @expanded against @pg_start,
> which holds the unrounded start.
> 
> @pg_start exists for that conversion: commit 88f2cfc5fa90 ("f2fs: fix to
> update last i_size if fallocate partially succeeds") added it as an
> immutable base because map.m_lblk moves every round.  Each round now maps
> exactly sec_blks blocks starting from rounddown(pg_start, sec_blks), so
> pg_start + expanded overshoots the last allocated block by
> pg_start % sec_blks, and a partial failure leaves i_size covering a tail
> that was never allocated.  Nothing corrects that afterwards either, since
> file_dont_truncate() has already cleared FADVISE_TRUNC_BIT.
> 
> Keep @pg_start pointing at where allocation actually begins.

Hi Xuesheng,

Can you please provide a reproducer?

Thanks,

> 
> Fixes: 4275b59673eb ("f2fs: fix to round down start offset of fallocate for pin file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>   fs/f2fs/file.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4b52c56d71f0..cc0d2b8c4684 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1919,8 +1919,9 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>   		block_t sec_len;
>   
>   		if (map.m_lblk % sec_blks) {
> -			map.m_lblk = rounddown(map.m_lblk, sec_blks);
> -			map.m_len = pg_end - map.m_lblk;
> +			pg_start = rounddown(map.m_lblk, sec_blks);
> +			map.m_lblk = pg_start;
> +			map.m_len = pg_end - pg_start;
>   			if (off_end)
>   				map.m_len++;
>   		}



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
