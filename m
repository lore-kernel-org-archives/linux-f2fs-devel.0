Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E14F3C991
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ny/UihQkQ8i5or6Nkm9PChgcIduqFy5ZTtnZZacGmhc=; b=akuygdu9iXqBbvfnYCcmNaicFj
	Zv9XDtuPbZSd2SKa2lboS0ZHyYcUsLKDwqgXW0pL4MDQsy9H+12dw1Y3PgWdObRPJTXME4Y9jiykl
	hmEHp15uhN3lxXJJ3VDsXiTITUhK1duLMxbLtXdwo9Q7nfL1d1ywOKRsfDwc7uIVQ+oQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vuuHl-0000pN-1i;
	Tue, 24 Feb 2026 15:25:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tytso@mit.edu>) id 1vuuHe-0000pC-Bl
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 15:25:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xDSAnXoB9ejN/bLi5BfMqVBcp3Wg5UbG7Pg4difgCEo=; b=dINS4yhT4/3FItICQF9EN6jCrR
 FY3PDhK68MsmvtxEi/qxdCtB6FK0hB/1BNN7ymY9a88PcPcGtCN7Zi5MI2buXwn/Ow1Tj1ZC078qq
 U0Egh72YGaHedlObYTnwoLDTfxLyv2wxD/1pvMwwCcnB1iyWhPWe5uW/tthXiSBCYKvs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xDSAnXoB9ejN/bLi5BfMqVBcp3Wg5UbG7Pg4difgCEo=; b=Stv9g6UAcisUZqx613mNj+By5V
 WP2fftatOFnVA0wGMSPQiK0eLEag/SIZdozLc4o6uc3JRYKYk1bb5C27FprRI2eyA9YwH6KCOR3ei
 FzwDNAGN6wd2V7Nm/94A0PWEGCgCrKxm4KD7m0mV9numnwveSDsc95rmi0W38HfAyyhM=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vuuHd-0004EI-El for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 15:25:10 +0000
Received: from macsyma.thunk.org (pool-173-48-111-182.bstnma.fios.verizon.net
 [173.48.111.182]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61OFOqSx010759
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Feb 2026 10:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1771946694; bh=xDSAnXoB9ejN/bLi5BfMqVBcp3Wg5UbG7Pg4difgCEo=;
 h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
 b=U997oiXoilh/FS+HP/sc9+AhvTSPm0sBVkyHybp7gSa3iwBR/F0vHIr9gMl1tvktL
 geUmnMAjAkBOiWEs0omBnR23bwxfTcKdEFoorNTnzCi2IANakgSzfbDF1IZtx1UAXD
 F463L33LgFV/nTPaE90lpwOv4t5pO1N3CMCqURjK5IyTc0SZGaQocu9PBIirS2jT2B
 38WkzQSpSshgvUurqCVerpzXVYQ7WTTmiaoofZbkU+I979He89eQrXvo8HWtaqBM7X
 9A7bqjC2LHLFwYamCJdTBTMqvXLae972b2/zlSPQXb+TTvh45vFdLkHokDvoOLYd8n
 XbqE2fwiJvdUw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
 id EDB4759B421E; Tue, 24 Feb 2026 10:24:51 -0500 (EST)
Date: Tue, 24 Feb 2026 10:24:51 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260224152451.GB16846@macsyma-wired.lan>
References: <20260221204525.30426-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260221204525.30426-1-ebiggers@kernel.org>
X-Headers-End: 1vuuHd-0004EI-El
Subject: Re: [f2fs-dev] [PATCH] fsverity: add dependency on 64K or smaller
 pages
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
Cc: fsverity@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Feb 21, 2026 at 12:45:25PM -0800, Eric Biggers wrote:
> Currently, all filesystems that support fsverity (ext4, f2fs, and btrfs)
> cache the Merkle tree in the pagecache at a 64K aligned offset after the
> end of the file data.  This offset needs to be a multiple of the page
> size, which is guaranteed only when the page size is 64K or smaller.
> 
> 64K was chosen to be the "largest reasonable page size".  But it isn't
> the largest *possible* page size: the hexagon and powerpc ports of Linux
> support 256K pages, though that configuration is rarely used.
> 
> For now, just disable support for FS_VERITY in these odd configurations
> to ensure it isn't used in cases where it would have incorrect behavior.
> 
> Fixes: 671e67b47e9f ("fs-verity: add Kconfig and the helper functions for hashing")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Closes: https://lore.kernel.org/r/20260119063349.GA643@lst.de
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
