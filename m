Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FA9CC6B2D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uaOjFv78lSvdZkLmYfmtXzd8eejyyh6TTKBvUfso6EM=; b=i/lYJl9NAnAWi5yJ+GoFdfQ2wy
	bWIeQS2k7VSbdnVnFvlYY02eoIIQnESoUtxRCOQwwy1DL+olv7lc2qLkaJl7VxVLughW3zoQyNdtF
	axBgozvk4v9uCJfnc5cswRfG3BFjmzr/WQcqXhLYgbmAA165fJYG6iw9blPIvcSCaKho=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHC8b-0008MY-7Y;
	Thu, 15 Oct 2026 03:28:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xHC8a-0008MR-D0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 03:28:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=THrvGhaMruo3uO4UuSuqySwQUJkWS/AIHlJsZDp2/MQ=; b=camag0obceTyV5f7SZ64Cpa/2q
 S9niqNIWRvqFr9h5gW19+K4P6iYdq3dOrW/Te8h3m1E3PRtzwuRbEYR5g9ctXgxpdn6DRfFTyiMys
 GRKwima9lvmD29A7l3LRqpHVOa4zhyfcW62IDujmYHGjLOFhjJy7hpzSKi8oYFlGtO3Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=THrvGhaMruo3uO4UuSuqySwQUJkWS/AIHlJsZDp2/MQ=; b=FQNybgFfA1dzO5UHeAJiUiqEmS
 tPfqPocekGqHQRgihx37yvwwoHkbIDnBLFReZaSCHwBWDMyP1shASO6WGruDOLpmZwAkNzrFlacAM
 Bt+lcMelCTmXdQVi+LxSEO0tEG1PBbDZWK5rPQYSsuVzYBBQVOYkWDoV0oFWB3H3CcXA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHC8X-0003qi-HL for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 03:28:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25C7B41E43;
 Thu, 15 Oct 2026 03:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FD41F000C4;
 Thu, 15 Oct 2026 03:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792034884;
 bh=THrvGhaMruo3uO4UuSuqySwQUJkWS/AIHlJsZDp2/MQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=bvKPJ4i9BGnucKtrHJlFlwwuGfjmt2uyvv5bE6/KNt2m8EoBd8ikKv5s61fUCHE3A
 x1Wnq0ICn7tV8y2L8Iaw6muvYcDo3NZPd2VKzc2jyw3Qmhaqkhsf68jEuF42qTckV2
 mB2O+rU2eSFNtpvLLBBd7d/cEa/fsOHkrJ45GjqS+JhjQM+IEB7W0e6ivesGrrC+ms
 uUXSQQkEmOgEKTV7XBxsHetrXdMryZm/SBRCRDOjMY6UYT3fTgpKLP63rmaSb7d96M
 5w2fuBNra+4GU35gCLXSTEHKNQXpf5Zx9zv2m7fLFLBoP6mmo791Jk5nsZBnYBCJbs
 vCnCgwK1cryDA==
Message-ID: <d58c66d6-0163-4084-ab79-560513108e9b@kernel.org>
Date: Thu, 15 Oct 2026 11:28:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261015025732.1564032-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261015025732.1564032-1-daeho43@gmail.com>
X-Headers-End: 1xHC8X-0003qi-HL
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: release a removed xattr node in
 roll-forward recovery
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/15/26 10:57, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When xattrs shrink enough to fit in the inline xattr area,
> write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
> the file is then fsynced without a checkpoint, only the inode block is
> written, with i_xattr_nid of 0.
> 
> Roll-forward recovery starts from the checkpointed inode, whose
> i_xattr_nid still points to the old xattr node.
> f2fs_recover_inline_xattr() copies only the inline xattr area, and
> f2fs_update_inode() writes the old i_xattr_nid back. So the inode keeps
> the stale xattr node:
> 
>  - The node block is never released, and fsck reports "nonzero bytes in
>    xattr space after end of list".
>  - If the inline xattr list ends exactly at the end of the inline area,
>    its terminator is read from the stale node, and the removed xattrs
>    come back after recovery.
> 
> When the fsynced inode has no xattr node but the checkpointed one has,
> release the old xattr node as truncate_node() does: check its block
> address, invalidate the block and drop its node cache, which may still
> be dirty.
> 
> Fixes: 28cdce0459cc ("f2fs: recover inline xattr data in roll-forward process")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
