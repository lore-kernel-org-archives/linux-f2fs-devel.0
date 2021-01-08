Return-Path: <SRS0=cRzz=GL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D713BC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 Jan 2021 09:11:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E36522248;
	Fri,  8 Jan 2021 09:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E36522248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kxnnV-0008Up-Qj; Fri, 08 Jan 2021 09:11:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hch@lst.de>) id 1kxnnM-0008UD-35
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Jan 2021 09:10:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZDMeCoYrOdkHWZ7zu9pNB1zGZRq66p543FzmoSOc7oY=; b=er39Gb5DTebC4mCJI0UZTCnzUr
 D9SC+qsgx8IgT9XPyTo9kF2MUDiIt6ECdKJSnAONO/8IfGgSbDbj8ZxWM0X/wTh2QgYZAH3exx7Gm
 2PTkN6Q28pJD8GNjAijGBbBhWxvQLn2LYq82uK/DFze5b8ut9TuWhFmokXNK/7knEwug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZDMeCoYrOdkHWZ7zu9pNB1zGZRq66p543FzmoSOc7oY=; b=TrZGcfbzzUwOgt8N8pRWgVxuV6
 1q5ZT92Rvxq3aIVqJFNK06PaDi2PwhX1mRiua3Wgux7TFH1teaWJLaurpbDxG7iBxf/u63219weKX
 urFPtR2tlywHZ4BCePPuIbLmRJDokKCd1yS5TyJwL06utcl8M0zAXVdwcB9MGDDIPFAA=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kxnnF-009Y5G-89
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Jan 2021 09:10:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B6DD168B05; Fri,  8 Jan 2021 10:01:33 +0100 (CET)
Date: Fri, 8 Jan 2021 10:01:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Message-ID: <20210108090133.GD1438@lst.de>
References: <20210105005452.92521-1-ebiggers@kernel.org>
 <20210105005452.92521-2-ebiggers@kernel.org>
 <20210107144709.GG12990@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210107144709.GG12990@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1kxnnF-009Y5G-89
Subject: Re: [f2fs-dev] [PATCH 01/13] fs: avoid double-writing inodes on
 lazytime expiration
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
Cc: linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> +	/*
> +	 * If inode has dirty timestamps and we need to write them, call
> +	 * mark_inode_dirty_sync() to notify filesystem about it.
> +	 */
> +	if (inode->i_state & I_DIRTY_TIME &&
> +	    (wbc->for_sync || wbc->sync_mode == WB_SYNC_ALL ||
> +	     time_after(jiffies, inode->dirtied_time_when +
> +			dirtytime_expire_interval * HZ))) {

If we're touching this area, it would be nice to split this condition
into a readable helper ala:

static inline bool inode_needs_timestamp_sync(struct writeback_control *wbc,
		struct inode *inode)
{
	if (!(inode->i_state & I_DIRTY_TIME))
		return false;
	if (wbc->for_sync || wbc->sync_mode == WB_SYNC_ALL)
		return true;
	return time_after(jiffies, inode->dirtied_time_when +
			  dirtytime_expire_interval * HZ);
}


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
