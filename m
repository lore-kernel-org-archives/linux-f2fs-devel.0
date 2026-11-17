Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C2160A2611
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XL0V1C19;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Xbeyefxj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dNsqLW0e;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlF6JON1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qnnjiNo/OSjvy2qiMSTiF7z3/WquDK4RI308hJb0mH8=; b=XL0V1C19+gYErb
	3BXp+FkGVS0DLWhDBYusXGVY4hnb4A1fhBKmOBKWJ8UDFRAy27dDI44YYBy5UoLVHFt7+3JwcINKH
	30LVRwQW7r23Al02l4IJfRuGSH19E5Zzz5/diaWgtQbStv4F7wXdcKyWJ7dX/fJ//TZw/su+aafWE
	OOM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTF1q-0000000038F-2eAx;
	Tue, 17 Nov 2026 08:59:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTF1p-0000000037y-0FBs
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:59:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UfPUXhLHv7nnCZ879aEk2MvKrIm4Y4NVkVAkXD0d6Dc=; b=Xbeyefxjg9+A1wfCqvbXnugEl+
 j1o9mJfaR7z+5/GVLOfABt+wEBREdArtJ34q/LnPenYZuTPCOkpiOYue5hp2WpGV3iy0cHT/PxLBY
 Oz3giYaNEf1M5CIzMcfaedsDWVSKsX2TJiKJ+REBehdgSLgEp/oYDCpxxqfjzb9daxWs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UfPUXhLHv7nnCZ879aEk2MvKrIm4Y4NVkVAkXD0d6Dc=; b=dNsqLW0eDgz5yn6iLMtRUrFFMJ
 0GEOIOodrL1Y+Gkvt5V1clMdkTNEc3Koqo5i/jqLXouYG4pN2DNGp5ruO4ZjAtCoKR3QQLnUg3GCf
 9N1lThYXlkb0+vwB0dgcpNLP8OIOoMCBkvL3KAz0y1ppTV1zIGyPNxz3aO0vWlThqpMQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTF1N-000000006zp-2843
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:59:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E3A05601C5;
 Tue, 17 Nov 2026 08:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF4F1F000C4;
 Tue, 17 Nov 2026 08:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794905907;
 bh=UfPUXhLHv7nnCZ879aEk2MvKrIm4Y4NVkVAkXD0d6Dc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=KlF6JON15E0+mBMT4+PSoVdxw4TlOTma4T0Sd6oknoY8gAh9oxyLNBb2j7rPTLBMT
 nXdwrrIyacqm+NubmtXeLPTLn437MaQfsOSwzQbg0YnMqnfA1HyfXQ9O+ZwBi/t8O8
 gbPqCOZHNliGTJB0oMeQM2G2WzIRdNw/Z0J1aZIrG0eSEcCnDCDGjcwR6Ort3l/nUZ
 61WXWiP/wiQpfNydePaIasG/hH0eIbUcbAYbNqhDKR6i3zboJTHKFgThmuSeKG5WHh
 PvJJTxCVIZz84YjE/5+Up0hIlgJLqT830jWHChwNWLO9sjmHXcX9erTm8XfMQ5qOl3
 Nhrgqkw0JWnuw==
Message-ID: <22a8264a-0538-458d-a20e-f1d732aa69ac@kernel.org>
Date: Tue, 17 Nov 2026 16:58:24 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-7-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-7-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTF1N-000000006zp-2843
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> With subpage blocks, a folio can be partially uptodate, so reads and GC
> have to work per block.
> 
> - Read only the non-uptodate blocks of a multi-block folio, and send
>   every inode to this path in subpage mode.
> - Do not use the folio state when a single bio reads the whole folio.
> - Implement ->is_partially_uptodate.
> - Convert block indices to folio indices in the data folio getters and
>   GC, and prefetch the whole folio in GC so that its blocks are read
>   together.
> - Fix error handling in f2fs_read_data_large_folio().
> - Zero the blocks past EOF in f2fs_read_data_large_folio() instead of
>   reading them, as f2fs_read_single_page() does. With subpage blocks,
>   they share a page with the last block of the file and can be seen
>   through mmap.
> - Test the per-block uptodate state in f2fs_find_data_folio() under the
>   folio lock, as ->release_folio can free the folio state otherwise. A
>   fully uptodate folio is still returned without the lock.
> - Keep the folio state of a folio that is not fully uptodate in
>   ->release_folio while the folio has other users. Otherwise a block
>   that a lockless reader, e.g. a dentry lookup, is using can be read
>   from disk again.
> - Get sbi from the folio in f2fs_finish_read_bio() only after the
>   compressed page check, as nothing pins the inode of a compressed page
>   once its cluster is unlocked.
> - Rename helpers that now take block indices, e.g.
>   f2fs_submit_page_read() to f2fs_submit_block_read().
> 
> The read changes also apply to large folios when the block size equals
> PAGE_SIZE.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

> @@ -5636,6 +5684,16 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
>  	if (folio_test_dirty(folio))
>  		return false;
>  
> +	/*
> +	 * The folio state holds the uptodate state of the blocks of a folio
> +	 * that is not fully uptodate. Keep it while the folio has users other
> +	 * than the caller, e.g. a dentry lookup that parses a block without
> +	 * the folio lock, so that the block is not read again under them.
> +	 */
> +	if (f2fs_folio_has_ffs(folio) && !folio_test_uptodate(folio) &&
> +	    folio_ref_count(folio) > folio_expected_ref_count(folio) + 1)
> +		return false;
> +
>  	ffs_detach_free(folio);
>  	return true;
>  }

BTW, we should notice this side effect, dio may be blocked due to it can not
invalidate folios which is referenced by other buffered reader.

    Thread A (buffered read)                Thread B (DIO write, same range)
    - filemap_read
     - filemap_get_pages
     : folio ref taken (batch), folio
       partially uptodate, ffs present
     - copy_folio_to_iter
                                            - iomap_dio_complete
                                             - kiocb_invalidate_post_direct_write
                                              - invalidate_inode_pages2_range
                                               - folio_unmap_invalidate
                                                - f2fs_release_folio
                                                : !uptodate && ref > expected + 1
                                                  -> false
                                               : -EBUSY
                                              - dio_warn_stale_pagecache
                                              : pr_crit, wb_err = -EIO

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
