Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C8EC5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LDAg5xR4nyXzOz3Ii2MD08Noeufpe96kxBZ6NnSQCq8=; b=g0bJeM9Yb4bTtxxMZZQQhQoF/P
	6eoydlf2NW/7B4vTrocCBjTpKoDVTLrgAHNn3DWIX8riH60Eir9fr1/RUK3TtT6ytSURdRAyzM/rM
	OAf1xRHzwXUO8+oSqXCKwkfyofBwagzWG4alj9r8zuMPPzAf0E4UvLFgTPDCZV1UPFJ4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyRbC-0002Zv-Sp;
	Mon, 24 Aug 2026 10:08:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyRbB-0002Zi-DN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cQht530mieFUeugmQqlDH51hivGpkoJbD3uSg8tM2y8=; b=TLyWNrEAtcwdQXwfK7/WFB5FV5
 uhgAXdU5vuW7YPMQUgRdT8HFFf8WikbtuW7VNWZ7YEIbTI8SlKeA16Wf2kOgUUTDX6byjtpkul8SF
 EjgYbmStphnc3F4ceqnUzCmfdW0NNm9wgQG0f6BufGj03P4ko22p8aeD1IohtLU4WNFk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cQht530mieFUeugmQqlDH51hivGpkoJbD3uSg8tM2y8=; b=XWw9qCay2/DXyqEpPu4LZwE40u
 7DA9wb+CK5hdkjb6R1+VJk3qGTuDnt5ADS3zSZogOUQgGRjPgY7uQv+pYrfm/HKwzwNm/S5OcxRBD
 HEQ3BmaXy9s0vhGOCqeAl3uoc9dhmhN24BcvcOfedB7DKXtLruwdww/05OBjCMOowLdY=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyRb7-0003sF-Dj for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:08:10 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-381b831d535so4670867a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787566084; x=1788170884; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cQht530mieFUeugmQqlDH51hivGpkoJbD3uSg8tM2y8=;
 b=qGNVg6tV6CI1X1lLtM/3d8361G+Q17hCekXoK9Qn4az+lQa4+xQh+OFDPJXL8uitt1
 H5Zc4aDIlf/LgvPsXlQFwxVqH6mSj8YBgSkRFpZ+ho8OYa6VkW/l//yJBeog49XP5iUr
 tLOKARSXAICajgaTFapZt5z64HisIEubC9Q8QfVoAHiv/Q5i6LZHqG7ydzPWZgYerSRQ
 P18QdMtsjC3Y8HmRHZVtU0TKxmAj1EyJZT+yO8f76Xj1iCCmYE8AdbQwkBvURT3FuDBb
 9ZAS15RvHwHoDkO0nAvuWzVOzqBRhlXAHyUIuizoiZ5fFgJAgBK0z2KmDaQHAiDQN21w
 hh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787566084; x=1788170884;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cQht530mieFUeugmQqlDH51hivGpkoJbD3uSg8tM2y8=;
 b=G0rw3aPaXWJjItqHF9R3Eap1Y0P/LOjEQIdwOTZL69JSwDtoruXgf+s6lIxjfdkEMf
 ZYGd2d7GMrHj7QuITnEiyB8AxustSJjIMkb7De7tH8MFuSkKy0AkpzLJVnId5zbMRjZj
 yE0Y5E4VC+JwraJGrlLTJsUgGINdnPORw3HWj6K8JLxz2c43y/x6TpiwgYrl8GqGwd2x
 CdZa3X5fcWL05kynFNuv6CX60JR1Op0wVubvJpiFczRlMk9rVMzCJyCKY5B/40n5w7Ry
 kp3RfZ46tSPEEXYL7aMK3x86sxGKikcsDgsnDEc9P1WwtrW+de8JMXL56yBGESyzhUnd
 ldow==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3rgPVJRMgg579C3OMeKSO6bUKAxJz5IXMu+f788Li12tSSf+W4fzZykWul1QVl7bDSBoU0/GonZCkasEPI1H2@lists.sourceforge.net
