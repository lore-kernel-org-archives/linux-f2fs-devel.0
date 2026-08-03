Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30468C55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TP1CHIktc3dKxA3mndZNKDVal6/Ol5rrnJ02VCD6quc=; b=avWIiybrDRrP6yVjOMbXTbbnXR
	gbfHCxY4WrrME0iYHR4QVFSgbNOp7S43fHsHRzMQxD46YR6MNaVbS4EhZ6sWOTMgqxsdrYFQZIoEv
	4uYy6UXpzDVvu9f/1Tte/ZhgEHHfvA4DagttEWKs/dSZS7EMPWJTr3h+rUxV6hSR3cUQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqnFZ-0001yZ-Fz;
	Mon, 03 Aug 2026 07:38:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chenchangcheng@kylinos.cn>) id 1wqnFZ-0001yS-02
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:38:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+jGUM7lcMx7m3evdq3lzbuH0rZ/QXA3zY3GiS5gBjLc=; b=Y7gjH8ioWSEzHnZsnTEXkKYbkN
 6jXArJa9B6PXCFjSb/6eRISDrK51HRInw1D6K/4kTSnVUW7zR7bmwaR83fWT8M3JaHhbLa+FJ2k4L
 yJlp3e+RKufUjZWMzxUGOajyJ3tz4caJw3DyziEgd++6chtNrLuOKLSryuI222UmVu6c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+jGUM7lcMx7m3evdq3lzbuH0rZ/QXA3zY3GiS5gBjLc=; b=ijdJCvRjOn3hcFlP5oFrSC9APQ
 h5+eBckwX9PfOsMZVKUudHl5j+bZiWirx+y4k/QhYOc/mpjYfqhVL56kp5OeJ+vb3iZy7yX0PhK6H
 vgoofPGzcUoj7K+yCro93u6hICi7LoRN3/vGR5Guf14acBJRYMFvsM4YidwSpCwHDjfc=;
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqnFb-00071r-Ns for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:38:16 +0000
X-UUID: 42b0c37c8f0e11f1aa26b74ffac11d73-20260803
X-CID-CACHE: Type:Local,Time:202608031536+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:87fee93c-e716-4b1d-9388-1f80390cf996, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:e7bac3a, CLOUDID:dad0b878ae4256c8ba312a05b0d29186,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:83|102|136|850|865|898,TC:nil,Content:0|
 15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
 :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 42b0c37c8f0e11f1aa26b74ffac11d73-20260803
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <chenchangcheng@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1537620235; Mon, 03 Aug 2026 15:38:03 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: chao@kernel.org
Date: Mon,  3 Aug 2026 15:38:00 +0800
Message-Id: <20260803073800.218814-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a2f3ace1-73ba-4180-9004-859b14b14cb6@kernel.org>
References: <a2f3ace1-73ba-4180-9004-859b14b14cb6@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wqnFb-00071r-Ns
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix valid block count leak on data
 block allocation failure
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ccc194101@163.com, linux-kernel@vger.kernel.org, chenchangcheng@kylinos.cn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> Needs fixes and Cc stable line?
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thank you for the review. Yes, I'll add both Fixes and Cc stable tags
and send a v2 shortly.

Thanks
Chen


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
