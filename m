Return-Path: <SRS0=MO+R=IV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C612AC433E9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Mar 2021 18:34:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903EE619C6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Mar 2021 18:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903EE619C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lOlqw-0003zY-65; Tue, 23 Mar 2021 18:34:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lOlpx-0003wq-Ss
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Mar 2021 18:33:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4ACpTaTaccGZz22NVLefFKJA0kreKzoZN1bibjo5Od0=; b=W48ssWhnnn4XsmW+bymlov2uda
 2mx8fsmYX1uLKluMF/o01TMwssTfoIXqazyRKIgS5r4xKgsJSk4Gq3j99sKCQ1AY3OzXWKX7oGStR
 0Ggj5iY2IErDWiegg5+3u7d2QEbFjnxS/Xknbcqj8dD8+GkyKiwm0AmRSbnLodmnZI3E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4ACpTaTaccGZz22NVLefFKJA0kreKzoZN1bibjo5Od0=; b=KYPs2vrdKCX8mnKGv+xrAy9Qfu
 0Urhnce94GGsKPqn/4YOoc4nCBXGyhhFhmokotdycfleUue3KQL4pRRcrpS6vgJt0m8WzbvrbgSW8
 EFCApzD0/CBH1ZBwpVv+3aUjg0Nx56GI9Ad/VC74Whq81cDhkhS/WrdBUVgw7abUO5lg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lOlpt-0007Db-05
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Mar 2021 18:33:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2AEB619BB;
 Tue, 23 Mar 2021 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616524369;
 bh=SrXcVBV4nIQgyIM/fSLSVHs7w6pMJ/2dsxCVsXvB8zY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rUjxWZ9gdwrdHn6tWK74f9t7uFHKIpK1FRY4C4+u0het+B+AG2OxVB/nx9jgS0UZ4
 FeEa1ualNfMqtREFs8w3W4sm7yjOWOkDAfLCe7cmp1zF9fshivPKLAaE9ixmB0sYH2
 h7pIoYN8jeDMLuja7RyiDJ4RaZ+rc4OzDcIN4OaocgEfAnB0tSypo3qDOidK6xAUW+
 FKfU+nIIJu0GFVoBGQQTZtRqT9AEbm1ZuvpcGLhusOL7GeMzMmsE+of5ydaXRxPUMa
 GI4OJ/q8aY5AeSIiVeGwy513R4nCNr/TwchCu0ZLrTIawt7d1abEKHM01bgbrtP437
 R3wvGVqQYIWwQ==
Date: Tue, 23 Mar 2021 11:32:47 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YFo0Tz1zl4tw7lUP@google.com>
References: <20210305095601.96591-1-yuchao0@huawei.com>
 <d9c118eb-45b3-7f35-70bd-cb016957e6e8@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d9c118eb-45b3-7f35-70bd-cb016957e6e8@kernel.org>
X-Headers-End: 1lOlpt-0007Db-05
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to align to section for
 fallocate() on pinned file
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

On 03/23, Chao Yu wrote:
> On 2021/3/5 17:56, Chao Yu wrote:
> > Now, fallocate() on a pinned file only allocates blocks which aligns
> > to segment rather than section, so GC may try to migrate pinned file's
> > block, and after several times of failure, pinned file's block could
> > be migrated to other place, however user won't be aware of such
> > condition, and then old obsolete block address may be readed/written
> > incorrectly.
> > 
> > To avoid such condition, let's try to allocate pinned file's blocks
> > with section alignment.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> Jaegeuk,
> 
> Could you please check and apply below diff into original patch?
> 
> ---
>  fs/f2fs/file.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 236f3f69681a..24fa68fdcaa0 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1648,13 +1648,13 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>  		return 0;
> 
>  	if (f2fs_is_pinned_file(inode)) {
> -		block_t len = (map.m_len >> sbi->log_blocks_per_seg) <<
> -					sbi->log_blocks_per_seg;
> +		block_t sec_blks = BLKS_PER_SEC(sbi);
> +		block_t len = rounddown(map.m_len, sec_blks);

len is declared above, so let me rephrase this as well.

> 
> -		if (map.m_len % sbi->blocks_per_seg)
> -			len += sbi->blocks_per_seg;
> +		if (map.m_len % sec_blks)
> +			len += sec_blks;

is this roundup()?

Could you check this?
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=e1175f02291141bbd924fc578299305fcde35855

> 
> -		map.m_len = sbi->blocks_per_seg;
> +		map.m_len = sec_blks;
>  next_alloc:
>  		if (has_not_enough_free_secs(sbi, 0,
>  			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
> -- 
> 2.22.1
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
