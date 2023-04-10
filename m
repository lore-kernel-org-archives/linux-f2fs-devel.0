Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3B3C76196
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Apr 2023 18:33:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1plwKd-0004Pp-SK;
	Mon, 10 Apr 2023 18:33:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1plwKd-0004Pj-3S
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Apr 2023 18:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aCedN8fVWFzIAkQmIIIPgaGze/GZkUY/NB4LnSFf3SA=; b=GQGApS4GsMt/9AonkyV6WKNprn
 ZpClvj8nxcP792m2iS6uTSsNKhcq10LENkbEbl5dishK1jldfQgRuyw3PzUx8szB188e/iq7HQArr
 Xl0TmsP61vk/1q1V6EKhhKlw6YQFq1C6gFotaOi0w6XFwyyca6rXzj424xV67gqygzX4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aCedN8fVWFzIAkQmIIIPgaGze/GZkUY/NB4LnSFf3SA=; b=UyeiXAtYIzytykXjPtTH/cQbTo
 zAZFKMGGeIHN/LYkj1sMi2p3S5nuF1IoT0voA8SXAk1S57hB3Omdi4PbRPO/3aUD6LuY0DYO1XuKe
 q4+7yf47ZiqEhiaJ2UDOGshWjNg+vuCaUwHVNtXBcVtpoVOZiKd5eGnnk98YeOvfnEUY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1plwKa-0035ij-Mr for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Apr 2023 18:33:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 54ECB61228
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Apr 2023 18:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11B7C433D2;
 Mon, 10 Apr 2023 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681151606;
 bh=LXAl7LmH7DPvBG2tCvsfOUy9uznk9588j5SHxfWELbY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mMEQVvUl5JOYt59RpLrNqNZkRWlPbS1On2qVVk11XOibMH+qD6/NVeZ1mYU7lfguT
 c495Pxo45CPFrJMZnvzy7BSlHte4c9EwTRdrM7E/ZYykBpJ/I6YcbNRg1ZO7xAWAo/
 jYUAAxCMJ6mTbeQZc5pUZ3p94YDnsjhkApIEKrmaFGVRyEAvCu3xczP5wskTZOLMQQ
 gXWGPf1Y5B6hENR/qr3Cq4M5cEwYUrZ7Qf1Cv8oxPK5JBMHrXczrltGD8kKfbu5R/r
 APyWLt1KaR0QdvrjFbvx/IY6ojlS8BrRUZjdBiUBIS79wD2QYvIv+fI42urw+8lM6b
 APOtFTHTCWL7w==
Date: Mon, 10 Apr 2023 11:33:24 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZDRWdJxP6QzcIU7G@google.com>
References: <20230410022418.1843178-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230410022418.1843178-1-chao@kernel.org>
X-Headers-End: 1plwKa-0035ij-Mr
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: remove folio_detach_private() in
 .invalidate_folio and .release_folio
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/10, Chao Yu wrote:
> We have maintain PagePrivate and page_private and page reference
> w/ {set,clear}_page_private_*, it doesn't need to call
> folio_detach_private() in the end of .invalidate_folio and
> .release_folio, remove it and use f2fs_bug_on instead.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 4946df6dd253..8b179b4bdc03 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3737,7 +3737,8 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
>  			inode->i_ino == F2FS_COMPRESS_INO(sbi))
>  		clear_page_private_data(&folio->page);
>  
> -	folio_detach_private(folio);
> +	f2fs_bug_on(sbi, PagePrivate(&folio->page));
> +	f2fs_bug_on(sbi, page_private(&folio->page));

I think we can just check page_private() only.

>  }
>  
>  bool f2fs_release_folio(struct folio *folio, gfp_t wait)
> @@ -3759,7 +3760,9 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
>  	clear_page_private_reference(&folio->page);
>  	clear_page_private_gcing(&folio->page);
>  
> -	folio_detach_private(folio);
> +	f2fs_bug_on(sbi, PagePrivate(&folio->page));
> +	f2fs_bug_on(sbi, page_private(&folio->page));
> +
>  	return true;
>  }
>  
> -- 
> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