X-Gm-Message-State: AFuF++n83NCYmkHfc5ViNEeKGG2fB5LkDXmSTCQmtb+vUw4asRLEZoOT
 tZr/WQg7G0wqSuq/NiRy648eKqOiEctgAeHzPKbsNY9VmlG8G+HMBaqK
X-Gm-Gg: AR+sD10RICJjh/VH/UXmlNb4aaeDYGm7iKqEYAJ7rs7tGhilLg6d3fSNu/5WGDr4sXq
 dfHcEzca3ltitMAz57xoKFT2RIakdYZOv0zwlTQzRMuxDJJ5eKon8JAUgAZEMSLYPjYrsBpDeEc
 1aBLAQhQaMyBq6DHlwDrGpyRF0hQvG7ew4m0DZ+gYF045IEEjVpXfxePJgHcshpia38MuWtmmN7
 YgAp0s3GrInjhtoN+wW+e0WXg0bFcWtsrNa6azhytKp1QqdLxhy2ApbVJLUCf7nkQ1iUAExsyjF
 ZzIrHXYs1GAAQGe6bncycD+WDyNUNuM27xKM4gSjHQmvoHAF29jkpU+qghoRJU06yiNOK8B0BPb
 UAn4ZU1D0Ruh77EKnFjgraCTpmA2fX4QRqKuACr72oSepa51uO7TtMXqUdorUu6hCH8nIl7pUjp
 ceTnagG4kWsPJ3qPb0JsPyFcB3emfW5b4PanGM8wRGqy2ZAKv9keVehtJjc+SwnC4dA5dY4r1vI
 rH4zcgeq3sFbexY6BvyYw==
X-Received: by 2002:a17:90b:2712:b0:395:543a:cf3b with SMTP id
 98e67ed59e1d1-395c3518185mr49198167a91.2.1787566083683; 
 Mon, 24 Aug 2026 03:08:03 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4999471sm9433393a91.8.2026.08.24.03.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:08:03 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: Chao Yu <chao@kernel.org>
Date: Mon, 24 Aug 2026 18:07:52 +0800
Message-ID: <20260824100752.3890850-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820031721.12218-1-chao@kernel.org>
References: <20260820031721.12218-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyRb7-0003sF-Dj
Subject: Re: [f2fs-dev] [PATCH v1 00/12] f2fs: introduce metadata cache
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
Cc: Wenjie Qi <qwjhust@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

At Xiaomi, we have an out-of-tree F2FS node-cache prototype for mobile
workloads that retains clean node contents in compressed memory after
page-cache reclaim.  This is different from this series:
F2FS_NODE_CACHE is the primary cache and can hold dirty authoritative
data, while our compressed contents are clean and disposable.

In our mobile workloads, clean F2FS node pages can represent roughly
100 MB of uncompressed working-set memory.  We have observed an LZ4
payload-to-original ratio of about 0.1 for these pages, excluding
zsmalloc fragmentation, entry metadata, and workspaces.  Node reads are
also on latency-sensitive paths, while memory pressure can repeatedly
reclaim and later reread the same node pages from storage.

These are observations from our out-of-tree mobile workloads, not
benchmark results from this series or current upstream Linux.

If the primary metadata-cache model moves forward, the direction we
would like to explore is one F2FS_NODE_CACHE slot per NID with mutually
exclusive clean representations:

    UNCOMPRESSED_CLEAN <-> COMPRESSED_CLEAN

Active, dirty, and writeback entries would stay uncompressed, and a
slot would not retain stable copies in both forms.  Compression would be
prepared outside the shrinker and direct-reclaim paths.  Shrinker reclaim
would continue to discard clean entries without compression, allocation,
or I/O.

If an optional compressed representation for clean, idle F2FS_NODE_CACHE
entries fits your intended metadata-cache roadmap, would it make sense to
discuss the clean-entry state and lifetime contract first, and prototype
it on top of v2 once the base cache is ready?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
