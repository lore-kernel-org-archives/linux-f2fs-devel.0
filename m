Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70080606A32F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CE1eGH1G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MfcsO4uH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D0lXyH7q;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZ96EuAd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PAHKjixykGSzhc4eywMwZpgCdLHq+/TG3VVU7R5SbOE=; b=CE1eGH1GpERKd+
	snm+JkSy3mrG5VM8D9yHLDbLcczNsSZ4Z+NvQTGloD0M7hbudygO9CcElNUxXnIN96tPlS43E+QG6
	OC21BBwapq+kEropzDTx8eOHqOGeZ7qqSrh8tfi7JGUlcivDr3Yen0MBF3CKnlG1U6pACeRDCb09X
	qe8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTHJd-000000006lR-0maw;
	Tue, 17 Nov 2026 11:25:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTHJU-000000006lF-3MyS
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:25:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yl5icuEXIda7IxOjFmHbe1+uqtm5Dj+XPSKgMl8VH9c=; b=MfcsO4uHWR2pBWoP4e6ecAdGQM
 lfQM7zFCMMd2fBEZttPVb1Eqv2waWFCdZ7EuWy8gP1M1ZecVDPlqbZ6p84xz0jxv1A7S004ofdzsY
 n9zNxDptDtp2Q1NAT2Rc6fo4W29zeA25cCG4TlA1LyAKlk72Jn8VR7vfPzige+gRdwVs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yl5icuEXIda7IxOjFmHbe1+uqtm5Dj+XPSKgMl8VH9c=; b=D0lXyH7q+hY/nOGdImNNjqChRv
 drWrFCJf0bHYMTUqWlnXtRhXETfRU9fzm0KFf6IENbA57P5MZK4So7jPBMcnqIBLQWqMWFyLHWvLh
 mgi5bQ299hKABf0u/EAxScAxXFdnOy++tqN4UQQnsz3BakHVlkh+fVP241dLQupNn7ww=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTHJT-000000007f0-1kZ3
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:25:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20560450F4;
 Tue, 17 Nov 2026 11:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDD81F000C4;
 Tue, 17 Nov 2026 11:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794914718;
 bh=yl5icuEXIda7IxOjFmHbe1+uqtm5Dj+XPSKgMl8VH9c=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=iZ96EuAdmCsE/PAZ7iW0KBrDhbSoCXQPCV4mWWIOrYU7LizxIKieHeOKfnNo6nyB4
 S7JDi2Svx35NAfydILBEArJMOkonFq8hJGr+ppYAMZ6wF1iV6YbhHOf5njBBHQAvyH
 lLJHDOSNcDt1yrdbMrdi1GvC+ggtAxRaaAVaWL1mwYn4ERRW31pXhuBgNSixlgBc9z
 2/fOOcVm3Xmxg9uxKlgxRSWV6xi5tXbSCzzrmxk51X53JwdrrqnUxk0A9eUSdqliTG
 pDihVFSADSE+pDuv8iaqKxFJea9bBLV3e8jPm+G+ezUy47Ze24zvi5SDUSF3k4EFu1
 g2VfKxXIg2M8g==
Message-ID: <31d5625e-226d-4524-b4f5-67c2d11b3882@kernel.org>
Date: Tue, 17 Nov 2026 19:25:14 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-13-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-13-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTHJT-000000007f0-1kZ3
Subject: Re: [f2fs-dev] [PATCH v2 12/20] f2fs: support subpage blocks in
 defragmentation
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
> Mark only the target block, not its whole page, dirty when redirtying
> data for defragmentation. Remove the -EOPNOTSUPP check.
> 
> Read a multi-block folio once through ->read_folio() instead of each
> block synchronously, and redirty the folio that was read after locking
> it. This also applies to large folios when the block size equals
> PAGE_SIZE.
> 
> Read compressed files through ->read_folio() as well, with any block
> size. f2fs_get_lock_data_folio() reads the mapped block as it is, so a
> block of a compressed cluster that was not in the page cache was read
> without decompression, and defragmentation wrote the compressed data
> back as file data.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
