Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54190D2502E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Jan 2026 01:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u8eFpDozOImvwmg1B9V0UjH5UrdqyHNhUJdxbSBH60M=; b=TqZkWWhBRP4RVf8ZhBQJG79tvV
	/s7hNu2ZogeOu1GYyx3Q99QSGUZqj83nnbTmJ6f4Uz8Z7czhgU02A7dYQuYhEifbp78kL0Y3TebPW
	H4o5CIq+FK+Iq5bdGzWRNXLm8ylnb96d8SiKCbK+eA5IEZMZnd8JI59m9eXCLE8F9Zwc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vf6Ke-0004aE-90;
	Mon, 12 Jan 2026 01:02:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vf6Kc-0004a7-Jy
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jan 2026 01:02:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gjdgwLsfF1ofLshvHkpKHKPlxN9m71KKYcrh4PcNnXI=; b=TyqE4qUTxjA5tD6EAq3/SAW9qg
 N8FA3Wl5q1vrmidKCGC/R0EbnbQBKJwMBE6wwMCj8YuMUG80rk6HDH5t1Ng4odr8rQFYv8eeHhFVI
 /LLvBBKOlORHMHLhe0JdDMiaAUiTHeeXbfNjuhNjXb8ioxV5JfT5RNDm58uP06rd786I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gjdgwLsfF1ofLshvHkpKHKPlxN9m71KKYcrh4PcNnXI=; b=NoWw1OsvF7yCEcZmqAqu96R888
 PZDc1PWQHDm9VEo+uOLe5S9gGLa060Jg4uMSmkRrpQk/wjz+K8r7jlpZ53xtIi0Gq8BUyThFUB0IP
 fhxP5dR0UZBU8GThE4IcFAgY3J6J9WFOaiXfcVwj5xkqJUsC7m6QjkAZ1i9Qk9IXKVcs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vf6Kc-0007tn-6W for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jan 2026 01:02:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CFF8640514;
 Mon, 12 Jan 2026 01:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13E1C4CEF7;
 Mon, 12 Jan 2026 01:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768179768;
 bh=a3jueOmJgOzgdKLB9j/N2iyZkyJk2mut/X4NQcziptM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=u+8mjHWCon1SEzSLZW2hoFcGQ1WDLGzPyX/usaQyM4lhUBv8xa43Ow4FgBGuT2T0m
 jC/f7pA2l7gTwUATodJb4qtCz43wSQquMZD/SeSfHsBM4EKEaFfFiHyGx+LsHEUx1D
 9X3t4cvY7/IWefAVR6yebA5Y2UbK/xlZvAHkJrHwK1RsxYvyjHKtp75AhDnelmt4Di
 TesPlyRPY0ZTfrg23DOl38nvZ1hBhByKZopAVpXpuozPAujOuXjBXdL6Tkq3GO2PGM
 /MtgmNgfnjMn38lzffD9qp8Bk04eenDALqgzte5KbkjgMANQ66NfmMrMM1873ZA9D/
 Fk7xK0V7o8BrQ==
Message-ID: <0aca7d1f-b323-4e14-b33c-8e2f0b9e63ea@kernel.org>
Date: Mon, 12 Jan 2026 09:02:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao@126.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <20260111100941.119765-1-nzzhao@126.com>
 <20260111100941.119765-2-nzzhao@126.com>
Content-Language: en-US
In-Reply-To: <20260111100941.119765-2-nzzhao@126.com>
X-Headers-End: 1vf6Kc-0007tn-6W
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add 'folio_in_bio' to handle
 readahead folios with no BIO submission
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/11/2026 6:09 PM, Nanzhe Zhao wrote:
> f2fs_read_data_large_folio() can build a single read BIO across multiple
> folios during readahead. If a folio ends up having none of its subpages
> added to the BIO (e.g. all subpages are zeroed / treated as holes), it
> will never be seen by f2fs_finish_read_bio(), so folio_end_read() is
> never called. This leaves the folio locked and not marked uptodate.
> 
> Track whether the current folio has been added to a BIO via a local
> 'folio_in_bio' bool flag, and when iterating readahead folios, explicitly
> mark the folio uptodate (on success) and unlock it when nothing was added.
> 
> Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
> ---
>   fs/f2fs/data.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f32eb51ccee4..ddabcb1b9882 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2436,6 +2436,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	unsigned nrpages;
>   	struct f2fs_folio_state *ffs;
>   	int ret = 0;
> +	bool folio_in_bio;
> 
>   	if (!IS_IMMUTABLE(inode))
>   		return -EOPNOTSUPP;
> @@ -2451,6 +2452,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	if (!folio)
>   		goto out;
> 
> +	folio_in_bio = false;
>   	index = folio->index;
>   	offset = 0;
>   	ffs = NULL;
> @@ -2536,6 +2538,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   					offset << PAGE_SHIFT))
>   			goto submit_and_realloc;
> 
> +		folio_in_bio = true;
>   		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
>   		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
>   				F2FS_BLKSIZE);
> @@ -2545,6 +2548,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	}
>   	trace_f2fs_read_folio(folio, DATA);
>   	if (rac) {
> +		if (!folio_in_bio) {
> +			if (!ret)

ret should never be true here?

Thanks,

> +				folio_mark_uptodate(folio);
> +			folio_unlock(folio);
> +		}
>   		folio = readahead_folio(rac);
>   		goto next_folio;
>   	}
> --
> 2.34.1
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
