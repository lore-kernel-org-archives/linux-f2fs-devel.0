Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE05C55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I6add7PDHbhEFkhe/yCsPbxADUR+0BKyjXl+mTPVFfQ=; b=lRf7TPg6y3m+bzrNutTSQbLr7g
	X1Sgrk1g7Qu3xDSBrHYn7zauMZ1HVYI+F1b3eTwqIcpBWyaZywMcQ1v4HNg/lDB7ZI02zrMsjUabH
	O6GOodFIG5MEJ3lur8lBFfOis/HzTh7/P1n9TiHVanLWzjf6GNvh0oicbeV04hVdCW7Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqmmQ-0001Er-W3;
	Mon, 03 Aug 2026 07:08:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqmmP-0001Ek-Qe
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O4JiXbd+a30fELma3hISkdDkULyA1AU9v/peO8WzUe8=; b=YY88pGtpHMQXWkv9uhyDfKNq5f
 GI5pPvZxFTj++JaEXiVQnJFrZUzl0QddSTPXGiwFO/jQ0r4s4KZa88kXJ+xnPHzwvnlCafq0/0tLc
 DOcRfNqDPTJktRdbE/D/PXF63jd9omJF/9x7pLycXH85G8XZLdNq57A2NyHVfCI3VpCk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O4JiXbd+a30fELma3hISkdDkULyA1AU9v/peO8WzUe8=; b=men9KO/6UmtqXb/FKL4QnO3apf
 pVti12iciiDx69cUiwDMXSjIrnDXNSU4YG+seexw94Lhgp67jiMUw4fhHhrldYsgdzU440gB7uAMW
 1GfdOdHeV9hUdwuSlx9izkFcdRH42T9Pxkw4FZ66pfjGa5kYfcSUY/HfiFgYS8zeu6ck=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqmmO-0005kF-Cv for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:08:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3CBE600FF;
 Mon,  3 Aug 2026 07:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A521F000E9;
 Mon,  3 Aug 2026 07:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785740882;
 bh=O4JiXbd+a30fELma3hISkdDkULyA1AU9v/peO8WzUe8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=jAeQkoFt7WhF36HIiKZE1FWXw7GajEghVI/VG0yFpeYFsmymQPi2vAtmNqhArxkj8
 et0eErY7KeP2YLj/KRPTwp2RLHZwJLcpNc5hnv5yF0TtYSyVtYTjeEUxOvyUcwdCUz
 bRBvWmARk4cKizrXkUuFw3TJuiETTmCMOEGtMjus2+vgCnZmBHdgAPHCpixVHzlrkt
 cf7cpLFA5haRaZ7us8BGvTYzky2rbsvei060XYm/vOFWjM8gFR7w6UkU7OI16J2loy
 NAX/hUJeV52qKJ5g+0/SEUK1xIsVl5gBIyirtB3KXgf100ZF2p7n7jVmgMg3a7237B
 aRVtfuDodhT2w==
Message-ID: <4febf145-36cf-4d4a-b9d3-1c33ac273607@kernel.org>
Date: Mon, 3 Aug 2026 15:07:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hao-Qun Huang <alvinhuang0603@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260708065439.1139937-1-alvinhuang0603@gmail.com>
Content-Language: en-US
In-Reply-To: <20260708065439.1139937-1-alvinhuang0603@gmail.com>
X-Headers-End: 1wqmmO-0005kF-Cv
Subject: Re: [f2fs-dev] [PATCH] f2fs: reject overlapping move range after
 len expansion
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/8/26 14:54, Hao-Qun Huang wrote:
> F2FS_IOC_MOVE_RANGE treats a zero length as a request to move data
> from pos_in to EOF. However, the same-file overlap check runs before
> that expansion, so a request with len == 0 bypasses the overlap
> rejection added for same-file moves.
> 
> For example, with a four-block file, moving from block 0 to block 1
> with len == 0 is accepted by the old check because pos_in + len is
> still pos_in at that point. The code then expands len to cover the
> rest of the file and calls __exchange_data_block() on overlapping
> source and destination ranges in the same inode, which is the
> data-corruption case the overlap check was meant to reject.
> 
> Move the overlap check after the source range has been validated and
> len == 0 has been expanded, so it sees the effective length. This is a
> no-op for non-zero len (the value is unchanged there) and keeps the
> existing early return for identical positions.
> 
> Fixes: d95fd91c1ac1 ("f2fs: exclude special cases for f2fs_move_file_range")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>
> ---
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4b52c56d71f0..fdfef01dc799 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3144,8 +3144,6 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   	if (src == dst) {
>   		if (pos_in == pos_out)
>   			return 0;
> -		if (pos_out > pos_in && pos_out < pos_in + len)
> -			return -EINVAL;
>   	}
>   
>   	inode_lock(src);
> @@ -3171,6 +3169,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   		goto out_unlock;
>   	if (len == 0)
>   		olen = len = src->i_size - pos_in;
> +	if (src == dst && pos_out > pos_in && pos_out < pos_in + len)
> +		goto out_unlock;

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

>   	if (pos_in + len == src->i_size)
>   		len = ALIGN(src->i_size, F2FS_BLKSIZE) - pos_in;
>   	if (len == 0) {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
