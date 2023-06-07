Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B49C7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 09:04:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6p5N-0004Cp-Te;
	Wed, 07 Jun 2023 09:04:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q6p5F-0004Ce-Dc
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:04:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m4vZcjEnozhcnCD85g4kD5+JXDldaNqstJsOFIj9hiY=; b=MyhaxpYYQT8guMhSUTqGE770fE
 9EmOdM5X0VVysIDNJKRgSi08lwit/gReUhQy1+C7VJDqOAw4yUkyUYfH9jA8VmcgWD81PjxgHyOta
 P/bJ8KFQw1MmfQWIEuFBA3k/ZnjncOEutPiKnxvb45g0gWrN2615kRq0q8prLq0S2KEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m4vZcjEnozhcnCD85g4kD5+JXDldaNqstJsOFIj9hiY=; b=KrgnsC7KYRdILVclKLC4Ii2Hcv
 j8oJ8Oe0Z/1iZESds54oPG6daaMcGIQ2SY4xjmWZoP3SMNp/FgjU8lpt8N9xAIs5QX2l6K1eYKW1U
 Fwe70bPlrSa1w8ZHO6zgSXuF77ZrSe2XN+nNOJq3wOMkVp09W398JqSL79LR79BqTsfM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6p5D-0005B8-4n for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:03:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BB1906333B;
 Wed,  7 Jun 2023 09:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E80DC4339B;
 Wed,  7 Jun 2023 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686128633;
 bh=Xf/4P91dRygUOBcu7Gf2FM/yIcNpKmxg81kLyQ/xABI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IN6GC1DPfELHi6cX+5K0wKVVtYJ3DXedGhjwgRx699RBFbnd08dZETxrlqxzpLWKC
 ekLoBpbWyqE6gmBLFLtkaZYgr6+AIeoZpKwDTwgdWG99m14V2UqWKfwBTtVvgUBRu+
 0e6TBWMLJuIbAlRNYxIXjylaMD7QGrfKMwVXHWPcJnjd57/ddsdyM/BmkOIIfzhzqD
 30g5q2KZ4YvHf7cCwWG4eQIpdKajUy1CEU/O6AmKN2EBhjjDNdUAUDLCZCHrmIXgZM
 kwBNuzs8INbYR7r2R62ZE/viyZfDvNDpkswXSRvBH+lz4n+zQ2vNlfy8TcF9REK4vz
 k5N5wSWsZUJNw==
Date: Wed, 7 Jun 2023 11:03:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230607-umgewandelt-fabelhaft-5f3c72318a9a@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-28-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-28-hch@lst.de>
X-Headers-End: 1q6p5D-0005B8-4n
Subject: Re: [f2fs-dev] [PATCH 27/31] block: remove unused fmode_t arguments
 from ioctl handlers
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
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-nvme@lists.infradead.org,
 Phillip Potter <phil@philpotter.co.uk>, Chris Mason <clm@fb.com>,
 dm-devel@redhat.com, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Pavel Machek <pavel@ucw.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Jack Wang <jinpu.wang@ionos.com>, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 linux-pm@vger.kernel.org, linux-um@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 06, 2023 at 09:39:46AM +0200, Christoph Hellwig wrote:
> A few ioctl handlers have fmode_t arguments that are entirely unused,
> remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
