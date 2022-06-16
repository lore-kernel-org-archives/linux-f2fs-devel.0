Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E24C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Jun 2022 06:19:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o1ir5-0002qw-TQ; Thu, 16 Jun 2022 06:19:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1o1ir4-0002qq-NB
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 06:19:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kw1LODiDMl8sS6JpZ56XMhMDOH2cfP45jdhVGnUDz/k=; b=eMaqnaUlN7Tw/9tuWE8Hw4230a
 s/WeBvnkd7Urvl6O/tiovMenoWpeQcbOcAINiEndDkZTVSWCRcbPz/Fxc9D3KJ1BwbBHhxgEkwx/G
 ingQWrT26HRpJhRDyyK2oMiQYfpnae1V6FHXZF0cqDOrhgIN0f9rm8nzRuqT88JIStI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kw1LODiDMl8sS6JpZ56XMhMDOH2cfP45jdhVGnUDz/k=; b=GApTcksJqgl9fZ7EIMhe5Zhr0r
 ihER0aPOimQLCcFePb1HoC9VUADXdf87Rxla7JzK1omL2GqBE0AyQLOqcRhQngDwwNODjXdI6jbD7
 kMvp8IcCCXovVH4YJK/Obc4bKmwHC3MZ/trTX4svLcNNS0KxeUdfGtz25bLMTXWPscjs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o1ir2-0000H9-A9
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 06:19:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6A908619E0;
 Thu, 16 Jun 2022 06:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3A3C34114;
 Thu, 16 Jun 2022 06:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655360374;
 bh=9WtnFezIM4KX4P3ySZStpuq8OOCxc7UiGqUdRTu14IU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Zbm83yfLXoLOCTJN/17SG94P7h8qzzoKuhRyDkoMLpxUMLdpOIYf9Ina/d/ccOi+m
 2DfdrqmNMNxXflN8F0chJjQwfj+Ga32syiPjxwTrXN3T5X/44cLAgo//HC/ssjlKE0
 L9c07K5/7Epq7PUTKf79rU3eaAUqTFt8pqu/vcQo5p9C2hxXO3nRszdTm2E/IU8Gpu
 6wx/4Df69k+QH6WRs5N4xQ9J5HYk+hvYgT6yR8aDjXmIzK1GE9Hb/g9DjEJ0llglRV
 fF+XpJQ0TxrQKHAApO9bvDo5m+XaZ0ehIal+LLBJ0N0D/tCgIAEW7A877NxmcVRVVn
 N48OrEtqGZlqw==
Date: Wed, 15 Jun 2022 23:19:32 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <YqrLdORPM5qm9PC0@sol.localdomain>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <YobNXbYnhBiqniTH@magnolia>
 <20220520032739.GB1098723@dread.disaster.area>
 <YqgbuDbdH2OLcbC7@sol.localdomain> <YqnapOLvHDmX/3py@infradead.org>
 <YqpzqZQgu0Zz+vW1@sol.localdomain> <YqrIlVtI85zF9qyO@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqrIlVtI85zF9qyO@infradead.org>
X-Headers-End: 1o1ir2-0000H9-A9
Subject: Re: [f2fs-dev] [RFC PATCH v2 1/7] statx: add I/O alignment
 information
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
Cc: linux-block@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 15, 2022 at 11:07:17PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 15, 2022 at 05:04:57PM -0700, Eric Biggers wrote:
> > One more thing.  I'm trying to add support for STATX_DIOALIGN on block devices.
> > Unfortunately I don't think it is going to work, at all, since the inode is for
> > the device node and not the block device itself.  This is true even after the
> > file is opened (I previously thought that at least that case would work).
> 
> For an open file the block device inode is pointed to by
> file->f_mapping->host.
> 
> > Were you expecting that this would work on block devices?  It seems they will
> > need a different API -- a new BLK* ioctl, or files in /sys/block/$dev/queue.
> 
> blkdev_get_no_open on inode->i_rdev gets you the block device, which
> then has bdev->bd_inode point to the underlying block device, although
> for a block device those limit probably would be retrieved not from
> the inode but the gendisk / request_queue anyway.

Yes I know that.  The issue is that the inode that statx() is operating on is
the device node, so *all* the other statx fields come from that inode.  Size,
nlink, uid, gid, mode, timestamps (including btime if the filesystem supports
it), inode number, device number of the containing filesystem, mount ID, etc.
If we were to randomly grab one field from the underlying block device instead,
that would be inconsistent with everything else.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
