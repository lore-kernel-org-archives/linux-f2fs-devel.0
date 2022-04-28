Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931D8C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 Apr 2022 17:30:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nk7xo-00061V-WF; Thu, 28 Apr 2022 17:30:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mcgrof@infradead.org>) id 1nk7xm-000618-Pm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Apr 2022 17:30:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M77UyFZc/CQOenG5boLjqoc0qTJMwAANdJbVnxb68KE=; b=bVKlF5y1n6CfmAqU8m8tcdg98X
 41fFqTi+kGAWZcyG2Gj3skaxzKhtgnCDwjfH1jG56OAnaD4/YA2FLTqfVtoxdu9c9CaGC1oLn7HP5
 YeE0QhSg4wN9FCh8H5IRB5+/BiyRUkupFNCdUY75kjZnxFynS54kc7jIAzZ17wvmxO00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M77UyFZc/CQOenG5boLjqoc0qTJMwAANdJbVnxb68KE=; b=Zv8QpQElhyBIg3y63ZXbfYop3+
 uON6/QqakWS3kh9OeygDYlrHqdX2d3QVU59WhjZShnbBdrUyCIll3G9R3folZUuQrST2jVwVAMntc
 H02uXAXiZpeFfF+HBBmYH2IFsSi/Pf3cK5bhfwLxn0Afhb19YWwPy9oldTvwLgxodgxQ=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nk7xj-0008OS-QE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Apr 2022 17:29:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M77UyFZc/CQOenG5boLjqoc0qTJMwAANdJbVnxb68KE=; b=JWA7yBd2WgLv8JgmAvqWwyoH7N
 CbCI23q7BAOQJ0ekZUG/FMPi05rdlj74q9wztR9r4BIk+quAD2WWbX+5hu0/Tn9NNZBjpH7On+mMo
 VC6igZust8a3wLGSg61u8qnlyDLLzOqnSRuUT272lK0I/PfG3acjO4xrDkVkSKqZP881da1wHQb0o
 YPusvURC9voi3RnaJh4nT8b+IVwjMG6wfxev2aPSyh9jfbfzwITiAEf0dPZe2VsVzZunc5WtOly+c
 R1yUG4N0F25z4sNcXZVg07M81adkeM3AyCXsGszurdLc5pViE/I3gVGt7mNG8XZe7KQhBn80LujAv
 8QWTtyqQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nk7xL-0082dM-NY; Thu, 28 Apr 2022 17:29:31 +0000
Date: Thu, 28 Apr 2022 10:29:31 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Message-ID: <YmrO+2sexVkJEaIr@bombadil.infradead.org>
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a@eucas1p1.samsung.com>
 <20220427160255.300418-5-p.raghav@samsung.com>
 <eeb86052-399c-a79b-32ab-1ed1b2d05e07@opensource.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eeb86052-399c-a79b-32ab-1ed1b2d05e07@opensource.wdc.com>
X-Headers-End: 1nk7xj-0008OS-QE
Subject: Re: [f2fs-dev] [PATCH 04/16] block: allow blk-zoned devices to have
 non-power-of-2 zone size
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
Cc: jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org, clm@fb.com,
 dm-devel@redhat.com, hch@lst.de, agk@redhat.com, naohiro.aota@wdc.com,
 sagi@grimberg.me, gost.dev@samsung.com, jonathan.derrick@linux.dev,
 Pankaj Raghav <p.raghav@samsung.com>, kch@nvidia.com, snitzer@kernel.org,
 josef@toxicpanda.com, linux-block@vger.kernel.org, dsterba@suse.com,
 kbusch@kernel.org, jaegeuk@kernel.org, matias.bjorling@wdc.com,
 bvanassche@acm.org, axboe@kernel.dk, johannes.thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Apr 28, 2022 at 08:37:27AM +0900, Damien Le Moal wrote:
> Also, the entire premise of this patch series is that it is hard for
> people to support the unusable sectors between zone capacity and zone end
> for drives with a zone capacity smaller than the zone size.
> 
> Yet, here you do not check that zone capacity == zone size for drives that
> do not have a zone size equal to a power of 2 number of sectors. This
> means that we can still have drives with ZC < ZS AND ZS not equal to a
> power of 2. So from the point of view of your arguments, no gains at all.
> Any thoughts on this ?

You are right, a check should be added on bringup so that if npo2 is
used, zone cap == zone size. That should be added on the next iteration
of this patch.

  Luis


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
