Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BCEC61DCB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x0LPzJTD+LecL2JDd6AZ4gwkrBi+JpKRXBW+SDhyuPM=; b=KeJTpWWSxofz1AKK6PxwLWJ2a1
	Tvpf6Y5iUXvVmJBg7NY3ZXX4HN2Tssd5Z30YVC8LQu03EnuZoh+ZojS62RZfMpAkb3dO6l07tpIvN
	lUQIw9zCJjkJQMDtFSQDhSMuOjKAmACjIMreLYg3tC17cPg9vmhfElx34vLu7LGq0JKY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzxKE-0007on-1s;
	Fri, 28 Aug 2026 14:12:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wzxKC-0007of-8D
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:12:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n29SS5Q6nUE/mH+zwwp5J1MgKbYJCrFJK4KKmQ6En+4=; b=e8ibhouQJ9jVMPJDctGOPVGgon
 MdbOYKJB3YvlPqDB/7ho8tcJhqXhFtnmVjVJbzkNGGROkIg3ZzYBccm95Z3wolW71kMYlQR941pn1
 ph88SMnoVQKwsQEpAwLA7gbEluVXkpo0taucF2AH8oY26/oKwq6E/KhQUk0Fp4lxZ1kk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=n29SS5Q6nUE/mH+zwwp5J1MgKbYJCrFJK4KKmQ6En+4=; b=J
 6d15VTi6f4a+qozXqkACJ0hS7cD5vTwUjIbu6GMk1mbD3WJp0qkhsWy53Ub6fiDeDIens9FYO5xJ0
 E61EUjsft1EMC/35iMi9irdHnugOfBolBT8eaD5Ju2THFUbQK0un3FPydq+bXcXf0ZztB6uh9Mtek
 czoYGVbgdK+2Ek5g=;
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzxK9-0005B0-9g for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:12:53 +0000
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc1cc97b84bso976658a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787926367; x=1788531167; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n29SS5Q6nUE/mH+zwwp5J1MgKbYJCrFJK4KKmQ6En+4=;
 b=NgiIQ+/fKVOt0/EAz4veqdvqV88oJHOgHpmcfHYC6fzOMpl5oVJK2SrULcHoBujUbL
 +W3T6RQ8Y+dtD1QaWxjYgT5A1qnc90Alm+by+MjL+W+oplzgbDyWpCW5r6xZJ9Ur9sIh
 dGIHpH+NhSWJ7sBXCNyNDnFlPpNxpALTWaJbcUyj3sMzZOIPke/80G1krVJHF6h1M5bk
 P6RGBIntodcUu142hZQnP8HNkYeyock7YW2kMVE9T40EVq2mm/c6NueOKGYOiqQq9l56
 FACFm/CjnWSRuJQFp4mUR4vpP13pxHIrR8OJ0PueE7IWKUpF1d8QXzDE3OPSDXoDyZlf
 vFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787926367; x=1788531167;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n29SS5Q6nUE/mH+zwwp5J1MgKbYJCrFJK4KKmQ6En+4=;
 b=D0ACvk1MWCJAwjOW74wW/yCit7kdx3vnLQO9qpVhRSYd01yUGLWW2RTXiJSN6MFKZ3
 ZTfAaczj/V3EEFw2MR42MDaGQGCPSQ+PPZLSZVYlhTtdyT1kMZVDk5YmX3ynAz15lgc+
 z5P5W5cfAyxvqRhVo4+3JNfBibXp6gYxr38vImq7DLoY3z4Fg/71TIIKNgp27J8rBlv0
 ISTMoed4Q+/4HWpkiYqxDO7h/5t3IBXxuZrgBsJgH04F8Es5tCtJFeXVXGjuOpUU+Kd4
 8SPI1i9Ls8/54gQSY/ALXr2BZ76M0c4jOeqHEHlt7kRHl9Pxa9ykdkEZ5CxqWyuxW2rT
 z5Cw==
X-Forwarded-Encrypted: i=1;
 AHgh+RocDF/A4Rs17skJRfd4mubVGeShFkAXBNlrgr8hq1leviZb0gwEe/IpvYUuIBnDovzpSalvJiHzp/oQrgBIWosh@lists.sourceforge.net
X-Gm-Message-State: AFuF++mGF99ahgFW94IQ/iAYWBjKxGPeROpOSte9lNyHf1DSIUQz0bAJ
 fU2+IEo7udZTkOHhYwkFBiLBsPJufrJeQC6gJ+/m4sh+3rcvHt/rw2cF
X-Gm-Gg: AR+sD12HfUN55e8/j8U3sF0mTz1FF8DhkMAv/PaaP5MhzOa/pHdlIAd+kG0o4uNDAQF
 vaz3M5N7BvoeqDoBWm8qtXlIWrI+q/g0G6P419TN4w+LzxtvDAvLJPV1/r2iccQslEB0aUcs8jk
 QACtnybwJ1iV/f5sTdQvLLRLhI7UYzofzQpJS5VTzESHsKH0mpvDaWJqoe0cXjLSGQeVuXMBCgv
 xP9RGRwL0W7dEeNJbcQM4cFkGkdGXGK+eqghmLRmDob2c5Q/akZQhHdStU3Q0qtUrtxuzytVwGG
 Rcb+CaHPRcJqSBhO57j1IayDyVKHBTmYqHioPiBMIaHsQeDaC4CexZWFHQ1Va5LZyYNWxRoFE9J
 Fjh1FsCrVLS1rGCTLeJee1+qalN5rQEIhDJlTw2HYLFALUADbBYMRGoDh3kFKl7KfqUqZ0aoPfx
 4pZ36KM66bSOgZup1a+V61K9VX1vPiVZarwPJXDNjqdomiBahnoY52vqRkIA0IAkRd5oB/jcBRN
 TUMaMAMTCoEaFKazyoLju1Z
X-Received: by 2002:a17:90b:3810:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-396d0e7cdc1mr13901532a91.6.1787926367461; 
 Fri, 28 Aug 2026 07:12:47 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396ddc0c703sm2737951a91.9.2026.08.28.07.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:12:46 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 28 Aug 2026 22:12:39 +0800
Message-ID: <20260828141240.2391915-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wzxK9-0005B0-9g
Subject: [f2fs-dev] [PATCH 1/2] f2fs: flush SIT journal during filesystem
 resize
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

During a filesystem resize, SBI_IS_RESIZEFS prevents new SIT entries
from being added to the journal and forces existing entries to the SIT
area. However, f2fs_flush_sit_entries() returns early when there are no
new dirty sentries, leaving existing journal entries behind.

After the main area shrinks, a later checkpoint can access a journal
entry whose segment number is outside the new geometry and trigger
f2fs_bug_on().

Only take the zero-dirty fast path when entries may be written back to
the journal. This lets resize drain existing entries through
remove_sits_in_journal() even when there are no new dirty sentries.

Fixes: 04f0b2eaa3b3 ("f2fs: ioctl for removing a range from F2FS")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1e7e745be71d..9f9ce25dd07e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4816,7 +4816,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	down_write(&sit_i->sentry_lock);
 
-	if (!sit_i->dirty_sentries)
+	if (!sit_i->dirty_sentries && to_journal)
 		goto out;
 
 	/*
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
