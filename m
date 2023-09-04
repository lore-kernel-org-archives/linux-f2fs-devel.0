Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B84CA0FE3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Sep 2023 09:57:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qd6L6-0001sK-Jw;
	Mon, 04 Sep 2023 09:57:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1qd6L5-0001s9-Gx
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Sep 2023 09:57:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3nBALREBe4uYOQysxhL3FnVqTkdR7jMiX68zU5wvxQ8=; b=K1nzGxiMuN/4aMq/3/spus9Y2Z
 zUf1/c+t/R3Qf67TDsVRv9Tsc/Jzd4pw8xiI6kQbHyhpgINgPYU2MRc8B/Lgq+EmMwscZGbReJWJx
 zXi8qsLum9DuEwkMaG/3WwRdLoKToDvoYuEAnZcqSknTOb1+5gE91ofmtVFdiDLkdbgM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3nBALREBe4uYOQysxhL3FnVqTkdR7jMiX68zU5wvxQ8=; b=BvuqG3ekbt1Zi1Q3UZlBTKw8kR
 /tpcUcklCf47yLgXE7sw8ZdkdlaqSF3qn291s1Fm1FMSRitBMikrgK1t3DEnOVhxHuuZlXIsp4vF5
 YJqqu28tDlkH6EsrxMI46rMnW3ZAZ9ojuCB+hplLXwkLq318FJfdu4328w/CiS59S17I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qd6L3-0006vi-KP for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Sep 2023 09:57:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2128260110;
 Mon,  4 Sep 2023 09:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2861AC433CA;
 Mon,  4 Sep 2023 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693821459;
 bh=3nBALREBe4uYOQysxhL3FnVqTkdR7jMiX68zU5wvxQ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pEztgc4TUkd2yfcHxcboc+zDXAcA4KHCmIGSB/gsRgCo9DGA1rLyRBmfivPzAjnOB
 KKw5j1sjO7veroFTPAfq4w/Dw21tYljOg8WM+sB6xZikYv2ILFdOD928dMMu6jaMTA
 hsFmv7Cbjvf4C2EEf3kIjrkFy7uHmWrX1TbMwxUdVWRcMpkNca5fPpStkr+O9O9AVs
 oGtWlPEvUt+phBNKXuy5CCjefBQ9+fHhCcNVb2HuJp7/pDdC8MPGp01mLBBiMVtugi
 LQHGEf2o9T+0sCa9DBGt1latLMv6pIa/RLJn+fTPda2hnB4Yrxv5cYlj5KyxA/vFa0
 BGrzmLYXagYqw==
Date: Mon, 4 Sep 2023 11:57:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hao Xu <hao.xu@linux.dev>
Message-ID: <20230904-butterbrot-aufraffen-db483c53eab5@brauner>
References: <20230827132835.1373581-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230827132835.1373581-1-hao.xu@linux.dev>
X-Headers-End: 1qd6L3-0006vi-KP
Subject: Re: [f2fs-dev] [PATCH v6 00/11] io_uring getdents
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
Cc: Wanpeng Li <wanpengli@tencent.com>, "Darrick J . Wong" <djwong@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, linux-cachefs@redhat.com,
 linux-ext4@vger.kernel.org, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
 bpf@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Aug 27, 2023 at 09:28:24PM +0800, Hao Xu wrote:

For the future it would be helpful to hold of on sending larger series
that like this until a stable tag is out.

Right now this series is generating a bunch of merge conflicts because
of all the changes to relevant codepaths that got merged. So either we
have to resolve them to see whether things still make sense within the
context of all the changed code or risk that stuff we comment is outdated.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
