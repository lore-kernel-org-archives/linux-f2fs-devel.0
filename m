Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307B606A329
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PAZo0f1Q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PU1wj6WF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ST4hMuXt;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXR+xf2Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YQsX30cO8qhr57kRkssC+JGb+Xir0UrLKR8WtDdSAYY=; b=PAZo0f1QgLVb7E
	SQX4y8LYL6yN2ioIxhFshyMC0hjRNZnus+6/GIOI2awIocqYmgsO0jewZRu13LC/vGMHre4ljkkEL
	/EDF7jEF2VdChGB0gSfJbFK6uxr0FjUoXiRtK1NHfolHjSEFMYsapCrX2V8xNEpp6PXVapXQxW1g3
	KJY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTHGk-000000006gH-3DpL;
	Tue, 17 Nov 2026 11:22:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTHGi-000000006gA-3bUF
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:22:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DBWDdYeJ5KNHUCcYayk7e9to+UqL74ZokWwi2GyVhLE=; b=PU1wj6WFhpXQaQBlNxO6L3Jffw
 nE+ckJyMQdrABt7xtQXxBTHDVmeUzfvr0hVYFD6Y0WB94f+CJykpbiQGi2u77w63egyMetR9zpNCK
 DtgbW4vb6YYZDlB8y2VDKpapMoKD7GhXdqpiwAkN/5XOUmk/qp+Ta4tF3u5tPCLoXJmI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DBWDdYeJ5KNHUCcYayk7e9to+UqL74ZokWwi2GyVhLE=; b=ST4hMuXtvSJr0Nb6Y7b/uKOYcn
 5qO54TTWLrB6HPvHYywaDFEmZkHxmX1F3IPCKhDbNiIJpCFzZKDE9wXzPHSX1XEu35KO8ShlX8LiP
 +/zufHQ8F2SQiS2+xdzsllWtLSrluC3eJznt1W4G4oReHjwoOfeAJWviXw0SsMxKHKOk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTHGi-000000003Ii-1HTS
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:22:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE2736340F;
 Tue, 17 Nov 2026 11:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8421F000C7;
 Tue, 17 Nov 2026 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794914546;
 bh=DBWDdYeJ5KNHUCcYayk7e9to+UqL74ZokWwi2GyVhLE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=BXR+xf2QWqrPdbYaM7Lh9ObomQVhPJFQxAy5QlAu2VwSzq23RuHbw2ttLRc7fXN8E
 iEOrgh8j4cpMMS0NJ8n0ZHJmYIG9ObruvGuqD9J1tAQEw3LakbQ29s3dbbLytExbgO
 Qpq+XMOyVkK2WUoiKpR/qjx757/uAZd6jIOB2UfJDhQJBDVu1S5RnhLSI2nWRze2iB
 k5rtEx/hQWljZ3zRG8oHMKXtb+EZQggDvtHX/16X3MKXNnwUqxk3suPgjChyo9kw9R
 rAaru+c7Yo9At8JIVjdO3wxK42ScRy0wAw0/6oE+W8c1f9H+5gIRk+yo5TZBb5T974
 ogfKmuOnvwUBw==
Message-ID: <fa41d65f-358a-4b8b-bfd5-1e73ed04e723@kernel.org>
Date: Tue, 17 Nov 2026 19:22:23 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-12-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-12-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTHGi-000000003Ii-1HTS
Subject: Re: [f2fs-dev] [PATCH v2 11/20] f2fs: support subpage blocks in
 move range
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
> Folios at both ends of the moved ranges can straddle the range
> boundaries. Write back and truncate the page cache from PAGE_SIZE
> boundaries, and hold invalidate_lock of both inodes during the exchange
> so that faults and readahead cannot bring back stale data. After the
> exchange, also after one that failed part way, drop the source blocks
> that it read into the page cache, and call pagecache_isize_extended()
> for the gap between the old EOF of dst and the moved data. The page
> cache was not truncated before, so this also applies when the block
> size equals PAGE_SIZE. Remove the -EOPNOTSUPP check.
> 
> Zero the cached data past the old EOF of dst with
> f2fs_zero_post_eof_page() before the move extends dst over it, as the
> other paths that extend a file do. Otherwise data stored past EOF
> through a mapping becomes file data. This also applies when the block
> size equals PAGE_SIZE.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
