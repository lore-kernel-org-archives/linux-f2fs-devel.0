Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5E3C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 29 May 2022 06:59:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nvCtC-0001d1-H4; Sun, 29 May 2022 06:59:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nvCtB-0001cq-5t
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 May 2022 06:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i3z3zPwNjFOftRNGg2yCf7o0oxURRptFmUkZGVFMFNM=; b=EQuD53ibxfo7qVhplUovOi9NA9
 U/GiRM920T8d8vUHy1vYB/owaIq07yIL0veJkRiHCMaEz5SrgnCKI6H3EJiO9OvsYNJaBA0UBK1Cv
 Ag8Un7rQqYuKIw8kRtl0YtxWt5/hx1GO3I7vQ/R2ARftxveW+sL+Q1kmZlPS8y1ow8So=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i3z3zPwNjFOftRNGg2yCf7o0oxURRptFmUkZGVFMFNM=; b=gCvVQYIeCVqlZXf83BT96lLSGF
 LKbVKHF+GSObZKnwniG11XJ/HS4VxqWVXlxYG5E3igwqSovHjWikdxTuJY1klV+XASed5VlDBOqHK
 RPLrIMXnYBkvDvtBaGxaaT1Q1pTNIXB3COYT9WgIrz35heMtUinv8LDU+Gez3sTDDH2g=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nvCt7-0007c1-Tp
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 May 2022 06:58:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CC98360DF9;
 Sun, 29 May 2022 06:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15C0C385A9;
 Sun, 29 May 2022 06:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653807533;
 bh=95wbLei2yMNGyVdvi55Y/XM841K2c9PMa5u5DUTd8RM=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=b3sq0prvrUhVKLcGOerqBOiOObZMJ5xzCxXsI8KGTySpeUEkQQ6B/BS1lwfURowXd
 maQmC9r42lyb6ZM0lnqCfLC/c7R32dFTwM0OmxQxCD5TyOu5ZRVsrTaB2f8mnEIWG5
 VzsF6O3/bu7x/RX6B8rUMnx2SLKNoT7cVxHH2U4bzNmU3dE+dqX27VEVeuPUOdRAv/
 xRXifIsDa8+VnpTJfsGXCdui/YqNA+FbBXmhlaePA1VzfdlJ+Tyr1PmJ302Q+u0c0w
 RGDQQpTyEluIyUyH/Sy7xefB3QvfRhP0s0Qe3uKxqzUqXjKCI+CvauOtRVF9GlcI2/
 NSVaHtz/rUXvQ==
Message-ID: <fe8f163b-5ba9-f361-8e6f-5af007564420@kernel.org>
Date: Sun, 29 May 2022 14:58:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Jack Qiu <jack.qiu@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20220528093503.2608388-1-jack.qiu@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220528093503.2608388-1-jack.qiu@huawei.com>
X-Headers-End: 1nvCt7-0007c1-Tp
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix page leak in redirty_blocks
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

On 2022/5/28 17:35, Jack Qiu via Linux-f2fs-devel wrote:
> When find_lock_page return error, page in [i, page_len) will leak.

I doubt it is impossible to fail in find_lock_page due to one extra
reference count was added in previous read_cache_page().

Thanks,

> 
> Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
> ---
>   fs/f2fs/file.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 100637b1adb3..0e8938c5918e 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3954,6 +3954,12 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>   	struct page *page;
>   	pgoff_t redirty_idx = page_idx;
>   	int i, page_len = 0, ret = 0;
> +	struct page **pages;
> +
> +	pages = f2fs_kvzalloc(F2FS_I_SB(inode),
> +				sizeof(struct page *) * len, GFP_NOFS);
> +	if (!pages)
> +		return -ENOMEM;
> 
>   	page_cache_ra_unbounded(&ractl, len, 0);
> 
> @@ -3964,6 +3970,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>   			break;
>   		}
>   		page_len++;
> +		pages[i] = page;
>   	}
> 
>   	for (i = 0; i < page_len; i++, redirty_idx++) {
> @@ -3975,8 +3982,14 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>   		set_page_dirty(page);
>   		f2fs_put_page(page, 1);
>   		f2fs_put_page(page, 0);
> +		pages[i] = NULL;
>   	}
> 
> +	/* put pages[i, page_len) when error happens */
> +	for (; ret < 0 && i < page_len; i++)
> +		f2fs_put_page(pages[i], 0);
> +	kvfree(pages);
> +
>   	return ret;
>   }
> 
> --
> 2.31.1
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
