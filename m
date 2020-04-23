Return-Path: <SRS0=NCuU=6H=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77225C54FD0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2020 19:50:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408422076C;
	Thu, 23 Apr 2020 19:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="e3kWNJ63";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="mlShx33G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnakBwVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408422076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jRhrP-0002Az-0e; Thu, 23 Apr 2020 19:50:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jRhrN-0002As-MK
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Apr 2020 19:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BuscXwQyBOWqi2VsHx5GftESVyiZpSJ7fjFC8sbLs/Y=; b=e3kWNJ63QuwT1jwzIMhB/y/xWL
 IvvhhN2cfOa5VZaWXJT3XhTZtuOGIIwOhFgVPehj5ewAFz5ZrcesjpvXiC/axvR9EaxT9QXkTIMxY
 oIT0hiFgjbHaKb++4nXz6RhnW39ql17K2vF27l5O//9+MAYoFawfKaF1GIigYeV8YYWY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BuscXwQyBOWqi2VsHx5GftESVyiZpSJ7fjFC8sbLs/Y=; b=mlShx33GrHjoEPe/MVusIzr6j2
 z1l2gnifrT8+8UNJq21PM0C3z4hpIi8YtO+C3PdSXc37W18nufQKINabZzTSAOZLoO1OtfTgvryMC
 +bXE1dSsKYxdCCFUPm0Koz4NUj92lEovdwRSyU+GO7gFfcY22UkyITL65OuMyVqiDi/w=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jRhrH-00BffQ-QC
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Apr 2020 19:50:09 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 464002076C;
 Thu, 23 Apr 2020 19:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587671393;
 bh=NdIcmjR1rpCMGh8Dhza7SRrZXqT4odEC+7YzykSaSFU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HnakBwVgRpRxEczGalqm5FmpNfotCzFm5qxdCkh6YSxtIKNFyvkpgqlFhvkGWuu81
 0Ttxk9coS5iU0AM59Mtz+scJ2GegLCIdJQAnVwKOqSK/jZevHdBqd/ZEZdi022cLQ+
 TImpW8U28qDWoUCqD020ADRwNlyCpg3+Urcj0sfY=
Date: Thu, 23 Apr 2020 12:49:52 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200423194952.GA99191@google.com>
References: <20200409173056.229855-1-jaegeuk@kernel.org>
 <77e9f2e6-f3f3-8ca9-e6b5-3d57c4d2acc5@huawei.com>
 <20200416213946.GA196168@google.com>
 <fd8b116a-7830-809c-70a4-a3a12da1eb14@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd8b116a-7830-809c-70a4-a3a12da1eb14@huawei.com>
X-Headers-End: 1jRhrH-00BffQ-QC
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix quota_sync failure due to
 f2fs_lock_op
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/23, Chao Yu wrote:
> On 2020/4/17 5:39, Jaegeuk Kim wrote:
> > f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
> > f2fs_write_data_page() returns EAGAIN.
> > Likewise dentry blocks, we can just bypass getting the lock, since quota
> > blocks are also maintained by checkpoint.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > v2:
> >  - fix multipage write case
> > 
> >  fs/f2fs/compress.c | 2 +-
> >  fs/f2fs/data.c     | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index df7b2d15eacde..faaa358289010 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -985,7 +985,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
> >  	loff_t psize;
> >  	int i, err;
> >  
> > -	if (!f2fs_trylock_op(sbi))
> > +	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
> >  		return -EAGAIN;
> 
> I encounter deadlock..
> 
> Should call f2fs_unlock_op() for non-quota compressed inode later.

Could you elaborate a bit?

> 
> Thanks,
> 
> >  
> >  	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index accd28728642a..5c8d3823d7593 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2656,8 +2656,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
> >  			f2fs_available_free_memory(sbi, BASE_CHECK))))
> >  		goto redirty_out;
> >  
> > -	/* Dentry blocks are controlled by checkpoint */
> > -	if (S_ISDIR(inode->i_mode)) {
> > +	/* Dentry/quota blocks are controlled by checkpoint */
> > +	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
> >  		fio.need_lock = LOCK_DONE;
> >  		err = f2fs_do_write_data_page(&fio);
> >  		goto done;
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
