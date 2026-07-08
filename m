Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745B7C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HdaDVwiXdzx38b3+zdOQ3lrJQN1ScpmfutJXKtM95g=; b=B05bC4v6kmy6VyuYjADbMUrQyy
	/AXp4lIcPJZeY4q/niXH/9HUIFJr9RQyaNeAvEiYldTw2iTfJMu1pVz65ANMbwXDiboO3i4dXDmNd
	HylRm8PamZXYCAwK2z7W7B5Ye5My+YYDu0ZojJq2JwMleeQLvK8gC7bVwdueBTR3W2EY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1whI7P-0005DV-TG;
	Wed, 08 Jul 2026 02:34:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1whI7O-0005DO-FD
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 02:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NOpsRFp5Vz5pUcGeuFJY8h2sol+SNTT6AXyNJIVrmy0=; b=ck68xDb3fGV7JoQz7wOMQN2hb+
 bTiyWHz7vcwg1a/7Yl1z8ZfVG8GgZ4PyQPz4n1KQbFFuRyYe04gzeM3LIYnCYJVgbN9x56QlqoCP+
 OFp4DOkldVLFBAEMH0JkkOFc4KahL4QunYSf8QFw6jfhpFnhQ5oJzpKABuBlfPdQAApU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NOpsRFp5Vz5pUcGeuFJY8h2sol+SNTT6AXyNJIVrmy0=; b=CKYGbCTJ1ybbj3JMM8MjwQRX8t
 Fs5PWYGAp1onNtMMDe/YPpwy8saRZM+S/GWqS7cvzUj343fb27g7FC5R9sXco9krHjREO3bv4SrPA
 ffKDDuFQVPXDjVFGNxxN9kyMg9ie9jMK9/3qTRU5kB6DXoSmbr6LLaR9ippaY5iTMczs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whI7O-0005Ed-2D for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 02:34:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90F074058D;
 Wed,  8 Jul 2026 02:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A6C1F000E9;
 Wed,  8 Jul 2026 02:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783478068;
 bh=NOpsRFp5Vz5pUcGeuFJY8h2sol+SNTT6AXyNJIVrmy0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=MBIv9dtPsK92v7GcTvhvJ1Cfma2NmpBjbmSe2tjx+sNYFvoLKh5nGF41rcTpqRc6p
 RKsPeAXdrv72Z+FDU8yXSmTgnMTtS0SwXyR2ER4/LraKJaxUE0M5ILL+Sien+OTUk0
 fJz3IMRXxv9wLHKjbHQWYdzQbwSGv8OzUc2DVXHZDJvXUDsbr9YEyggUIKibYkPNVc
 UDAKEFsELhkztu2ARETc6s90+RbDl/pvzrA46Z6ZkdcXHP+bcHtgFiTwTTjF2hk37Z
 2mxqVLNKqgoyiStd1vzngG5lPFWkSXq7nAN+RsehdBMmeGfstx3ii2n8xwyk3sYeS2
 GWHSdZwAY84YA==
Message-ID: <330f8b5c-6db0-4a3b-8296-716061eb6849@kernel.org>
Date: Wed, 8 Jul 2026 10:34:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
References: <20260530123038.2101877-1-jinbaoliu365@gmail.com>
Content-Language: en-US
In-Reply-To: <20260530123038.2101877-1-jinbaoliu365@gmail.com>
X-Headers-End: 1whI7O-0005Ed-2D
Subject: Re: [f2fs-dev] [PATCH] inject.f2fs: fix injecting nat/sit journal
 in compact summary
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
Cc: Sheng Yong <shengyong1@xiaomi.com>, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/30/26 20:30, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> When CP has CP_COMPACT_SUM_FLAG set, the nat/sit journal is stored in
> compact summary blocks at start_sum_block() rather than in the regular
> summary area. However, rewrite_nat_in_journal() and
> rewrite_sit_in_journal() only handled CP_UMOUNT_FLAG and the running
> state, missing the compact summary case.This caused the fault injection
> to fail.
> 
> Fix this by adding the CP_COMPACT_SUM_FLAG check before the existing
> CP_UMOUNT_FLAG check in both functions, writing the journal to the
> correct compact summary block location.
> 
> Test steps:
> 1. NAT journal injection (nid=4, quota file):
>   inject.f2fs --nat 0 --mb block_addr --nid 4 --val 12345 /dev/block/by-name/userdata
>   Before: blkaddr unchanged (308225)
>   After:  blkaddr = 12345
> 
> 2. SIT journal injection (segno=61075, CURSEG_COLD_DATA):
>   inject.f2fs --sit 0 --blk 0x1e1da00 --mb vblocks --val 123 /dev/block/by-name/userdata
>   Before: vblocks unchanged (0)
>   After:  vblocks = 123
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
