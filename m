Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC283C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Dec 2021 15:19:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n1rmL-0000xH-Jh; Mon, 27 Dec 2021 15:19:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1n1rmK-0000x7-G3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Dec 2021 15:19:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZKL/dgfFAzygr/pl1t3m+y6DBLYUWYSp19DqRxTXikg=; b=DQhq6PkHZlrAMX9t/SWB6UI6Oq
 Njhab33weL/9aoheC0DgcFsEBf9kXP/3RZUgARixUBuM0qwDB7g1/vzB2xEbFJa6ncgpMPr7qzU2t
 voisD3pEgCxJDIodE9b3gJNj5ADNIVxLrfUtRCq7+ybRlfe0hU4WGZ7MB28z952J8HMc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZKL/dgfFAzygr/pl1t3m+y6DBLYUWYSp19DqRxTXikg=; b=aCKVJ8aBG+aja3qf0XYUVZDCM5
 RETzDo7yhb4foNOUe4waiMGotOrLWIG3nVZPMwKtJz2TgvZLCpbRc2SCuX4R16Ly5swlaSMFYVaol
 I6/YtRRdu9g+InjNj5aDvAJZMV9hH9WEixdgh2ZK4SK4ctLyJp4xY5mac7VdlyPqlk3g=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n1rmJ-0005Q0-T8
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Dec 2021 15:19:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7A7C361092;
 Mon, 27 Dec 2021 15:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAB0C36AEA;
 Mon, 27 Dec 2021 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640618345;
 bh=kA4npB6yoTZRYf7IjekNCJoGQEoGpO0ejy34xngjDYk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mrq6JM9Yed2ObhToBjRx6yd1MeMzaCojE8ZE0j28gQNLwkVcnHZE3e9l/Bbs/3wng
 ryl3YaRr9LMzNJWb+f3ktfS5aixG7tGhxh4gLS2pBI2nh876UL/Y9GjJIyyB5leNbL
 48VqURpetSjIDGw/F5G5vD2CdpegSoDUlIOh3+OcTiagWzneGmiVJbTes1hAw21pZZ
 uhTzByN2DLsELdRbh1bBHeowAYP8HOYEx7sZph17BFTig1ZErOfuMHikekVHmjLcHz
 mHI8l08EcKmUy0rRd5FFooD48cJcgfyA0q5iPrMCo1i4M/FuHHd75qk3Wjgd+PyJYz
 HlJ16jZCxiROA==
Message-ID: <565d08aa-f615-83d2-9f39-54cac2fdbd84@kernel.org>
Date: Mon, 27 Dec 2021 23:19:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org
References: <20211227094051.108938-1-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211227094051.108938-1-changfengnan@vivo.com>
X-Headers-End: 1n1rmJ-0005Q0-T8
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: remove redunant invalidate compress
 pages
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/12/27 17:40, Fengnan Chang wrote:
> Compress page will invalidate in truncate block process too, so remove
> redunant invalidate compress pages in f2fs_evict_inode.
> In normal case, f2fs_evict_inode only called when i_nlink become 0, so
> unlikely.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
>   fs/f2fs/inode.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 2ab3b424735a..ef30f3698a97 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -751,7 +751,8 @@ void f2fs_evict_inode(struct inode *inode)
>   	trace_f2fs_evict_inode(inode);
>   	truncate_inode_pages_final(&inode->i_data);
>   
> -	if (test_opt(sbi, COMPRESS_CACHE) && f2fs_compressed_file(inode))
> +	if (unlikely(inode->i_nlink) && test_opt(sbi, COMPRESS_CACHE) &&
> +				f2fs_compressed_file(inode))

unlikely is not necessary, how about:

if (test_opt(sbi, COMPRESS_CACHE) && f2fs_compressed_file(inode) &&
	(inode->i_nlinke || is_bad_inode(inode)))

Thanks,

>   		f2fs_invalidate_compress_pages(sbi, inode->i_ino);
>   
>   	if (inode->i_ino == F2FS_NODE_INO(sbi) ||


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
