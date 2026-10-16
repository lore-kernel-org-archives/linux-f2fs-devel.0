Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DD9CC6B38
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lD7rZpKSw9PjSg+eEk0YWq2YXsR8b9SZEcAif5gI6kw=; b=YAjcBgmzFaS38sWGNGUS8IS9oq
	NtzFvK02QUowxi21iqDgYzwJdILUyrEa8h8RVjQ0vJo4ZlSt6ZEct6VKsppPQEsmHM1H4U+4i1zKV
	/b8ROXqi7rkW2ESb9nnh7XSdlgskU7rgEM1PbbiCrWWGVQK+3SoWq8DYKt6Z4CJpoQP8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHbVF-0004jj-9s;
	Fri, 16 Oct 2026 06:33:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xHbVE-0004jc-B9
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 06:33:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5pYBGJeLz4+tOOPCafuu9Zn/0MD382vkNaRMoh+JKVg=; b=MzVjCc/3Wr7EUJDsthSnrXyh/y
 lErYoP4l+5xOCF82lvzAgKaxUiyD6cXcOpSpP+FJbvU5aubyMJp1Atzb2loGOUilUmYwQmD5NV7se
 aI9AJMwIXqaO8JZLAwV+ON5Ehotr88a7IM2DdDQfOZ6Zl0e0HR4TZlAUB0tNoneM/w6E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5pYBGJeLz4+tOOPCafuu9Zn/0MD382vkNaRMoh+JKVg=; b=N/xuAMQymMdBw709omkiiztY02
 wazqLnD6az/DMERBk8RWXRvAGa0S9u/znQgTvM935miNKFzd3RF6nh76VUOmTrz4gz84QpEMP8Kkm
 CwKrpJ9OLIFpvqvIowcVPUgR3mIoQUkPE28sJeJAUZF1UGIDblnnolGcjFJ/RsSuyzdY=;
Received: from mail-dl1-f47.google.com ([74.125.82.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHbVD-0004hz-Oz for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 06:33:17 +0000
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so4059839c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 23:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132390; x=1792737190; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5pYBGJeLz4+tOOPCafuu9Zn/0MD382vkNaRMoh+JKVg=;
 b=qJTmBvIPCCoQlEZtXSGJUWGo4KnfRGxreCx2l639TEseOBSpC4CoiStvQgAHDsoM0m
 bTWHkTRirJ9JAlaOHr05apr4xOmGe6NS3AijLLKE687cjeCxPWEXhJSGOdoUe8C6nGr+
 XZ/x+1CWpWJxknJgX4trmFyPWJJtsJheVMxJHg+z5fEiIakVhBegtZ+ixwHiYhYqwt1x
 0v2hxIQ0QdLaiOWKyYsmFE9IfLN8v8uAvjDCYhf6d0nDOLPU9bVUzIx+GCC2u6mCWU5z
 4M/59bMNOG1UM2aBiHJw2k7VrQE9M2DZPLCcJG8YSl5IVJ2LMfyW4M7sA35zrZ1oySEt
 RsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132390; x=1792737190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5pYBGJeLz4+tOOPCafuu9Zn/0MD382vkNaRMoh+JKVg=;
 b=iqb1o8UdAscIhqfxOMdAd6PS3aIFGwz3huwxoq285YecdU9NQ7WOgwiF1/0mVITXzl
 EDM7KKcSlSyq02cyJ3JBmOhSxmMytfTMEABjZa9UWe0cAmG+N3/JfzopTJZ3r3sewgn5
 pnr7Yk878jLUoObtb4ZJZtECqh23Hg9mZAekIBTmv4Bx6Wi3VExSQjWmarESdgxCMZRk
 lVJ/xg5vfOgVrnMGcwVd/HGJs+YiGENVKXOupp4xnE/hkshuwFzgaWmPoa54AqihxGil
 3q9VPFceLskvKgvpdjPuscedIJCGXVql4bsCCQt3HC4qd0tq/Bk8szNFRpOe259NWQR3
 TIJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBznjBU7GoSM7USCCp1qvEmrSVZuavzxfB9gCgRF5fUQ1hchpSqJ606lrwCdqIGIQFu1ZHYJ8kY2E0yDQFLzrZSu@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLGb+ilOWS6GPT29xi4QkYg9i8XF9clf5hJEILfdJZrEETZj+BZ
 Lw6X6wMEqvRnCPk925jjgrSy+yQHXzIVRYiWJgm1xs5u42bVSO/dxNtXZ7RvIZDH9PI=
X-Gm-Gg: AYBFou1WsVZqroDnuGH3ZlQoSDkQdQNh13kDroFNuftP5PzZiW2PMfCsIOUkIymPw1V
 O7z3HWSLBltC2EsDHHxsMCixqXa0NVKrjVPbaWmje0xkaJedbjme1RKDkeFGp2qHNMKQKzvHMFp
 2mOxXsq3eo1TslYpTRTT1wIpXNwPjE3M5iYNZOvSO/LtK6UPcT18Z6Z4tyqSB4ubVhCjeBNc9gy
 zqp9t8PUnzBwSaAnVL7JO8c25UOfrFVXM5+VOW4u6imoJWGeDXwyp0Bguhtn6sjBXM2Qevj6tcS
 qX9NvSAIh1dG+3bZOolYuYH3wLs3D4fApqZWxFRHl5vkD916Nbu10prfdv+VhgqtxPh0F6u7tVr
 HNaHQr5X6LSDdXW63hkly9mVC6wVxtOCAhxibw9FQDqzJMJ2QpfvaIK/c7Glg4QTp3hoYHJAXpX
 7o+1VYx6HkzLS/xwLCIDyOfA4pv+R3rJqwUvRabxJLmWrVNmpOBllCXHdUJgJWmeNzyNhDBDyPY
 V6U1NRDil5IyY1RCAiJmds5cSGtlANDYeY=
X-Received: by 2002:a05:7022:170a:b0:15f:28e1:7c7d with SMTP id
 a92af1059eb24-16a61d5c4f6mr25527430c88.42.1792132390074; 
 Thu, 15 Oct 2026 23:33:10 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831bd28789sm3027457c88.19.2026.10.15.23.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:33:09 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daeho43@gmail.com
Date: Fri, 16 Oct 2026 14:33:02 +0800
Message-ID: <20261016063302.426184-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_yFv9ht_Hbg5a3hdx0+-=L7YXqzx8NhddbZ0Vjj2tNJLw@mail.gmail.com>
References: <cover.1792050467.git.qiwenjie@xiaomi.com>
 <eaed01c69f5af16df36a6df9be3f6615e4818d29.1792050467.git.qiwenjie@xiaomi.com>
 <CACOAw_yFv9ht_Hbg5a3hdx0+-=L7YXqzx8NhddbZ0Vjj2tNJLw@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xHbVD-0004hz-Oz
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: refresh pinned allocation
 boundary after resize
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org, sunqiuyang@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

> Could you bound it by MAIN_SECS() in get_new_segment()?

Thanks for pointing this out. I've sent v4 [1] with the suggested
min(sbi->pinned_area_max_secno, MAIN_SECS(sbi)) bound in
get_new_segment(). This prevents pinned curseg allocation from entering
the range being removed while MAIN_SECS() is temporarily reduced.

Patch 1 is unchanged.

[1] https://lore.kernel.org/linux-f2fs-devel/cover.1792116883.git.qiwenjie@xiaomi.com/T/#u

Best regards,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
