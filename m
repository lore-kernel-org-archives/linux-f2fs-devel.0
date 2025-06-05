Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D630BC5B543
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+FwKgMiyqFk7S0VNawANZ/QGzCicOJCbMdcowVUaQE=; b=EqafLUkkWnRX1rFFCQ06fyYCOv
	dCtoqWA8H1NUs5VdjHHEaLLDaWpiXWbzs+K5h6mZSaSbw6It61gh25Fb2dxIbx//btXj3U9JfOW/F
	kf1he5SuaSdo4tNiRgCuoRnY48ymN7G0MagwCKEj219URtMm8jLC7ChAOFDXyjlxKOr0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uN5m6-0000wZ-Sw;
	Thu, 05 Jun 2025 08:16:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uN5m1-0000vZ-MC
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Jun 2025 08:16:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B8hm8U1NlZG5Rzh0lxskLBNWer+MfO1icD0g5yP9S9w=; b=jiGbctP5Bf8+wQlPsjvGz7Vf8p
 N5Q1Pcnffua1ZjVWrDx3cHPUokshpnhwvOhix6iyYNJa5KzpY4VLx6/o/7m0P67wENUqb4YV//ZUV
 02f9ROIQrpvkSr34GnAqqXhgOd2SvS8r3zHYQApLkagWbJTaqYOHUgpxV9eWJh6DW0+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B8hm8U1NlZG5Rzh0lxskLBNWer+MfO1icD0g5yP9S9w=; b=fjL1R6gVz8K3Ec3ryF9HFsWCpY
 MbLSB3uFVSMVLKSpyCXkXUd0dX3LlPNRyqLJy3wnipKQGu/KFeoyWc9vlmC865w0HwTDvEdrRG0e8
 ajpdF1fv2pIrlzFj/XqHRaBMxoCcXz1enNwMqsQJDnFxsZ44+epaWIUSEwZTkgtWMPdo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uN5m1-0006WK-AQ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Jun 2025 08:16:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 87A7E61127;
 Thu,  5 Jun 2025 08:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D5BC4CEE7;
 Thu,  5 Jun 2025 08:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749111383;
 bh=TMeDcR3Ngso8hDEVnwaJtaUK1Pulrv9Er3MDX3dvUnU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=JgIzz5osfm+MMt4pkQ4XXiWn7/SmmmtcX0c9mLh1BYsDO0tKyvlV5xA8xrMmhOWkz
 D9oFlGvV8RuBLtfPrkxdMwrFgj4jYwtSJnCMhF+tvQVU8KkTAXXXdSMD1VwDjVo1Nr
 iUxgWv0WvjQKaYIzpc3jrt/t6C+7LZ6TFUW3endyYi/dl4pxpgJUzj4LwA9FR3vRxA
 IQtNxKsNVkAIP1XvrDaHfpoScsPUJa6fc1L7qAkzS+6OpeqcjV65krV+NxoRvM5QjC
 Sm5s25Na8FbHzfWGKoabDoouiI7aS5clHAXjwIPgPmqsYlJWY2dbsegbMUIPytIW8E
 JLzpDNKC8Qzuw==
Message-ID: <9da338b4-4d38-4206-81d5-531265165d16@kernel.org>
Date: Thu, 5 Jun 2025 16:16:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1749107920-17958-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
In-Reply-To: <1749107920-17958-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1uN5m1-0006WK-AQ
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: compress: fix UAF of
 f2fs_inode_info in f2fs_free_dic
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, baocong.liu@unisoc.com,
 Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/5/25 15:18, Zhiguo Niu wrote:
> The decompress_io_ctx may be released asynchronously after
> I/O completion. If this file is deleted immediately after read,
> and the kworker of processing post_read_wq has not been executed yet
> due to high workloads, It is possible that the inode(f2fs_inode_info)
> is evicted and freed before it is used f2fs_free_dic.
> 
>     The UAF case as below:
>     Thread A                                      Thread B
>     - f2fs_decompress_end_io
>      - f2fs_put_dic
>       - queue_work
>         add free_dic work to post_read_wq
>                                                    - do_unlink
>                                                     - iput
>                                                      - evict
>                                                       - call_rcu
>     This file is deleted after read.
> 
>     Thread C                                 kworker to process post_read_wq
>     - rcu_do_batch
>      - f2fs_free_inode
>       - kmem_cache_free
>      inode is freed by rcu
>                                              - process_scheduled_works
>                                               - f2fs_late_free_dic
>                                                - f2fs_free_dic
>                                                 - f2fs_release_decomp_mem
>                                       read (dic->inode)->i_compress_algorithm
> 
> This patch use igrab before f2fs_free_dic and iput after free the dic when dic free
> action is done by kworker.
> 
> Cc: Daeho Jeong <daehojeong@google.com>
> Fixes: bff139b49d9f ("f2fs: handle decompress only post processing in softirq")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Baocong Liu <baocong.liu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
