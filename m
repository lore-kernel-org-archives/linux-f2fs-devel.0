Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C93606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JSlVNXgp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XxwlSceT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HJtcBDeF;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jd+/4Zzd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IMg6OS6aXmwCtwvjqTw1OCMwEhIauKsgb3JmZlCRx7o=; b=JSlVNXgpw4tWnu
	Qvw2DRXmhycdrSDST/AwYehGvOqqffLLaXNm/Xh9DIGgN53bgkOpyJlaUsvKZEIcokxU3y+b9KeKT
	UL0U4CTWU061y7qVz6SvwrHaTmsAQFFNEGinHa90XD8oj1Kl9plMEOWPgjKuQptRaA7LFkaGszeis
	8sM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xR3jQ-000000001bN-3VR7;
	Wed, 11 Nov 2026 08:31:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xR3jP-000000001bG-3fpg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:30:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3H9/gKfZON35QpEehuN/02KH/4m7mFFGWW7NINuD4kU=; b=XxwlSceT2nQBC8LCUjRUhOI2ec
 z6Yb6dUibAU4qwRVXw5j4Cr1sPoE1Zl8osEbkISMcYuN0mDL/URBHUKQpoAurKoL9jmzN9pecrZxk
 SF2RrfqijmbuOgbh/G7RqAtawAz2YLnnAlBJZHDCXx3tSrGgx+VEd5xE0qCNmdZZ9tM8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3H9/gKfZON35QpEehuN/02KH/4m7mFFGWW7NINuD4kU=; b=HJtcBDeF77Cz2r0O++9SSFPx/B
 0BuOwEYaYTZZZCZWKtcaZOiNkewucRHclV8zXpXjkMfidXcvvrBiB/bn8r6R5XTexAAmc0V61NG2P
 T+IUuhkEcAmdM4Grq/NdOuecExMttUKZzB4w0XibORcl+ePYKsfYD0bNqEF0zn607QAo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR3jN-000000007Tf-0jJp
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:30:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDC7E40B1B;
 Wed, 11 Nov 2026 08:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB251F00A09;
 Wed, 11 Nov 2026 08:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794385851;
 bh=3H9/gKfZON35QpEehuN/02KH/4m7mFFGWW7NINuD4kU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Jd+/4Zzd33jg0xiYr4KG6ZMv59DluJdGvQyECHxm3i13QwhLqQWkZwdB5PZ0Voh4G
 WVxnnG/fkglmxPtRB+yt7tsBPO7jzV9/W+JAuQAvTHS1o3N2ODBtuuzKDcMZ5HNNED
 m1LOSwhLVJ/t+o7H59Jw6s4YCf8074TJpF5QhF4HW2xHInDxyz/tiuwjE+v8iSscvO
 A0LmkdBZvfroks7lh5TuLAOkivp/waxGUzTDO6PxRfujIQOrNkrdqpkohwGH2lRCv5
 Y34bHBjnU3u9aHiVI6KU+aGbtyeLX7/9hHVlKhk+IPmgVGLpxIhIwQS+jIUjV90Fmd
 B/ypaXGto/hYg==
Message-ID: <acb8e08b-4a9f-4419-8b1b-b1933800311b@kernel.org>
Date: Wed, 11 Nov 2026 16:30:48 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <tencent_B30A444DF94444D1A63A7D6F8E2039F1990A@qq.com>
 <20261105034419.2701443-1-zhanxusheng1024@gmail.com>
Content-Language: en-US
In-Reply-To: <20261105034419.2701443-1-zhanxusheng1024@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR3jN-000000007Tf-0jJp
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't BUG_ON a missing orphan inode at
 mount
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
Cc: zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Guikun Yang <yangguikun19@qq.com>,
 stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 11:44, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> recover_orphan_inode() treats -ENOENT from f2fs_iget() as a kernel
> bug, but the ino comes from the on-disk orphan block. An image whose
> orphan entry names an inode without a NAT entry hits the BUG_ON at
> mount with CONFIG_F2FS_CHECK_FS, or a WARN and a failed mount
> without it.
> 
> To reproduce, unlink a file while it is still open, sync, crash,
> then change ino[0] in the checkpoint's orphan block to an unused
> nid and mount:
> 
>   kernel BUG at fs/f2fs/checkpoint.c:967!
>   RIP: 0010:f2fs_recover_orphan_inodes+0x6a3/0x9a0
> 
> Treat it as corruption, the same way the entry_count check does:
> fail the mount with -EFSCORRUPTED and record
> ERROR_INCONSISTENT_ORPHAN for fsck.
> 
> Fixes: 8c14bfadeac2 ("f2fs: handle error of f2fs_iget correctly")
> Reported-by: Guikun Yang <yangguikun19@qq.com>
> Closes: https://lore.kernel.org/linux-f2fs-devel/tencent_B30A444DF94444D1A63A7D6F8E2039F1990A@qq.com/
> Cc: stable@kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
