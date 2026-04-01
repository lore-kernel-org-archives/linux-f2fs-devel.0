Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C851076372
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1T0RNXxRE+4PKzvQV9XLqJ6hUp3BETuQ4XfHhNkxA4I=; b=IP0F2cLQ+FQjKkVluYeVDDJzX3
	kZCh7aO0x7CmEccrAlKSpjw+fWz/7eCyknXfK3VnUR+p5Rzck1MIG/l0HNHIZlobFeqpCkd0AyKYn
	0vXgBcidnnE9A4dI5ekDwy1Q4pTfr+E10xZVBXfQ1Ojn9s6h8BVBTmtZfkA+cUw8GCjw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7p8Z-00086r-E1;
	Wed, 01 Apr 2026 06:33:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1w7p8O-00086I-7v
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 06:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aLxUhpyTKn43VG3vTemWcbaUEIA3iAko1d3EU97hycg=; b=Tb+QLgVOtoo2T8gYcwn1YccSdg
 z1beSPLqUJOBgoVmLZDfGB+//zY2R1cNXh6aWVh3Ue6kFV/1DDoWPqYCdzyiIP3pZhFibCWJdYbQy
 6ZRrGb/IBxXo9qb1dumXWSn1TB6kP7uEMV+8t1DciSTJx8+5qKLK8cayC93zGocxgjTo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aLxUhpyTKn43VG3vTemWcbaUEIA3iAko1d3EU97hycg=; b=BcLqYfJJZIjwR9gI3fkTPtFooJ
 eXHXwDTUxnUO80OhMFSfQ3ICONmP3BTZHZlSSywFqTMWnzbcgRVMx5ZTGQ+tUdnxFpazfx/RKrM2B
 anEtyD7GJ49NNsAbIAqMPc3N/bFqyGotI/lp7HbivQv5joyKy2ARy8bCtJY4W33TXIFs=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7p8N-0000pK-OU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 06:33:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9B7FA68AFE; Wed,  1 Apr 2026 08:32:52 +0200 (CEST)
Date: Wed, 1 Apr 2026 08:32:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>, ebiggers@kernel.org
Message-ID: <20260401063252.GF24459@lst.de>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-1-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1w7p8N-0000pK-OU
Subject: Re: [f2fs-dev] [PATCH v6 00/22] fs-verity support for XFS with post
 EOF merkle tree
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
Cc: fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Eric,

can we get you to chime in on the core fsverity changes, especially
the hole handling?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
