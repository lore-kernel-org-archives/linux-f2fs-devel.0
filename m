Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59C6C7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 08:58:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6p03-0003gI-Hk;
	Wed, 07 Jun 2023 08:58:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q6p02-0003gC-Di
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sktQH5/gZchOE2ktuYmcp3qpPHa5uOw4gaXM3JxsGn0=; b=UhD2/UGYNSu3I3u5+Pwwv5FaiV
 Aglf+PLRnOjzJDtx59KzeQpq43mDKyghLSS6gQD1IHXL/QtByW0oYu7ZztrFOJ5eWI681DMEqd/Y6
 iiLD51tqzRShgexxb8kqAEby0tA4xiu6iUI+SGDkQkMlKpANfHvWXcgS5uEtTFv/fbq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sktQH5/gZchOE2ktuYmcp3qpPHa5uOw4gaXM3JxsGn0=; b=Zd9qW3FelNfS/4FrFgAXZvRZ0J
 lpIVumKpt92TEFi6aWp7ceLv7MF3wPPNn/YAIJdk4NoCZEg6RWBWLmRpwJK+5OAP7dwl/2NStHeSl
 jEgspMdVtE1xsm5nnGiBlVW6VXIVOCpUyctuBIYEmd+HV6i/YpklLLWAxcXO8jIIGQwg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6p02-00DXTK-Je for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:58:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 381A9635B9;
 Wed,  7 Jun 2023 08:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA18C433D2;
 Wed,  7 Jun 2023 08:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686128312;
 bh=ULzdhbcJeHPqQXgxbjAFPajJp4EhMC2K+LFc4KO7vAA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QDgpcas10bhc6n+3tq+Tww3RU/1erBcAFvLdGNqmlHFWLpUff8UGptsIZjNJ5w8gT
 KYA7ed+ki78rGbhq5L/pIz6djcKUzIgFySOylESb78Bo6dP+lYa+WimjJyqZa15c3b
 1a4lMbl2TA4crdhAnzslPR1Iz130r59S9JasIE6AZsdKPxJjYPbAxErnPuZ4MNQ2GS
 KGvt5cBHh6T/W5itlNub0ikJLxBe6iyEJiSqAGXrX+LiQTSGUC5G+HFALEh7g1JEED
 Ql69+otxwsCqAC05NjZF31NRBQV7RRI+/YZWHju6mtccLdXuvkjFbYs/ytHfl1KO7w
 qd67klAruXQuw==
Date: Wed, 7 Jun 2023 10:58:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230607-dates-innenansicht-78e76eea7347@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-21-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-21-hch@lst.de>
X-Headers-End: 1q6p02-00DXTK-Je
Subject: Re: [f2fs-dev] [PATCH 20/31] scsi: replace the fmode_t argument to
 scsi_ioctl with a simple bool
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

On Tue, Jun 06, 2023 at 09:39:39AM +0200, Christoph Hellwig wrote:
> Instead of passing a fmode_t and only checking it for FMODE_WRITE, pass
> a bool open_for_write to prepare for callers that won't have the fmode_t.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
