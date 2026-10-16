Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975B7CC6B38
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Hm9b328HbSHsl5czrjJb9eUtACsO/NMlarqUkJLWBok=; b=NUspdWC+BZBEW6584anT46XNDr
	QA3K401boVhf0IlSOYWofHT5DPTcar2KStATO2/bqF01KYSClUoXp2o/IyX5vS7vBriDaN9N19RbF
	nFWkl0NcqRmG6eumUVJx/g+tg44Mjm1mmyB5PxG0RNOn9ADwCG/WuPE2VbjDUurH5JQA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHajr-0000nE-Tr;
	Fri, 16 Oct 2026 05:44:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xHajq-0000n1-Ql
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 05:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OK8gQ1ufxTYQRu20UVmbLfwGO0s2WmJNokT26nu2ksg=; b=Yn1sgkDytaW61vmzuCOZqC5ZN+
 +nKT6lefrKhGkUND5bHuyGVNzlidc1YGwqnpFx6WMAvp7AgKdZXtRqZPG8uqIWRHnKGDJM3kVR5jQ
 TrjBqFs0W0NWVFwCbWRwqbSo186OldP+uR1UsiSHj2LsNvfHpoJB0PUDWoCFLhEy5jqk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OK8gQ1ufxTYQRu20UVmbLfwGO0s2WmJNokT26nu2ksg=; b=L
 sgLsrV0D5HM3ZRvktujduuOYyMoAudHd/Cqixm/8a/WXC221I6Q5YJnvCr//INuj72/lFsyST3y9z
 kKbbJ2FmBYLB6FPKRtvoCP1F9aPCzMIFLjCMyDgBLcbt+6xxpPZxvAr2MB0sPVRuxArMenrSwtEaX
 pZS0JW5ugmPx3Ymc=;
