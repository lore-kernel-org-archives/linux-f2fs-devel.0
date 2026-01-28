Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760A3D46C01
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Jan 2026 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qwfA4Bn0yRR2BGQgXnf+dgNi8r505MwOwuNm4YiQNiQ=; b=Q7jqF26M/sx6TPEQSNDEGs+1HC
	OR4MlEzG20DPn7AmRSWFMKOMwpYcJwnv+nMdethZDC3FC9dcU36MACfvJJy92xJn7zt0JQ+Pc9uL5
	/VefWDYFhNmoIqXsRDXbSXkiqiM4zhaVyPHHZvcjYmnnEBoMPbP6DQ7TYSNL4hSQCNPI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vlESO-0005sJ-97;
	Wed, 28 Jan 2026 22:56:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vlESN-0005sD-Bf
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 22:56:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3oh93kyW7ovgPL0tsNpkrDrmZsuPmnfVE63+RzT7AUw=; b=TZa0dex7B7ox/9V6Axm0RvuuAp
 vZCIO8niAI+4dDATbke4OSOZgZQUpv4yOxPcbeHaUW5Je5ZtLOzF4HqgUAJNPHGDWL/G9oZLrj6rT
 +4RXHzFQyaern6SUPZH/qFOLnkGzt6NpW5SOIZE4NwaYHfINJ4rHjpyTrMHy9ED7LDB0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3oh93kyW7ovgPL0tsNpkrDrmZsuPmnfVE63+RzT7AUw=; b=REVfaaitfp/0oPZtNBsBPdL6i1
 KImkY/bPQqxolfHidl9xptD3En9Kom9E2oUGbrAfqUFSt7tHMfFoZjNkEYvg223A2hTd89VMm/b8d
 UMpxW/9rxeelOFQ4+lbWMrAh6axhic4mxiVtAVp1iBQHZa+DnCAjEUkHrmu87B05n0/U=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vlESM-0006hu-S0 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 22:56:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 823A844219;
 Wed, 28 Jan 2026 22:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EEDC4CEF1;
 Wed, 28 Jan 2026 22:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769640964;
 bh=G6AVfIC1JGDmaTVQGwdR7hkkzoGFp2N573ZSu778fg0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fUevwDKSYXW2qTthC9suQTp33pQKthgDUbL5JNSr8SUB95p7dbq9JTSxHdI+D8HOd
 /YqIbK8xa3d3Qzi2bBHGXDpc7pFtPhMllHX71bDnH4cJGrYgnci5TYNl/KlJUg1Fiq
 e4yDFz3nJ+KopJVJ8s+TdRiFXhHwJ6mbEt1Tjk8+3C6XT5IVlWkp3RfoF13IUfR21B
 wIgkwMYfz9yhgE8eQn+6TntFv4LHtqxeGuwUs9v7bnfX8U3VNieD6IMpG9hC+n3SJt
 WrtLVoQ8Wj2cToeVUyzXmGk99CjqQDtTFdOzWyxTVDcXLZFgUlrji2NtZD9/EYkSfs
 jwlYa7R7l7AgQ==
Date: Wed, 28 Jan 2026 14:56:02 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260128225602.GB2024@quark>
References: <20260128152630.627409-1-hch@lst.de>
 <20260128152630.627409-9-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260128152630.627409-9-hch@lst.de>
X-Headers-End: 1vlESM-0006hu-S0
Subject: Re: [f2fs-dev] [PATCH 08/15] fsverity: kick off hash readahead at
 data I/O submission time
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

On Wed, Jan 28, 2026 at 04:26:20PM +0100, Christoph Hellwig wrote:
> Currently all reads of the fsverity hashes is kicked off from the data
> I/O completion handler, leading to needlessly dependent I/O.  This is
> worked around a bit by performing readahead on the level 0 nodes, but
> still fairly ineffective.
> 
> Switch to a model where the ->read_folio and ->readahead methods instead
> kick off explicit readahead of the fsverity hashed so they are usually
> available at I/O completion time.
> 
> For 64k sequential reads on my test VM this improves read performance
> from 2.4GB/s - 2.6GB/s to 3.5GB/s - 3.9GB/s.  The improvements for
> random reads are likely to be even bigger.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: David Sterba <dsterba@suse.com> [btrfs]

