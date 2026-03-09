Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8220CEF36FB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Mar 2026 07:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2X2l5QqLRZXjaszhtWlTFZmS12YhDFY/LThHvokvnBE=; b=Oj4xmBw6VdjUitjBZJ/OYZBYKE
	jhBn35mM+CUvIV0gPMw97rRyisw/+MROKGfMqfoqIznb77fi4t+b2T7zG0Jwl20PWJET0nXaZufET
	HrPJ8lvBVsLPXBFEc7/nXVwsmBHa8+cgGGYVlRxJeFaC9PVlyM8+CIdj1yy344mo18I4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vzVIH-0001Pr-6P;
	Mon, 09 Mar 2026 07:44:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vzVIF-0001Ph-E0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 07:44:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oljgG9OM1qYwUZ1BGG7xNR5yqQDuGJwCUWvYbFbuXb8=; b=bC5GnW+Qq7/u3xfiKJft4MMm3n
 eZJz2fU5fDawYXvGdO9A7bIAQuWQlNtfGK8RXzySoxogUg215h92vDVa2yqWXVbvzMbpczoOYEr7+
 A94qV+2Rc+nY9idqdv3zu9zKf7S7qTXjSDfnFnBhswCDPvdfQg7GjJ9f8N16t4VN0pWI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oljgG9OM1qYwUZ1BGG7xNR5yqQDuGJwCUWvYbFbuXb8=; b=N9VllBzOJCpivkGU08GftdNEzb
 I5KusAvDXv+RQSRMWYFBr2eJTvtYbiMs0IClIZWSAULh+qjpkYAAQUzZP3GjBLzaDQ3jDOKAczahp
 5/8ReSo9qBZuDio14Kq9EQ/92BPgjuPPhAZBFxHbsHjzF+98T9wEASUzcNMN2pODV2zc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vzVIE-0006GM-O2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 07:44:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E315600AE;
 Mon,  9 Mar 2026 07:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67401C4CEF7;
 Mon,  9 Mar 2026 07:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773042280;
 bh=ZegLcoI9M6oQ95oOXLJ0eKVaKiWl94Map1upXRf8d88=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=Tj/PwWIFrPIcNo4/as8pzs3tmSqLSZxo9cUkYjbt5xgxUr5f43C3l53bYfzdSUZJ+
 bkfgAOb/0Qfwv0Rd4YRSKhdSEB+F3qEod8QIkksiDmer3V0NTZU0qWopmoDHxk+ulM
 eoe/RgZT5rhlrcSQGONX8iV5tXxpTTQYOJVe8caKWazIqDjNTnYAqZ10ZzfE6REZHG
 VQvYBZYrl6PfV8zxGWcb2HACwOH3akhiz4uQ0Sa8qvw7Tr5D5vC1jSDTbQ8MZrTWT8
 91KZ1R/NxqI/dIPfl9rGyraYGjYhPeWA18NDPouBHUIk0vQA+KP6ihUrsuCngafhOl
 z+MP1DM7jbCsQ==
Message-ID: <9df7bc57-f0e1-4c7b-9ce1-0017eab62c2a@kernel.org>
Date: Mon, 9 Mar 2026 15:44:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Taerang Kim <kth5965@gmail.com>, jaegeuk@kernel.org
References: <20260224160654.448538-1-kth5965@gmail.com>
 <20260224165408.450957-1-kth5965@gmail.com>
Content-Language: en-US
In-Reply-To: <20260224165408.450957-1-kth5965@gmail.com>
X-Headers-End: 1vzVIE-0006GM-O2
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: evict: truncate page cache before
 clear_inode
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
Cc: syzbot+fc026e87558558f75c00@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/25/26 00:54, Taerang Kim wrote:
> syzbot reports a BUG_ON(inode->i_data.nrpages) in clear_inode() when
> mounting a corrupted f2fs image.
> 
> I agree with Dmitry's RFC that dropping page #0 in f2fs_truncate()
> can address this reproducer, since f2fs_convert_inline_inode() may
> grab page #0 via f2fs_grab_cache_folio() and leave it cached on the
> clear_out success path.

I suspect that we may miss some corner cases in f2fs_evict_inode() ->
f2fs_truncate(), can we figure out the root cause of this issue first
rather than just truncating all page cache before clear_inode()?
Otherwise, current fix may cover potential bug.

Thanks,

> 
> However, clear_inode() requires the inode mapping to be empty, and it is
> hard to guarantee that the page cache can only be populated from this
> truncate/inline-conversion path. Make f2fs_evict_inode() defensively
> truncate any remaining page cache before calling clear_inode(), so
> nrpages is guaranteed to be 0 regardless of how the cache was populated.
> 
> Link: https://lore.kernel.org/linux-f2fs-devel/20260206092958.578191-1-dmantipov@yandex.ru/
> Reported-by: syzbot+fc026e87558558f75c00@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fc026e87558558f75c00
> Signed-off-by: Taerang Kim <kth5965@gmail.com>
> ---
> v2: rebase onto torvalds/master (fsverity_cleanup_inode() not present);
>     fix patch context, no functional change.
> 
>  fs/f2fs/inode.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index e0f850b3f0c3..e7942e6e312c 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -1006,6 +1006,13 @@ void f2fs_evict_inode(struct inode *inode)
>  	}
>  out_clear:
>  	fscrypt_put_encryption_info(inode);
> +	/*
> +	 * Defensively truncate any remaining page cache, e.g.
> +	 * f2fs_convert_inline_inode() called from f2fs_truncate()
> +	 * may leave page #0 behind in the page cache when the
> +	 * inline conversion takes the clear_out success path.
> +	 */
> +	truncate_inode_pages_final(&inode->i_data);
>  	clear_inode(inode);
>  }
>  



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
