Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE5606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VJcBEFVP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BlH7tjz8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ViwTpZT9;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHbhhraw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=J5NtW3stXHmkRmsXoszoTcAqXTAx5kcpxeUSgQ+EcyU=; b=VJcBEFVP6+MSLc
	NbyPCgSfHswF6SpbF1nPhHgXAN/L0iJXC+wPr9K7s0XX3Cis4D8YW4CtxOUyhYdnvbZ4Ge0eyj5xj
	dYipxGSClt9LaWRwqgOtdu9wfH9/Y6IY47W0d2t13xUiv/lZGPtjKho+BmFpcCUsPn1BG4t6UiPMA
	GN0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xR3cP-000000003JN-1ZM8;
	Wed, 11 Nov 2026 08:23:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xR3cN-000000003JH-39WD
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:23:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CU4hnlrXZCd9tMMKXfDhfgcXLuc9tfgbhabHI1pc2r4=; b=BlH7tjz8xAiWYPR32BPoIMy2pb
 DiLoPQpmsrOb2PdsXspiJytq+0+8WK8QVGC7EHxSRcp95c5gMUkqLUnpwr1sFvgJYJwX0E0GngREy
 5KCnD+MXoZRlA7GUbDoKWndUymK9fzJYu70r4PWWhtJgJiGrtOC/1db4+OJtXVQvNwCI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CU4hnlrXZCd9tMMKXfDhfgcXLuc9tfgbhabHI1pc2r4=; b=ViwTpZT9yshtWxqwnDUYC1pUFC
 iNTAik7Ct08iuuAFAuTuY8IrIei2Ge06IykcjSvMkirbDsAanaz/+QoLTd1uA9f5yDZmOKkVyluB6
 A0OIV2yzRd/7q/lv3sgy47rzOTn91+7T51Pq/SswMtsxWzIEeBYF+GNbC+jhQ3EQUvcU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR3cN-0000000075N-19jC
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:23:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A37CF611F1;
 Wed, 11 Nov 2026 08:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D3A1F00A05;
 Wed, 11 Nov 2026 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794385417;
 bh=CU4hnlrXZCd9tMMKXfDhfgcXLuc9tfgbhabHI1pc2r4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=QHbhhraw3DXiSH2OvMIT8zikgFolnxYI6yo6kNp8HlhaXPyVH99BWHGiHmP4u+i5l
 gCY6OIxgtJgGGUEY5+mkyI5K0SvWFVt1vAD8tzll9oMFV1RuxCsJI+x8CkYXmmKci4
 5/nlB26c2WSshqzGzIWx3QfMGn0uSGOuMXEoQZRqdEOdI3mgXil+dd2chSNDlapZk/
 U57EGNGL8C/dHFSRmjA3oszXqGQX55H8yT3v4xgq6t7FFviJdH9GeDEQu/qBHNYOFN
 C+pwbW5PhGjVAow3SmrtaDSEo4a5DuBu9yzfl+kI5nXRDUP3RrPYLif4DTOzzXBHzr
 kXUWjrU/oDQVQ==
Message-ID: <205eb014-0ebc-422f-8421-f9cf175acad7@kernel.org>
Date: Wed, 11 Nov 2026 16:23:34 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seungbum Ju <seungbum.ju@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261103101208.4550-1-seungbum.ju@gmail.com>
Content-Language: en-US
In-Reply-To: <20261103101208.4550-1-seungbum.ju@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR3cN-0000000075N-19jC
Subject: Re: [f2fs-dev] [PATCH] f2fs: wait for node writeback on the first
 fsync after a checkpoint
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 18:12, Seungbum Ju wrote:
> f2fs_add_fsync_node_entry() numbers each fsync'd warm node page with
> sbi->fsync_seg_id++, and f2fs_reset_fsync_node_info() sets the counter back
> to 0 at every checkpoint. The first node page fsync'd after a checkpoint
> therefore gets seq_id 0, which f2fs_do_sync_file() passes to
> f2fs_wait_on_node_pages_writeback(). That function treats 0 as "nothing to
> wait for":
> 
>     while (seq_id && cur_seq_id < seq_id) {
> 
> so the fsync issues its cache flush without waiting for its own node page.
> If the flush completes before the node write, the inode's fsync-marked
> node block (needed by roll-forward recovery) is not covered by the flush,
> and a power loss can lose data that fsync reported as durable. In our
> traces the first fsync after a checkpoint returned before its node write
> completed in many trials.
> 
> Start the numbering at 1, so that 0 keeps meaning "no node page written".
> 
> Testing (kernel 7.0.0-42, f2fs built as a module from the same source,
> QEMU/KVM, block-layer FLUSH/FUA model with dm-log-writes replay):
> - block traces, append+fsync after sync: FLUSH issued before the node
>   write completed in 29/30 first fsyncs unpatched, 0/30 patched; never
>   for later fsyncs;
> - crash-state replay (28 cells x 3 recordings per module): SQLite
>   WAL/TRUNCATE/PERSIST, LevelDB, RocksDB, LMDB and an append log lose
>   acknowledged commits or become unopenable in 24 cells unpatched, and
>   are clean in all of them patched.
> 
> The same code is present in Android GKI android12-5.10 through
> android15-6.6 and in the f2fs dev tree as of 2026-11-02.
> 
> Fixes: 50fa53eccf9f ("f2fs: fix to avoid broken of dnode block list")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seungbum Ju <seungbum.ju@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
