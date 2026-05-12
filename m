Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67B0CD4F26
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6j+o7oD+ZAwr8l4OsqpVRM4gpnlae4bJs51q9DBSqNg=; b=HI2zj7YkKKegIBSPrQ6glEuEp/
	UIjGgUbsAAyvfZux8ISwxsPOQG2WxDZkpzjeJSUayzom41FxH+CSftq6xPVk9k3i3VONPmpRql2EI
	i9aAU/3g896MVroFqrZTwNCnRt6bQE1aXh5ScLg0/SSw6XGLUaxGOiD5I3Q1/BowAXjA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhTB-0003ot-3h;
	Tue, 12 May 2026 07:23:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wMhTA-0003on-I6
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:23:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BU2y59SqFukqO7Luqv9lSeOSHObUdXJCRb74gvCvzQ8=; b=migCcJP8aebhXSm4PKvFFmxQDm
 nTFImzdQE+7vn9uxa+MfpQ+4xgpe3Wo+qGKABKB0gxsNpsCicb2lJeozsHXv/Aj7mJLlTjrYxqEkW
 eQgUKoOCtQXLkizeisZBWFPSWJ70XlNsEULlIBmxGUIjfVa7t8uXtvvAGztDpaZ5LkG4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BU2y59SqFukqO7Luqv9lSeOSHObUdXJCRb74gvCvzQ8=; b=C2acur5PgRKER2kDk0XOxlQm0n
 vlG9tnRv4VF/EExFxAlmNruwa8eysvf9daPpO2CHHw3Sm1yP7Gjvm2MedQHz4VbbL7WR6Gg654EW+
 R0zAesaEJPYYcyRDpotHLGkBR+AiaMftBnDCTF8A+ctRpBlYyK/S8XdeonQFTq+2N4KQ=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhTA-0001wT-7u for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:23:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E305568BFE; Tue, 12 May 2026 09:23:47 +0200 (CEST)
Date: Tue, 12 May 2026 09:23:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Message-ID: <20260512072347.GA32756@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-8-hch@lst.de>
 <217f91d9-4d5f-47a6-ad20-0404968b8e08@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <217f91d9-4d5f-47a6-ad20-0404968b8e08@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wMhTA-0001wT-7u
Subject: Re: [f2fs-dev] [PATCH 07/12] swap,
 block: limit swap file size to device size
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
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Chris Li <chrisl@kernel.org>,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Kairui Song <kasong@tencent.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-cifs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Steve French <sfrench@samba.org>, linux-btrfs@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 12, 2026 at 04:21:47PM +0900, Damien Le Moal wrote:
> On 5/12/26 14:35, Christoph Hellwig wrote:
> > Don't blindly pass the value from the swap header to swap_add_extent,
> > but instead the device size rounded down to page granularity.  This
> > activated the sanity checking in the core code that catches a too large
> > value in the swap header.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks OK to me, though this maybe could be folded in the previous patch ?

I prefer to keep behavior changes as isolated as possible.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
