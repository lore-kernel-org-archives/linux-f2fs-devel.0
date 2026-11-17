Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84B606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ApYHfn4W;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X6g8klVe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RaIyIKaH;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mz8kApnu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YgnGlwx7JZQ/MhuZwHP20ZtjyFrMKl/xp1qm/t2vF9U=; b=ApYHfn4WHC/HjC
	1aIBPm47OGL+CdRO8uw85puOkBQx2cOd6p9ZTOVt0UTQsDB7eV6SH86MOhlefTW8VJZ5SHcsAg7YR
	gRMirr4fLBRFBcOzOe1qtpldINXK0+nbxhEfTsNDFaGqCvZaX74j2m8wnDKKwrhFr3Xu7nQVRM0B1
	xvU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTHXV-000000007Bn-1BN8;
	Tue, 17 Nov 2026 11:39:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTHXR-000000007Be-0JOT
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kTKfM3E0D9hYugyXbXLMpuiAOru2XWcId1jwWBVeBXg=; b=X6g8klVeVECEZU2khoJrhGJfZ5
 3586A2hsbZHTFqdRxCk+MdmtGimp7xZmYSH07Hi90tCdi3/mlYSbZ/nUArqnRvzTYdTv45DtMky4B
 AkBzV7C7gcAHZhsbpgkqunAY0A9fSDU7d0/vGlqCnCoDhYEO8ydbfH3cjDx7peH001LM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kTKfM3E0D9hYugyXbXLMpuiAOru2XWcId1jwWBVeBXg=; b=RaIyIKaHn3sR7cD8rR4IQx35sR
 BKb5zATJlgKQMdCvY9euWME7yHzdTlXOkUQ4bdXJX3xAO4/DOkL52VEx//vr5GNx7jmPYuY/FulGe
 m9iCN9Jog1ZITs5uoui2uH6yhEOlobdRat0/9ooz6iZob7O9XfL78+rBOLMgyAzJoTkk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTHXP-000000003iA-2j3a
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:39:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEA06628D9;
 Tue, 17 Nov 2026 11:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4CD1F000C4;
 Tue, 17 Nov 2026 11:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794915581;
 bh=kTKfM3E0D9hYugyXbXLMpuiAOru2XWcId1jwWBVeBXg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Mz8kApnuvbwlXmwzwNzy/CPFYHpUl2A1cOq1pXVfAT/TSWONCPXb57x8+5A3SJ+5F
 tgzd0ObNnMcSK8/WKYdKoSY01RbThRZEMvYLHCLedYr05t8cu1LJEM2tgixY+OBCH4
 T9uJ5dfXSxdrJR+BBnZqV4oUuiTRDBqoC3oSnt+Xsi/QxOwdWhtlMC8EzEfvW3i79R
 5nJLDe2x24cu4sonrrv3JzaTUDWIzlH59phyo5M94Iq+vtCSu1MnxXT0QKWdE1NN8u
 fz9g6jZSJLGC7JLRmH3wVw18VSj4+uy3WHtWWIaP/xqBrv7Po8Pv/XacHQvAoUcNyb
 2saaI0TjG1Wpg==
Message-ID: <b253465e-d0c6-45eb-9ae8-798ef9ced6bd@kernel.org>
Date: Tue, 17 Nov 2026 19:39:38 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-16-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-16-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTHXP-000000003iA-2j3a
Subject: Re: [f2fs-dev] [PATCH v2 15/20] f2fs: support subpage blocks in
 atomic writes
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
> Writeback already writes dirty blocks to the COW inode per block. Make
> write_begin of atomic files reserve and read COW blocks per block as
> well, and remove the -EOPNOTSUPP checks. Skipping the read of the
> blocks that a write fully covers also applies to large folios when the
> block size equals PAGE_SIZE.
> 
> Aborting atomic writes drops the page cache and restores i_size without
> i_gc_rwsem[WRITE] and invalidate_lock. With subpage blocks, a page fault
> in between can make a folio writable with only the blocks within the
> smaller i_size prepared, and a read can zero-fill the blocks beyond it
> and mark them uptodate, while they are inside the restored i_size. GC
> reads through the page cache as well once FI_ATOMIC_FILE is cleared, and
> then moves the zeroes. Hold both locks across it as
> f2fs_ioc_start_atomic_write() does, except at eviction, where no one
> else uses the inode.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
