Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF06C531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 23:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1OkbAesZdU6Q4GRAqRowMzBYcD3G6jVNHpci3EETcLg=; b=MDohDQaSjRWkxolLes0RIZphTR
	sA4SNWcd58mzXyQfQ3wSxrNnYyGZDtK2GmHU0d910C6Ow5OBtqLOrOHGpUKwDLKzjMjNWKDi0z8ow
	ZEg5fz8knnC4YjiQNYxCur3iZPIoqT5Z+/bV/lzWbNtbzF5WtjdEexxALwEC2LWolrOw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnPIp-0006aQ-Nt;
	Fri, 24 Jul 2026 23:27:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wnPIp-0006aH-2j
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 23:27:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OgPLBeFtoOQvxkYCdbNtEOfXgM/Nsooo6ufk7hwPv1s=; b=HLBue8TGJ1pFDjH5RpMblZLJQr
 dLJCtSam1unApohOqoQZftnMRfLBCkoc064rcc2rTHTcyjO+xQsNVChbu1BGSeKJspYBjjG2j7Yla
 RvymLvsZIMaEQF7XSqKgLlr4sXzT7AZ3a2Bw7k7PfJawwKZMUHDO+AKAHePtGkVnP+TQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OgPLBeFtoOQvxkYCdbNtEOfXgM/Nsooo6ufk7hwPv1s=; b=NKxnBIibspWzFvPhYhFVk2vcfl
 89KW1jv88KECMLkzxo73UnUGPSlfS2KRyfqtyrxXxDiIbtrVYaIKqfegqx6ciqKNsVS9XN6MkmMLS
 4KZoay0GqQVgE6OaLtEsNlfW8BD6xjbjaywdi9+GkRGXhjxzkDST1Wo1PX7PX+pHM6Lk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnPIs-0001Cl-W3 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 23:27:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C0BF4600AD;
 Fri, 24 Jul 2026 23:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D3E1F000E9;
 Fri, 24 Jul 2026 23:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784935653;
 bh=OgPLBeFtoOQvxkYCdbNtEOfXgM/Nsooo6ufk7hwPv1s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GHkjEjgd8BlItiDBtlfYPSaMvNyrgiTibzAajHRaTWif+tYvW5MR0el1W52n3PjXt
 OAfvzQ7M5YFoKwH/zNO4nmmaiU9eGZY193VpU5GyfX5koUhbTxSXSMIYAYqfLcrKlz
 h3fjh83xoFz2+SbHru4y8l/VIw+rAPWpRcTKDh2vRHBn9Rh6XZuSUn0YMBtft0GaL1
 aC9t32aiA+WDANuGHgb3vLWieO+v1IVLu03AHgn2NXaackcpdeskgxkJQ3Org8dsx8
 7/PPjYLM/giOVt3LYRkchNB6lUAtfHFxMAgwjlNZZTVd6BEeqPsPYm3H3bcwiaGLBD
 cAgcKJ/1zcKWw==
Date: Fri, 24 Jul 2026 16:25:40 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260724232540.GA1901@sol>
References: <20260721184346.416657-1-aalbersh@kernel.org>
 <20260721184346.416657-8-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260721184346.416657-8-aalbersh@kernel.org>
X-Headers-End: 1wnPIs-0001Cl-W3
Subject: Re: [f2fs-dev] [PATCH v13 07/23] fs,
 fsverity: remove check for fsverity being enabled in
 setattr_prepare()
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jul 21, 2026 at 08:40:44PM +0200, Andrey Albershteyn wrote:
> The check that fs-verity is available in the kernel is not necessary
> here. Filesystems could have fsverity files even without fs-verity
> module, then truncate will succeed. Previously, this would return
> EOPNOTSUPP if verity is missing, but if it's not EPERM was returned
> anyway.
> 
> Fixes: e9734653c523 ("fs,fsverity: reject size changes on fsverity files in setattr_prepare")
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 4f437fabb7f0..71888ac903c2 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -176,7 +176,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
>  		 * covered by the open-time check because sys_truncate() takes a
>  		 * path, not an open file.
>  		 */
> -		if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
> +		if (IS_VERITY(inode))
>  			return -EPERM;

I'm confused what the commit message is trying to say.  But ignoring
that and looking at the actual diff, it looks good.  Not sure how we
missed this.

Acked-by: Eric Biggers <ebiggers@kernel.org>

Please add Cc stable as well.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
