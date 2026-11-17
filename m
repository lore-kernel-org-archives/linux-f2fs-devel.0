Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FABB606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=clET/wsu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hLx3CWhA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cEnDQ343;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CH6YGOtG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gs6j/X3fMnZBaL39OOD/4OVq4oiNfdFUNvRl8ERxui0=; b=clET/wsuttEK2i
	IzZ+I8Z8hlegs61Q9pJZvsQk31e1IXEodo9usMTC/1aKsBcLOy4JGeTJnhG88frQ2OpDLcGZip1Im
	lBlP4OicgmkpZQ+jZkBDiu6YfpAg853pzbMhZtUieKsqd0XIutr4b84NnhNDcZ+7L37RSpU/hIq2h
	Qp4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTGfD-000000007G9-2aTn;
	Tue, 17 Nov 2026 10:43:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTGfC-000000007G2-3PaK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:43:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oya8J1CPElef6oZeFlm2b0Uh/NkwyFXzThuDchjvEIY=; b=hLx3CWhAb2Q3cR6WZdmeGgokyx
 ru1RoyK3bcajtb8wIj1Kf9SxrzLSUeqQ7moddoP9UyT1+VcRx5o3xGGBHTaF4StkRaJkL0Ado4oa9
 dLbnVcVQPzU+h0Hyig7OBhtnuTegxlG3wE+ETGdRZEwHAGaI+muerlhhOtbwxDIUEidk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oya8J1CPElef6oZeFlm2b0Uh/NkwyFXzThuDchjvEIY=; b=cEnDQ343803HyMavsSrwSEDY7U
 VKsUpY7s5cXwUBYB4yQmW6Es5UqgPmKOk7vXLQyJopfjP7qkMicVqCGkvGJTfhczOCAvsQkYJfeDi
 X+tEUAKh20YCKulg1IhMT4fKsoddTdFUWPgix3Tx+4FZIMqa5ykS6iuTtk8V44OlC7VQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTGfC-000000002N2-1NKI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:43:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EDC1C402E4;
 Tue, 17 Nov 2026 10:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECC11F000C5;
 Tue, 17 Nov 2026 10:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794912220;
 bh=oya8J1CPElef6oZeFlm2b0Uh/NkwyFXzThuDchjvEIY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=CH6YGOtGI5PPL+fkA3FlQdXSmGq9++wtuZWDQdPqqimFHBPd++Ux03OgqN5vEmvWY
 8dfYmRZuWyU7qtcv4OKNi6B4RulSluSJvXH+gZTzL0Cw1ju968YWL24aoedD0KNoRj
 fGWb6Y4jJpHt6r9KLrCGsKUBNCftWhM2u5iCdaW+s0ttoN+oyKbMElzywjPXM7ApG4
 xGcOkur1KQQ5vNzaIqaVGkad0rm+n8rfcTXWS2v78VNmZTYxyyw/c02QBWVy7urqt2
 FWOeW6jvlyW/pLk9UB//ld3OfyVl0hBapBtE0jhhYdMrf1rLf+ZDqTYMoM9XtCPhsR
 JK6IA7swwYzwA==
Message-ID: <6733d2b6-e41c-4f9e-9ccd-80a704c5307a@kernel.org>
Date: Tue, 17 Nov 2026 18:43:38 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-8-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-8-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTGfC-000000002N2-1NKI
Subject: Re: [f2fs-dev] [PATCH v2 07/20] f2fs: support subpage blocks in
 data write path and writeback
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> With blocks smaller than PAGE_SIZE, a folio holds several blocks, so
> write_begin, write_end and writeback have to handle individual blocks
> instead of the whole folio.
> 
> - Read, zero and reserve the blocks touched by a write per block in
>   write_begin, and mark only the written blocks dirty in write_end.
> - Write back only the dirty blocks of a multi-block folio and complete
>   write I/O per block. In subpage mode every inode is written back by
>   f2fs_write_cache_folios(), which now handles dentry and quota folios
>   and checkpoint errors as f2fs_write_single_data_page() does. Both use
>   the new f2fs_cp_controlled_inode() and f2fs_wb_folio_action() helpers
>   for these rules.
>   It also resets the error for each folio, so that the remaining folios
>   are still written back after an error, as writeback_iter() expects
>   for integrity writeback, instead of redirtying them.
>   f2fs_write_folio_dirty_range() cleans up each block where it is
>   written or skipped, and advances last_disk_size only up to the last
>   block it submitted. On an error, it clears the dirty state of the
>   blocks before the failed one, so that only the failed block and the
>   ones after it are written again.
> - Count inode dirty blocks from the dirty bits of the folio state, and
>   count every block of a folio dirtied without one, e.g. after a read
>   of the whole folio or through folio_mark_dirty(). Attaching a folio
>   state to a dirty folio converts its count to the dirty bits, so the
>   counter stays balanced.
> - ->dirty_folio() does not know which blocks were modified, so it marks
>   the uptodate blocks of the folio within EOF dirty. Otherwise, a folio
>   dirtied by mm after writeback cleared its dirty bits, e.g. through a
>   pinned page, is cleaned without being written. The updates made by
>   f2fs mark only the blocks they modify and dirty the folio with
>   f2fs_folio_mark_dirty(), which keeps the other blocks clean.
> - Compressed and atomic files are not supported yet in subpage mode:
>   write_begin returns -EOPNOTSUPP for them. Inline data is converted
>   first.
> 
> Some of these changes also apply to large folios when the block size
> equals PAGE_SIZE.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
