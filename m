Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD4606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=izGk5PC9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JeJ3/XpH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YQ7gBPy1;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTK3Zdzd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SQVUv4XVXz6uDusU7v3PJEhn8S37Aghkzo9F/MH5VpI=; b=izGk5PC9WnfISp
	i4biAl7qL68LoMI/0Iojmjd7JaQaI0VDPnnjUTF5HKDGpn3o5qHUg+jVsSy2jzxPBGuPZAZDVInhe
	um3vMq+0agzkmb3hEYTSKOyDLNMECJC1TkcRMMOHs+za5yqgt0OWltHNslysQEduoH/p2JNkxtahM
	u64=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTHYY-0000000024k-3FQH;
	Tue, 17 Nov 2026 11:40:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTHYX-0000000024a-3j2C
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:40:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wS1Hzm923FuQaQ3mJRDlA9hColzdiTa3bh8NOA9jRh8=; b=JeJ3/XpHe1YmFBbskgVgCK5gfV
 98V3zCj2YgyUV07XGM2s6u9QtOb6c/OHTsFwPjQpgVBtMKparQ3YxzdgnW5RE35gRCL9Z8HPPh5ak
 rgC0Cv8RqjKKwoKn6ODX9drrBCL+eccACHiYWDHDWQS73hqSStnLYZn2OMePCqMhfdkU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wS1Hzm923FuQaQ3mJRDlA9hColzdiTa3bh8NOA9jRh8=; b=YQ7gBPy1Psjs5FZzWrl/ekxL5E
 SOpkgAWtj7xkL2fv5t735gWq7o7uoE6GR0OPabGaVz24ZPrse37UNmq2GxlxZKZK8aqr+BsNEisgu
 hOn7n1V7cP5VinplBqdtwYQFy0SR5P59OUJ8DNIdmmms2ln+TUwyW++SfHXnWS7IfqW4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTHYV-000000003l5-1O0p
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:40:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0690E417B5;
 Tue, 17 Nov 2026 11:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3FE1F000C4;
 Tue, 17 Nov 2026 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794915649;
 bh=wS1Hzm923FuQaQ3mJRDlA9hColzdiTa3bh8NOA9jRh8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=NTK3Zdzd4o+qPfuSxZTopEgjQZKW2k57Ge635tyzKGGdLWI/xGgqXQ10B2EjQP41k
 FxgHk5iFUozKecZvh96pc1zwdApOAKBCI/rAspnTJPx+fem9nNvx2epmYgETnmtlkd
 b1Y2IwcIp5wFXSdsxnjMx4vG25QhGXHzyjClvGJpvpKgq6MIxkkTmQxUSLs1ZkwfyT
 q3jRQHOGkiQJiNMm9oGqFbpQdBjFpz9trQaqdLZynTrtWd+sFAxixa+SM+9wkAemBJ
 iZQwzX8dGUDSbc5w8/08NGuo7dmWMyWmft3fJ/OsA0KNLxo1oAQhUojypnGpqTPlIT
 2zYAtFcPbHrWg==
Message-ID: <5833f9d9-26b1-41c4-86bf-31b353ea41c1@kernel.org>
Date: Tue, 17 Nov 2026 19:40:47 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-17-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-17-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTHYV-000000003l5-1O0p
Subject: Re: [f2fs-dev] [PATCH v2 16/20] f2fs: preserve inline data in
 subpage block mode
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
> A write to an inline inode converted it to a regular inode whenever the
> folio held multiple blocks, allocating a block even for small files.
> Convert only when the write goes beyond MAX_INLINE_DATA; otherwise read
> the inline data into the folio and write it back to the inode block in
> f2fs_write_cache_folios(). This also applies to an inline inode that
> uses large folios when the block size equals PAGE_SIZE: its writeback
> now goes through f2fs_write_cache_folios() instead of
> f2fs_write_cache_pages().
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
