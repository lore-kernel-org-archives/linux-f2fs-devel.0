Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C082C74A5B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 26 Mar 2023 23:39:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgZxR-0005NY-IZ;
	Sun, 26 Mar 2023 23:39:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+1946e0fab8d5f7ff56ba+7154+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1pgZxP-0005NS-Kn for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 23:39:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GxavDADegA8D8D4cqFi6Pgh//L0JzHyL/uT8PMbCBW8=; b=k8jATNYvIXZ45zZJsnMmgDq3+A
 Il+ufvnJqpoiPJ03HnuXfxEPFZgRaTxu/bK9H555fZkarwyRp1S2OMvlaQ9EVjGvK9tP23nIztkiI
 Cb7vWI4mcCv9kMgxn+ImtMN9Mmp4I8uRE5EscqE+GyvXoQ+T8TxrrpvoNXSykvaMQBns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GxavDADegA8D8D4cqFi6Pgh//L0JzHyL/uT8PMbCBW8=; b=Udjxp5sed6RURuajeeDSIlk1T3
 VWn2WSEYpFt81h5Gxz7Cw3QVgsB6jwaTfM3nNWkhdv3WnKeWf2fHpNuhFiWjD4zemD1hYU/hZgwH4
 28Yz96pp/PDabVP5L2pzrQCRLBByVz7z+qrOlYdetSnUU6giMl0xK22imvGrreAbWL2s=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pgZxK-00026u-1h for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 23:39:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=GxavDADegA8D8D4cqFi6Pgh//L0JzHyL/uT8PMbCBW8=; b=PhrOnzbWxGpMu8JvonvDeAb52v
 tin7Vc7DTDlvxZUpODoB9x0UZ9kVpLNDJZxqHtC3NN6wwD1rKh4dFQ36avx7iutUeBPLxKIgvq0wJ
 gJSacNhBMZPzchGlsL0r+Gu82WTjhpyOQCNsCEtUlpYhYF+Lkh5cniUQVkc+3vCQN5QPQa79qyhYh
 9hUNuSrvMV5QbQo8hwffBbr/g8VnsOmFZYf+EfqU7wrRHEEw+ZHehpiMy+sJtS7zt9Cp/ru7n5IcS
 7hKwaP0szC6vDPVETvv79rQTj+UX0ldUHdsqxRsU0Wa2xxIngDzNihqjVTsV1Pa+EmqMGg3+fcDLC
 uIVSDg3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pgZx8-009M33-1H; Sun, 26 Mar 2023 23:39:10 +0000
Date: Sun, 26 Mar 2023 16:39:10 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <ZCDXnuV7oZwcYvRP@infradead.org>
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
 <ZBhisCo7gTitmKeO@infradead.org> <ZBzPYwcoLXkFngz8@google.com>
 <402cc90ce5defa81c937c3fcd09de1f6497459ee.camel@wdc.com>
 <ZBzkzg+lr+TOXZcW@google.com>
 <8207efb81cd1e9322ad608d313eb4b4bd5740e80.camel@wdc.com>
 <ZBzy7RHlCqmApxUe@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZBzy7RHlCqmApxUe@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1pgZxK-00026u-1h
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: preserve direct write semantics
 when buffering is forced
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 23, 2023 at 05:46:37PM -0700, Jaegeuk Kim wrote:
> > Yes, and that was exactly my point: with LFS mode, O_DIRECT write
> > should never overwrite anything. So I do not see why direct writes
> > should be handled as buffered writes with zoned devices. Am I missing
> > something here ?
> 
> That's an easiest way to serialize block allocation and submit_bio when users
> are calling buffered writes and direct writes in parallel. :)
> I just felt that if we can manage both of them in direct write path along with
> buffered write path, we may be able to avoid memcpy.

Yes.  Note that right now f2fs doesn't really support proper O_DIRECT
for buffered I/O either, as non-overwrites require a feature similar
to unwritten extents, or a split of the allocation phase and the record
metdata phase.  If we'd go for the second choice for f2fs, which is the
more elegant thing to do, you'll get the zoned direct I/O write support
almost for free.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
