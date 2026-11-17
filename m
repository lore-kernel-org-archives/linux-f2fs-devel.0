Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29130606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hh2FjKcG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KixE/w5U;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JhL0jaPn;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bs39lSpJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JvtwK84uLRSaVVJRq1gEyqucMI10cgF/DgcAT8nyTVE=; b=hh2FjKcGdmVDlUPzf4XWJEL1vX
	HfJZcBr8CihF4QJ8+EIB+vLV2paoEM0GRFVpmoTX248Z+ddsO08SRRKy3ou59HDL7ET2oeNOds+hm
	dyz8zAwaBx9ceRKM6Hpo2U3s9GXEkTGQmI1PQiT/SAvCgV+eM29kLMkEsKkozZqah6aY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTMPJ-000000000GI-3itg;
	Tue, 17 Nov 2026 16:51:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jaegeuk@kernel.org>) id 1xTMPI-000000000GB-3Obs
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:51:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3KbnbVGo+5jELz4RnHBN3fdcKesRiud/qwVfWP3x9go=; b=KixE/w5UkICp+Zi2a2H2zXDTXw
 07fgTswIFZRGD1KyQ6roDAHEbHGujEaEccwdzdBWWdd6SbNEEJ/gswpsLwIG7gMlVSyhmZZvmZhCs
 2e8gffEclJPygsBuhUN6fcsRypF524pVK/Qo1VjK6w5Z2a1D92nLvYIHd7DqPrZaQX6o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3KbnbVGo+5jELz4RnHBN3fdcKesRiud/qwVfWP3x9go=; b=JhL0jaPn4OKdX4L/9Z84uHU88F
 8Oj+ZclzOxYnQZcrVFK2MV448p07+kdkHW9EGCq4qd1mY7jzUDIOrGECaGRZEL9up76ZTF/LlW1QT
 EDF+K2y7B45Gfytjp8Hr/Ha/Rk8NF6DTe4X8ZkT+CcvieujZG4ifNLkcB/TcT3Rz8m9c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTMPG-000000007Pp-032L
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:51:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98D31407C2;
 Tue, 17 Nov 2026 16:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435451F000C5;
 Tue, 17 Nov 2026 16:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794934296;
 bh=3KbnbVGo+5jELz4RnHBN3fdcKesRiud/qwVfWP3x9go=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Bs39lSpJ8Ea1a1aFOtpNMLgHW61y0xwvtNlSYF3bC+BTgb1noJ+2Jfum2pFYXILpj
 FozARdl12izT3TaQL+2B+6zupswnN+HU3UbxE4mpupqR47t8QtoW0TBI6a2PMpIimG
 qgfJ7y/yqV9Ay8u8iRUHoXLSj13q/nJhLB0hzgXrTcYUhEZcPi++TkDeIpNqwN9H+p
 wOExdBu45ED25QoN3lHWPFrxSJuQxSLZsfM7Ab6qvNttKjbyeUHvlR+RQpyn2H7h0d
 34//Wb9H42xny4iQvMsr55xclqYqL65CVA/ubKzbUStB8vMDHVQ5Nmw30ycYLoSY36
 swHjvOGGB5VuQ==
Date: Tue, 17 Nov 2026 16:51:34 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <avyGFkZdLhKIC9Rs@google.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-7-daeho43@gmail.com>
 <22a8264a-0538-458d-a20e-f1d732aa69ac@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <22a8264a-0538-458d-a20e-f1d732aa69ac@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTMPG-000000007Pp-032L
Subject: Re: [f2fs-dev] [PATCH v2 06/20] f2fs: support subpage blocks in
 data read path and GC
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17, Chao Yu wrote:
> On 11/16/26 12:08, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > With subpage blocks, a folio can be partially uptodate, so reads and GC
> > have to work per block.
> > 
> > - Read only the non-uptodate blocks of a multi-block folio, and send
> >   every inode to this path in subpage mode.
> > - Do not use the folio state when a single bio reads the whole folio.
> > - Implement ->is_partially_uptodate.
> > - Convert block indices to folio indices in the data folio getters and
> >   GC, and prefetch the whole folio in GC so that its blocks are read
> >   together.
> > - Fix error handling in f2fs_read_data_large_folio().
> > - Zero the blocks past EOF in f2fs_read_data_large_folio() instead of
> >   reading them, as f2fs_read_single_page() does. With subpage blocks,
> >   they share a page with the last block of the file and can be seen
> >   through mmap.
> > - Test the per-block uptodate state in f2fs_find_data_folio() under the
> >   folio lock, as ->release_folio can free the folio state otherwise. A
> >   fully uptodate folio is still returned without the lock.
> > - Keep the folio state of a folio that is not fully uptodate in
> >   ->release_folio while the folio has other users. Otherwise a block
> >   that a lockless reader, e.g. a dentry lookup, is using can be read
> >   from disk again.
> > - Get sbi from the folio in f2fs_finish_read_bio() only after the
> >   compressed page check, as nothing pins the inode of a compressed page
> >   once its cluster is unlocked.
> > - Rename helpers that now take block indices, e.g.
> >   f2fs_submit_page_read() to f2fs_submit_block_read().
> > 
> > The read changes also apply to large folios when the block size equals
> > PAGE_SIZE.
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> > @@ -5636,6 +5684,16 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
> >  	if (folio_test_dirty(folio))
> >  		return false;
> >  
> > +	/*
> > +	 * The folio state holds the uptodate state of the blocks of a folio
> > +	 * that is not fully uptodate. Keep it while the folio has users other
> > +	 * than the caller, e.g. a dentry lookup that parses a block without
> > +	 * the folio lock, so that the block is not read again under them.
> > +	 */
> > +	if (f2fs_folio_has_ffs(folio) && !folio_test_uptodate(folio) &&
> > +	    folio_ref_count(folio) > folio_expected_ref_count(folio) + 1)
> > +		return false;
> > +
> >  	ffs_detach_free(folio);
> >  	return true;
> >  }
> 
> BTW, we should notice this side effect, dio may be blocked due to it can not
> invalidate folios which is referenced by other buffered reader.

Not from my end. Can we add a bug_on to detect this first with a reproducer?

> 
>     Thread A (buffered read)                Thread B (DIO write, same range)
>     - filemap_read
>      - filemap_get_pages
>      : folio ref taken (batch), folio
>        partially uptodate, ffs present
>      - copy_folio_to_iter
>                                             - iomap_dio_complete
>                                              - kiocb_invalidate_post_direct_write
>                                               - invalidate_inode_pages2_range
>                                                - folio_unmap_invalidate
>                                                 - f2fs_release_folio
>                                                 : !uptodate && ref > expected + 1
>                                                   -> false
>                                                : -EBUSY
>                                               - dio_warn_stale_pagecache
>                                               : pr_crit, wb_err = -EIO
> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
