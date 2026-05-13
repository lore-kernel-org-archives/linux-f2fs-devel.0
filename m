Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B441CD4F35
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 May 2026 07:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wvwcZkaQV6pxXkl9VTBUHq/NUMtlkzN78MZQpI4J66o=; b=Ihs30ndOiVyXC4KPtFcz5yjrcj
	jL3T+ZJvUQVcH0kSgEXljjEtcmOCrIYfLE9OlGEhUq4PrZ1kzzQphko3OFHyX4L6U4l8sSfZJQxD3
	WkoVFQC/I5pchC96frnJNAMTiRarSBPOdE+GZZlILSOSSasWak6QoNGSriP7W/4AyWCE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wN4UZ-0004BH-OS;
	Wed, 13 May 2026 07:58:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wN4UY-0004BA-AZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 07:58:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vrkBN/u+6ltGDhsPgBXFUoHF7FkgQq1LPDjGfY01vJ8=; b=gwJWB5SCxldBWFdvoqmLEkU45F
 jTbcsS5DYnhwwtIsMDkujlurOloe5RyCYeSAcYPlUhNhuHsYXD8e3cujrRTl+iQwP6rtfFv61QqBy
 eTKRY54jJrzzcLOkReNZTka5yLC3kJRU7Cd4fMJaBYRzUOmkLkJllF7E5hkCGkkp4PL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vrkBN/u+6ltGDhsPgBXFUoHF7FkgQq1LPDjGfY01vJ8=; b=I8AXno4B2mY90k1JZKqmwU6ha6
 iprlgQdOZFiFYLZP03O9Iw844IFuNrgqH+MEIeZJQ8Xw6TYPpoD2vIdYOAWjllqg/hXOeeSu9SQtb
 AnWZrdE+xB4+jKQB5ALI+WK1U3xmA2F2VST6c76qQfewR0QRQRWLm/graiMkInbnkafk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wN4UY-0003eL-4t for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 07:58:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E7BE260120;
 Wed, 13 May 2026 07:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FF3C2BCB7;
 Wed, 13 May 2026 07:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778659123;
 bh=ZFOLhdTLTDwHAC91xE1k1QxOntVrUq2R8VzrDX/0eKI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=N7A9hVUV0qRwGIlPSwv6zb8J15Avw/8OiY0tC2pYfT3vAImBYoTK+1lI8++KSnfTQ
 enquvQ1kQFG5q2SLMBOMl5LIdaa3HrPz8yfV/mB+IPtRZ9EwSTq915aLv9gnYaUSZ0
 2czee33FVo8GdHO98/Unlcwyp8wZLK0wN4oPZakxBFnLVZVt/BEiOmCdWJRI4N+cY+
 3MR1Iv22FF+LhxmqxonfMaEmbjDzyvgI6p8HLq6tmndsgXMGnxPjs/zzCmTTAuJh8z
 ofabM7G9g1LGbCLvCfh554V2u3vKBFrubmNJsMCnPLUeVj1Xtx7dZ5jJC2Yhh6Ns+W
 0VbT0WJxHsqZQ==
Message-ID: <b37ca8a7-289e-45a0-8cbd-eb14d7453b97@kernel.org>
Date: Wed, 13 May 2026 16:58:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-10-hch@lst.de>
 <20260512170846.GJ9555@frogsfrogsfrogs> <20260513055806.GC1236@lst.de>
 <acd6428b-a352-4f7b-a349-b2c9e341fd87@kernel.org>
 <20260513074608.GA3693@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260513074608.GA3693@lst.de>
X-Headers-End: 1wN4UY-0003eL-4t
Subject: Re: [f2fs-dev] [PATCH 09/12] swap: push down setting sis->bdev into
 ->swap_activate
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
From: Damien Le Moal via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Damien Le Moal <dlemoal@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 Chris Li <chrisl@kernel.org>, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Kairui Song <kasong@tencent.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-cifs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 linux-btrfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/13/26 16:46, Christoph Hellwig wrote:
> On Wed, May 13, 2026 at 04:44:53PM +0900, Damien Le Moal wrote:
>> Hmmm... With zonefs, swap files can be created on top of conventional zone
>> files. So enforcing "no swap on zoned device" here would break that.
> 
> We can check that none of the extents fall onto sequential zones instead
> of just devices.
> 
> I still wonder why you bother with swap to zonefs at all, though.

Yeah. I do not think anyone actually use that... But since it is there from the
start, kind of stuck with it now.


-- 
Damien Le Moal
Western Digital Research


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
