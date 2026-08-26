Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6852C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bSz4fsIRSTECAgexXlwYb2GlhjvhU/z5Ij3C/GJK+88=; b=VUR7GlzM9R9tuZpG0rVwGPS1SO
	DKRuogfz5QsNNKnCoQwl7OCWIUsesJ6TfS8SSq8tgeoP8eZMl6Fkc9skP2ia8NmbHQFhxEiBAUQYv
	wACgF9/jsamiavNhIsvUm3pcGHj9Mmr9xrceuHVfsfBXR5DqEROaTMO/lO2JD4zGS8tE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzFIb-0007Cf-Oz;
	Wed, 26 Aug 2026 15:12:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wzFIa-0007CZ-Oy
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:12:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rqzQBp0nrSAFCfyclJraR8i8GHOdK8ExujsnsKkIJkk=; b=LIA3FUdu3YhY2r87QxXzYMUZHu
 XAuQ7PJgtO2JtcoClApxOR70+L6hyMyncjq4f8jqU1XBVD9DYVYxuRxuoROtsGRI5EtQySgb6+nYy
 Zzl5uzosXbJcPo4UPcjpqO/P9rg8gjECCnPHJnPn/DoMXIfkYS9gMXHc+2i6pulSEc+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rqzQBp0nrSAFCfyclJraR8i8GHOdK8ExujsnsKkIJkk=; b=Q
 rniUUqeTFkF4lT4nM9MptRcWqpVS2d+Euzp+tfcEEYUvD+w+Mz1wzrKaVJwpyAT2slGPbeFkyxXMx
 /A8uwA2KQeAa4boHsRZ/vcLJhr447Ym2Vr/nZZDkvh5DkxMmGprG90XGvdiofr8C9nM1N4Q+YJ49B
 Enj1LDMIrim7P/OM=;
Received: from mail-oa1-f43.google.com ([209.85.160.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFIW-0006pW-Oa for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:12:18 +0000
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-462df62f872so2340260fac.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787757131; x=1788361931; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rqzQBp0nrSAFCfyclJraR8i8GHOdK8ExujsnsKkIJkk=;
 b=UAiqO0IMRdQ3Bv0Cbey41ZcOOSsfAJnXpt++A17+vMzqHkw/JOHV8bJw9sje5i3inw
 +T+NGTvBSC2kRK4NaG4AqJ9HI61fky7gugrrhrpXnwaqQpZ+aENceZAIegxCRmT+qWHY
 IWRaBrzVrcJs5zAt6tQl7pL6Wdb3HU7WVWd+Onb21iLXmjIu95yYtcJpLSgK6vsbI1KR
 AwISUP8tr8UWlEMg8ypfDaB92EmcioeUnKJhtb//WlgvMv27sS+zrJ/dj+A+LoWxzmpw
 6MQKyL7sTXFG4xH2MRz6tlcfjx06OuB3DJj1cLH0JaJxx1wwM4PDZb6zOk0fxOA5yTq8
 +nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787757131; x=1788361931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rqzQBp0nrSAFCfyclJraR8i8GHOdK8ExujsnsKkIJkk=;
 b=J48wBgb2FuUoL2vWmN+OKQkndfmAZ+rw6Wo7FGghnLxTQCjEsJhavEfThXaLvnVmbf
 1IyDmkuHBUU2UwqAzVM3fhATUeUleuNPsYVYTShC+bZ26XL1fwHtfyvuJlizCFC9DZtP
 IGMC1FQc9ZYsQDFeXRTh3rF9fYsQHdg3gOz6Ij+r1Tpx1T7WmOkP/QayJ7wlVS48pRPK
 jW1/bu0nGZ5keV+DcVSdGYFCedf8uYTadj1iM8Fp2nXj+2BEmfagQJP9woQ3vF2WK5Vz
 6HDdKk36nGGB9QDUdGpKWthJ7B3El5A0Epn7P2reUIEV2zQ3pZXnDzGFXfbM5H1WgNG4
 r0ng==
X-Gm-Message-State: AFuF++kW0kuIAi0gytmuRIXYDJYN58RmIGb1aQvR03BQQsjp2L3sQxYp
 cwfBlvJqiH04MWIOYMh1PsoTNsGHiriZzVLS7iSzWJifm8dxvs8p+ECGio1pL26g
X-Gm-Gg: AR+sD10DqPhA09pxhNIGle/RyXZ2S7zWsOafCOPSWqdlH7V3Bapb9Z6URcIMypByAJg
 aMn9wMqwrBb8ym+TM8EFGmL6KBpGCCbn7VBOZcogcn6Vc1AedGniybaz9tCRv/wcT7OIjlC/sat
 rz76GKLRbJITt0ZmLM9TWSEZrautVFFXOmZi7GlJRfHf09nCQVpCI96m3R4UXb7klvLKw2DUHED
 1mXCPmBf/4LYK6xZhF+X2ycsAVQaiyRBLC8uXA64kuIEb5Bd4Jm+ROGtQvapZcYLF6BGwEmDW4C
 92s8uZfRp132vYMeKQBDdj721YxQ4ooHyXONlZi2Bgn7ZxJPoRfvmd41Mu35U0vABDz4c/7fR1Z
 88FaLO8auUEP/vh0yU4z7FMUTRzVjQj+frJTFmMtoiDKqkG0GYWOo1l/hsxjYNjjEdPieh55tOW
 6iy8VgUgp1CPC6wpCZ2NhG9oVuDsyrQoX9pHVEtjWAqCVjP13qr8B/4NrnSuxJtAf7ugOUisLee
 WYeonKgx5IZxAgb41FA1fe+
X-Received: by 2002:a17:90b:3d81:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-3966d3d1262mr8939100a91.3.1787751693501; 
 Wed, 26 Aug 2026 06:41:33 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d69065sm8906472a91.13.2026.08.26.06.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:41:32 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 26 Aug 2026 21:41:24 +0800
Message-ID: <20260826134126.3729507-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wzFIW-0006pW-Oa
Subject: [f2fs-dev] [PATCH 0/2] f2fs: fix device alias state across remount
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, daehojeong@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Split device-alias remount handling into two changes.  The first records a
stable device-to-inode mapping so a custom alias name can be reserved again
after release and remount.  The second uses that mapping to keep released
alias devices out of pinned allocation, both immediately and after remount.

The f2fs-tools layout and mkfs update will be sent separately because it
applies to a different repository.

Wenjie Qi (2):
  f2fs: persist device alias inode across remount
  f2fs: keep released alias devices out of pinned allocation

 fs/f2fs/file.c          | 100 ++++++++++++++++++++++++++++++++++------
 fs/f2fs/super.c         |  48 +++++++++++++++++++
 include/linux/f2fs_fs.h |   3 +-
 3 files changed, 136 insertions(+), 15 deletions(-)

-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
