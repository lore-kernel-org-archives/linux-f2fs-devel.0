Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC649D19518
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 20:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lz0Dq78WdU5H9UPEIlsydaPxV+N971aeMXVr+xvSqoo=; b=SA7PWvldA0pN2l7IP5uRVzA3fN
	0FEaUrL+uiDIlVhWz5Ky9JYFg9AqIMb8/WPMNe0W/vZ+qyLdpgVd0iJnAYslKkK/wOCuUPGKCkivN
	ixAzdhN6v1MT9laJT8ZTsLcsZpLk4xB0QZLkjNUCc08C/KRfnvnqv05m1Gn2p/YnnWN4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkTOA-0007b5-Kb;
	Mon, 26 Jan 2026 20:40:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vkTO7-0007ao-S6
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 20:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5+mdCDHTLKUZStslE45M6d/w7r8i6cIFsJ8N6HjjaF8=; b=e0a7M0yHV6Ni77Pt4HgdoJ69CU
 FM3sKaulAxu7jRoOBW48rDo9EQSahNek1NaB9Pv80m3uRQsb/kvo7yzkH4M6fHYshxOruUrQWQpw9
 qL0Vx6S2mdA5w/ofW1bF8y5P6W1vYh7Ob/xsT3vk08gbIfDJD9+K87pvKphO13SLY3/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5+mdCDHTLKUZStslE45M6d/w7r8i6cIFsJ8N6HjjaF8=; b=dhFeBlY3YhLju/aHznqH0qBgqr
 A0a/W9UT7e5OflU6aG2hJ57Efv4BrRimlSAylJHpjU5tZ0kkq6/dZmwtVzYQ80+nYAkEnXQDazWsi
 wHoJhz/pp0bLU1ZUEyyZRmsnCYMfKOr3hy0d0iWu0WQU9GmTxNBgUNWdayMprYdrQBzA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkTO8-0001Sr-8o for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 20:40:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9AE3A60097;
 Mon, 26 Jan 2026 20:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EF5C19425;
 Mon, 26 Jan 2026 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769460033;
 bh=l9LtVaA6nSgchLlbWTin67CmDN89iXVzMWWCdcxjYtQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GvCXJa1wvGHyoJV9yOd66dqhtlHhRupqhUfh5O2T0Ya8SFJbAMSYNmVfKko3GIlzu
 GZ4v7xk90vOaiMqntDQZxal2LJHyMdqlrfA2VrpO1g1ONf3CaidthkaAO/8WSMijUC
 nRhLsxhFiOQKBR46zuWB+3wSNaEv0N1t9HVvogXMcgvEXPJsyzsH3D7nLjEGus2NDu
 BtuiviqxabzsOo6QlqNqbiaPJMyPcakCnf391arUowfEXOpSoV5GY9Xab/cmuxIRhp
 MtOqb7XafJGEURKGFxcUFt7JsLfBHierdMIOntMx4UUkCnLxHWHNc05ScL7mmULr5F
 7Ls1cBic34NrA==
Date: Mon, 26 Jan 2026 12:40:30 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260126204030.GC30838@quark>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-17-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-17-hch@lst.de>
X-Headers-End: 1vkTO8-0001Sr-8o
Subject: Re: [f2fs-dev] [PATCH 16/16] fsverity: use a hashtable to find the
 fsverity_info
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 26, 2026 at 05:51:02AM +0100, Christoph Hellwig wrote:
> The file open path uses rhashtable_lookup_get_insert_fast,
> which can either find an existing object for the hash key or insert a
> new one in a single atomic operation, so that concurrent opens never
> allocate duplicate fsverity_info structure.

They still do, though.  But that's unchanged from before.
ensure_verity_info() frees the one it allocated if it finds that one got
set concurrently.

> Because insertion into the hash table now happens before S_VERITY is set,
> fsverity just becomes a barrier and a flag check and doesn't have to look
> up the fsverity_info at all, so there is only a single lookup per
> ->read_folio or ->readahead invocation.  For btrfs there is an additional
> one for each bio completion, while for ext4 and f2fs the fsverity_info
> is stored in the per-I/O context and reused for the completion workqueue.

btrfs actually still looks up the verity info once per folio.  See:

    btrfs_readahead()
        -> btrfs_do_readpage()
            -> fsverity_get_info()

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
