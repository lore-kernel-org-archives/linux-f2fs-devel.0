Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD48C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 05:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pSBiu84FOpNtCvQ8xd7F2RMx+1ZHBjspuZvAXMXRMWI=; b=fJCOhFBj9nI+f2Q4mLF4mP9gn9
	XgZ4wq0mTdyTqfxiTe1fxPP6KuPv09TPOjcGLnMjjv8LRZloaJJ+SVo0aSXXI7jFYuo63N37n7bCU
	kfgGI8Jeu4XW4i2i0fGJAN1sPGBQYXAQWMPY3eSO4aJYFDIysPEotzrRDvu4JGC84Du0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyjtW-0001H9-8N;
	Tue, 25 Aug 2026 05:40:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyjtT-0001Gu-Mx
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dSoGeZyRdNRSZtTqjTKrkb9NI+7n/LC5ZJUPxx7dNCE=; b=l/NRAf3g6LBV4N3DzHDe/9FuWa
 1cE9T3EiSu97wXejuulUKj7FRro44VBnryHe51sTyAOPGkALeoHiUHFnmOoxof2u2WzIU1HwahV9Y
 h5h5LsWUEF+mVRAQVH+NlpX5EZODx6nYCoc66JTwiqqlTytk6Gs8WZXxQaT43Pwa1KS4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dSoGeZyRdNRSZtTqjTKrkb9NI+7n/LC5ZJUPxx7dNCE=; b=LGMtdQAs9AULa9z/Z7IQNFsoAm
 hmuFzt1norRFW/XOdiGGrUur3GuXU93a4zfemLNAtUColeewN5fmAJn6rta7bWN0jAMz5BshqSae+
 58vpwjM2wLHSSTTTcBrwLGVY9vzRcjU0jrxgbuGXfZvbZLN9DoXRtj72IArNY8VrQXr0=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyjtS-0004gH-VN for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:40:20 +0000
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2caced6038eso4989955ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 22:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787636413; x=1788241213; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dSoGeZyRdNRSZtTqjTKrkb9NI+7n/LC5ZJUPxx7dNCE=;
 b=boutbhbRnHIP9znFFgWJdZEl0lAxQ5GwRVUMb+4uf5jNwbHStCmC7B1xTIjDcVpt9A
 IgHa1Q6Hzg7lg1PhtNH5lLciFfOSxBNlPYBS/LKGo0fBy8+EC7SyLMP9nBU40smTElcv
 kBovtTIRmZxb8wyU2T7U023xzAt8cuFigHL1mV/zDKkg1lb2lV6VuQiWxtVkg0D26w/V
 9t4hqp1D0Aj6nnqWDhpeO9eonuMZDkEHXIm9RYuYHqI7t8u2WQDE1Tj3BtyzeOGtx+br
 lnJp2MNfes0/hHKyf9mdIu7nZ30QxK1agvv3+nodfL74/aJlIF+hBiwdGvvVx+lJdYb5
 eNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787636413; x=1788241213;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dSoGeZyRdNRSZtTqjTKrkb9NI+7n/LC5ZJUPxx7dNCE=;
 b=a6WCnZEjY0xwa43QSZ+bTL5YM9a379XIot0L6z3G0jkxLmBsYc1sAJHag8uu4BuLBD
 njTnXfleowr3DjX36b7Iul0gqi8LxZcWu1pZcH1bBhjHolxccaEIcTkDlyIOj7lHCF1d
 9eNnt5BznRmyG71CJtS/S01EHd9/GC9B9wilIUv4ziNtdEPtYhJdc5V7ELTLGOZEjYiK
 bgD3w8G/5pYN7Z0kBJQ/LGlITI6PzCqjf2sYn4jezMYB6OooOWFiveOZ6qY7L265bDER
 vxIcTZgl7izJBWiu8RBcpRP0NvefOoVUwu2pxFibi5k6Cztnxx5zoAhDWBKfGqyDc5oN
 73wg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrB9miZLl4zHSGtcDBWHZAICEPcxOtuTSHKJzflcIdg8/Da/tkp2UmgQCzeQv2lq5S3lCARIMTr3r3e2csNRXV/@lists.sourceforge.net
X-Gm-Message-State: AFuF++nTzSkb8R1t481fwZQgIlvp4OO8hlMWYMM55VMSEwFH9Ezs3yzr
 NIijc1t1m5ggHIi5QwXw1BDMa2JZWHneYs5JfPRwalx9yrEgG/fv8CE3
X-Gm-Gg: AR+sD108TBjxoX56uTXx0PnAAIDTjdCZ8qYLqjeh3qJ3AUM4VyOMLLxegcyQbuIKNqu
 Bn1YSGOpmLWnnTUrb3gggHMMFptEBvhBzESHpsZl2DidXI6vJt7MCsUBL+9IwS9HiQVU6rwvl3O
 Adva7K0ZnPBrQHlC/FAEwfW1EUM2fTNhS6xzrtzYri8MhnDopwgGNOqdTcU0xUs3xYBqNx4K9Y9
 cwidvMGavcduPdgOYdUJdTO4ip5ElVARh9i0TqQLT/qUh0t7BYq/axu6tpSFkzBUxGK1WqIrLb/
 U/uWs7X5bCL9ArgqIlhbQ9L5UHyZHupSOwjorYUC1seGskoRoq90XMBtgCVbCaqVo65XUuHvpRu
 788bxCFiiv4+n+7kwTd7Vp0hm8iI3OThPx0iskXtr1UKhMRGSA9uyTVXFrPV4IskgiZSH23DU6n
 qeYk6sporyeLGF7LVfsHq2zRUv+rLsiGoLsVgOig0xgkVFvWDTZWEV9xj34NyLzQ+FZvcMRpYIo
 9LtrGhqKZp/lEx95pN4QxAR
X-Received: by 2002:a17:903:3810:b0:2ca:12aa:a390 with SMTP id
 d9443c01a7336-2d6da0e8d22mr46452635ad.0.1787636413143; 
 Mon, 24 Aug 2026 22:40:13 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d676895a1asm24497185ad.42.2026.08.24.22.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 22:40:12 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Tue, 25 Aug 2026 13:39:59 +0800
Message-ID: <20260825053959.395465-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824134731.3704352-2-chao@kernel.org>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-2-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyjtS-0004gH-VN
Subject: Re: [f2fs-dev] [PATCH v2 01/12] f2fs: cache: implement metadata
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
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> next:
> 	spin_lock_irqsave(&cache->tree_lock, flags);
> 	nr = radix_tree_gang_lookup(&cache->root, (void **)entries, index,
> 		min((unsigned long)F2FS_ONSTACK_CACHES, end - index));
> 	...
> 	spin_unlock_irqrestore(&cache->tree_lock, flags);
> 	...
> 	if (index < end)
> 		goto next;

`nr` bounds each gang lookup, while the outer loop continues until `index`
reaches `end`.  Dropping `tree_lock` between batches is not itself a
scheduling point.

Is there a scheduling point or another bound on the number of entries that
this range invalidation can process in one invocation?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
