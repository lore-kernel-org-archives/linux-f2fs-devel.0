Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CB0C5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dvV+Yxv/lBEq+fx/AQqtxhG0vKGaR7o9x3USidJ2wuo=; b=J/auhS69bSp5gtt3K+X3HAeT1K
	Pk3rAHzSjHsFgJj8nYukaJbhXU7vTS0WDIIXxDjfDssQdQ4cTK9M6ytxurCddWtCLvhfCUz+uBM4E
	SxLoYW4eLYdJNHELhmF4M/X4Ex87etH9F4+pZZ3U6exIalvoi1zKXhyB3LVmuDz0ImM4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wy7hG-0004Z6-GN;
	Sun, 23 Aug 2026 12:53:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wy7hE-0004Yy-L0
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 12:53:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qIWm729zuQh/GIvjmGNzwFQmmDaO+JV5mOHYksS/vFo=; b=SElk3+3h9zxhY+DH6yuuHVeBAA
 9Q6eoWTe2H63z1+FF6EVYFrrlYhqYSvD8Bh0Gfm5ItirV77uEc6ShbIlvL6HtK7Tc+gcLM8UB6AJY
 8A3tXaAKhvB021HnUaGzMOausA4Dat6XkvuORKiw9zlhbvz+6Dz3Y4D0Vf1VPi2FFQ9w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qIWm729zuQh/GIvjmGNzwFQmmDaO+JV5mOHYksS/vFo=; b=IE8yLqeUykb0fF4Y469XmlY98u
 wJihwCFRVMxMAu21GUlhVEyimIJ3g6+yTJD0GO6VtQeP1V0C6b+cI/bHJOVQhgjn6aMaezjynRPn0
 JzuUnRTSpCGcpemRHkA1TLob6JgAmudlrafG1U1UP/bv6thhn1wiWeWTKxIDNRHdmKYA=;
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wy7hE-0006jR-A7 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 12:53:08 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so1935600a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787489583; x=1788094383; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qIWm729zuQh/GIvjmGNzwFQmmDaO+JV5mOHYksS/vFo=;
 b=HbxYC5HDdSRK7L7ymR5FkUdb/gtDCBOXCXk2UV6DrzomXvMwZhlTcpDYt7os9NQcNz
 IHG9vT0M5HpmRjWpGEFbalThLtehjegWeg4HraAcgNa38jfM2doWRf/d78QA10LlEGsG
 arcsNtgoINH3vgySnV3c2FprJ0UioYAA6uTwoiphaFue2coGQyN15FubWJKj3DRF87tw
 8FeWALsXouS3ESiDZjDAu0GSCJHRSG9PtFZ/ne6i1jo2Hf+U23u88+ZDWlMiu/peVtvl
 63za/qAimY2pGZFzmM+b8NeatH2sUO0h+KgAKxKVRpcJTXKn3nKkK7BE1Gi5q+e73riT
 6Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787489583; x=1788094383;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qIWm729zuQh/GIvjmGNzwFQmmDaO+JV5mOHYksS/vFo=;
 b=Eb/e3C9K6Jors4niwUdSzgWHwbj6Dxyuj5Sa5XnkinyBxVe/vH01Yjk7bzmMymM70P
 ZuMHVAZmwRow+4Zwci0riaMQPLBs+ytWMSw6IkDoL4bVKzWzxGR5Qmv+D8rApgRtQxsW
 HPTTKJ3Ur8YPGgpNOs1g2QmubDLdL2ft+WqrrbCQIaodQjsMB55sxz62sBNUh63k9rzK
 DhRDUGDPW3I/Lw1QHAoO8R5ne9uX2PpNV+Dk2a6OzTxHXRNE4RrHIMKY8ZBlfnsWzrJb
 Gju2oWX7h6JbLPOmCS5vcNUyifxECg+goFb5fdQh+kWSKRKypId8r4IuM7jP5Vn6cSOf
 +Fhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RodcTd9HD5+FYjyf+pp2c23/R2DWtKOTbnAqUeQ4Mj6T4Rvj6yDl+f9blGg4J+4zLx/D8Kj7sP/iXlQZedgoN7N@lists.sourceforge.net
X-Gm-Message-State: AFuF++mbaHU5mI8Gr4zSnpSk9QyvP+bGLwV/62DWgAfDeQFfqJEFcKgY
 YULnNNi8khtBIRmxRY66RnibShUMwlAIEed8BYvdLHu2vWfEm5YeGdcG
X-Gm-Gg: AR+sD11p+VfL0gpfmzkZ8c2lowE1itj4Sx/pgVZl780lAkztuSK+diyMxsQ/ZUw2ON6
 +lDU7dfjFJKSdMJed4C3+VvRyGW5nEXlzmZ+HymXw2nVhlYxA6Yg1HiXBMq2YDDm3JhUmw+p7ZH
 LLMEEWPIAFPE9mklPObYcjykWNCZ4IRik1s6WptabCShXBZjl5edUiscy1HMLxRao6zanejYaPL
 JcLZAVqBVelLWJ7HTvwV3S7EfLAlLulIedtFXCa1NSLBEPSy0rkVZovKt5362cWdCUwXL/iqozI
 wrnAhpoP7xcMviIceZJY9OHr6rGDRyuP5IGueGmkmnTJok3obwpext3qY2/pm4V3ZyW8ZdLCotx
 VcSGSpKZz8gF2bLBSLKhaWfuvQ7qgwb0dr8Xs2jIjcWZV2cBV7x9N6AbhDjU/TkyUDDZQk0NoAc
 Wh38T4aS7SmCukrimahMFuSs8/NCk2bIiy+oTRIpohNqgrntCfobV/eSCXTwAtbjB3d1VL+A0+M
 0dzIIumVopQWstcpR4MJZwO
X-Received: by 2002:a17:90b:33c2:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-395c3597c56mr31819351a91.5.1787489582577; 
 Sun, 23 Aug 2026 05:53:02 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e42d6139sm5989602a91.0.2026.08.23.05.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 05:53:02 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Sun, 23 Aug 2026 20:52:57 +0800
Message-ID: <20260823125257.3227421-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820031721.12218-2-chao@kernel.org>
References: <20260820031721.12218-1-chao@kernel.org>
 <20260820031721.12218-2-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wy7hE-0006jR-A7
Subject: Re: [f2fs-dev] [PATCH v1 01/12] f2fs: cache: implement metadata
 cache
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Wenjie Qi <qiwenjie@xiaomi.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> static void f2fs_zone_write_end_io(struct bio *bio)
> {
> 	bio->bi_private = io->bi_private;
> 	complete(&io->zone_wait);
> 	if (io->fio.is_cache)
> 		f2fs_cache_write_end_io(bio);
> 	else
> 		f2fs_write_end_io(bio);
> }

`io->fio` is updated when the next BIO is prepared.  Once
`complete(&io->zone_wait)` wakes the waiting writer, that preparation can
run before this callback reads `io->fio.is_cache`.

Is there another serialization condition that keeps `io->fio.is_cache`
unchanged between `complete()` and this read?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
