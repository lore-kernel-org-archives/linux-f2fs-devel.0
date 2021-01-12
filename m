Return-Path: <SRS0=pHl4=GP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C922C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Jan 2021 13:25:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BB022E03;
	Tue, 12 Jan 2021 13:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BB022E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kzJg3-00084D-0j; Tue, 12 Jan 2021 13:25:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hch@lst.de>) id 1kzJg2-000846-8f
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 13:25:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ohjhUAmEGPJC4BcqI1gjkDSNtKuZBC2S/xaU2E56EaI=; b=DvUHTME6/eUIqt/aSxYQxIMBim
 0o0pKSWj+9ig7zfMxadAC1+ioa1q1v3ELa0hZj2Li4wn2QcW9Y5x4Agfq+eHR8Vuf/y/AzzdRUwEJ
 eFfdrA3mXJuEp9TFuzInqjgqiFZ+SldF3D3mj13SNBUnaGtPtchhGFxNKgRCSVZAa8X4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ohjhUAmEGPJC4BcqI1gjkDSNtKuZBC2S/xaU2E56EaI=; b=PYPXMKZV9/ZXUJiSmi51Fh7Kio
 YjCYDEJikQlXu6GiIHuAygMpG3/ZJ7UsuJxyAhIltra0mjshWMp1F5eubeOXoOhAQo5TjkHA46GZh
 nDzNeUX841eDVnq/AU9SftjPAp4BtQ4owvsRwCYqMSrzAYE2tCkQNzFtK/dgj4ccf2j0=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kzJfv-0046j8-KP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 13:25:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5AC0A68B02; Tue, 12 Jan 2021 14:25:21 +0100 (CET)
Date: Tue, 12 Jan 2021 14:25:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20210112132521.GB13780@lst.de>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-12-ebiggers@kernel.org> <20210111105342.GE2502@lst.de>
 <X/yzzKhysdFUY/6o@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X/yzzKhysdFUY/6o@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1kzJfv-0046j8-KP
Subject: Re: [f2fs-dev] [PATCH v2 11/12] ext4: simplify i_state checks in
 __ext4_update_other_inode_time()
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

On Mon, Jan 11, 2021 at 12:23:40PM -0800, Eric Biggers wrote:
> > I think a descriptively named inline helper in fs.h would really improve
> > this..
> 
> Do you want this even though it is specific to how ext4 opportunisticly updates
> other inodes in the same inode block as the inode being updated?  That's the
> only reason that I_FREEING|I_WILL_FREE|I_NEW need to be checked; everywhere else
> justs want I_DIRTY_TIME.
> 
> We could add:
> 
> 	static inline bool other_inode_has_dirtytime(struct inode *inode)
> 	{
> 		return (inode->state & (I_FREEING | I_WILL_FREE |
> 					I_NEW | I_DIRTY_TIME)) == I_DIRTY_TIME;
> 	}
> 
> But it seems a bit weird when it's specific to ext4 at the moment.
> 
> Are you thinking that other filesystems will implement the same sort of
> opportunistic update, so we should add the helper now?

For my taste these checks for flags is way too much black magic and will
trivially break when people add new flags.  So having a helper next to
the definition of the I_* flags that is well documented would be very,
very helpful.  My preferred naming would be something along the lines
of 'inode_is_dirty_lazytime_only()'.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
