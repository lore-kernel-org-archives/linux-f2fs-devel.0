Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945B5606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TQpsCUsf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AAx2LO5l;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k/iHxMhd;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgxRHqvo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mfsjKdFeKLeENudNQIuJiOQGffIBO5hRwIJUn9sVN6k=; b=TQpsCUsfLLi9JQ
	kfQb/qLMy2iSCfn7bh5k8WMVcQM3PpHsPaevakTH+22oh+hY5L9uImN5iFyZmvbTOoWrlRUH+4qEg
	p5QmIW9X6r/mDbfnIk2XgwCxYzvS/c24VuyR8ERuyw3d8uwupK+mGnRVrVutvKwpoPryWzJBCf+sv
	G0M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNh0W-000000002jO-28Qh;
	Mon, 02 Nov 2026 01:38:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xNh0V-000000002jI-2P8K
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 01:38:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=98ogIzUPGu7VLgOlc7jyEjCqxoUMXHaR5mWvZQJYWL8=; b=AAx2LO5l+U9+3UYeLB4PVfDpqn
 18XSa1rzBUy4cFLSO3Lmkn30jKLEMq0C60tAzRHZDagOLXM7708JvDldM769DLKMmpsS9uOBiMpPz
 SkJmni2gTLHHzc4b0t1rlsyRFKWKOy4mEuatvttgndl1fKdPbqgVRYzgGxRot7odOxAA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=98ogIzUPGu7VLgOlc7jyEjCqxoUMXHaR5mWvZQJYWL8=; b=k/iHxMhdNYhChzsngz4DGgTjx7
 5yO/x4TE3GUHuThIEgT9ggTcAm1aU4meLIs+zk3ai5CLNM/2++Fb7XTx9CSoRd2ulkZh8tK8iREk5
 tT0JXSb3HtI8xSj9wSJoC13aB/cPaOg6qG0JZ0f8yJaW40h0LeIpa7+uHyUmKQIuVFrA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNh0U-000000007xQ-3nJX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 01:38:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BAF06060D;
 Mon,  2 Nov 2026 01:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33661F00919;
 Mon,  2 Nov 2026 01:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793583517;
 bh=98ogIzUPGu7VLgOlc7jyEjCqxoUMXHaR5mWvZQJYWL8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=BgxRHqvont4YB9LXG3eZLOBq3ZiQb0j1cjZxAdkrye2De8wyxLDkF54eNxN/M7dcS
 HnW3ia5/CGadudrItMNG2I1Wipk5ZCM2zlrD5CgXTe5x7VfhoVs+mkqzV4XzkUnO2O
 8rxHn2IYJ6oMo45GVAZVADPt2OFOQ9axX731uL+6wNalc3aPiYb4Pv7uIMRLQQ4oRU
 8MXEt/o+xIO0Gc3HsiaMC/uYGRu7DasomXyF1QdSQJqk9E1mxOeRTIPUfI/LTBKab0
 cWoYg+gkCTF2KO0qmTf+Zq8KgReH0iptTuUiDnRXhp63eLWi9d9IHwWBhM8EObTuUM
 10KRx37o8Jusg==
Message-ID: <87d3a118-c6d1-4c8b-b88f-25f54b7418c7@kernel.org>
Date: Mon, 2 Nov 2026 09:38:32 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, jaegeuk@kernel.org
References: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
 <20261030072423.197883-2-zhanxusheng1024@gmail.com>
Content-Language: en-US
In-Reply-To: <20261030072423.197883-2-zhanxusheng1024@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNh0U-000000007xQ-3nJX
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: free the quota file name that
 remount drops
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
Cc: sandeen@redhat.com, zhanxusheng@xiaomi.com,
 syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, lihongbo22@huawei.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 15:24, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Remounting with an empty journalled quota option such as "usrjquota="
> clears the name, but f2fs_apply_quota_options() overwrites the old
> string without freeing it, so every such remount leaks it.
> 
> Free it after a grace period, as f2fs_show_options() may still be
> reading it.
> 
> Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
> Reported-by: syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6c000dea1a93b4f5905c
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
