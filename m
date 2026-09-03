Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EE1C624D6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=17rSLkkWEhIGMwJfopv+rMIzR2+Cmb1HuhIoCotFf3g=; b=S9tQwuUC5FUC14oE261e9puJ2d
	5DyAmGtISAd3MJw9Lk6hCpbPpP6AWx1DzBJjqo62gTXSzIJn0zY/Nt3YsA+cn1o0GQp3n1cW+UCBb
	g3nBaE82lTAH8AAOv+j5NhtwfpvPXomsgvDbq1x6NdIaMEFCjMSbjZUFHGrj4yH64e80=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1wfh-0001hP-C3;
	Thu, 03 Sep 2026 01:55:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x1wff-0001hJ-FZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 01:55:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o/7WxrjjY9F8d70xdLQPvDsjqzk1/OszqklUcwt+2YM=; b=BjjuJQA4AOg048J00tR/PEKXeW
 XfXN0zuI5L31pdZny5Ah5HW2+kF/Yvk2CoTP65vTyfnXtIi2UA7LeF5vTumNcoHLAWgtGMwRwqiF/
 J4u9Zx9roDADHLk2QtKYKk/JeyD9GMUhEGNgm4gkoxxamCmQhs0gJXQL+GAMWwJKyAOc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o/7WxrjjY9F8d70xdLQPvDsjqzk1/OszqklUcwt+2YM=; b=Ci5qFZkAUh2j/5aKyLK2458a4O
 iVZtn3i/TYmhR24Sg5K6MGXi0HKOAW56KgrQ3RnswYf/kNPPHXv1hkc5Yf8DTSRHyHiNsKyNjXIWh
 xdSzC5kPCEHBdYiyfabSBnYmZ80zcJHS8gb+C7KREFe/1bkSJIsqiKQE9KRSI/ENne9M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1wfa-0000wY-4x for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 01:55:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3038C600C8;
 Thu,  3 Sep 2026 01:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9891F000E9;
 Thu,  3 Sep 2026 01:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788400507;
 bh=o/7WxrjjY9F8d70xdLQPvDsjqzk1/OszqklUcwt+2YM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=YBpVCBrfbPIUvAD1s4k+JPNbAg/tY5qRFWDFAq27gA6gU4TyRtAAEmBPP+zL0QZcT
 AVNK5ci7RD5k27X8Sp5eQwHhpmBENS5/FJinYTVrsaiWf7s7/kxdVo5MYFd4nTkrbv
 xTUK4Ar7EWTY7YHFzF2YrhI/NtOH3s0A6uyxuJZ9OWePKNzuoy8bZEJuzjEDG/9EBm
 LLFrQsPXrWebZX/TMcHvyWB3JJ26tW+xBz+PICEO9aLyUZlbuZCAhute1wQFZrQCrq
 nNowBOT3xHnNjIlzkP4bENivw/6nzniJrRhwfO10AspCKTxRA+U0uj2XhoypqoshL7
 31gYKphhDpuag==
Message-ID: <fecb1fb8-316e-4da6-9504-608d69edf342@kernel.org>
Date: Thu, 3 Sep 2026 09:55:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xinping Zhang <zhangxp1998@gmail.com>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <a21bc0d17ce657d0ccd86fd398785b946fa268d6.1788213716.git.zhangxp1998@gmail.com>
 <CAH=xXfHZuQ2s1rQLdQ1tWSSVPTs9SX9GuNZ2kf3znjY2YyexPw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=xXfHZuQ2s1rQLdQ1tWSSVPTs9SX9GuNZ2kf3znjY2YyexPw@mail.gmail.com>
X-Headers-End: 1x1wfa-0000wY-4x
Subject: Re: [f2fs-dev] [PATCH v7 06/11] f2fs: describe {i, d,
 id}node block layout dynamically
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Kelvin,

On 9/3/26 07:52, Xinping Zhang wrote:
> Hi Chao,
> 
> The 0-day build failure on feature/subpage (lkp report; 6/11,
> include/linux/f2fs_fs.h:355: "expected specifier-qualifier-list before
> '*' token") is a nested comment in struct f2fs_inode.
> 
> The applied commit keeps the old inline comment "/* direct(2)... node
> id */" inside the new block comment, so the inner "*/" closes the comment
> early and the following lines get parsed as struct members:
> 
>     /*
>      * __le32 i_nid[DEF_NIDS_PER_INODE];  /* direct(2), indirect(2),
>      *                  double_indirect(1) node id */
>      *
>      * It is stored immediately before the node footer ...
>      */
> 
> That's a hard compile error on every arch, not just m68k-allmodconfig.
> 
> The version I posted in v7 6/11 doesn't have this; it drops the old
> inline comment. The applied commit (35efac5) looks like an earlier
> revision -- its subject is "{i, d, id}node" (with spaces) vs
> "{i,d,id}node" in v7. Could you re-apply v7's 6/11, or de-nest the
> comment, e.g.:
> 
>     /*
>      * __le32 i_nid[DEF_NIDS_PER_INODE];
>      * direct(2), indirect(2), double_indirect(1) node IDs
>      *
>      * It is stored immediately before the node footer at the end of
>      * the filesystem block. Its offset depends on the filesystem block
>      * size, so locate it dynamically with F2FS_INODE_NIDS().
>      */

Done, let me know if you have a new version, I can help to cache in my tree
for lkp build test.

Thanks,

> 
> Thanks,
> Kelvin



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