Unfortunately, this patch causes recursive down_read() of
address_space::invalidate_lock.  How was this meant to work?

[   20.563185] ============================================
[   20.564179] WARNING: possible recursive locking detected
[   20.565170] 6.19.0-rc7-00041-g7bd72c6393ab #2 Not tainted
[   20.566180] --------------------------------------------
[   20.567169] cmp/2320 is trying to acquire lock:
[   20.568019] ffff888108465030 (mapping.invalidate_lock#2){++++}-{4:4}, at: page_cache_ra_unbounded+0x6f/0x280
[   20.569828] 
[   20.569828] but task is already holding lock:
[   20.570914] ffff888108465030 (mapping.invalidate_lock#2){++++}-{4:4}, at: page_cache_ra_unbounded+0x6f/0x280
[   20.572739] 
[   20.572739] other info that might help us debug this:
[   20.573938]  Possible unsafe locking scenario:
[   20.573938] 
[   20.575042]        CPU0
[   20.575522]        ----
[   20.576003]   lock(mapping.invalidate_lock#2);
[   20.576849]   lock(mapping.invalidate_lock#2);
[   20.577698] 
[   20.577698]  *** DEADLOCK ***
[   20.577698] 
[   20.578795]  May be due to missing lock nesting notation
[   20.578795] 
[   20.580045] 1 lock held by cmp/2320:
[   20.580726]  #0: ffff888108465030 (mapping.invalidate_lock#2){++++}-{4:4}, at: page_cache_ra_unbounded+0x6f/0x20
[   20.582596] 
[   20.582596] stack backtrace:
[   20.583428] CPU: 0 UID: 0 PID: 2320 Comm: cmp Not tainted 6.19.0-rc7-00041-g7bd72c6393ab #2 PREEMPT(none) 
[   20.583433] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[   20.583435] Call Trace:
[   20.583437]  <TASK>
[   20.583438]  show_stack+0x48/0x60
[   20.583446]  dump_stack_lvl+0x75/0xb0
[   20.583451]  dump_stack+0x14/0x1a
[   20.583452]  print_deadlock_bug.cold+0xc0/0xca
[   20.583457]  validate_chain+0x4ca/0x970
[   20.583463]  __lock_acquire+0x587/0xc40
[   20.583465]  ? find_held_lock+0x31/0x90
[   20.583470]  lock_acquire.part.0+0xaf/0x230
[   20.583472]  ? page_cache_ra_unbounded+0x6f/0x280
[   20.583474]  ? debug_smp_processor_id+0x1b/0x30
[   20.583481]  lock_acquire+0x67/0x140
[   20.583483]  ? page_cache_ra_unbounded+0x6f/0x280
[   20.583484]  down_read+0x40/0x180
[   20.583487]  ? page_cache_ra_unbounded+0x6f/0x280
[   20.583489]  page_cache_ra_unbounded+0x6f/0x280
[   20.583491]  ? lock_acquire.part.0+0xaf/0x230
[   20.583492]  ? __this_cpu_preempt_check+0x17/0x20
[   20.583495]  generic_readahead_merkle_tree+0x133/0x140
[   20.583501]  ext4_readahead_merkle_tree+0x2a/0x30
[   20.583507]  fsverity_readahead+0x9d/0xc0
[   20.583510]  ext4_mpage_readpages+0x194/0x9b0
[   20.583515]  ? __lock_release.isra.0+0x5e/0x160
[   20.583517]  ext4_readahead+0x3a/0x40
[   20.583521]  read_pages+0x84/0x370
[   20.583523]  page_cache_ra_unbounded+0x16c/0x280
[   20.583525]  page_cache_ra_order+0x10c/0x170
[   20.583527]  page_cache_sync_ra+0x1a1/0x360
[   20.583528]  filemap_get_pages+0x141/0x4c0
[   20.583532]  ? __this_cpu_preempt_check+0x17/0x20
[   20.583534]  filemap_read+0x11f/0x540
[   20.583536]  ? __folio_batch_add_and_move+0x7c/0x330
[   20.583539]  ? __this_cpu_preempt_check+0x17/0x20
[   20.583541]  generic_file_read_iter+0xc1/0x110
[   20.583543]  ? do_pte_missing+0x13a/0x450
[   20.583547]  ext4_file_read_iter+0x51/0x17


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
