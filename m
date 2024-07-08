Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF1DC3DA41
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jul 2024 01:36:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sQdIo-00053u-2y;
	Mon, 08 Jul 2024 01:36:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sQdIm-00053n-SQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 08 Jul 2024 01:36:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wop8NB1CADJf3dFgsWZMxf0NKSiH+ehqvaP/c2uW7ls=; b=OiOdJziPKILltWVuV2ukH8In6P
 ybt7XYBhq5dKibJvsAT0wgq2nbl1+cMvbUkBOkTXwvdnrb1SS4cF8aje9GVoPCHxhasbT+a3EH44Z
 c0XlSYPtOiUMQcVpPv4qzodCQ/1rFfF9HcZSP5dFu6pzeQgr0SJrMs7MUJdw9ilfnSDs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wop8NB1CADJf3dFgsWZMxf0NKSiH+ehqvaP/c2uW7ls=; b=jmg271nSKtH6UcjRHp+TB0UgrO
 5bR7tgOPU1KiHPib/sih7h7unpWhKwUr5yib8LVAN6GJo85+APoIHtMNPQWuJCp8Gkc12LPsFJnZR
 Nc5U3J1BG+iHCkfx6L4Pzqwid6aBvo/XgSL63cTDK7zQFS3iAndj5FM1YOAgTV+DvN6g=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sQdIn-0007RY-Dp for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 08 Jul 2024 01:36:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4D7E960A16;
 Mon,  8 Jul 2024 01:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62690C3277B;
 Mon,  8 Jul 2024 01:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720402574;
 bh=jjPi20fkpscvvuNNyz28Huqs5WzzTrBLiMl2784STsA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EMuq40Qd+Cjaf5+t9w3DZODkks8kWlHbhNWUn8WRkQLw19FUN92uPBWqD3LDXvlA0
 eaEzDUxQSC25NgJDgLqLcNBdpsBPA0NivlCVG9gqCYhhpJPgRunub1Mzggx0jhfeZs
 FWNrqgmEB6iT+BzxlKz/wyAqPRaGC0MpQ8Pqnoj8+sM7E2g2WaXd3vMH/bfcmzP90t
 V41rdSezPp4ZDFLuIC7KPrlehro2h5K1r6ZIdTCnkeZdk4TVkU5vqfwTdScbGoV/N0
 UwSLADDxrVbzCOrZGxwshHtvjtaZZgWSazs30FOyeYMvYNvKbuepApukTipOqdpCSi
 ve7By4XKgSDgg==
Message-ID: <149db396-b62b-4c24-88ee-a6dd2dd85459@kernel.org>
Date: Mon, 8 Jul 2024 09:36:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sunmin Jeong <s_min.jeong@samsung.com>, jaegeuk@kernel.org
References: <CGME20240705082453epcas1p3b42790db4a6df77c14b1f8a2bae39435@epcas1p3.samsung.com>
 <20240705082448.805306-1-s_min.jeong@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240705082448.805306-1-s_min.jeong@samsung.com>
X-Headers-End: 1sQdIn-0007RY-Dp
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: use meta inode for GC of atomic
 file
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
Cc: Sungjong Seo <sj1557.seo@samsung.com>, daehojeong@google.com,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/5 16:24, Sunmin Jeong wrote:
> The page cache of the atomic file keeps new data pages which will be
> stored in the COW file. It can also keep old data pages when GCing the
> atomic file. In this case, new data can be overwritten by old data if a
> GC thread sets the old data page as dirty after new data page was
> evicted.
> 
> Also, since all writes to the atomic file are redirected to COW inodes,
> GC for the atomic file is not working well as below.
> 
> f2fs_gc(gc_type=FG_GC)
>    - select A as a victim segment
>    do_garbage_collect
>      - iget atomic file's inode for block B
>      move_data_page
>        f2fs_do_write_data_page
>          - use dn of cow inode
>          - set fio->old_blkaddr from cow inode
>      - seg_freed is 0 since block B is still valid
>    - goto gc_more and A is selected as victim again
> 
> To solve the problem, let's separate GC writes and updates in the atomic
> file by using the meta inode for GC writes.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Cc: stable@vger.kernel.org #v5.19+
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
