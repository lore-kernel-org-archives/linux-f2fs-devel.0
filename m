Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C986DC98304
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2026 03:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dMRwTsAVHBjQBfMoTuBUB4X/jKPI1zRtJg/h+IM8LxU=; b=PHBNGu1C8ytXg87KYTQUPtyTuT
	zJiVHLQmafuNK3Gryp0qzg0WUk+qNJMWQmj7kurSgmzr3W1HZqkRvfVSSmjfv3qBh0nd4OMZf6igu
	7SIWO+tzeAbaEiW9wzssvEiwwVjLwjpr2LwwLBwICxs2OKmJ7cXMgOmtkZsXrBrp5leY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9aW7-00052Q-P9;
	Thu, 24 Sep 2026 03:53:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x9aW6-00052J-CH
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 03:52:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HMrOM7vzfWJDRkwcvRQsGWRYxRgpYk4wHHutCRIrF7U=; b=Y6Ld7fcRIBP18T8TMuQyuiog+w
 LFXmg4Ti1yGW1LF0SFSVmFehn2iWMgEB2PFP+0RiI0q33mji9HLK5npgqM2u58/PHiUuMFFU95Uqu
 wq4VybPNXpkRcOSegQhWGH8dJAX3ZH2E3DCZ2aprbPg17E+MtIOvU6LktXpWJqSZQ2jk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HMrOM7vzfWJDRkwcvRQsGWRYxRgpYk4wHHutCRIrF7U=; b=HPjyNpnT5Z/5vuRWSYPoQT91dZ
 Sfzc2/DZyL/DXln2985JWkBa799avyLdilnWqnlyLnXHzfzu9HT0ys2zAtzv4Jv3/LRtiwlt95ipW
 5y7b2tKvHxESgDW6Ro1NTL4li2j5QVzAwGO1KipAlKSbIbNxwysVhPTH3WNFHaj6tllg=;
Received: from mail-pz2-f41.google.com ([74.125.228.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9aW3-0001pj-I6 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 03:52:59 +0000
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso921339b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 20:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790221974; x=1790826774; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HMrOM7vzfWJDRkwcvRQsGWRYxRgpYk4wHHutCRIrF7U=;
 b=kzMRew9lrOhJ4noYk3BCWhQGYtAAWVydSG4BxSXGLZnVBTuL88iX3aYfnRezkEtEKU
 INkHGygKSBWnboGhbq74SxlRu5nhU7mCzQqht+45g9bt6EpcAJV9oum7IAbbfatc7628
 X/GAHgoZ5AR6sfgY/JPGNSVzGRjTqXjX50zavTZZZ69g/8eqU3vrsnKc4kSYjf2Uyo8u
 w4DtPwi1m8gETWQ62ZDr3KvD9eZ1eF11Sg7UZYbo6NqsfN/bDTzeS3pUjE3sDrIWlxUH
 7wJrOc13tVWEj8fFBDLRk9GEP+NkIZErmwPX6X60QgR5Ju27lHIrx7Z+1WdcAZRqv7Zq
 2eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790221974; x=1790826774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HMrOM7vzfWJDRkwcvRQsGWRYxRgpYk4wHHutCRIrF7U=;
 b=T1ISS0s+kdkdvbRWjBDiQoQeCtg/9hmAzAOv6pJ5QSBic6xIBSxTWyD+WgW/PTfEIE
 mtPeGv4G+QbzkM9OR3JCDedP7s5M75nja3ZQelKFbHoKP8liankrysSgSohIcBJJGJ1F
 Ckin6tIcAJv8x0dfmftg94c4BBTKoyjEw5DtnH+BxP9K9PVbEJeXgxdeXqjQ507pgMQk
 /kw/wrPUfLraB8Wp/2BsuISO+M7uRCTOP3wjjYF1IPAl5AyV6BNyICejkq4S3JBC2AI1
 fGYaJu5I7HYdOoPcphVNxnh6Gmx7V7VtEg1Q7E8V+K0o/SlhkBewe8hn7zyJcsUY5+Ka
 Ddug==
X-Gm-Message-State: AFuF++k5swNKLVzSHuDXC72ing0Qer23qt5n2gwfftMmawCkg3imGGXL
 oGRQJEXAE+7aYfmYQEyxBboukgljv3+BxSaJSeR+Smm381bNiv77bX+6
X-Gm-Gg: AYBFou2KoVbrXwOA+Uo+P39B6u1Cn6BOwKPtg1CPk7yPOEkXD5zaS//ceK/0LvoztYS
 0jQZgCa3PpUuQ26S+0WvxYwXbn48UGkeQlI6OYO7i/G132PBU2O12Na3fTRxBS64HGJ7u9WC7kK
 BfphoyEHP3tKIWIYc/yjL0Kyw4WK+Jbb2ZT+tewlNw/pcfNKRY66KvZJakmAcv7c/yvPP8FWX4H
 L7KzB9qnZZ2/8Cr0qMx6ELBH2qzjqzTJDOVK498ocOiZRdtpqVYnxdSX95p3qtgxZd18q8n6ZVS
 /NCIEoDUFde+BtJHZcMVwKOlZSVUJHsd3nbIaz8uSazZdlXzkgr7cZW/FEl7rbvjjsuQD/dprEX
 o98nKwc3LDiIRcpXHM+/BkY5FP3bheuE8x9HPdip5/e3J/CYWrCm7GlAPVOtbt1XXyhn/5IPDss
 l9tk6T5Yz+r6j1RK+51i+VNhuGrcOS+3vE6vG7MPEtWraVKkYH2FxG3ZaQTW4VMXU65n/b9Jlqs
 trDNZC+j5qxcNfsesCDYDWH+r4kLc0Bzt4=
X-Received: by 2002:a05:6a00:6c88:b0:868:f29f:67c9 with SMTP id
 d2e1a72fcca58-87e9899515bmr958238b3a.9.1790221973831; 
 Wed, 23 Sep 2026 20:52:53 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1cfbcc08sm2188359b3a.15.2026.09.23.20.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 20:52:53 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 24 Sep 2026 11:52:46 +0800
Message-ID: <20260924035246.3604446-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829060524.2656620-1-qiwenjie@xiaomi.com>
References: <20260829060524.2656620-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1x9aW3-0001pj-I6
Subject: Re: [f2fs-dev] [PATCH v2 0/2] f2fs: fix online resize state
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
Cc: Daeho Jeong <daehojeong@google.com>, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, Qiuyang Sun <sunqiuyang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk and Chao,

Just a gentle ping on this series.

On Fri, Aug 29, 2026 at 02:05:22PM +0800, Wenjie Qi wrote:
> Online filesystem shrink changes both persistent SIT state and the
> in-memory geometry used by pinned allocation. Two stale-state paths can
> leave old information active after the main area is reduced.
>
> Patch 1 makes the resize checkpoint drain existing SIT journal entries
> through the normal SIT-area write path even when there are no newly
> dirty sentries. Patch 2 refreshes the pinned allocation boundary after
> every geometry change and rejects a shrink that conflicts with the
> configured resizable tail.

Patch 2/2 has received Daeho's Reviewed-by after the concurrent-remount
rationale and test were clarified.

Please let me know if another revision or additional testing is needed.

Thanks,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
