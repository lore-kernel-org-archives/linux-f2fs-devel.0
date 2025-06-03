Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F842C5AE59
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YhpPmT8fF4gpgNzRgVgGBuZIFJgZ9pHsnFaOplvr7kU=; b=baLhaB+joszbOVt/yEqr9Z9n1v
	IWAkKcAQr9uDGU1dbYpAx9O9xzPCk8tYCt/2luxvDW5/+Il/mep+5GAOXhzzBXi/bZYobzkwWz+0D
	I4TgxM/CHPlBI4pUoEa/n/Gs5/pQHB3sSSwiAzv6unqCmIdIp/Rabw7XW7qu4wHmCrAU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uMRdO-0005Ae-Mr;
	Tue, 03 Jun 2025 13:24:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1uMRdL-0005AX-8e
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jun 2025 13:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QfdJcMtitqVv2K9sFm4dcEYmSiJwmxzfWqAeWpKi4OE=; b=hkWaEC8uZkvx9/RcLp5YpV9oru
 qtQjbPJxPsta0KHeIkyZcK5U5tzzecpPrbxRgah2jfSahAXa1BrJ6akLhHw4nAQmKBv2WJaJAq1kD
 NVrd1Mla6hMjdYyDeLzkmzqAy6k6L9xeQXxVaECfsqTbW4yS70qi81SJ9Fcz8eUOr8fE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QfdJcMtitqVv2K9sFm4dcEYmSiJwmxzfWqAeWpKi4OE=; b=dAj7s1UXYVVOGBdB/43xoiJqK7
 uvB6y2DuTjilm8OhiIdmZ8dfDZ2TMDGzN+O3PpDPxGoXjim3x6QK5F+zdLsjmf870gG0IX3lpaRqa
 tbV+2bAPixiRwEUeZHJ4V7/XulInSmuHkm/pPDzV6wwQTlU/iw9KmleZsNN5iFOINHpg=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uMRdK-0002GL-7K for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jun 2025 13:24:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D45DF68D0F; Tue,  3 Jun 2025 15:24:34 +0200 (CEST)
Date: Tue, 3 Jun 2025 15:24:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
Message-ID: <20250603132434.GA10865@lst.de>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com>
 <20250602141904.GA21996@lst.de>
 <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1uMRdK-0002GL-7K
Subject: Re: [f2fs-dev] [PATCH 00/13] Parallelizing filesystem writeback
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
Cc: ritesh.list@gmail.com, anuj1072538@gmail.com, jack@suse.cz,
 djwong@kernel.org, amir73il@gmail.com, david@fromorbit.com,
 gfs2@lists.linux.dev, linux-mm@kvack.org, clm@meta.com,
 Christoph Hellwig <hch@lst.de>, dave@stgolabs.net, agruenba@redhat.com,
 miklos@szeredi.hu, Kundan Kumar <kundan.kumar@samsung.com>,
 willy@infradead.org, p.raghav@samsung.com, linux-nfs@vger.kernel.org,
 da.gomez@samsung.com, viro@zeniv.linux.org.uk, kundanthebest@gmail.com,
 jaegeuk@kernel.org, axboe@kernel.dk, brauner@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, mcgrof@kernel.org, anna@kernel.org,
 gost.dev@samsung.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 03, 2025 at 02:46:20PM +0530, Anuj Gupta/Anuj Gupta wrote:
> On 6/2/2025 7:49 PM, Christoph Hellwig wrote:
> > On Thu, May 29, 2025 at 04:44:51PM +0530, Kundan Kumar wrote:
> > Well, the proper thing would be to figure out a good default and not
> > just keep things as-is, no?
> 
> We observed that some filesystems, such as Btrfs, don't benefit from
> this infra due to their distinct writeback architecture. To preserve
> current behavior and avoid unintended changes for such filesystems,
> we have kept nr_wb_ctx=1 as the default. Filesystems that can take
> advantage of parallel writeback (xfs, ext4) can opt-in via a mount
> option. Also we wanted to reduce risk during initial integration and
> hence kept it as opt-in.

A mount option is about the worst possible interface for behavior
that depends on file system implementation and possibly hardware
chacteristics.  This needs to be set by the file systems, possibly
using generic helpers using hardware information.

> Used PMEM of 6G

battery/capacitor backed DRAM, or optane?

>
> and NVMe SSD of 3.84 TB

Consumer drive, enterprise drive?

> For xfs used this command:
> xfs_io -c "stat" /mnt/testfile
> And for ext4 used this:
> filefrag /mnt/testfile

filefrag merges contiguous extents, and only counts up for discontiguous
mappings, while fsxattr.nextents counts all extent even if they are
contiguous.  So you probably want to use filefrag for both cases.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