Received: from mail-dl1-f43.google.com ([74.125.82.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHajr-0002aU-6g for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 05:44:19 +0000
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-16079d54c17so262542c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 22:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792129453; x=1792734253; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OK8gQ1ufxTYQRu20UVmbLfwGO0s2WmJNokT26nu2ksg=;
 b=ehkQJWvoF1aSWycHs/Pmax/sD4/RhJNJ1w4HgNFFSZEZyj9kQKph+APJl7VE7vK7Dk
 ukKIoV16dgeqgtqkoJSGWqHzWeMjTlLDGwrtHz0tIv5G3LIf0QU+OckVZsVtKzaOLWMX
 MzZ5nb2ELqoAi+5dgM9fT3L+e2W2kt6j/M0XUQRen5YD4QnVGtEUs1nPgRCUEKlboODZ
 fYTxz6VathbH0j/KxW6AVErRgkJu/0IIt+mXgK24/NfX/w5G9g9YIr3KcATwnPooGpFS
 WfezMPGrCdPFpvaQw3iSY8O8gVZkCcoi+1dVQjoYSCVBjy1PJot56npreVO+PhVhfuZe
 ZuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792129453; x=1792734253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OK8gQ1ufxTYQRu20UVmbLfwGO0s2WmJNokT26nu2ksg=;
 b=nWk/mAf1eFdHP5Z6944nz7r++wW6AM2j9H4aufB7LR2R6soEJxe/SxapkSozYUY8ZI
 NM6pkXnoa1gRYdb1XKRWOoOp8T243s2MnNnpPbZiI1//avL+7rzZs3fB1WCHGZYGlQgO
 Njwet42OJyvy4/498hgnEvgypVhetvO7ZQtrRjcMiD4mhP3g0z5owsRJdshdP08R7ZDl
 4lR92sNBG8cUS/dSRGRzcO8wm7it2pQAWlPbYllmakiBGewuxMPpAI68uZrpcN59mhOc
 FIQN/Kgkxr25i1nVZopCnGyAY9h/IYUPKE4wN3LbkparmHLGqjMLFDrAG1Eq1ynNv21x
 6wMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2Qq0LnMomfHC/hytxmnXWB11/C+ALp8JN4UoB3G7THGIN3BcAaU9pUmRk9km58lhFXN8r6fka52P3D2ME9PXm@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJuxeEa4oofr5cSWbcoei/4ketDvAWYe0FUHZVTOgiKSbKn7qJ/
 jSnhHLI6HEEtVr/QTBY7qZKwTS5+35EIvY4UVdsL0+g1q0O6/17adc9/
X-Gm-Gg: AYBFou093iqa7rbWro0xWI5bh1PUgCuTZJggIw2z3bVgcfq0V9eK+iYMiCOyb0vFxiE
 YolwVFjcS9xdvrOa0/USMuWfGmIEZZzOTVOOyBIlLij0pezDdoRggiI90qpDRc71cxwAGJxKmUx
 HBYbnDBEIceAc5cmyGbR+dTZn2gKaKI98CQHg0l6ltch/fXBaxY4mNDz+nt0he+5N02Y7vwRCbp
 6GOzJOrFJSnLis49vCGiw45zBmXnDzJXkhqKeLD5H9PvSZtn5VH9bh7DwtVEQm6tWw3WuOMmgiH
 4sLNAx+6aYFJmFBGT4MC8dN/WL8ynTS/JiiCuYOkALi+Ossknr7KuuLzdToMTuuXb/wjoBGQDur
 PG2Z8YL3MocPtfAWp80N2R6hCzlTCYJA56myoPeFbBE218g8E8G51oSq/SYyqjKfA+NafUJB4Cs
 T4HCy1DDB1xbHuDXGQVbPo4JZ0rTxRhWP15I8YdJOmXb7NZzZGaKhbOcyLVp8d732mjknc5NtTV
 EqS1nNSHGRzDUju8tZugv6jTo5t1fXiX6U=
X-Received: by 2002:a05:701b:4544:10b0:144:c12b:dfc6 with SMTP id
 a92af1059eb24-16a60ce7b43mr28097347c88.44.1792129453455; 
 Thu, 15 Oct 2026 22:44:13 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831919fdfesm2642428c88.7.2026.10.15.22.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 22:44:12 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 16 Oct 2026 13:44:04 +0800
Message-ID: <cover.1792116883.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1xHajr-0002aU-6g
Subject: [f2fs-dev] [PATCH v4 0/2] f2fs: fix online resize state
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
 sunqiuyang@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Online shrink changes both persistent SIT state and the geometry used
by pinned allocation. This series keeps those states consistent during
range evacuation and after the geometry changes.

Patch 1 drains the SIT journal during resize even when there are no
new dirty sentries. It is unchanged and retains Daeho's Reviewed-by.

Patch 2 consumes the tail reservation, refreshes the pinned boundary,
and restores both on final checkpoint rollback. It also limits pinned
allocation by the temporarily reduced MAIN_SECS() during evacuation.

Changes in v4 (since v3):
- Bound pinned section allocation by the current MAIN_SECS().

Changes in v3 (since v2):
- Rebase onto f2fs/dev.
- Reduce resizable_tail_secno by the removed sections, down to zero.
- Save the current tail after freeze and restore it on rollback.
- Document that online shrink consumes the reservation.
- Retain Daeho's review for patch 1; request a new review for patch 2.

Changes in v2 (since v1):
- Simplify tail validation and improve rejection diagnostics.
- Validate before taking the mount write reference and recheck
  after freeze for concurrent remounts.

v1:
- Initial SIT-journal and pinned-boundary fixes.

Wenjie Qi (2):
  f2fs: flush SIT journal during filesystem resize
  f2fs: refresh pinned allocation boundary after resize

 Documentation/filesystems/f2fs.rst |  3 ++-
 fs/f2fs/gc.c                       |  6 +++++-
 fs/f2fs/segment.c                  |  4 ++--
 fs/f2fs/segment.h                  | 11 +++++++++++
 fs/f2fs/super.c                    | 15 ++-------------
 5 files changed, 22 insertions(+), 17 deletions(-)


base-commit: e455328a66a5f4827d4ba96acfe50dbbb0e13b8d
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
