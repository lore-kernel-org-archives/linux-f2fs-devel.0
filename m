Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D6C43219
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Apr 2022 17:29:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ndxrK-0007X0-55; Mon, 11 Apr 2022 17:29:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <dsterba@suse.cz>)
 id 1ndxrI-0007Wq-Vx; Mon, 11 Apr 2022 17:29:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y9/RDfYGC6K6KRC0KdrprIVWfIX/zpdTiz9ROrz551U=; b=jtb8U+cTaBktdB0FTHhojDhMYc
 mU8koenC3KGAEaKrgkGpdb0FLR2Uy5Nk7aUGqGl8RTaDbXXjtttXwgs84jA3ouu9/v5n3Q68nA6Us
 6bMFV+Fm+WyPt2zBW3FW7rw+PdwdY6OI1n9tUaS5cmdDiYQi/9BsVElEo0Mya7g6y3cw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y9/RDfYGC6K6KRC0KdrprIVWfIX/zpdTiz9ROrz551U=; b=iK4DQOIkNbxWX/eYndFmwer+ub
 fgvWD+fExBPQdFVyVj3q4A3q8LqwDdnB5gtrGzqKPXS+xXJglwZx9RhsqSH71cfPnv/skjygDsWcc
 Ljq05NtHtm2hpnRpGW5m270eAQBXklWsQHWcY/Ja+0/j9z9Jl19zpiv49F9CDOXmzi+U=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1ndxrH-0005Ey-8W; Mon, 11 Apr 2022 17:29:47 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id CB2971F38D;
 Mon, 11 Apr 2022 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649698180;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9/RDfYGC6K6KRC0KdrprIVWfIX/zpdTiz9ROrz551U=;
 b=I9nwx9hrwiLBwY8Cn2rQGBPnpBriJmDMs1b8oNISqOpk754k7ib2Xve0iYAZqqPcSD2SgP
 oZEA90HfyQ7ya+rehSXEh9k5AQbwstldp6HDVnl/WGBpQS17mVXtCGXXbsCypPUDUyaMdU
 y+Peaf55gboQyV27R4kCRTuYgY7wFX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649698180;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9/RDfYGC6K6KRC0KdrprIVWfIX/zpdTiz9ROrz551U=;
 b=AzkdKu96rYkAsjhpJavWNTiZGL3Agdt16W1llO8/BhnjKgsTeGvgPw66Q+CklEVPEpPHBk
 JsD+WnrQfAy3whCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
 by relay2.suse.de (Postfix) with ESMTP id B0827A3B87;
 Mon, 11 Apr 2022 17:29:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 47973DA7F7; Mon, 11 Apr 2022 19:25:36 +0200 (CEST)
Date: Mon, 11 Apr 2022 19:25:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20220411172536.GV15609@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 David Sterba <dsterba@suse.com>
References: <20220409045043.23593-1-hch@lst.de>
 <20220409045043.23593-26-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220409045043.23593-26-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Headers-End: 1ndxrH-0005Ey-8W
Subject: Re: [f2fs-dev] [PATCH 25/27] block: add a bdev_discard_granularity
 helper
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
Reply-To: dsterba@suse.cz
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
 xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
 linux-um@lists.infradead.org, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 David Sterba <dsterba@suse.com>, ceph-devel@vger.kernel.org,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 linux-raid@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org,
 Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Apr 09, 2022 at 06:50:41AM +0200, Christoph Hellwig wrote:
> Abstract away implementation details from file systems by providing a
> block_device based helper to retrieve the discard granularity.
> =

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Acked-by: Christoph B=F6hmwalder <christoph.boehmwalder@linbit.com> [btrf=
s]

This ^^^^ is for drbd

> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Acked-by: David Sterba <dsterba@suse.com> [btrfs]


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
