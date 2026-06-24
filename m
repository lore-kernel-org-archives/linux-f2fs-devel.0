Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262E1CDB470
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oi4gfclK/aCpJcfIzmVbD/VmM/I0w3VJJux8z3DP9cA=; b=gDHezCzaLHXnveQrg1bcjeh/fN
	SOPsae1xLxRnTz1h/NYimqIOiVSzplLKj+Gpkb6o9ZcKYnKdo8WXd8Jvv923b5npTGKc+m+9il/XZ
	xEHSlLyopjsvD6qWWwqXsWvDP7yTji/M2DA14oQ6wCsZt/cxLkxfmOS0UKdRAso/ykY4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcIJP-0006bB-RG;
	Wed, 24 Jun 2026 07:46:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+41526429243acde27946+8340+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wcIJN-0006b5-2E for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 07:46:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5SQ2ceOLmQorTQ/rIGAZVtdIP0obDHikYx9CZqlXZ4w=; b=U6eiMPfVyhZ/24qSs88QxVemxe
 e605pSrTuYj0segcmQ42umuApmqD8k+8M67GJDFkDVHBZcK1cd9tdvUsX1Nh2OO1W/C3NMDHS0imF
 6YK1LZi2HPSThpNAAehKNOxkGWaMCZS8RNVK6v65fp//FAKNclAHfQ85FT8MCcAxTaak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5SQ2ceOLmQorTQ/rIGAZVtdIP0obDHikYx9CZqlXZ4w=; b=FSmpWHdKH9pBA16bOL1hGFquSK
 3MTsC+YWuMzyeO20j+G9EgTeBc0NypktPgRQT3E5DjAJmj32k3OLYKLkHxbPMigY243yGTAyd9iaW
 d7faGnm7/ttrj3Uls5eKls6rzBMxeT1moGBYD75VxRvBk4J2wwJPWDgtjWAkSWfRqOmQ=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcIJI-0002Yz-8E for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 07:46:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5SQ2ceOLmQorTQ/rIGAZVtdIP0obDHikYx9CZqlXZ4w=; b=wsrZS24efcnk+Bk5fbKf9298JM
 Lphj2FrgoMJ5q3B9K2UimUGJPyIJSTULUUMaMpUp6t9EeMdEspHBVVZC+NOv0fj+WYnvNXnDY8Bku
 3CnmLqPpMAibDC9/WId1ReugEhQLevVKe0DRgKsFqD8x76tVO4+ck1kk3ghVw1hAnrqol2KobwRTw
 /4Zg0F5BVJZ6TpWzB8hgVCnvEhL3FhG+CEJDQdnoJtwjogHleJAgnHcc0go0GXTohWBhetUpFuxdU
 lJyf9I/yY5P0wM0WrQG8WOBnyiwXsiWjq1eH5MvYiLrH5B9dJ1Nzq7YEQmHWyvPr29K507+blCJ9A
 VG0l0r5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wcIJ7-00000007LHS-3i7c;
 Wed, 24 Jun 2026 07:46:01 +0000
Date: Wed, 24 Jun 2026 00:46:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Prusakowski <jprusakowski@google.com>
Message-ID: <ajuLORVplOvEXvnI@infradead.org>
References: <20260622070438.1542638-1-jprusakowski@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260622070438.1542638-1-jprusakowski@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wcIJI-0002Yz-8E
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
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
Cc: jaegeuk@kernel.org, zlang@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 22, 2026 at 07:04:38AM +0000, Jan Prusakowski wrote:
> On F2FS, generic/064 fails with "extents mismatched before = 1 after =
> 50" following multiple fcollapse (collapse range) operations.
> 
> To ensure crash consistency and checkpoint integrity, F2FS forbids
> in-place SSR (Summary Standalone Replacement) overwrites on valid
> checkpointed blocks. When collapse range shifts blocks, F2FS allocates
> new data pages in LFS mode (out-of-place log writes). As a result,
> sequential collapse range calls rewrite shifted blocks at new log
> locations, intentionally leaving the file with 50 extents.

This sounds odd.  The test allocates a contigous range and then just does
insert/collapse on it, which should not lead to any new data block
allocations.  Given that the test works fine on zoned XFS and btrfs
with strict out of place write policies we know it does not require
overwriting blocks to work as well.

So I think something is fishy in f2fs if needs to allocate data blocks
here.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
