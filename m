Return-Path: <SRS0=V0x5=GO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CAEC433E9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Jan 2021 15:00:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A7222795;
	Mon, 11 Jan 2021 15:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A7222795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kyygF-0007qF-Vu; Mon, 11 Jan 2021 15:00:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jack@suse.cz>) id 1kyygF-0007q1-7V
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jan 2021 15:00:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iey68WWVjyploGx2KyESkUwhn2c202bhiDX092f/qEk=; b=EAB+slbLBRJlJvNyoAm8fAna3e
 SEou61EpDpigKEa1woI0qBqMs98cqoO0yRHM0T/YDzMntq/5vRHVgJ9b8XkBT7qZCw99/Yvt5yM0N
 TYltu7vlMDnVdMh3WMvfSwu4BkYnPbyBf5wdrEP2ZjjE+Jb1n7mAB10KK4yHoBAQsCUI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iey68WWVjyploGx2KyESkUwhn2c202bhiDX092f/qEk=; b=FDFJkC25/cOitU3//7+cu2rVLq
 U2t4vrPod3rfIkt+GCXr8owHKw9rQuZ4v17dRAXlpQeDazAYab9ZKOa5HNENtOe6t+WBgz2QDrve2
 /8ZWqxM/dE6X7Ff7shMML/2hoxAc39GuYRJNus3p4/bI5geyyL16qJGvF7jKrQiSInhc=;
Received: from mx2.suse.de ([195.135.220.15])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kyyg7-009bMe-0U
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jan 2021 15:00:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4E4B4AFA7;
 Mon, 11 Jan 2021 15:00:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 1B8AF1E0807; Mon, 11 Jan 2021 16:00:05 +0100 (CET)
Date: Mon, 11 Jan 2021 16:00:05 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20210111150005.GG18475@quack2.suse.cz>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-9-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-9-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1kyyg7-009bMe-0U
Subject: Re: [f2fs-dev] [PATCH v2 08/12] fs: drop redundant check from
 __writeback_single_inode()
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

On Fri 08-01-21 23:58:59, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> wbc->for_sync implies wbc->sync_mode == WB_SYNC_ALL, so there's no need
> to check for both.  Just check for WB_SYNC_ALL.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 80ee9816d9df5..cee1df6e3bd43 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1479,7 +1479,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  	 * change I_DIRTY_TIME into I_DIRTY_SYNC.
>  	 */
>  	if ((inode->i_state & I_DIRTY_TIME) &&
> -	    (wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
> +	    (wbc->sync_mode == WB_SYNC_ALL ||
>  	     time_after(jiffies, inode->dirtied_time_when +
>  			dirtytime_expire_interval * HZ))) {
>  		trace_writeback_lazytime(inode);
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
