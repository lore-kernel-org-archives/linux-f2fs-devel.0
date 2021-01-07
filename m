Return-Path: <SRS0=SuUp=GK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F9CC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 Jan 2021 13:18:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FC72065E;
	Thu,  7 Jan 2021 13:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FC72065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kxVBB-0006nL-0V; Thu, 07 Jan 2021 13:18:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jack@suse.cz>) id 1kxVB9-0006nE-RM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Jan 2021 13:18:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yGRJjC261etHHiSCX8WtRwhmsgcMN30yk50yc4eKaTk=; b=fHgLDEYtVtsxpG1lAAs4+aMCOW
 IG2gDpw4t2p0voMP+dlQVFpjyPzmKt9mHpbMyOBLGK1+ucROtOH0aGroSHysFkMsFGROisDSTvfpF
 gj5/mdY/pWUEaCJej3s/yLKnGUZSLk6G+b9DBrID5wYK7NmVhKkgkrFYRzEOpWXBBbWY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yGRJjC261etHHiSCX8WtRwhmsgcMN30yk50yc4eKaTk=; b=cKykhXtJ6RAIbmkpnhnnbu8+zo
 WxYk2OSN/4AFwtetzAMJaQe7ngZwfw22PSDSKyJKrR8vzPODVEahkUuhraZs8jxdji87DrZ6NzUC+
 cCnA+e8qFwiQYUj33bJTvdvN6rF0wjyq3d5LRrzguA6CGlyztNgew1OSfgWIMSUUI1uk=;
Received: from mx2.suse.de ([195.135.220.15])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kxVAx-00Ai7h-MJ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Jan 2021 13:18:15 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AA419AD12;
 Thu,  7 Jan 2021 13:17:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 7BA261E0872; Thu,  7 Jan 2021 14:17:53 +0100 (CET)
Date: Thu, 7 Jan 2021 14:17:53 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20210107131753.GD12990@quack2.suse.cz>
References: <20210105005452.92521-1-ebiggers@kernel.org>
 <20210105005452.92521-6-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210105005452.92521-6-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1kxVAx-00Ai7h-MJ
Subject: Re: [f2fs-dev] [PATCH 05/13] fs: don't call ->dirty_inode for
 lazytime timestamp updates
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon 04-01-21 16:54:44, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> There is no need to call ->dirty_inode for lazytime timestamp updates
> (i.e. for __mark_inode_dirty(I_DIRTY_TIME)), since by the definition of
> lazytime, filesystems must ignore these updates.  Filesystems only need
> to care about the updated timestamps when they expire.
> 
> Therefore, only call ->dirty_inode when I_DIRTY_INODE is set.
> 
> Based on a patch from Christoph Hellwig:
> https://lore.kernel.org/r/20200325122825.1086872-4-hch@lst.de
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

...

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 081e335cdee47..e3347fd6eb13a 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2264,16 +2264,16 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  	 * Don't do this for I_DIRTY_PAGES - that doesn't actually
>  	 * dirty the inode itself
>  	 */
> -	if (flags & (I_DIRTY_INODE | I_DIRTY_TIME)) {
> +	if (flags & I_DIRTY_INODE) {
>  		trace_writeback_dirty_inode_start(inode, flags);
>  
>  		if (sb->s_op->dirty_inode)
>  			sb->s_op->dirty_inode(inode, flags);

OK, but shouldn't we pass just (flags & I_DIRTY_INODE) to ->dirty_inode().
Just to make it clear what the filesystem is supposed to consume in
'flags'...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
