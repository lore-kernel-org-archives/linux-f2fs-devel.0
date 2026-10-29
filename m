Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7A606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jMGIm7PB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qmd3cqu+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J8SW8QCy;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9UJdwEz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=domCU8+o0Ol5E0RMr+tTG3CqwPW7lXrvtuKGJ8v95rk=; b=jMGIm7PBNTlEUM
	e6TMm++tTMYRc86a6WxTRDUYH42X/Kfz3KuVs/wWWI5Xur1yOxejNBya+xjyngD4CVdHvTzAmOrGp
	0J2EUdlkX98jFll4sVoCserRuc3S+7A1ioWvTn0V8dClDQPT1nb1d35LTQX55U2647dlbmPfKEHs3
	zks=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMF0a-000000006em-3CKW;
	Thu, 29 Oct 2026 01:32:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMF0Z-000000006ef-1kml
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:32:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hz8ZSO29ymk2Pxs2l0BF7OAQ9+ikMPxW1OzAHC82fFA=; b=Qmd3cqu+0uTjS9Jq8z95V6ewps
 31rQboJ0uWQ5dIiQwNEqtrf4qTH/xbZFD0+KCxUzpDy7icwnrArHOuU8wUVh5ENMnmG5VORQEUCvZ
 DWmn8FLukZhpBd9NeI4b7pL66qcIsqK0kAUX6h9/woliIoBgsqz+FuDn3t6aTIpdxptk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hz8ZSO29ymk2Pxs2l0BF7OAQ9+ikMPxW1OzAHC82fFA=; b=J8SW8QCyM6lFmHb5fKj2P1ZytN
 cr4iC58GQT6oi/1z8htPrC7dwB1V3OOL96uZDxJBhiYySE+XyMAIkhBsaH/hk0HT8dyW61G6tc1c9
 TmXC3NacQXV8Exp7Pj1Jb4rOvq8aYu8K+7Km3AyCTvTMCIp6/JZJehDpMQ48j2An2hAo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMF0Y-000000001YX-38pA
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:32:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30F05601FA;
 Thu, 29 Oct 2026 01:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C8D1F01828;
 Thu, 29 Oct 2026 01:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237560;
 bh=hz8ZSO29ymk2Pxs2l0BF7OAQ9+ikMPxW1OzAHC82fFA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=f9UJdwEzaYCSo616Gb1fRD/zS5YtKiRzyV4UgJx/z8Dyc7xKG8cewsfSgRJX+egA2
 iP5L/GTAatEdVmlbyHf0sBrPRbbZj+NHD/DgdEjUz6VFS/Nhcw1DaDlpIMDG+lThxf
 48R6/g7rpAgbSVvxGWAXA2iNJ7D8tGiRaWDQp5DKEZS1iiVxluFO8hD7jAZQ9RzYuR
 zfNdApHNmUorkfuiiM3IxKuv9bvBphmFTnyLhJP6G9zYSKOA8xHOzVeYC+MXw1Lsro
 WeJsg176zDJE+4SgpCSobSnoJ6yb6iHdT5i/QdSsRy1Hs9vv1uTA8IopJL09B+QCjJ
 F2u9G1o7dfESg==
Message-ID: <dede484b-8f07-4ccb-86c3-b80466e49717@kernel.org>
Date: Thu, 29 Oct 2026 09:32:37 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-8-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-8-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMF0Y-000000001YX-38pA
Subject: Re: [f2fs-dev] [PATCH v8 07/15] f2fs: prepare mmap write faults for
 large folios
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 23:43, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> Now write protect `mmap` also need to support large folio,
> Change `f2fs_vm_page_mkwrite` to achieve that.
> 
> Note it currently marks the whole large folio dirty
> to avoid data loss which causes write amplification.
> Further optimization is welcome.
> 
> The folio_zero_segment() in mkwrite is extended to zero the
> post-EOF part of the faulted folio for both order-0 and large
> folios, so the f2fs_zero_post_eof_page() call that was added
> to cover the removed shortcut is no longer needed.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
